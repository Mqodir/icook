import "js/constants.js" as constants;

            Rectangle{
                anchors.top: parent.top;
                anchors.left: parent.left;
                anchors.leftMargin: 15;
                anchors.bottomMargin: 15;
                width: 605;
                height: 150;
                radius: 30;
                color: "#fff4ef";
                borderColor: activeFocus ? "#444444" : "#cccccc";
                borderWidth: 2;
                BodyText{
                     anchors.centerIn: itemImg;
                     text: "Загрузка…";
                     color: "#444444";
                 }
                Image{
                    id: itemImg;
                    anchors.top: parent.top;
                    anchors.bottom: parent.bottom;
                    anchors.left: parent.left;
                    anchors.leftMargin: 15;
                    anchors.topMargin: 15;
                    anchors.bottomMargin: 15;
                    width: 150;
                    source: model.img != "null" ? model.img : "apps/icook/resources/icon512.png";
                    fillMode: PreserveAspectFit;
                    
                }

                ScrollingText{
                    id: itemText;
                    anchors.top: parent.top;
                    anchors.left: itemImg.right;
                    anchors.right: parent.right;
                    anchors.bottom: parent.bottom;
                    anchors.leftMargin: 15;
                    anchors.topMargin: 15;
                    font: secondaryFont;
                    anchors.bottomMargin: 15;
                    anchors.rightMargin: 15;
                    text: model.text;
                    color: "#555555";
                }
            }