/*
    Grover OS - Kodiak desktop loading screen (KSplash)
    Picks up where the boot screen leaves off: the bear and title hold,
    the eye keeps pulsing, and a thin blue bar fills as the desktop loads.
    Images are links to the boot-screen art in the Plymouth theme.
*/
import QtQuick

Rectangle {
    id: root
    color: "#000000"

    // KSplash raises this from 1 to 6 as Plasma starts up.
    property int stage: 0

    readonly property real bearAspect: bear.sourceSize.width > 0
        ? bear.sourceSize.height / bear.sourceSize.width : 782 / 1400
    readonly property real bw: Math.min(width * 0.55, height * 0.55 / bearAspect)
    readonly property real bh: bw * bearAspect
    readonly property real s: bw / 1400      // bear.png is 1400 px wide

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        NumberAnimation on opacity { from: 0; to: 1; duration: 500; easing.type: Easing.OutQuad }

        Image {
            id: bear
            source: "images/bear.png"
            width: root.bw
            height: root.bh
            x: (root.width - width) / 2
            y: root.height * 0.40 - height / 2
            smooth: true
        }

        Image {
            id: glow
            source: "images/glow.png"
            width: 200 * root.s * 2.0
            height: width
            x: bear.x + 380 * root.s - width / 2      // the bear's eye
            y: bear.y + 280 * root.s - height / 2
            opacity: 0.8
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 1.0; duration: 1300; easing.type: Easing.InOutSine }
                NumberAnimation { to: 0.6; duration: 1300; easing.type: Easing.InOutSine }
            }
        }

        Image {
            id: title
            source: "images/title.png"
            width: root.bw * 0.62
            height: width * sourceSize.height / Math.max(1, sourceSize.width)
            x: (root.width - width) / 2
            y: bear.y + bear.height + root.height * 0.02
            smooth: true
        }

        Image {
            id: sub
            source: "images/subtitle.png"
            width: title.width * 0.45
            height: width * sourceSize.height / Math.max(1, sourceSize.width)
            x: (root.width - width) / 2
            y: title.y + title.height
            opacity: 0.9
            smooth: true
        }

        // Loading bar
        Rectangle {
            id: track
            width: root.bw * 0.4
            height: 3
            radius: 1.5
            color: "#16263a"
            x: (root.width - width) / 2
            y: sub.y + sub.height + root.height * 0.03

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
