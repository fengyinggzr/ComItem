#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    
    // 添加构建目录中的 QML 模块路径，以便可以找到 ComItem 插件
    engine.addImportPath(QStringLiteral("qrc:/qt/qml"));
    engine.addImportPath(app.applicationDirPath() + QStringLiteral("/../qml"));
    
    // The first subfolder is the libraryName followed by the regular
    // folder structure: LibraryName/Subfolder
    const QUrl url(QStringLiteral("qrc:/qt/qml/ExampleProjectApp/example/example.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
