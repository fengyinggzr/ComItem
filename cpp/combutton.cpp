#include "combutton.h"
#include <QPainter>
#include <QMouseEvent>

ComButton::ComButton(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , m_text("Button")
    , m_backgroundColor("#3498db")
    , m_textColor("#ffffff")
    , m_radius(5)
    , m_pressed(false)
    , m_hovered(false)
{
    setAcceptedMouseButtons(Qt::LeftButton);
    setAcceptHoverEvents(true);
    
    // 设置默认尺寸
    setImplicitWidth(100);
    setImplicitHeight(36);
}

ComButton::~ComButton() {}

void ComButton::paint(QPainter *painter)
{
    painter->setRenderHint(QPainter::Antialiasing);

    // 根据状态调整颜色
    QColor bgColor = m_backgroundColor;
    if (m_pressed) {
        bgColor = bgColor.darker(120);
    } else if (m_hovered) {
        bgColor = bgColor.lighter(110);
    }

    // 绘制背景
    painter->setPen(Qt::NoPen);
    painter->setBrush(bgColor);
    painter->drawRoundedRect(boundingRect(), m_radius, m_radius);

    // 绘制文字
    painter->setPen(m_textColor);
    QFont font = painter->font();
    font.setPointSize(12);
    painter->setFont(font);
    painter->drawText(boundingRect(), Qt::AlignCenter, m_text);
}

QString ComButton::text() const { return m_text; }

void ComButton::setText(const QString &text)
{
    if (m_text != text) {
        m_text = text;
        emit textChanged();
        update();
    }
}

QColor ComButton::backgroundColor() const { return m_backgroundColor; }

void ComButton::setBackgroundColor(const QColor &color)
{
    if (m_backgroundColor != color) {
        m_backgroundColor = color;
        emit backgroundColorChanged();
        update();
    }
}

QColor ComButton::textColor() const { return m_textColor; }

void ComButton::setTextColor(const QColor &color)
{
    if (m_textColor != color) {
        m_textColor = color;
        emit textColorChanged();
        update();
    }
}

int ComButton::radius() const { return m_radius; }

void ComButton::setRadius(int radius)
{
    if (m_radius != radius) {
        m_radius = radius;
        emit radiusChanged();
        update();
    }
}

bool ComButton::pressed() const { return m_pressed; }
bool ComButton::hovered() const { return m_hovered; }

void ComButton::mousePressEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        m_pressed = true;
        emit pressedChanged();
        update();
    }
}

void ComButton::mouseReleaseEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        m_pressed = false;
        emit pressedChanged();
        if (boundingRect().contains(event->position())) {
            emit clicked();
        }
        update();
    }
}

void ComButton::hoverEnterEvent(QHoverEvent *event)
{
    Q_UNUSED(event)
    m_hovered = true;
    emit hoveredChanged();
    update();
}

void ComButton::hoverLeaveEvent(QHoverEvent *event)
{
    Q_UNUSED(event)
    m_hovered = false;
    emit hoveredChanged();
    update();
}
