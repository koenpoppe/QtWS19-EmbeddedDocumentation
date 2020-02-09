#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

#include "Documentation.h"
#include "DocumentationController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const char *uri = "EmbeddedDocumentation";
    qmlRegisterType<Documentation>(uri, 1, 0, "Documentation");
    qmlRegisterType<DocumentationController>(uri, 1, 0, "DocumentationController");

    QQuickStyle::setStyle("Material");
    const QUrl url(QStringLiteral("qrc:/qml/EmbeddedDocumentationMain.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return QGuiApplication::exec();
}
