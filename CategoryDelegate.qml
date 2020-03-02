import "js/constants.js" as constants;


Rectangle {
    id: categoryDelegate;
    height: 110;
    width: 446;
    radius: 19;
    color: "#fff4ef";

    onKeyPressed: {

        log(key)
        if (key == "Select") {
            icook.showItems(model.cat, "cat", model.title);
        }

    }
    focus: true;
    borderWidth: 2;
    borderColor: activeFocus ? "#444444" : "#fff6ef";
    Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                BodyText{
                    id: categotyTitle;
                    anchors.left: parent.left;
                    anchors.leftMargin: 10;
                    anchors.right: categotyImg.left;
                    text: model.title;
                    color: "#444444";
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Rectangle{
                    anchors.top: parent.top;
                    anchors.right: parent.right;
                    height: 110;
                    radius: 21;
                    width: 178;
                    color: "#ff6f00";
                    borderWidth: 2;
                    borderColor: categoryDelegate.activeFocus ? "#444444" : "#fff6ef";
                    Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                }
                SecondaryText{
                    text: "Загрузка…";
                    color: "#666666";
                    anchors.centerIn: categotyImg;
                }
                Image{
                    id: categotyImg;
                    anchors.top: parent.top;
                    anchors.right: parent.right;
                    anchors.rightMargin: 2;
                    anchors.topMargin: 1;
                    height: 107;
                    width: 174;
                    fillMode: PreserveAspectFit;
                    source: model.poster
                }
}

