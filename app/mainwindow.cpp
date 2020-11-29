#include "mainwindow.h"
#include "./ui_mainwindow.h"

#include "pchinesecalendar.h"

#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    PChineseCalendar cal;
    cal.setTime(PAbstructCalendar::now());

    qDebug() << cal.yearDisplayName() << cal.monthDisplayName() << cal.dayDisplayName();
}

MainWindow::~MainWindow()
{
    delete ui;
}

