# ComItem AI Coding Instructions

This repository contains **ComItem**, a Qt6 QML Plugin library delivering a unified blue-purple themed UI component set. It uses a dual-layer architecture (C++ & QML) and is designed for seamless integration with Qt Creator and Qt Design Studio.

## Project Architecture

### 1. Dual-Layer Component System
- **C++ Components** (`cpp/`):
  - Handle complex logic, custom painting (`QQuickPaintedItem`), or system integration.
  - Exposed to QML via `QML_ELEMENT` macro.
  - Example: `ComProgressBar`, `ComThemeAttached`.
- **QML Components** (`qml/`):
  - Purely declarative UI components.
  - Inherit from standard Qt Quick Controls (e.g., `Button`, `TextField`).
  - Style strictly using the `ComTheme` system.
  - Example: `ComButton.qml`, `ComSwitch.qml`.

### 2. Theming System (`ComTheme`)
- **Compulsory Usage**: All visual components **must** derive colors, fonts, and metrics from `ComTheme` attached properties.
- **Implementation**: Defined in `cpp/ComThemeAttached.h`.
  - `ComThemeAttached`: The data class holding values (e.g., `primary`, `radiusMedium`).
  - `ComTheme`: The anchor class using `QML_ATTACHED(ComThemeAttached)`.
- **Usage**: `ComTheme.primary`, `ComTheme.textOnPrimary`, `ComTheme.spacingSmall`.

### 3. Module Definition
- Defined in `CMakeLists.txt` using `qt_add_qml_module`.
- URI: `ComItem`
- Plugin Target: `ComItemplugin`

## Development Workflows

### Build System
- **Generator**: Ninja (preferred).
- **Process**:
  1. Configure: `cmake -B build -G Ninja -DCMAKE_PREFIX_PATH="<PATH_TO_QT>"`
  2. Build: `cmake --build build --config Debug`
  3. **Auto-Install**: The build scripts are configured to automatically install artifacts into the Qt SDK QML directories and Qt Design Studio directories. **Be aware that builds modify the local Qt SDK.**

### Running Examples
The `example/` directory is a **standalone** CMake project that depends on the installed/built `ComItem` library.
1. Build root `ComItem` project first.
2. Build `example` project:
   ```powershell
   cd example
   cmake -B build -G Ninja -DCMAKE_PREFIX_PATH="<PATH_TO_QT>"
   cmake --build build
   ```
3. Run: `.\build\Debug\ComItemExample.exe`

## Coding Conventions

### QML (`.qml`)
- **Root ID**: Always name the root element `id: root`.
- **Imports**:
  ```qml
  import QtQuick
  import QtQuick.Controls
  import QtQuick.Controls.Basic
  // ComItem is implicit if inside the module, otherwise import ComItem
  ```
- **Sizing**: Use `implicitWidth` and `implicitHeight`.
- **Theming Example**:
  ```qml
  Rectangle {
      color: root.enabled ? ComTheme.primary : ComTheme.backgroundDisabled
      radius: ComTheme.radiusMedium
      border.color: ComTheme.border
  }
  ```

### C++ (`.cpp`/`.h`)
- **Standard**: C++20.
- **Macros**:
  - `COMITEM_EXPORT` for all public classes.
  - `Q_OBJECT`, `QML_ELEMENT` / `QML_NAMED_ELEMENT` for QML exposure.
- **Properties**: Prefer `CONSTANT` properties for theme values that don't change at runtime.

## Common Tasks

- **Adding a new QML Component**:
  1. Create `qml/ComNewItem.qml`.
  2. It is automatically picked up by `file(GLOB QML_FILES ...)` in `CMakeLists.txt`, but purely relying on GLOB can be flaky; re-configure CMake if needed.
  3. Use `ComTheme` for all styling.

- **Adding a new C++ Component**:
  1. Create `.h` and `.cpp` in `cpp/`.
  2. Add `QML_ELEMENT` to header.
  3. Re-configure CMake (GLOB will pick it up).

## Debugging
- If QML components are not found, check if `qt_add_qml_module` in `CMakeLists.txt` includes the file.
- `ComItemExample` prints import paths on startup; check console output to verify module resolution (especially `QT_PLUGIN_PATH` or `QML_IMPORT_PATH`).
