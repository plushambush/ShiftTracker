#include <QApplication>
#include "qmlapplicationviewer.h"
#include "stviewer.h"

//#include <QGraphicsEffect>
//#include <QDeclarativeEngine>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    // Custom start
  /*  qmlRegisterType<QGraphicsBlurEffect>("Effects",1,0,"Blur");
    qmlRegisterType<QGraphicsColorizeEffect>("Effects",1,0,"Colorize");
    qmlRegisterType<QGraphicsDropShadowEffect>("Effects",1,0,"DropShadow");
    qmlRegisterType<QGraphicsOpacityEffect>("Effects",1,0,"OpacityEffect");*/
    // Custom end

    QScopedPointer<QApplication> app(createApplication(argc, argv));

    STViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
