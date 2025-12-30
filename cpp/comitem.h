#ifndef COMITEM_H
#define COMITEM_H

#include <QtQuick/QQuickPaintedItem>
#include <QtQml/qqmlregistration.h>

// 导出宏定义
#if defined(COMITEM_LIBRARY)
#  define COMITEM_EXPORT Q_DECL_EXPORT
#else
#  define COMITEM_EXPORT Q_DECL_IMPORT
#endif

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
