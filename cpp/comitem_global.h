#ifndef COMITEM_GLOBAL_H
#define COMITEM_GLOBAL_H

#include <QtCore/qglobal.h>

// ComItem 库导出宏定义
// 编译库时定义 COMITEM_LIBRARY 以导出符号
// 使用库时不定义 COMITEM_LIBRARY 以导入符号
#if defined(COMITEM_LIBRARY)
#  define COMITEM_EXPORT Q_DECL_EXPORT
#else
#  define COMITEM_EXPORT Q_DECL_IMPORT
#endif

#endif // COMITEM_GLOBAL_H
