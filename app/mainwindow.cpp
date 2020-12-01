#include "mainwindow.h"
#include "./ui_mainwindow.h"

#include "pchinesecalendar.h"
#include "pgregoriancalendar.h"

#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    PChineseCalendar cal;
    cal.setTime(PAbstructCalendar::now());
    PGregorianCalendar gcal;
    gcal.setTime(PAbstructCalendar::now());

    qDebug() << cal.yearDisplayName() << cal.monthDisplayName() << cal.dayDisplayName();
    qDebug() << gcal.yearDisplayName() << gcal.monthDisplayName() << gcal.dayDisplayName();
}

MainWindow::~MainWindow()
{
    delete ui;
}

