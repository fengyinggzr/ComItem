#ifndef COMBUTTON_H
#define COMBUTTON_H

#include <QtQuick/QQuickPaintedItem>
#include <QtQml/qqmlregistration.h>
#include <QColor>

// 导出宏定义
#if defined(COMITEM_LIBRARY)
#  define COMITEM_EXPORT Q_DECL_EXPORT
#else
#  define COMITEM_EXPORT Q_DECL_IMPORT
#endif

class COMITEM_EXPORT ComButton : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(bool pressed READ pressed NOTIFY pressedChanged)
    Q_PROPERTY(bool hovered READ hovered NOTIFY hoveredChanged)

public:
    explicit ComButton(QQuickItem *parent = nullptr);
    ~ComButton() override;

    void paint(QPainter *painter) override;

    QString text() const;
    void setText(const QString &text);

    QColor backgroundColor() const;
    void setBackgroundColor(const QColor &color);

    QColor textColor() const;
    void setTextColor(const QColor &color);

    int radius() const;
    void setRadius(int radius);

    bool pressed() const;
    bool hovered() const;

signals:
    void clicked();
    void textChanged();
    void backgroundColorChanged();
    void textColorChanged();
    void radiusChanged();
    void pressedChanged();
    void hoveredChanged();

protected:
    void mousePressEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;
    void hoverEnterEvent(QHoverEvent *event) override;
    void hoverLeaveEvent(QHoverEvent *event) override;

private:
    QString m_text;
    QColor m_backgroundColor;
    QColor m_textColor;
    int m_radius;
    bool m_pressed;
    bool m_hovered;
};

#endif // COMBUTTON_H
