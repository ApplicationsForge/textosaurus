// This file is distributed under GNU GPLv3 license. For full license text, see <project-git-repository-root-folder>/LICENSE.md.

#include "common/network-web/downloader.h"

#include "common/miscellaneous/iofactory.h"

#include <QRegularExpression>
#include <QTimer>

Downloader::Downloader(QObject* parent)
  : QObject(parent), m_activeReply(nullptr), m_downloadManager(new SilentNetworkAccessManager(this)),
  m_timer(new QTimer(this)), m_inputData(QByteArray()),
  m_targetProtected(false), m_targetUsername(QString()), m_targetPassword(QString()),
  m_lastOutputData(QByteArray()), m_lastOutputError(QNetworkReply::NoError) {
  m_timer->setInterval(DOWNLOAD_TIMEOUT);
  m_timer->setSingleShot(true);
  connect(m_timer, &QTimer::timeout, this, &Downloader::cancel);
}

void Downloader::downloadFile(const QString& url, int timeout, bool protected_contents, const QString& username,
                              const QString& password) {
  manipulateData(url, QNetworkAccessManager::GetOperation, QByteArray(), timeout,
                 protected_contents, username, password);
}

void Downloader::uploadFile(const QString& url, const QByteArray& data, int timeout,
                            bool protected_contents, const QString& username, const QString& password) {
  manipulateData(url, QNetworkAccessManager::PostOperation, data, timeout, protected_contents, username, password);
}

void Downloader::manipulateData(const QString& url,
                                QNetworkAccessManager::Operation operation,
                                const QByteArray& data,
                                int timeout,
                                bool protected_contents,
                                const QString& username,
                                const QString& password) {
  QNetworkRequest request;

  QHashIterator<QByteArray, QByteArray> i(m_customHeaders);

  while (i.hasNext()) {
    i.next();
    request.setRawHeader(i.key(), i.value());
  }

  if (operation == QNetworkAccessManager::Operation::PostOperation &&
      request.rawHeader(QString(HTTP_HEADERS_CONTENT_TYPE).toLocal8Bit()).isEmpty()) {
    request.setRawHeader(QString(HTTP_HEADERS_CONTENT_TYPE).toLocal8Bit(),
                         QString("application/x-www-form-urlencoded").toLocal8Bit());
  }

  m_inputData = data;

  // Set url for this request and fire it up.
  m_timer->setInterval(timeout);
  request.setUrl(url);

  m_targetProtected = protected_contents;
  m_targetUsername = username;
  m_targetPassword = password;

  if (operation == QNetworkAccessManager::PostOperation) {
    runPostRequest(request, m_inputData);
  }
  else if (operation == QNetworkAccessManager::GetOperation) {
    runGetRequest(request);
  }
  else if (operation == QNetworkAccessManager::PutOperation) {
    runPutRequest(request, m_inputData);
  }
  else if (operation == QNetworkAccessManager::DeleteOperation) {
    runDeleteRequest(request);
  }
}

void Downloader::finished() {
  QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

  QNetworkAccessManager::Operation reply_operation = reply->operation();
  m_timer->stop();

  // In this phase, some part of downloading process is completed.
  const QUrl redirection_url = reply->attribute(QNetworkRequest::RedirectionTargetAttribute).toUrl();

  if (redirection_url.isValid()) {
    // Communication indicates that HTTP redirection is needed.
    // Setup redirection URL and download again.
    QNetworkRequest request = reply->request();

    if (redirection_url.host().isEmpty()) {
      request.setUrl(QUrl(reply->request().url().scheme() + QSL("://") + reply->request().url().host() + redirection_url.toString()));
    }
    else {
      request.setUrl(redirection_url);
    }

    m_activeReply->deleteLater();
    m_activeReply = nullptr;

    if (reply_operation == QNetworkAccessManager::GetOperation) {
      runGetRequest(request);
    }
    else if (reply_operation == QNetworkAccessManager::PostOperation) {
      runPostRequest(request, m_inputData);
    }
    else if (reply_operation == QNetworkAccessManager::PutOperation) {
      runPutRequest(request, m_inputData);
    }
    else if (reply_operation == QNetworkAccessManager::DeleteOperation) {
      runDeleteRequest(request);
    }
  }
  else {
    // No redirection is indicated. Final file is obtained in our "reply" object.
    // Read the data into output buffer.
    m_lastOutputData = reply->readAll();
    m_lastContentType = reply->header(QNetworkRequest::ContentTypeHeader);
    m_lastOutputError = reply->error();
    m_activeReply->deleteLater();
    m_activeReply = nullptr;

    emit completed(m_lastOutputError, m_lastOutputData);
  }
}

void Downloader::progressInternal(qint64 bytes_received, qint64 bytes_total) {
  if (m_timer->interval() > 0) {
    m_timer->start();
  }

  emit progress(bytes_received, bytes_total);
}

void Downloader::runDeleteRequest(const QNetworkRequest& request) {
  m_timer->start();
  m_activeReply = m_downloadManager->deleteResource(request);
  m_activeReply->setProperty("protected", m_targetProtected);
  m_activeReply->setProperty("username", m_targetUsername);
  m_activeReply->setProperty("password", m_targetPassword);
  connect(m_activeReply, &QNetworkReply::downloadProgress, this, &Downloader::progressInternal);
  connect(m_activeReply, &QNetworkReply::finished, this, &Downloader::finished);
}

void Downloader::runPutRequest(const QNetworkRequest& request, const QByteArray& data) {
  m_timer->start();
  m_activeReply = m_downloadManager->put(request, data);
  m_activeReply->setProperty("protected", m_targetProtected);
  m_activeReply->setProperty("username", m_targetUsername);
  m_activeReply->setProperty("password", m_targetPassword);
  connect(m_activeReply, &QNetworkReply::downloadProgress, this, &Downloader::progressInternal);
  connect(m_activeReply, &QNetworkReply::finished, this, &Downloader::finished);
}

void Downloader::runPostRequest(const QNetworkRequest& request, const QByteArray& data) {
  m_timer->start();
  m_activeReply = m_downloadManager->post(request, data);
  m_activeReply->setProperty("protected", m_targetProtected);
  m_activeReply->setProperty("username", m_targetUsername);
  m_activeReply->setProperty("password", m_targetPassword);
  connect(m_activeReply, &QNetworkReply::downloadProgress, this, &Downloader::progressInternal);
  connect(m_activeReply, &QNetworkReply::finished, this, &Downloader::finished);
}

void Downloader::runGetRequest(const QNetworkRequest& request) {
  m_timer->start();
  m_activeReply = m_downloadManager->get(request);
  m_activeReply->setProperty("protected", m_targetProtected);
  m_activeReply->setProperty("username", m_targetUsername);
  m_activeReply->setProperty("password", m_targetPassword);

  connect(m_activeReply, &QNetworkReply::downloadProgress, this, &Downloader::progressInternal);
  connect(m_activeReply, &QNetworkReply::finished, this, &Downloader::finished);
}

QVariant Downloader::lastContentType() const {
  return m_lastContentType;
}

void Downloader::cancel() {
  if (m_activeReply != nullptr) {
    // Download action timed-out, too slow connection or target is not reachable.
    m_activeReply->abort();
  }
}

void Downloader::appendRawHeader(const QByteArray& name, const QByteArray& value) {
  if (!value.isEmpty()) {
    m_customHeaders.insert(name, value);
  }
}

QNetworkReply::NetworkError Downloader::lastOutputError() const {
  return m_lastOutputError;
}

QByteArray Downloader::lastOutputData() const {
  return m_lastOutputData;
}
