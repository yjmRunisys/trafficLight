import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Item {
    width:parent.width;
    height:parent.height;

    property real margin: 25
    property real circle_radius: 100
    property bool color_flag: true

    Rectangle
    {
        id: rect_root
        width: 150
        height: 450
        color:"black"
        focus: true
        state: "red"       

        Rectangle
        {
            id: rect_circle_red
            width: 100
            height: 100
            color: focus?"red":"gray"

            anchors.top: rect_root.top
            anchors.left: rect_root.left
            anchors.right: rect_root.right
            anchors.topMargin: margin
            anchors.leftMargin: margin
            anchors.rightMargin: margin

            radius: circle_radius
        }

        Rectangle
        {
            id: rect_circle_yellow
            width: 100
            height: 100
            color: focus?"yellow":"gray"

            anchors.centerIn: rect_root
            anchors.left: rect_root.left
            anchors.right: rect_root.right
            anchors.leftMargin: margin
            anchors.rightMargin: margin

            radius: circle_radius
        }

        Rectangle
        {
            id: rect_circle_green
            width: 100
            height: 100
            color: focus?"green":"gray"

            anchors.bottom: rect_root.bottom
            anchors.left: rect_root.left
            anchors.right: rect_root.right
            anchors.bottomMargin: margin
            anchors.leftMargin: margin
            anchors.rightMargin: margin

            radius: circle_radius
        }

        states:
        [
            State
            {
                name: "red"

                PropertyChanges
                {
                    target: rect_circle_red
                    focus: true
                }
            },

            State
            {
                name: "yellow"
                PropertyChanges
                {
                    target: rect_circle_yellow
                    focus: true
                }
            },

            State
            {
                name: "green"
                PropertyChanges
                {
                    target: rect_circle_green
                    focus: true
                }
            }
        ]

        transitions:
        [
            Transition
            {
                from: "*"
                to: "yellow"

                SequentialAnimation
                {
                    PropertyAnimation
                    {
                        target: rect_circle_red
                        property: color
                        duration: 1000
                    }

                    PropertyAnimation
                    {
                        target: rect_circle_green
                        property: color
                        duration: 1000
                    }
                }
            },

            Transition
            {
                from: "yellow"
                to: "*"

                SequentialAnimation
                {
                    PropertyAnimation
                    {
                        target: rect_circle_yellow
                        property: color
                        duration: 1000
                    }
                }
            }
        ]


        Timer
        {
            id: timer
            interval: 5000;
            running: true;
            repeat: true
            onTriggered:
            {
                change_state()
            }
        }

    }

    // change the state by current state
    function change_state()
    {
        if(rect_root.state == "red")
        {
            timer.interval = 1000
            rect_root.state = "yellow"
        }

        else if(rect_root.state == "yellow")
        {
            timer.interval = 5000
            if(color_flag)
            {
                rect_root.state = "green"
                color_flag = false
            }
            else
            {
                rect_root.state = "red"
                color_flag = true
            }
        }

        else if(rect_root.state == "green")
        {
            timer.interval = 1000
            rect_root.state = "yellow"
        }
    }
}




