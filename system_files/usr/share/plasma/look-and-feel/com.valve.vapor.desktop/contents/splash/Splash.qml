/*
    Grover OS - Kodiak desktop loading screen (KSplash)
    Installed over Bazzite's com.valve.vapor.desktop splash so every path shows Grover.
    Black screen, GROVER KODIAK title and GROVER OS 1.0 subtitle (same art as
    the boot screen), and a thin blue bar that fills as Plasma starts.
    Images are links to the boot-screen art in the Plymouth theme.
*/
import QtQuick

Rectangle {
    id: root
    color: "#000000"

    // KSplash raises this from 1 to 6 as Plasma starts up.
    property int stage: 0

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        NumberAnimation on opacity { from: 0; to: 1; duration: 500; easing.type: Easing.OutQuad }

        readonly property real tw: Math.min(root.width * 0.34, root.height * 0.75)
        readonly property real gap: root.height * 0.035
        readonly property real barH: Math.max(2, root.height * 0.0022)
        readonly property real blockH: title.height + sub.height + gap + barH

        Image {
            id: title
            source: "images/title.png"
            width: content.tw
            height: width * sourceSize.height / Math.max(1, sourceSize.width)
            x: (root.width - width) / 2
            y: root.height * 0.47 - content.blockH / 2
            smooth: true
        }

        Image {
            id: sub
            source: "images/subtitle.png"
            width: content.tw * 0.45
            height: width * sourceSize.height / Math.max(1, sourceSize.width)
            x: (root.width - width) / 2
            y: title.y + title.height
            opacity: 0.9
            smooth: true
        }

        // Loading bar
        Rectangle {
            id: track
            width: content.tw * 0.55
            height: content.barH
            radius: height / 2
            color: "#16263a"
            x: (root.width - width) / 2
            y: sub.y + sub.height + content.gap

            Rectangle {
                height: parent.height
                radius: parent.radius
                color: "#3b9cff"
                width: parent.width * Math.min(1, root.stage / 6)
                Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }
            }
        }
    }
}
