#ifndef STVIEWER_H
#define STVIEWER_H
#include "qmlapplicationviewer.h"
#include <QCloseEvent>

class STViewer : public QmlApplicationViewer
{
    Q_OBJECT
public:

    explicit STViewer(QWidget *parent=0);

    void closeEvent(QCloseEvent *event);

    bool askQuit();
};

#endif // STVIEWER_H
