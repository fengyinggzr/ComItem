#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 添加 ComItem 插件的 QML 导入路径
    // 默认查找父目录的 build/qml 文件夹
    QString qmlPath = QString::fromUtf8(QML_IMPORT_PATH);
    if (!qmlPath.isEmpty()) {
        engine.addImportPath(qmlPath);
    }

    // 输出当前的导入路径，便于调试
    qDebug() << "QML Import Paths:" << engine.importPathList();

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("ComItemExample", "Main");

    return app.exec();
}
