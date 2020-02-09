QT += quick quickcontrols2
CONFIG += c++11
CONFIG += warn_on

SOURCES += EmbeddedDocumentationMain.cpp
RESOURCES += EmbeddedDocumentation.qrc
OTHER_FILES += README.md
OTHER_FILES += LICENSE

INCLUDEPATH += src/
HEADERS += src/Documentation.h
HEADERS += src/DocumentationController.h
SOURCES += src/Documentation.cpp
SOURCES += src/DocumentationController.cpp
