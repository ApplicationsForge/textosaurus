// This file is distributed under GNU GPLv3 license. For full license text, see <project-git-repository-root-folder>/LICENSE.md.

#include "common/gui/widgetwithstatus.h"

#include "common/gui/plaintoolbutton.h"
#include "common/miscellaneous/iconfactory.h"
#include "saurus/miscellaneous/application.h"

#include <QHBoxLayout>

WidgetWithStatus::WidgetWithStatus(QWidget* parent)
  : QWidget(parent), m_status(StatusType::Ok), m_wdgInput(nullptr) {
  m_layout = new QHBoxLayout(this);
  m_btnStatus = new PlainToolButton(this);
  m_btnStatus->setFocusPolicy(Qt::NoFocus);
  m_iconProgress = qApp->icons()->fromTheme(QSL("view-refresh"));
  m_iconInformation = qApp->icons()->fromTheme(QSL("dialog-information"));
  m_iconWarning = qApp->icons()->fromTheme(QSL("dialog-warning"));
  m_iconError = qApp->icons()->fromTheme(QSL("dialog-error"));
  m_iconOk = qApp->icons()->fromTheme(QSL("dialog-yes"));

  // Set layout properties.
  m_layout->setMargin(0);
  setLayout(m_layout);
  setStatus(StatusType::Information, QString());
}

void WidgetWithStatus::setStatus(WidgetWithStatus::StatusType status, const QString& tooltip_text) {
  m_status = status;

  switch (status) {
    case StatusType::Information:
      m_btnStatus->setIcon(m_iconInformation);
      break;

    case StatusType::Progress:
      m_btnStatus->setIcon(m_iconProgress);
      break;

    case StatusType::Warning:
      m_btnStatus->setIcon(m_iconWarning);
      break;

    case StatusType::Error:
      m_btnStatus->setIcon(m_iconError);
      break;

    case StatusType::Ok:
      m_btnStatus->setIcon(m_iconOk);
      break;

    default:
      break;
  }

  // Setup the tooltip text.
  m_btnStatus->setToolTip(tooltip_text);
}
