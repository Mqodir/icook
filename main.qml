

import "js/constants.js" as constants;

import "CategoryView.qml";
import "TopItemsView.qml";
import "ItemsView.qml";
import "StepsView.qml";
import "CompilationView.qml";
import "SearchBar.qml";
import "MainMenu.qml";
import "ItemViewPanel.qml";
import "DayMenuView.qml";
import "Toast.qml";


Application {
    id: icook;
    anchors.bottomMargin: 0;
    anchors.topMargin: 0;
    color: "#ff7000";

    property bool isMain: true;

    MainMenu{
        id: mainMenu;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
    }

    Rectangle{
        id: menuWeek;
        color: "#ff6f00";
        focus: true;
        anchors.topMargin: 8;
        anchors.leftMargin: 8;
        anchors.bottomMargin: -25;
        anchors.rightMargin: -32;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom;
        anchors.left: homePanel.right;
        anchors.right: parent.right;

        BodyText {
            anchors.bottom: menuWeek.top;
            anchors.left: parent.left;
            color: "#ffffff";
            text: "Меню на неделю:";
        }
        Rectangle{
            id: emptyMenu;
            anchors.top: parent.top;
            anchors.left: menuWeek.left;
            anchors.topMargin: 12;
            SecondaryText{
                anchors.left: parent.left;
                anchors.top: parent.top;
                color: "#ffffff";
                text: "Нет данных!\nВы можете создать меню \nв мобильном приложении.";
                
                Rectangle{
                    id:reloadMenu;
                    anchors.top: parent.bottom;
                    width: 130;
                    height: 40;
                    focus: true;
                    radius: 15;
                    color: "#ffd8bd";
                    borderWidth: 2;
                    borderColor: activeFocus ? "#444444" : "#fff6ef";
                    Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                    SecondaryText{
                        anchors.centerIn: parent;
                        color: "#444444";
                        text: "Обновить";
                    }

                    onKeyPressed: {
                        if (key == "Left") {
                            topItemsView.setFocus();
                        }
                        if (key == "Select") {
                            weekMenu.loadData("https://icookserver.000webhostapp.com/getMenu.php?token="+load("token"));
                        }
                    }
                }
            }
        }

        DayMenuView{
            id: weekMenu;
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            property bool exist: false;

            onKeyPressed: {
                if (key == "Left") {
                    topItemsView.setFocus();
                }
            }
        }

    }

    Rectangle{
        id: homePanel;
        color: "#ffdabd";
        radius: 30;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        anchors.right: parent.right;
        anchors.bottomMargin: -30;
        anchors.topMargin: -30;
        anchors.rightMargin: 198;
        anchors.leftMargin: 50;

        SearchBar{
            id: searchBar;
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.leftMargin: 30;
            anchors.topMargin: 20;
            height: 40;
            width: 420;
            maxLen: 20;


            onKeyPressed: {
                if (key == "Down") {
                    topItemsView.setFocus();
                }
                
                if (key == "Left") {
                    mainMenu.setFocus();
                }
                if (key == "Select") {
                    icook.search(editItem.text);
                }

            }
        }

        BodyText {
            anchors.top: searchBar.bottom;
            anchors.left: parent.left;
            anchors.topMargin: 8;
            anchors.leftMargin: 30;
            color: "#555555";
            text: "Рекомендованные для вас:";
        }

        Rectangle{
            id: topItems;
            anchors.top: searchBar.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.leftMargin: 20;
            anchors.rightMargin: 10;
            anchors.topMargin: 35;
            height: 240;
            color: "#ffd8bd";
            // TopItemDelegate{
            //     anchors.top: parent.top;
            //     anchors.left: parent.left;
            // }

            BodyText{
                anchors.centerIn: parent;
                text: "Загрузка…";
                color: "#444444";
                visible: topItemsView.loading;
            }


            TopItemsView{
                id: topItemsView;
                anchors.top: parent.top;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.bottom: parent.bottom;

                onKeyPressed: {
                    if (key == "Up") {
                        searchBar.setFocus();
                    }
                    if (key == "Left") {
                        mainMenu.setFocus();
                    }
                    if (key == "Right") {
                        if (weekMenu.exist) {
                            weekMenu.setFocus();
                        }else{
                            reloadMenu.setFocus();
                        }
                    }
                }
            }
        }

        BodyText {
            anchors.top: topItems.bottom;
            anchors.left: parent.left;
            anchors.topMargin: 8;
            anchors.leftMargin: 30;
            color: "#555555";
            text: "Категории:";
        }

        Rectangle{
            id: categotyItems;
            anchors.top: topItems.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            anchors.leftMargin: 20;
            anchors.rightMargin: 10;
            anchors.topMargin: 40;
            anchors.bottomMargin: 20;
            color: "#ffd8bd";

            BodyText{
                anchors.centerIn: parent;
                text: "Загрузка…";
                color: "#444444";
                visible: categoryView.loading;
            }

            CategoryView{
                id: categoryView;
                anchors.top: parent.top;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                anchors.right: parent.right;

                onKeyPressed: {
                    if (key == "Up") {
                        topItemsView.setFocus();
                    }
                    if (key == "Left") {
                        mainMenu.setFocus();
                    }

                    if (key == "Right") {
                        if (weekMenu.exist) {
                            weekMenu.setFocus();
                        }else{
                            reloadMenu.setFocus();
                        }
                    }
                }

            }
        }

        Rectangle{
            id: compilationList;
            anchors.top: searchBar.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            anchors.leftMargin: 20;
            anchors.rightMargin: 10;
            anchors.topMargin: 8;
            anchors.bottomMargin: 20;
            color: "#ffd8bd";
            visible: false;
            BodyText {
                anchors.top: parent.top;
                anchors.left: parent.left;
                anchors.topMargin: 2;
                anchors.leftMargin: 15;
                color: "#555555";
                text: "Подборки рецептов:";
            }

            BodyText{
                anchors.centerIn: parent;
                text: "Загрузка…";
                color: "#444444";
                visible: compilationListItems.loading;
            }

            CompilationView{
                id: compilationListItems;
                anchors.top: parent.top;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.topMargin: 35;

                onBackPressed: {
                    compilationList.visible = false;

                    topItemsView.setFocus();
                    mainMenu.selIndex = 0;
                }

                onKeyPressed: {
                    mainMenu.setFocus();
                }
            }
        }

        Rectangle{
            id: itemsList;
            anchors.top: searchBar.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            anchors.leftMargin: 20;
            anchors.rightMargin: 10;
            anchors.topMargin: 8;
            anchors.bottomMargin: 20;
            color: "#ffd8bd";
            visible: false;
            property string p: "none";
            BodyText {
                id: itemsListTitle;
                anchors.top: parent.top;
                anchors.left: parent.left;
                anchors.topMargin: 2;
                anchors.leftMargin: 15;
                color: "#555555";
                text: "Title:";
            }

            BodyText{
                id: empty;
                anchors.centerIn: parent;
                text: "Пусто!";
                color: "#444444";
                visible: false;
            }

            BodyText{
                anchors.centerIn: parent;
                text: "Загрузка…";
                color: "#444444";
                visible: mainListItems.loading;
            }

            ItemsView{
                id: mainListItems;
                anchors.top: parent.top;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.topMargin: 35;

                onBackPressed: {
                    itemsList.visible = false;
                    log(itemsList.p);
                    if(itemsList.p == "cat"){
                        categotyItems.setFocus();
                    }else if(itemsList.p == "compilation"){
                        compilationListItems.setFocus();
                    }else{
                        topItemsView.setFocus();
                        mainMenu.selIndex = 0;
                    }
                }

                onKeyPressed: {
                    if (key == "Left") {
                        mainMenu.setFocus();
                    }
                }
            }
        }

        Rectangle{
            id: connectDialog;
            anchors.top: parent.top;
            anchors.right: parent.right;
            focus: true;
            height: 80;
            width: 460;
            anchors.topMargin: 15;
            anchors.rightMargin: 20;
            color: "#ffd8bd";
            SecondaryText{
                anchors.top: parent.top;
                anchors.topMargin: 10;
                anchors.leftMargin: 10;
                color: "#444444";
                anchors.left: parent.left;
                text: "Установите мобильное приложение iCook\nдля полноценного использования.\nСсылка для скачивания:"
            }
            Image{
                anchors.top: parent.top;
                anchors.right: parent.right;
                height: 80;
                width: 80;
                source: "apps/icook/resources/google_play.png";
                fillMode: PreserveAspectFit;
            }
        }
    }

    ItemViewPanel{
        id: itemViewPanel;
        color: "#ffdabd";
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        anchors.right: parent.right;
        anchors.bottomMargin: -30;
        anchors.topMargin: -30;
        anchors.rightMargin: -40;
        anchors.leftMargin: -40;
    }

    Toast{
        id: toast;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: -100;
    }

    Image {
        id: appIcon;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.topMargin: -20;
        anchors.leftMargin: -45;
        source: "apps/icook/resources/icon_white.png";
        fillMode: PreserveAspectFit;
    }

    onCompleted: {
        var token = load("token");
        log("TOKEN:"+token);

        if (token == null) {
            log("GetTOKEN!!");
            icook.getToken();
        }else{
            weekMenu.loadData("https://icookserver.000webhostapp.com/getMenu.php?token="+token);
        }
        topItemsView.loadData("https://icookserver.000webhostapp.com/getRecomend.php");
        categoryView.loadData("https://icookserver.000webhostapp.com/getCategory.php");
    }

    function showItems(category, type, title){
        itemsList.visible = true;
        itemsList.p = type;
        itemsListTitle.text = title+":";
        mainListItems.loadData("https://icookserver.000webhostapp.com/getItems.php?category="+category);
    }
    function search(text){
        itemsList.visible = true;
        itemsList.p = "search";
        itemsListTitle.text = "Результаты поиска \""+ text+"\":";
        mainListItems.loadData(encodeURI("http://icookserver.000webhostapp.com/search.php?q="+text));
        
    }


    function showFavs(){
        itemsList.visible = true;
        itemsList.p = "none";
        itemsListTitle.text = "Избранные:";
        mainListItems.loadData("https://icookserver.000webhostapp.com/getFavs.php?token="+load("token"));
    }


    Rectangle{
        anchors.centerIn: parent;
        height:250;
        width:250;
        color:"#ffd8bd";
        radius:20;
        borderWidth: 2;
        borderColor: "#444444";
        visible: btnMenu5.activeFocus;
        SecondaryText{
            anchors.top: parent.top;
            anchors.horizontalCenter: parent.horizontalCenter;
            text: "QR-код для сопряжения\nс приложением";
            color: "#444444";
            anchors.topMargin: 15;
        }

        SecondaryText{
            anchors.centerIn: imgToken;
            text: "Загрузка…";
            color: "#444444";
        }

        Image{
            id: imgToken;
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.topMargin: 60;
            anchors.leftMargin: 10;
            anchors.rightMargin: 10;
            anchors.bottomMargin: 10;
            fillMode: PreserveAspectFit;
        }
    }

    function getToken() {

        var request = new XMLHttpRequest();

        request.onreadystatechange = function() {
            if (request.readyState !== XMLHttpRequest.DONE)
                return;

            if (request.status && request.status === 200) {

                save("token", request.responseText);
                imgToken.source = "http://icookserver.000webhostapp.com/qr_codes/"+request.responseText+".png";
                log("Token: "+request.responseText);
            } else
                log("unhandled status", request.status);
        }

        request.open("GET", "http://icookserver.000webhostapp.com/getToken.php", true);
        request.send();

    }


    onStarted: { mainMenu.setFocus(); log("focused"); }


}
