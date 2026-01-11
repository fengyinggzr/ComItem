#ifndef COMITEM_H
#define COMITEM_H

#include "comitem_global.h"
#include <QtQuick/QQuickPaintedItem>
#include <QtQml/qqmlregistration.h>

class COMITEM_EXPORT ComItem : public QQuickPaintedItem
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
