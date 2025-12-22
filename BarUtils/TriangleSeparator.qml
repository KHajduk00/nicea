import QtQuick

Canvas {
    id: separator
    implicitWidth: 15
    implicitHeight: parent.height
    antialiasing: false
    
    property color fillColor: "transparent"
    property color backgroundColor: "transparent"
    property bool pointingRight: true
    
    onFillColorChanged: requestPaint()
    onBackgroundColorChanged: requestPaint()
    onPointingRightChanged: requestPaint()
    
    onPaint: {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);
        
        ctx.fillStyle = backgroundColor;
        ctx.fillRect(0, 0, width, height);
        
        ctx.fillStyle = fillColor;
        ctx.beginPath();
        
        if (pointingRight) {
            ctx.moveTo(0, 0);
            ctx.lineTo(width, height / 2);
            ctx.lineTo(0, height);
            ctx.closePath();
        } else {
            ctx.moveTo(0, height / 2);
            ctx.lineTo(width, 0);
            ctx.lineTo(width, height);
            ctx.closePath();
        }
        
        ctx.fill();
    }
}