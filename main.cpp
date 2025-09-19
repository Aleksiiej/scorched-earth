#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <FelgoApplication> 

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    FelgoApplication felgo;

    QQmlApplicationEngine engine;
    felgo.initialize(&engine);
    const QUrl url(u"qrc:/scorched-earth/qml/main.qml"_qs);
    engine.load(url);

    return app.exec();
}