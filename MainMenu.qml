Item{
    id: mainMenu;
    property int selIndex: 0;

    onActiveFocusChanged: {
        log("focus: Menu");
        if (activeFocus){
            if (mainMenu.selIndex == 0) {
                btnMenu.setFocus();
            }else if(mainMenu.selIndex == 1){
                btnMenu2.setFocus();
            }else if(mainMenu.selIndex == 2){
                btnMenu3.setFocus();
            }else if(mainMenu.selIndex == 3){
                btnMenu4.setFocus();
            }else if(mainMenu.selIndex == 4){
                btnMenu5.setFocus();
            }
        }
    }

    ActivePanel {
        id: btnMenu;
        height: 70;
        width: 110;
        focus: true;
        radius: 20;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: 100;
        anchors.leftMargin: -40;

        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#ff6f00";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

        color: activeFocus && mainMenu.selIndex != 0 ? constants.colors["active"] : mainMenu.selIndex == 0 ? constants.colors["selected"] : constants.colors["inactive"];
        
        Image{
            source: mainMenu.selIndex == 0 ? "apps/icook/resources/menu/home_sel.png" : "apps/icook/resources/menu/home.png";
            anchors.centerIn: parent;
            anchors.leftMargin: -12;
            fillMode: PreserveAspectFit;
        }

        onKeyPressed: {
            if (key == "Down") {
                    btnMenu2.setFocus();
            }
            if (key == "Up") {
                    btnMenu5.setFocus();
            }
            if (key == "Right" || key == "Select") {
                    topItemsView.setFocus();
                    compilationList.visible = false;
                    itemsList.visible = false;
                    videoList.visible = false;
                    mainMenu.selIndex = 0;
            }
        }


        Behavior on color { animation: Animation { duration: 300; easingType: Linear; } }
    }



    ActivePanel {
        id: btnMenu2;
        height: 70;
        width: 110;
        focus: true;
        radius: 20;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: 180;
        anchors.leftMargin: -40;

        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#ff6f00";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

        color: activeFocus && mainMenu.selIndex != 1 ? constants.colors["active"] : mainMenu.selIndex == 1 ? constants.colors["selected"] : constants.colors["inactive"];
        Image{
            anchors.centerIn: parent;
            source: mainMenu.selIndex == 1 ? "apps/icook/resources/menu/star_sel.png" : "apps/icook/resources/menu/star.png";
            anchors.leftMargin: -12;
            fillMode: PreserveAspectFit;
        }

        onKeyPressed: {
            if (key == "Up") {
                    btnMenu.setFocus();

            }
            if (key == "Down") {
                    btnMenu3.setFocus();
            }
            if (key == "Right" || key == "Select") {
                    mainMenu.selIndex = 1;
                    compilationList.visible = false;
                    videoList.visible = false;
                    icook.showItems("topAll", "none", "Лучшие рецепты");
            }
        }

        Behavior on color { animation: Animation { duration: 300; easingType: Linear; } }
    }

    ActivePanel {
        id: btnMenu3;
        height: 70;
        width: 110;
        focus: true;
        radius: 20;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: 260;
        anchors.leftMargin: -40;

        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#ff6f00";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

        color: activeFocus && mainMenu.selIndex != 2 ? constants.colors["active"] : mainMenu.selIndex == 2 ? constants.colors["selected"] : constants.colors["inactive"];
        Image{
            source: mainMenu.selIndex == 2 ? "apps/icook/resources/menu/news_sel.png" : "apps/icook/resources/menu/news.png";
            anchors.centerIn: parent;
            anchors.leftMargin: -12;
            fillMode: PreserveAspectFit;
        }

        onKeyPressed: {
            if (key == "Up") {
                    btnMenu2.setFocus();
            }
            if (key == "Down") {
                    btnMenu4.setFocus();
            }
            if (key == "Right" || key == "Select") {

                mainMenu.selIndex = 2;
                itemsList.visible = false;
                videoList.visible = false;
                compilationList.visible = true;
                compilationListItems.loadData("https://icookserver.online/getCompilation.php");

            }
        }

        Behavior on color { animation: Animation { duration: 300; easingType: Linear; } }
    }


    ActivePanel {
        id: btnMenu4;
        height: 70;
        width: 110;
        focus: true;
        radius: 20;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: 340;
        anchors.leftMargin: -40;

        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#ff6f00";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

        color: activeFocus && mainMenu.selIndex != 3 ? constants.colors["active"] : mainMenu.selIndex == 3 ? constants.colors["selected"] : constants.colors["inactive"];
        
        Image{
            source: mainMenu.selIndex == 3 ? "apps/icook/resources/menu/favorite_sel.png" : "apps/icook/resources/menu/favorite.png";
            anchors.centerIn: parent;
            anchors.leftMargin: -12;
            fillMode: PreserveAspectFit;
        }

        onKeyPressed: {
            if (key == "Up") {
                    btnMenu3.setFocus();
            }
            if (key == "Down") {
                    btnMenu6.setFocus();
            }
            if (key == "Right" || key == "Select") {
                    mainMenu.selIndex = 3;
                    compilationList.visible = false;
                    videoList.visible = false;
                    icook.showFavs();
            }
        }

        Behavior on color { animation: Animation { duration: 300; easingType: Linear; } }
    }


    ActivePanel {
        id: btnMenu6;
        height: 70;
        width: 110;
        focus: true;
        radius: 20;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: 420;
        anchors.leftMargin: -40;

        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#ff6f00";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

        color: activeFocus && mainMenu.selIndex != 5 ? constants.colors["active"] : mainMenu.selIndex == 5 ? constants.colors["selected"] : constants.colors["inactive"];
        
        Image{
            source: mainMenu.selIndex == 5 ? "apps/icook/resources/menu/video_sel.png" : "apps/icook/resources/menu/video.png";
            anchors.centerIn: parent;
            anchors.leftMargin: -12;
            fillMode: PreserveAspectFit;
        }

        onKeyPressed: {
            if (key == "Up") {
                    btnMenu4.setFocus();
            }
            if (key == "Down") {
                    btnMenu5.setFocus();
            }
            if (key == "Right" || key == "Select") {
                    mainMenu.selIndex = 5;
                    compilationList.visible = false;
                    itemsList.visible = false;
                    icook.showVideos();
            }
        }

        Behavior on color { animation: Animation { duration: 300; easingType: Linear; } }
    }



    ActivePanel {
        id: btnMenu5;
        height: 70;
        width: 110;
        focus: true;
        radius: 20;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.bottomMargin: 20;
        anchors.leftMargin: -40;
        
        borderWidth: 2;
        borderColor: activeFocus ? "#444444" : "#ff6f00";
        Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }

        
        color: activeFocus && mainMenu.selIndex != 4 ? constants.colors["active"] : mainMenu.selIndex == 4 ? constants.colors["selected"] : constants.colors["inactive"];
        
        Image{
            source: mainMenu.selIndex == 4 ? "apps/icook/resources/menu/qr_code_sel.png" : "apps/icook/resources/menu/qr_code.png";
            anchors.centerIn: parent;
            anchors.leftMargin: -12;
            fillMode: PreserveAspectFit;
        }

        onKeyPressed: {
            if (key == "Up") {
                    btnMenu6.setFocus();
            }
            if (key == "Down") {
                    btnMenu.setFocus();
            }
        }

        Behavior on color { animation: Animation { duration: 300; easingType: Linear; } }
    }
}