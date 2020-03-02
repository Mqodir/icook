import "js/constants.js" as constants;

        Rectangle{
                id: itemDelegate;
                height: 240;
                width: 220;
                color: "#ffdabd";
                focus: true;

                onKeyPressed: {

                    if (key == "Select") {
                        itemViewPanel.showItemView(model.id, "main");
                        itemViewPanel.setFocus();
                    }
                    
                }

                Rectangle{
                    id: foodInfo;
                    anchors.bottom: parent.bottom;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.leftMargin: 0;
                    anchors.rightMargin: 0;
                    anchors.topMargin: 12;
                    radius:22;
                    borderWidth: 2;
                    borderColor: itemDelegate.activeFocus ? "#444444" : "#fff6ef";
                    Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                    color: "#fff6ef";
                    height: 170;
                    Image{
                        id: timeIcon;
                        anchors.top: parent.top;
                        anchors.left: parent.left;
                        anchors.leftMargin: 8;
                        anchors.topMargin: 70;
                        height: 20;
                        width: 20;
                        source: "apps/icook/resources/time.png";
                        fillMode: PreserveAspectFit;
                    }
                    SecondaryText {
                        id: foodTime;
                        anchors.left: timeIcon.right;
                        anchors.top: parent.top;
                        anchors.topMargin: 70;
                        anchors.leftMargin: 2;
                        text: model.time;
                        color: "#444444";
                    }

                    Image{
                        id: kallIcon;
                        anchors.top: parent.top;
                        anchors.left: foodTime.right;
                        anchors.leftMargin: 8;
                        anchors.topMargin: 70;
                        height: 20;
                        width: 20;
                        source: "apps/icook/resources/kall.png";
                        fillMode: PreserveAspectFit;
                    }
                    SecondaryText {
                        id: foodKall;
                        anchors.left: kallIcon.right;
                        anchors.top: parent.top;
                        anchors.topMargin: 70;
                        anchors.leftMargin: 2;
                        text: model.kkal;
                        color: "#444444";
                    }

                    Image{
                        id: porsIcon;
                        anchors.top: parent.top;
                        anchors.left: foodKall.right;
                        anchors.leftMargin: 8;
                        anchors.topMargin: 70;
                        height: 20;
                        width: 20;
                        source: "apps/icook/resources/porsiya.png";
                        fillMode: PreserveAspectFit;
                    }
                    SecondaryText {
                        id: foodPors;
                        anchors.left: porsIcon.right;
                        anchors.top: parent.top;
                        anchors.topMargin: 70;
                        anchors.leftMargin: 2;
                        text: model.porsiya;
                        color: "#444444";
                    }

                    SecondaryText {
                        id: foodTitle;
                        anchors.left: parent.left;
                        anchors.right: parent.right;
                        anchors.top: parent.top;
                        anchors.topMargin: 98;
                        anchors.leftMargin: 8;
                        anchors.rightMargin: 8;
                        text: model.title;
                        width: 134;
                        color: "#444444";
                    }

                    SecondaryText {
                        id: foodDesc;
                        anchors.left: parent.left;
                        anchors.right: parent.right;
                        anchors.top: foodTitle.bottom;
                        anchors.topMargin: -2;
                        anchors.leftMargin: 8;
                        anchors.rightMargin: 8;
                        width: 134;
                        width: 30;
                        text: model.description;
                        color: "#777777";
                    }

                }
                Rectangle{
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.leftMargin: 46;
                    anchors.rightMargin: 45;
                    anchors.topMargin: 12;
                    height: 126;
                    radius: 65;
                    color: "#fff6ef";
                    borderWidth: 3;
                    borderColor: itemDelegate.activeFocus ? "#444444" : "#fff6ef";
                    Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

                    SecondaryText {
                        anchors.centerIn: parent;
                        text: "Загрузка…";
                        opacity: foodImg.status != ui.Image.Ready ? 1 : 0;
                        color: "#444444";
                    }
                }
                Image{
                    id: foodImg;
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.leftMargin: 49;
                    anchors.rightMargin: 49;
                    registerInCacheSystem: false;
                    anchors.topMargin: 14;
                    height: 122;
                    source: model.poster;
                    fillMode: PreserveAspectFit;
                }
            }