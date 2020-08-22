import "js/constants.js" as constants;


    Rectangle {
        id: videoDelegate;
        height: 220;
        width: 220;
        radius: 19;
        color: "#fff4ef";

        onKeyPressed: {
            if (key == "Select") {
                icookPlayer.playVideoById(model.video_url);
            }
        }
        focus: true;
        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#fff6ef";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                    BodyText{
                        id: videTitle;
                        anchors.left: parent.left;
                        anchors.leftMargin: 10;
                        anchors.right: parent.right;
                        anchors.bottom: parent.bottom;
                        anchors.bottomMargin: 10;
                        anchors.rightMargin: 10;
                        text: model.title;
                        color: "#444444";
                    }
                    Rectangle{
                        anchors.top: parent.top;
                        anchors.right: parent.right;
                        anchors.left: parent.left;
                        height: 148;
                        radius: 21;
                        color: "#ff6f00";
                        borderWidth: 2;
                        borderColor: videoDelegate.activeFocus ? "#444444" : "#fff6ef";
                        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                    }
                    SecondaryText{
                        text: "Загрузка…";
                        color: "#666666";
                        anchors.centerIn: videoPoster;
                    }
                    Image{
                        id: videoPoster;
                        anchors.top: parent.top;
                        anchors.right: parent.right;
                        anchors.left: parent.left;
                        anchors.leftMargin: 2;
                        anchors.rightMargin: 2;
                        anchors.topMargin: 2;
                        height: 144;
                        fillMode: PreserveAspectFit;
                        source: model.poster;
                    }
                    Image{
                        anchors.centerIn: videoPoster;
                        fillMode: PreserveAspectFit;
                        width: 100;
                        opacity: videoDelegate.activeFocus ? 1 : 0;
                        Behavior on opacity { animation: Animation { duration: 150; easingType: Linear; } }
                        height: 100;
                        source: "apps/icook/resources/ic_play.png";
                    }
    }
