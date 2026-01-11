#ifndef COMPROGRESSBAR_H
#define COMPROGRESSBAR_H

#include "comitem_global.h"
#include <QtQuick/QQuickPaintedItem>
#include <QtQml/qqmlregistration.h>
#include <QColor>

class COMITEM_EXPORT ComProgressBar : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(qreal minimumValue READ minimumValue WRITE setMinimumValue NOTIFY minimumValueChanged)
    Q_PROPERTY(qreal maximumValue READ maximumValue WRITE setMaximumValue NOTIFY maximumValueChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor progressColor READ progressColor WRITE setProgressColor NOTIFY progressColorChanged)
    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(bool showText READ showText WRITE setShowText NOTIFY showTextChanged)

public:
    explicit ComProgressBar(QQuickItem *parent = nullptr);
    ~ComProgressBar() override;

    void paint(QPainter *painter) override;

    qreal value() const;
    void setValue(qreal value);

    qreal minimumValue() const;
    void setMinimumValue(qreal value);

    qreal maximumValue() const;
    void setMaximumValue(qreal value);

    QColor backgroundColor() const;
    void setBackgroundColor(const QColor &color);

    QColor progressColor() const;
    void setProgressColor(const QColor &color);

    int radius() const;
    void setRadius(int radius);

    bool showText() const;
    void setShowText(bool show);

signals:
    void valueChanged();
    void minimumValueChanged();
    void maximumValueChanged();
    void backgroundColorChanged();
    void progressColorChanged();
    void radiusChanged();
    void showTextChanged();

private:
    qreal m_value;
    qreal m_minimumValue;
    qreal m_maximumValue;
    QColor m_backgroundColor;
    QColor m_progressColor;
    int m_radius;
    bool m_showText;
};

#endif // COMPROGRESSBAR_H
