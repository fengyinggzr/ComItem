#ifndef COMITEM_H
#define COMITEM_H

#include <QtQuick/QQuickPaintedItem>

class ComItem : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_DISABLE_COPY(ComItem)
public:
    explicit ComItem(QQuickItem *parent = nullptr);
    void paint(QPainter *painter) override;
    ~ComItem() override;
};

#endif // COMITEM_H
