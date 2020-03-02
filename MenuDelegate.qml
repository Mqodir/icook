import "js/constants.js" as constants;

        Rectangle{
            anchors.top: parent.top;
            height: 95;
            width: 220;
            anchors.topMargin: 30;
            radius: 20;
            color: "#ffd8bd";

            onKeyPressed: {

                log(key)
                if (key == "Select") {
                    itemViewPanel.showItemView(model.id, "menu");
                    itemViewPanel.setFocus();
                }

            }

            focus: true;
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

            SecondaryText {
                id: weekId;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.bottom: parent.top;
                text: model.date;
                color: "#ffffff";
            }

            SecondaryText {
                id: foodTitle;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.top: parent.top;
                anchors.topMargin: 12;
                anchors.leftMargin: 8;
                anchors.rightMargin: 8;
                text: model.type;
                color: "#444444";
            }

            Image{
                id: timeIcon;
                anchors.top: foodTitle.bottom;
                anchors.left: parent.left;
                anchors.leftMargin: 8;
                anchors.topMargin: 8;
                height: 20;
                width: 20;
                source: "apps/icook/resources/time.png";
                fillMode: PreserveAspectFit;
            }
            SecondaryText {
                id: foodTime;
                anchors.left: timeIcon.right;
                anchors.top: foodTitle.bottom;
                anchors.topMargin: 8;
                anchors.leftMargin: 2;
                text: model.time;
                color: "#444444";
            }

            Image{
                id: kallIcon;
                anchors.top: foodTitle.bottom;
                anchors.left: foodTime.right;
                anchors.leftMargin: 8;
                anchors.topMargin: 8;
                height: 20;
                width: 20;
                source: "apps/icook/resources/kall.png";
                fillMode: PreserveAspectFit;
            }
            SecondaryText {
                id: foodKall;
                anchors.left: kallIcon.right;
                anchors.top: foodTitle.bottom;
                anchors.topMargin: 8;
                anchors.leftMargin: 2;
                text: model.kkal;
                color: "#444444";
            }

            Image{
                id: porsIcon;
                anchors.top: foodTitle.bottom;
                anchors.left: foodKall.right;
                anchors.leftMargin: 8;
                anchors.topMargin: 8;
                height: 20;
                width: 20;
                source: "apps/icook/resources/porsiya.png";
                fillMode: PreserveAspectFit;
            }
            SecondaryText {
                id: foodPors;
                anchors.left: porsIcon.right;
                anchors.top: foodTitle.bottom;
                anchors.topMargin: 8;
                anchors.leftMargin: 2;
                text: model.porsiya;
                color: "#444444";
            }

            SecondaryText {
                id: foodDes;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.top: foodPors.bottom;
                anchors.topMargin: 2;
                anchors.leftMargin: 8;
                anchors.rightMargin: 8;
                text: model.title;
                color: "#666666";
            }
        }