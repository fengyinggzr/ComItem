#ifndef COMTHEMEATTACHED_H
#define COMTHEMEATTACHED_H

#include "comitem_global.h"
#include <QObject>
#include <QColor>
#include <QQmlEngine>
#include <qtmetamacros.h>

// ComThemeAttached - 附加属性类
class COMITEM_EXPORT ComThemeAttached : public QObject
{
    Q_OBJECT
    QML_ANONYMOUS

    // 主色调
    Q_PROPERTY(QColor primary READ primary CONSTANT)
    Q_PROPERTY(QColor primaryHover READ primaryHover CONSTANT)
    Q_PROPERTY(QColor primaryPressed READ primaryPressed CONSTANT)
    Q_PROPERTY(QColor primaryLight READ primaryLight CONSTANT)

    // 文字颜色
    Q_PROPERTY(QColor textPrimary READ textPrimary CONSTANT)
    Q_PROPERTY(QColor textSecondary READ textSecondary CONSTANT)
    Q_PROPERTY(QColor textDisabled READ textDisabled CONSTANT)
    Q_PROPERTY(QColor textOnPrimary READ textOnPrimary CONSTANT)

    // 背景颜色
    Q_PROPERTY(QColor background READ background CONSTANT)
    Q_PROPERTY(QColor backgroundHover READ backgroundHover CONSTANT)
    Q_PROPERTY(QColor backgroundDisabled READ backgroundDisabled CONSTANT)

    // 边框颜色
    Q_PROPERTY(QColor border READ border CONSTANT)
    Q_PROPERTY(QColor borderFocus READ borderFocus CONSTANT)
    Q_PROPERTY(QColor borderError READ borderError CONSTANT)

    // 状态颜色
    Q_PROPERTY(QColor success READ success CONSTANT)
    Q_PROPERTY(QColor warning READ warning CONSTANT)
    Q_PROPERTY(QColor error READ error CONSTANT)

    // 阴影
    Q_PROPERTY(QColor shadow READ shadow CONSTANT)

    // 通用属性
    Q_PROPERTY(int radiusSmall READ radiusSmall CONSTANT)
    Q_PROPERTY(int radiusMedium READ radiusMedium CONSTANT)
    Q_PROPERTY(int radiusLarge READ radiusLarge CONSTANT)
    Q_PROPERTY(int radiusCombo READ radiusCombo CONSTANT)

    Q_PROPERTY(int fontSizeSmall READ fontSizeSmall CONSTANT)
    Q_PROPERTY(int fontSizeMedium READ fontSizeMedium CONSTANT)
    Q_PROPERTY(int fontSizeLarge READ fontSizeLarge CONSTANT)

    Q_PROPERTY(int spacingSmall READ spacingSmall CONSTANT)
    Q_PROPERTY(int spacingMedium READ spacingMedium CONSTANT)
    Q_PROPERTY(int spacingLarge READ spacingLarge CONSTANT)

    Q_PROPERTY(int animationDuration READ animationDuration CONSTANT)

public:
    explicit ComThemeAttached(QObject *parent = nullptr);

    // Getters
    QColor primary() const { return QColor("#6366f1"); }
    QColor primaryHover() const { return QColor("#4f46e5"); }
    QColor primaryPressed() const { return QColor("#4338ca"); }
    QColor primaryLight() const { return QColor("#a5b4fc"); }

    QColor textPrimary() const { return QColor("#1e1b4b"); }
    QColor textSecondary() const { return QColor("#6b7280"); }
    QColor textDisabled() const { return QColor("#9ca3af"); }
    QColor textOnPrimary() const { return QColor("#ffffff"); }

    QColor background() const { return QColor("#ffffff"); }
    QColor backgroundHover() const { return QColor("#f5f3ff"); }
    QColor backgroundDisabled() const { return QColor("#f3f4f6"); }

    QColor border() const { return QColor("#c7d2fe"); }
    QColor borderFocus() const { return QColor("#6366f1"); }
    QColor borderError() const { return QColor("#ef4444"); }

    QColor success() const { return QColor("#10b981"); }
    QColor warning() const { return QColor("#f59e0b"); }
    QColor error() const { return QColor("#ef4444"); }

    QColor shadow() const { return QColor("#1e1b4b20"); }

    int radiusSmall() const { return 4; }
    int radiusMedium() const { return 6; }
    int radiusLarge() const { return 8; }
    int radiusCombo() const { return 1; }

    int fontSizeSmall() const { return 12; }
    int fontSizeMedium() const { return 14; }
    int fontSizeLarge() const { return 16; }

    int spacingSmall() const { return 4; }
    int spacingMedium() const { return 8; }
    int spacingLarge() const { return 12; }

    int animationDuration() const { return 150; }
};

// ComTheme - 提供附加属性的类
class COMITEM_EXPORT ComTheme : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_ATTACHED(ComThemeAttached)
    QML_UNCREATABLE("ComTheme is an attached property")

public:
    explicit ComTheme(QObject *parent = nullptr) : QObject(parent) {}

    static ComThemeAttached *qmlAttachedProperties(QObject *object)
    {
        return new ComThemeAttached(object);
    }
};

#endif // COMTHEMEATTACHED_H
