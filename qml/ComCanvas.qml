import QtQuick

// ComCanvas - 自定义绘图组件
Item {
    id: root

    property color strokeColor: ComTheme.primary
    property color fillColor: ComTheme.primaryLight
    property int strokeWidth: 2
    property string shape: "rectangle"  // "rectangle", "circle", "triangle", "star", "wave"
    property bool filled: true
    property real progress: 0.0  // 用于动画绘制 0.0-1.0

    implicitWidth: 100
    implicitHeight: 100

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            ctx.strokeStyle = root.strokeColor
            ctx.fillStyle = root.fillColor
            ctx.lineWidth = root.strokeWidth
            ctx.lineCap = "round"
            ctx.lineJoin = "round"

            var padding = root.strokeWidth
            var w = width - padding * 2
            var h = height - padding * 2
            var cx = width / 2
            var cy = height / 2

            switch (root.shape) {
                case "rectangle":
                    drawRectangle(ctx, padding, padding, w, h)
                    break
                case "circle":
                    drawCircle(ctx, cx, cy, Math.min(w, h) / 2)
                    break
                case "triangle":
                    drawTriangle(ctx, cx, cy, Math.min(w, h) / 2)
                    break
                case "star":
                    drawStar(ctx, cx, cy, Math.min(w, h) / 2, 5)
                    break
                case "wave":
                    drawWave(ctx, padding, cy, w, h / 3)
                    break
                case "chart":
                    drawChart(ctx, padding, padding, w, h)
                    break
            }
        }

        function drawRectangle(ctx, x, y, w, h) {
            var radius = ComTheme.radiusMedium
            ctx.beginPath()
            ctx.moveTo(x + radius, y)
            ctx.lineTo(x + w - radius, y)
            ctx.arcTo(x + w, y, x + w, y + radius, radius)
            ctx.lineTo(x + w, y + h - radius)
            ctx.arcTo(x + w, y + h, x + w - radius, y + h, radius)
            ctx.lineTo(x + radius, y + h)
            ctx.arcTo(x, y + h, x, y + h - radius, radius)
            ctx.lineTo(x, y + radius)
            ctx.arcTo(x, y, x + radius, y, radius)
            ctx.closePath()
            if (root.filled) ctx.fill()
            ctx.stroke()
        }

        function drawCircle(ctx, cx, cy, r) {
            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.closePath()
            if (root.filled) ctx.fill()
            ctx.stroke()
        }

        function drawTriangle(ctx, cx, cy, r) {
            ctx.beginPath()
            for (var i = 0; i < 3; i++) {
                var angle = (i * 120 - 90) * Math.PI / 180
                var x = cx + r * Math.cos(angle)
                var y = cy + r * Math.sin(angle)
                if (i === 0) ctx.moveTo(x, y)
                else ctx.lineTo(x, y)
            }
            ctx.closePath()
            if (root.filled) ctx.fill()
            ctx.stroke()
        }

        function drawStar(ctx, cx, cy, r, points) {
            var innerRadius = r * 0.4
            ctx.beginPath()
            for (var i = 0; i < points * 2; i++) {
                var radius = (i % 2 === 0) ? r : innerRadius
                var angle = (i * 180 / points - 90) * Math.PI / 180
                var x = cx + radius * Math.cos(angle)
                var y = cy + radius * Math.sin(angle)
                if (i === 0) ctx.moveTo(x, y)
                else ctx.lineTo(x, y)
            }
            ctx.closePath()
            if (root.filled) ctx.fill()
            ctx.stroke()
        }

        function drawWave(ctx, x, cy, w, amplitude) {
            ctx.beginPath()
            ctx.moveTo(x, cy)
            var segments = 50
            for (var i = 0; i <= segments; i++) {
                var px = x + (w * i / segments)
                var py = cy + Math.sin((i / segments) * Math.PI * 4 + root.progress * Math.PI * 2) * amplitude
                ctx.lineTo(px, py)
            }
            ctx.stroke()
        }

        function drawChart(ctx, x, y, w, h) {
            var data = [0.3, 0.7, 0.5, 0.9, 0.4, 0.8, 0.6]
            var barWidth = w / (data.length * 2)
            var gap = barWidth

            for (var i = 0; i < data.length; i++) {
                var barHeight = h * data[i]
                var bx = x + i * (barWidth + gap) + gap / 2
                var by = y + h - barHeight

                // 渐变色
                var gradient = ctx.createLinearGradient(bx, by, bx, by + barHeight)
                gradient.addColorStop(0, root.strokeColor)
                gradient.addColorStop(1, root.fillColor)

                ctx.fillStyle = gradient
                ctx.beginPath()
                ctx.roundedRect(bx, by, barWidth, barHeight, 2, 2)
                ctx.fill()
            }
        }
    }

    onStrokeColorChanged: canvas.requestPaint()
    onFillColorChanged: canvas.requestPaint()
    onStrokeWidthChanged: canvas.requestPaint()
    onShapeChanged: canvas.requestPaint()
    onFilledChanged: canvas.requestPaint()
    onProgressChanged: canvas.requestPaint()
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()
}
