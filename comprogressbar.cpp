#include "comprogressbar.h"
#include <QPainter>

ComProgressBar::ComProgressBar(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , m_value(0)
    , m_minimumValue(0)
    , m_maximumValue(100)
    , m_backgroundColor("#e0e0e0")
    , m_progressColor("#2ecc71")
    , m_radius(5)
    , m_showText(true)
{
}

ComProgressBar::~ComProgressBar() {}

void ComProgressBar::paint(QPainter *painter)
{
    painter->setRenderHint(QPainter::Antialiasing);

    QRectF rect = boundingRect();

    // 绘制背景
    painter->setPen(Qt::NoPen);
    painter->setBrush(m_backgroundColor);
    painter->drawRoundedRect(rect, m_radius, m_radius);

    // 计算进度
    qreal range = m_maximumValue - m_minimumValue;
    qreal progress = (range > 0) ? (m_value - m_minimumValue) / range : 0;
    progress = qBound(0.0, progress, 1.0);

    // 绘制进度条
    if (progress > 0) {
        QRectF progressRect = rect;
        progressRect.setWidth(rect.width() * progress);
        painter->setBrush(m_progressColor);
        painter->drawRoundedRect(progressRect, m_radius, m_radius);
    }

    // 绘制文字
    if (m_showText) {
        painter->setPen(Qt::black);
        QFont font = painter->font();
        font.setPointSize(10);
        painter->setFont(font);
        QString text = QString::number(qRound(progress * 100)) + "%";
        painter->drawText(rect, Qt::AlignCenter, text);
    }
}

qreal ComProgressBar::value() const { return m_value; }

void ComProgressBar::setValue(qreal value)
{
    value = qBound(m_minimumValue, value, m_maximumValue);
    if (!qFuzzyCompare(m_value, value)) {
        m_value = value;
        emit valueChanged();
        update();
    }
}

qreal ComProgressBar::minimumValue() const { return m_minimumValue; }

void ComProgressBar::setMinimumValue(qreal value)
{
    if (!qFuzzyCompare(m_minimumValue, value)) {
        m_minimumValue = value;
        emit minimumValueChanged();
        update();
    }
}

qreal ComProgressBar::maximumValue() const { return m_maximumValue; }

void ComProgressBar::setMaximumValue(qreal value)
{
    if (!qFuzzyCompare(m_maximumValue, value)) {
        m_maximumValue = value;
        emit maximumValueChanged();
        update();
    }
}

QColor ComProgressBar::backgroundColor() const { return m_backgroundColor; }

void ComProgressBar::setBackgroundColor(const QColor &color)
{
    if (m_backgroundColor != color) {
        m_backgroundColor = color;
        emit backgroundColorChanged();
        update();
    }
}

QColor ComProgressBar::progressColor() const { return m_progressColor; }

void ComProgressBar::setProgressColor(const QColor &color)
{
    if (m_progressColor != color) {
        m_progressColor = color;
        emit progressColorChanged();
        update();
    }
}

int ComProgressBar::radius() const { return m_radius; }

void ComProgressBar::setRadius(int radius)
{
    if (m_radius != radius) {
        m_radius = radius;
        emit radiusChanged();
        update();
    }
}

bool ComProgressBar::showText() const { return m_showText; }

void ComProgressBar::setShowText(bool show)
{
    if (m_showText != show) {
        m_showText = show;
        emit showTextChanged();
        update();
    }
}
