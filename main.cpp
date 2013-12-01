#include <QApplication>
#include "qmlapplicationviewer.h"
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

    QmlApplicationViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/ShiftTracker1/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
