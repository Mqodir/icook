import "js/constants.js" as constants;

    Rectangle{
        id: toast;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        height: 40;
        width: toastText.width + 30;
        radius: 20;
        anchors.bottomMargin: -100;
        color: "#444444";
        opacity: 0;

        Behavior on y { animation: Animation { duration: 300; } }
        Behavior on opacity { animation: Animation { duration: 300; } }

        BodyText{
            id: toastText;
            anchors.centerIn: parent;
            text: "Загрузка…";
            color: "#ffffff";
        }

        Timer {
            id: hideToastTimer;
            interval: 3000;
            repeat: false;
            running: false;
            onTriggered: {
                toast.anchors.bottomMargin = -100;
                toast.opacity = 0;
            }

        }

        function show(text, t_int) {
            log("showToast"+text)
            toastText.text = text;
            hideToastTimer.interval = t_int;
            toast.anchors.bottomMargin = 15;
            toast.opacity = 0.9;
            hideToastTimer.restart();
        }

    }