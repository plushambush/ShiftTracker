#include "stviewer.h"
#include <QCloseEvent>
#include <QMessageBox>

STViewer::STViewer(QWidget *parent): QmlApplicationViewer(parent)    {
};

void STViewer::closeEvent(QCloseEvent *event) {
    if (askQuit()) {
        event->accept();
    }
    else {
        event->ignore();
    }
}

bool STViewer::askQuit()
{
    QMessageBox::StandardButton ret;
    ret = QMessageBox::warning(this, tr("ShiftTracker"),
                     tr("Are you sure to quit application"),
                     QMessageBox::Yes | QMessageBox::Cancel);
    if (ret == QMessageBox::Yes)
            return true;
    else if (ret == QMessageBox::Cancel)
            return false;
    return false;
};
