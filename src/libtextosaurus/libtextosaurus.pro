TEMPLATE    = lib

unix|mac {
  TARGET      = textosaurus
}
else {
  TARGET      = libtextosaurus
}

MSG_PREFIX  = "libtextosaurus"
APP_TYPE    = "core library"

include(../../pri/vars.pri)

isEmpty(LRELEASE_EXECUTABLE) {
  LRELEASE_EXECUTABLE = lrelease
  message($$MSG_PREFIX: LRELEASE_EXECUTABLE variable is not set.)
}

include(../../pri/defs.pri)

message($$MSG_PREFIX: Shadow copy build directory \"$$OUT_PWD\".)
message($$MSG_PREFIX: $$APP_NAME version is: \"$$APP_VERSION\".)
message($$MSG_PREFIX: Detected Qt version: \"$$QT_VERSION\".)
message($$MSG_PREFIX: Build destination directory: \"$$DESTDIR\".)
message($$MSG_PREFIX: Build revision: \"$$APP_REVISION\".)
message($$MSG_PREFIX: lrelease executable name: \"$$LRELEASE_EXECUTABLE\".)

QT *= core gui widgets network printsupport svg

include(../../pri/build_opts.pri)

DEFINES *= TEXTOSAURUS_DLLSPEC=Q_DECL_EXPORT
CONFIG += unversioned_libname unversioned_soname skip_target_version_ext

win32 {
  LIBS *= Shell32.lib
}

CONFIG(FLATPAK_MODE) {
  message($$MSG_PREFIX: Enabling Flatpak-specific code.)
  DEFINES *= FLATPAK_MODE=1
}

RESOURCES += ../../resources/textosaurus.qrc

mac|win32 {
  RESOURCES += ../../resources/icons.qrc

  message($$MSG_PREFIX: Adding resources for default icon theme.)
}

HEADERS +=  common/dynamic-shortcuts/dynamicshortcuts.h \
            common/dynamic-shortcuts/dynamicshortcutswidget.h \
            common/dynamic-shortcuts/shortcutcatcher.h \
            common/exceptions/applicationexception.h \
            common/exceptions/ioexception.h \
            common/gui/baselineedit.h \
            common/gui/basetextedit.h \
            common/gui/basetoolbar.h \
            common/gui/guiutilities.h \
            common/gui/labelwithstatus.h \
            common/gui/messagebox.h \
            common/gui/plaintoolbutton.h \
            common/gui/systemtrayicon.h \
            common/gui/toolbar.h \
            common/gui/toolbareditor.h \
            common/gui/widgetwithstatus.h \
            common/miscellaneous/debugging.h \
            common/miscellaneous/iconfactory.h \
            common/miscellaneous/iofactory.h \
            common/miscellaneous/localization.h \
            common/miscellaneous/settings.h \
            common/miscellaneous/settingsproperties.h \
            common/miscellaneous/systemfactory.h \
            common/miscellaneous/textfactory.h \
            common/network-web/basenetworkaccessmanager.h \
            common/network-web/downloader.h \
            common/network-web/networkfactory.h \
            common/network-web/silentnetworkaccessmanager.h \
            common/network-web/webfactory.h \
            definitions/definitions.h \
            saurus/external-tools/externaltool.h \
            saurus/external-tools/externaltools.h \
            saurus/external-tools/predefinedtools.h \
            saurus/gui/dialogs/formabout.h \
            saurus/gui/dialogs/formfindreplace.h \
            saurus/gui/dialogs/formmain.h \
            saurus/gui/dialogs/formsettings.h \
            saurus/gui/dialogs/formupdate.h \
            saurus/gui/editortab.h \
            saurus/gui/settings/settingsbrowsermail.h \
            saurus/gui/settings/settingseditor.h \
            saurus/gui/settings/settingsexternaltools.h \
            saurus/gui/settings/settingsgeneral.h \
            saurus/gui/settings/settingsgui.h \
            saurus/gui/settings/settingslocalization.h \
            saurus/gui/settings/settingspanel.h \
            saurus/gui/settings/settingsshortcuts.h \
            saurus/gui/settings/syntaxcolorthemeeditor.h \
            saurus/gui/sidebars/basesidebar.h \
            saurus/gui/sidebars/findresultsmodel.h \
            saurus/gui/sidebars/findresultsmodelitem.h \
            saurus/gui/sidebars/findresultsmodelitemeditor.h \
            saurus/gui/sidebars/findresultsmodelitemresult.h \
            saurus/gui/sidebars/findresultssidebar.h \
            saurus/plugin-system/macros/macrossidebar.h \
            saurus/gui/sidebars/outputsidebar.h \
            saurus/gui/statusbar.h \
            saurus/gui/tab.h \
            saurus/gui/tabbar.h \
            saurus/gui/tabwidget.h \
            saurus/gui/texteditor.h \
            saurus/gui/texteditorprinter.h \
            saurus/miscellaneous/application.h \
            saurus/plugin-system/macros/macro.h \
            saurus/miscellaneous/syntaxcolortheme.h \
            saurus/miscellaneous/syntaxhighlighting.h \
            saurus/miscellaneous/textapplication.h \
            saurus/miscellaneous/textapplicationsettings.h \
            saurus/plugin-system/filesystem/favoriteslistwidget.h \
            saurus/plugin-system/filesystem/filesystemmodel.h \
            saurus/plugin-system/filesystem/filesystemplugin.h \
            saurus/plugin-system/filesystem/filesystemsidebar.h \
            saurus/plugin-system/filesystem/filesystemview.h \
            saurus/plugin-system/markdown/markdownplugin.h \
            saurus/plugin-system/markdown/markdownsidebar.h \
            saurus/plugin-system/markdown/markdowntextbrowser.h \
            saurus/plugin-system/pluginbase.h \
            saurus/plugin-system/pluginfactory.h \
            saurus/plugin-system/macros/macroswidget.h \
            saurus/plugin-system/macros/macros.h \
            saurus/plugin-system/macros/macrosplugin.h \
    saurus/gui/settings/settingsplugins.h

SOURCES +=  common/dynamic-shortcuts/dynamicshortcuts.cpp \
            common/dynamic-shortcuts/dynamicshortcutswidget.cpp \
            common/dynamic-shortcuts/shortcutcatcher.cpp \
            common/exceptions/applicationexception.cpp \
            common/exceptions/ioexception.cpp \
            common/gui/baselineedit.cpp \
            common/gui/basetextedit.cpp \
            common/gui/basetoolbar.cpp \
            common/gui/guiutilities.cpp \
            common/gui/labelwithstatus.cpp \
            common/gui/messagebox.cpp \
            common/gui/plaintoolbutton.cpp \
            common/gui/systemtrayicon.cpp \
            common/gui/toolbar.cpp \
            common/gui/toolbareditor.cpp \
            common/gui/widgetwithstatus.cpp \
            common/miscellaneous/debugging.cpp \
            common/miscellaneous/iconfactory.cpp \
            common/miscellaneous/iofactory.cpp \
            common/miscellaneous/localization.cpp \
            common/miscellaneous/settings.cpp \
            common/miscellaneous/systemfactory.cpp \
            common/miscellaneous/textfactory.cpp \
            common/network-web/basenetworkaccessmanager.cpp \
            common/network-web/downloader.cpp \
            common/network-web/networkfactory.cpp \
            common/network-web/silentnetworkaccessmanager.cpp \
            common/network-web/webfactory.cpp \
            saurus/external-tools/externaltool.cpp \
            saurus/external-tools/externaltools.cpp \
            saurus/external-tools/predefinedtools.cpp \
            saurus/gui/dialogs/formabout.cpp \
            saurus/gui/dialogs/formfindreplace.cpp \
            saurus/gui/dialogs/formmain.cpp \
            saurus/gui/dialogs/formsettings.cpp \
            saurus/gui/dialogs/formupdate.cpp \
            saurus/gui/editortab.cpp \
            saurus/gui/settings/settingsbrowsermail.cpp \
            saurus/gui/settings/settingseditor.cpp \
            saurus/gui/settings/settingsexternaltools.cpp \
            saurus/gui/settings/settingsgeneral.cpp \
            saurus/gui/settings/settingsgui.cpp \
            saurus/gui/settings/settingslocalization.cpp \
            saurus/gui/settings/settingspanel.cpp \
            saurus/gui/settings/settingsshortcuts.cpp \
            saurus/gui/settings/syntaxcolorthemeeditor.cpp \
            saurus/gui/sidebars/basesidebar.cpp \
            saurus/gui/sidebars/findresultsmodel.cpp \
            saurus/gui/sidebars/findresultsmodelitem.cpp \
            saurus/gui/sidebars/findresultsmodelitemeditor.cpp \
            saurus/gui/sidebars/findresultsmodelitemresult.cpp \
            saurus/gui/sidebars/findresultssidebar.cpp \
            saurus/plugin-system/macros/macrossidebar.cpp \
            saurus/gui/sidebars/outputsidebar.cpp \
            saurus/gui/statusbar.cpp \
            saurus/gui/tab.cpp \
            saurus/gui/tabbar.cpp \
            saurus/gui/tabwidget.cpp \
            saurus/gui/texteditor.cpp \
            saurus/gui/texteditorprinter.cpp \
            saurus/miscellaneous/application.cpp \
            saurus/plugin-system/macros/macro.cpp \
            saurus/miscellaneous/syntaxcolortheme.cpp \
            saurus/miscellaneous/syntaxhighlighting.cpp \
            saurus/miscellaneous/textapplication.cpp \
            saurus/miscellaneous/textapplicationsettings.cpp \
            saurus/plugin-system/filesystem/favoriteslistwidget.cpp \
            saurus/plugin-system/filesystem/filesystemmodel.cpp \
            saurus/plugin-system/filesystem/filesystemplugin.cpp \
            saurus/plugin-system/filesystem/filesystemsidebar.cpp \
            saurus/plugin-system/filesystem/filesystemview.cpp \
            saurus/plugin-system/markdown/markdownplugin.cpp \
            saurus/plugin-system/markdown/markdownsidebar.cpp \
            saurus/plugin-system/markdown/markdowntextbrowser.cpp \
            saurus/plugin-system/pluginfactory.cpp \
            saurus/plugin-system/macros/macroswidget.cpp \
            saurus/plugin-system/macros/macros.cpp \
            saurus/plugin-system/macros/macrosplugin.cpp \
    saurus/gui/settings/settingsplugins.cpp

FORMS +=  common/gui/toolbareditor.ui \
          saurus/gui/dialogs/formabout.ui \
          saurus/gui/dialogs/formfindreplace.ui \
          saurus/gui/dialogs/formmain.ui \
          saurus/gui/dialogs/formsettings.ui \
          saurus/gui/dialogs/formupdate.ui \
          saurus/gui/settings/settingsbrowsermail.ui \
          saurus/gui/settings/settingseditor.ui \
          saurus/gui/settings/settingsexternaltools.ui \
          saurus/gui/settings/settingsgeneral.ui \
          saurus/gui/settings/settingsgui.ui \
          saurus/gui/settings/settingslocalization.ui \
          saurus/gui/settings/settingsshortcuts.ui \
          saurus/gui/settings/syntaxcolorthemeeditor.ui \
          saurus/plugin-system/macros/macroswidget.ui \
    saurus/gui/settings/settingsplugins.ui

# Add qtsingleapplication.
SOURCES += $$files(3rd-party/qtsingleapplication/*.cpp, false)
HEADERS  += $$files(3rd-party/qtsingleapplication/*.h, false)

# Add uchardet.
SOURCES += $$files(3rd-party/uchardet/*.cpp, false)
HEADERS  += $$files(3rd-party/uchardet/*.h, false)

# Add Scintilla.
SOURCES += \
    3rd-party/scintilla/qt/ScintillaEdit/ScintillaEdit.cpp \
    3rd-party/scintilla/qt/ScintillaEdit/ScintillaDocument.cpp \
    3rd-party/scintilla/qt/ScintillaEditBase/PlatQt.cpp \
    3rd-party/scintilla/qt/ScintillaEditBase/ScintillaQt.cpp \
    3rd-party/scintilla/qt/ScintillaEditBase/ScintillaEditBase.cpp \
    3rd-party/scintilla/src/XPM.cxx \
    3rd-party/scintilla/src/ViewStyle.cxx \
    3rd-party/scintilla/src/UniConversion.cxx \
    3rd-party/scintilla/src/Style.cxx \
    3rd-party/scintilla/src/Selection.cxx \
    3rd-party/scintilla/src/ScintillaBase.cxx \
    3rd-party/scintilla/src/RunStyles.cxx \
    3rd-party/scintilla/src/RESearch.cxx \
    3rd-party/scintilla/src/PositionCache.cxx \
    3rd-party/scintilla/src/PerLine.cxx \
    3rd-party/scintilla/src/MarginView.cxx \
    3rd-party/scintilla/src/LineMarker.cxx \
    3rd-party/scintilla/src/KeyMap.cxx \
    3rd-party/scintilla/src/Indicator.cxx \
    3rd-party/scintilla/src/ExternalLexer.cxx \
    3rd-party/scintilla/src/EditView.cxx \
    3rd-party/scintilla/src/Editor.cxx \
    3rd-party/scintilla/src/EditModel.cxx \
    3rd-party/scintilla/src/Document.cxx \
    3rd-party/scintilla/src/Decoration.cxx \
    3rd-party/scintilla/src/DBCS.cxx \
    3rd-party/scintilla/src/ContractionState.cxx \
    3rd-party/scintilla/src/CharClassify.cxx \
    3rd-party/scintilla/src/CellBuffer.cxx \
    3rd-party/scintilla/src/Catalogue.cxx \
    3rd-party/scintilla/src/CaseFolder.cxx \
    3rd-party/scintilla/src/CaseConvert.cxx \
    3rd-party/scintilla/src/CallTip.cxx \
    3rd-party/scintilla/src/AutoComplete.cxx \
    3rd-party/scintilla/lexlib/WordList.cxx \
    3rd-party/scintilla/lexlib/StyleContext.cxx \
    3rd-party/scintilla/lexlib/PropSetSimple.cxx \
    3rd-party/scintilla/lexlib/LexerSimple.cxx \
    3rd-party/scintilla/lexlib/LexerNoExceptions.cxx \
    3rd-party/scintilla/lexlib/LexerModule.cxx \
    3rd-party/scintilla/lexlib/LexerBase.cxx \
    3rd-party/scintilla/lexlib/DefaultLexer.cxx \
    3rd-party/scintilla/lexlib/CharacterSet.cxx \
    3rd-party/scintilla/lexlib/CharacterCategory.cxx \
    3rd-party/scintilla/lexlib/Accessor.cxx \
    $$files(3rd-party/scintilla/lexers/*.cxx, false)

HEADERS  += \
    3rd-party/scintilla/qt/ScintillaEdit/ScintillaEdit.h \
    3rd-party/scintilla/qt/ScintillaEdit/ScintillaDocument.h \
    3rd-party/scintilla/qt/ScintillaEditBase/ScintillaEditBase.h \
    3rd-party/scintilla/qt/ScintillaEditBase/ScintillaQt.h

INCLUDEPATH +=  3rd-party/scintilla/qt/ScintillaEditBase \
                3rd-party/scintilla/include \
                3rd-party/scintilla/src \
                3rd-party/scintilla/lexlib

DEFINES *= SCINTILLA_QT=1 MAKING_LIBRARY=1 SCI_LEXER=1 _CRT_SECURE_NO_DEPRECATE=1

CONFIG(release, debug|release) {
  DEFINES *= NDEBUG=1
}

# Add hoextdown.
SOURCES += $$files(3rd-party/hoedown/*.c, false)
HEADERS  += $$files(3rd-party/hoedown/*.h, false)

INCLUDEPATH +=  $$PWD/. \
                $$PWD/common/gui \
                $$PWD/saurus/gui \
                $$PWD/saurus/gui/dialogs \
                $$PWD/saurus/gui/sidebars \
                $$PWD/saurus/gui/settings \
                $$PWD/common/dynamic-shortcuts \
                $$PWD/saurus/external-tools \
                $$PWD/saurus/plugin-system

# Localizations.
TRANSLATIONS_WO_QT += $$PWD/../../localization/textosaurus_en.ts \
                      $$PWD/../../localization/textosaurus_cs.ts \
                      $$PWD/../../localization/textosaurus_sk.ts

TRANSLATIONS += $$TRANSLATIONS_WO_QT \
                $$PWD/../../localization/qtbase_cs.ts \
                $$PWD/../../localization/qtbase_sk.ts

load(uic)
uic.commands -= -no-stringliteral

# Create new "make lupdate" target.
lupdate.target = lupdate
lupdate.commands = lupdate -no-obsolete -pro $$shell_path($$PWD/libtextosaurus.pro) -ts $$TRANSLATIONS_WO_QT

QMAKE_EXTRA_TARGETS += lupdate

# Make sure QM translations are created.
qtPrepareTool(LRELEASE, lrelease) {
  message($$MSG_PREFIX: Running: $$LRELEASE_EXECUTABLE -compress $$shell_quote($$shell_path($$PWD/libtextosaurus.pro)))
  system($$LRELEASE_EXECUTABLE -compress libtextosaurus.pro)
}

static {
  message($$MSG_PREFIX: Building static version of library.)
}
else {
  message($$MSG_PREFIX: Building shared version of library.)
}

mac {
  IDENTIFIER = $$APP_REVERSE_NAME
  CONFIG -= app_bundle
  QMAKE_MAC_SDK = macosx10.12
  QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7
  LIBS += -framework AppKit
}
