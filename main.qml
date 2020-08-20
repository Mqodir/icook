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
                        text: "Создать";
                    }

                    onKeyPressed: {
                        if (key == "Left") {
                            if (homePanel.lastSelected == "itemsList") {
                                itemsList.setFocus();
                            }else if(homePanel.lastSelected == "compilationList"){
                                compilationList.setFocus();
                            }else{
                                topItemsView.setFocus();
                            }
                        }
                        if (key == "Select") {
                            createMenuPanel.anchors.rightMargin = -40;
                            createMenuPanel.opacity = 1;
                            dark.opacity = 0.5;
                            reducePersonCount.setFocus();
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
                    if (homePanel.lastSelected == "itemsList") {
                        itemsList.setFocus();
                    }else if(homePanel.lastSelected == "compilationList"){
                        compilationList.setFocus();
                    }else{
                        topItemsView.setFocus();
                    }
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
        lastSelected: "topItemsView";
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
                        homePanel.lastSelected = "topItemsView";
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
                        homePanel.lastSelected = "categoryView"
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
                    if (key == "Left") {
                        mainMenu.setFocus();
                    }
                    if (key == "Right") {
                        homePanel.lastSelected = "compilationList";
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
                    if (key == "Right") {
                        homePanel.lastSelected = "itemsList";
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

    Rectangle{
        id: dark;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.left: parent.left;
        anchors.topMargin: -30;
        anchors.bottomMargin: -30;
        anchors.leftMargin: -40;
        anchors.rightMargin: -40;
        color: "#000000";
        opacity: 0;
        Behavior on opacity { animation: Animation { duration: 150; easingType: Linear; } }
        anchors.bottom: parent.bottom;
    }


    Rectangle{
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.left: parent.left;
        anchors.topMargin: -30;
        anchors.bottomMargin: -30;
        anchors.leftMargin: -40;
        anchors.rightMargin: -40;
        color: "#000000";
        opacity: btnMenu5.activeFocus ? 0.5 : 0;
        Behavior on opacity { animation: Animation { duration: 150; easingType: Linear; } }
        anchors.bottom: parent.bottom;
    }

    Rectangle{
        id: createMenuPanel;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        width: 500;
        color: "#ff7000";
        radius: 30;
        opacity: 0;
        anchors.topMargin: -30;
        anchors.bottomMargin: -30;
        anchors.rightMargin: -540;
        Behavior on opacity { animation: Animation { duration: 150; easingType: Linear; } }
        onBackPressed: {
            createMenuPanel.anchors.rightMargin = -540;
            createMenuPanel.opacity = 0;
            dark.opacity = 0;
            reloadMenu.setFocus();
        }

        BodyText{
            id: createMenuTitle;
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.topMargin: 20;
            color: "#ffffff";
            anchors.leftMargin: 20;
            text: "Создайте меню на неделю";
        }

        BodyText{
            id: personCountTitle;
            anchors.top: createMenuTitle.bottom;
            anchors.left: parent.left;
            anchors.topMargin: 10;
            color: "#ffffff";
            anchors.leftMargin: 20;
            text: "На сколько человек готовим?"
        }

        Rectangle{
            id: personCount;
            anchors.top: personCountTitle.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.leftMargin: 20;
            anchors.rightMargin: 20;
            anchors.topMargin: 5;
            radius: 20;
            height: 50;
            color: "#fff6ef";

            BodyText{
                id: personCountValue;
                anchors.centerIn: parent;
                color: "#444444";
                text: "4";
            }

            Rectangle{
                id: reducePersonCount;
                anchors.top: parent.top;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                width: 130;
                height: 50;
                focus: true;
                radius: 20;
                color: "#ffd8bd";
                borderWidth: 2;
                borderColor: activeFocus ? "#444444" : "#fff6ef";
                Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                BodyText{
                    anchors.centerIn: parent;
                    color: "#444444";
                    text: "-";
                }
                onKeyPressed: {
                    if (key == "Down") {
                        btnMeal1.setFocus();
                    }
                    if (key == "Right") {
                        multiplyPersonCount.setFocus();
                    }
                    if (key == "Select") {
                        var value = personCountValue.text - 1;
                        if (value > 0) {
                            personCountValue.text = value;
                        }
                    }
                }
            }

            Rectangle{
                id: multiplyPersonCount;
                anchors.top: parent.top;
                anchors.bottom: parent.bottom;
                anchors.right: parent.right;
                width: 130;
                height: 50;
                focus: true;
                radius: 20;
                color: "#ffd8bd";
                borderWidth: 2;
                borderColor: activeFocus ? "#444444" : "#fff6ef";
                Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                BodyText{
                    anchors.centerIn: parent;
                    color: "#444444";
                    text: "+";
                }
                onKeyPressed: {
                    if (key == "Down") {
                        btnMeal1.setFocus();
                    }
                    if (key == "Left") {
                        reducePersonCount.setFocus();
                    }
                    if (key == "Right") {
                        btnMeal1.setFocus();
                    }
                    if (key == "Select") {
                        var value = parseInt(personCountValue.text) + 1;
                        personCountValue.text = value;
                    }
                }
            }
        }

        BodyText{
            id: mealsTitle;
            anchors.top: personCount.bottom;
            anchors.left: parent.left;
            anchors.topMargin: 10;
            color: "#ffffff";
            anchors.leftMargin: 20;
            text: "Приемы пищи:"
        }

        Rectangle{
            id: btnMeal1;
            anchors.top: mealsTitle.bottom;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            anchors.topMargin: 5;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            selected: true;
            color: selected ? "#ffffff" : "#ffd8bd";
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "Завтрак";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnMeal4.setFocus();
                }
                if (key == "Left") {
                    multiplyPersonCount.setFocus();
                }
                if (key == "Right") {
                    btnMeal2.setFocus();
                }
                if (key == "Up") {
                    reducePersonCount.setFocus();
                }
                if (key == "Select") {
                    if (selected == true) {
                        btnMeal1.color = "#ffd8bd";
                        btnMeal1.selected = false;
                        log("True");
                    }else{
                        btnMeal1.color = "#ffffff";
                        btnMeal1.selected = true;
                        log("False");
                    }
                }
            }
        }

        Rectangle{
            id: btnMeal2;
            anchors.top: mealsTitle.bottom;
            anchors.left: btnMeal1.right;
            anchors.leftMargin: 8;
            anchors.topMargin: 5;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            selected: true;
            color: selected ? "#ffffff" : "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "Обед";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnMeal5.setFocus();
                }
                if (key == "Left") {
                    btnMeal1.setFocus();
                }
                if (key == "Right") {
                    btnMeal3.setFocus();
                }
                if (key == "Up") {
                    reducePersonCount.setFocus();
                }
                if (key == "Select") {
                    if (selected == true) {
                        btnMeal2.color = "#ffd8bd";
                        btnMeal2.selected = false;
                        log("True");
                    }else{
                        btnMeal2.color = "#ffffff";
                        btnMeal2.selected = true;
                        log("False");
                    }
                }
            }
        }


        Rectangle{
            id: btnMeal3;
            anchors.top: mealsTitle.bottom;
            anchors.left: btnMeal2.right;
            anchors.leftMargin: 8;
            anchors.topMargin: 5;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            selected: true;
            color: selected ? "#ffffff" : "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "Ужин";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnMeal6.setFocus();
                }
                if (key == "Left") {
                    btnMeal2.setFocus();
                }
                if (key == "Right") {
                    btnMeal4.setFocus();
                }
                if (key == "Up") {
                    multiplyPersonCount.setFocus();
                }
                if (key == "Select") {
                    if (selected == true) {
                        btnMeal3.color = "#ffd8bd";
                        btnMeal3.selected = false;
                        log("True");
                    }else{
                        btnMeal3.color = "#ffffff";
                        btnMeal3.selected = true;
                        log("False");
                    }
                }
            }
        }


        Rectangle{
            id: btnMeal4;
            anchors.top: btnMeal1.bottom;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            anchors.topMargin: 8;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            selected: false;
            color: selected ? "#ffffff" : "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "2-й завтрак";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnDuration1.setFocus();
                }
                if (key == "Left") {
                    btnMeal3.setFocus();
                }
                if (key == "Right") {
                    btnMeal5.setFocus();
                }
                if (key == "Up") {
                    btnMeal1.setFocus();
                }
                if (key == "Select") {
                    if (selected == true) {
                        btnMeal4.color = "#ffd8bd";
                        btnMeal4.selected = false;
                        log("True");
                    }else{
                        btnMeal4.color = "#ffffff";
                        btnMeal4.selected = true;
                        log("False");
                    }
                }
            }
        }

        Rectangle{
            id: btnMeal5;
            anchors.top: btnMeal1.bottom;
            anchors.left: btnMeal1.right;
            anchors.leftMargin: 8;
            anchors.topMargin: 8;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            selected: false;
            color: selected ? "#ffffff" : "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "Полдник";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnDuration2.setFocus();
                }
                if (key == "Left") {
                    btnMeal4.setFocus();
                }
                if (key == "Right") {
                    btnMeal6.setFocus();
                }
                if (key == "Up") {
                    btnMeal2.setFocus();
                }
                if (key == "Select") {
                    if (selected == true) {
                        btnMeal5.color = "#ffd8bd";
                        btnMeal5.selected = false;
                        log("True");
                    }else{
                        btnMeal5.color = "#ffffff";
                        btnMeal5.selected = true;
                        log("False");
                    }
                }
            }
        }


        Rectangle{
            id: btnMeal6;
            anchors.top: btnMeal1.bottom;
            anchors.left: btnMeal2.right;
            anchors.leftMargin: 8;
            anchors.topMargin: 8;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            selected: false;
            color: selected ? "#ffffff" : "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "2-й ужин";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnDuration3.setFocus();
                }
                if (key == "Left") {
                    btnMeal5.setFocus();
                }
                if (key == "Right") {
                    btnDuration1.setFocus();
                }
                if (key == "Up") {
                    btnMeal3.setFocus();
                }
                if (key == "Select") {
                    if (selected == true) {
                        btnMeal6.color = "#ffd8bd";
                        btnMeal6.selected = false;
                        log("True");
                    }else{
                        btnMeal6.color = "#ffffff";
                        btnMeal6.selected = true;
                        log("False");
                    }
                }
            }
        }


        BodyText{
            id: durationTitle;
            anchors.top: btnMeal6.bottom;
            anchors.left: parent.left;
            anchors.topMargin: 10;
            color: "#ffffff";
            anchors.leftMargin: 20;
            text: "Время приготовления:";
            value: 0;
        }

        Rectangle{
            id: btnDuration1;
            anchors.top: durationTitle.bottom;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            anchors.topMargin: 8;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            color: "#ffffff";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "Неважно";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnGenerate.setFocus();
                }
                if (key == "Left") {
                    btnMeal6.setFocus();
                }
                if (key == "Right") {
                    btnDuration2.setFocus();
                }
                if (key == "Up") {
                    btnMeal4.setFocus();
                }
                if (key == "Select") {
                    btnDuration1.color = "#ffffff";
                    btnDuration2.color = "#ffd8bd";
                    btnDuration3.color = "#ffd8bd";
                    durationTitle.value = 0;
                }
            }
        }

        Rectangle{
            id: btnDuration2;
            anchors.top: durationTitle.bottom;
            anchors.left: btnDuration1.right;
            anchors.leftMargin: 8;
            anchors.topMargin: 8;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            color: "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "До 30 мин.";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnGenerate.setFocus();
                }
                if (key == "Left") {
                    btnDuration1.setFocus();
                }
                if (key == "Right") {
                    btnDuration3.setFocus();
                }
                if (key == "Up") {
                    btnMeal5.setFocus();
                }
                if (key == "Select") {
                    btnDuration2.color = "#ffffff";
                    btnDuration1.color = "#ffd8bd";
                    btnDuration3.color = "#ffd8bd";
                    durationTitle.value = 30;
                }
            }
        }


        Rectangle{
            id: btnDuration3;
            anchors.top: durationTitle.bottom;
            anchors.left: btnDuration2.right;
            anchors.leftMargin: 8;
            anchors.topMargin: 8;
            width: 148;
            height: 50;
            focus: true;
            radius: 20;
            color: "#ffd8bd";
            Behavior on color { animation: Animation { duration: 150; easingType: Linear; } }
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "До 60 мин.";
            }
            onKeyPressed: {
                if (key == "Down") {
                    btnGenerate.setFocus();
                }
                if (key == "Left") {
                    btnDuration2.setFocus();
                }
                if (key == "Right") {
                    btnGenerate.setFocus();
                }
                if (key == "Up") {
                    btnMeal6.setFocus();
                }
                if (key == "Select") {
                    btnDuration3.color = "#ffffff";
                    btnDuration2.color = "#ffd8bd";
                    btnDuration1.color = "#ffd8bd";
                    durationTitle.value = 60;
                }
            }
        }


        Rectangle{
            id: btnGenerate;
            anchors.top: btnDuration2.bottom;
            anchors.left: parent.left;
            anchors.topMargin: 20;
            anchors.leftMargin: 130;
            width: 240;
            height: 60;
            focus: true;
            radius: 20;
            color: "#ffd8bd";
            borderWidth: 2;
            borderColor: activeFocus ? "#444444" : "#fff6ef";
            Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
            BodyText{
                anchors.centerIn: parent;
                color: "#444444";
                text: "Подобрать меню";
            }
            onKeyPressed: {
                if (key == "Up") {
                    btnDuration2.setFocus();
                }
                if (key == "Left") {
                    btnDuration3.setFocus();
                }
                if (key == "Select") {
                    var meals = []
                    if (btnMeal1.selected == true) {
                        meals.push("zavtrak")
                    }
                    if (btnMeal2.selected == true) {
                        meals.push("obed")
                    }
                    if (btnMeal3.selected == true) {
                        meals.push("ujun")
                    }
                    if (btnMeal4.selected == true) {
                        meals.push("2z")
                    }
                    if (btnMeal5.selected == true) {
                        meals.push("poldnik")
                    }
                    if (btnMeal6.selected == true) {
                        meals.push("2u")
                    }
                    var jsonVal = JSON.stringify(meals)

                    var request = new XMLHttpRequest();
                    request.onreadystatechange = function() {
                        if (request.readyState !== XMLHttpRequest.DONE)
                            return;
                        if (request.status && request.status === 200) {
                            var responseT = request.responseText;
                            log(responseT);
                            weekMenu.loadData("https://icookserver.online/getMenu.php?token="+load("token"));
                            createMenuPanel.anchors.rightMargin = -540;
                            createMenuPanel.opacity = 0;
                            dark.opacity = 0;
                            reloadMenu.setFocus();
                        } else
                            log("RealTimeResponseError", request.status);
                    }
                    var url = "https://icookserver.online/createMenu.php?token="+load("token");
                    url += "&meals="+encodeURIComponent(jsonVal)+"";
                    url += "&personCount="+personCountValue.text;
                    url += "&duration="+durationTitle.value;
                    log(url);
                    request.open("GET", url, true);
                    request.send();

                }
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
            weekMenu.loadData("https://icookserver.online/getMenu.php?token="+token);
        }
        topItemsView.loadData("https://icookserver.online/getRecomend.php");
        categoryView.loadData("https://icookserver.online/getCategory.php");
        iviPlayer.setFocus();
        iviPlayer.playVideoByURL("https://icookserver.online/videos/vid.mp4");
        log("VideoPlay");

    }

    function showItems(category, type, title){
        itemsList.visible = true;
        itemsList.p = type;
        itemsListTitle.text = title+":";
        mainListItems.loadData("https://icookserver.online/getItems.php?category="+category);
    }

    function search(text){
        itemsList.visible = true;
        itemsList.p = "search";
        itemsListTitle.text = "Результаты поиска \""+ text+"\":";
        mainListItems.loadData(encodeURI("https://icookserver.online/search.php?q="+text));
        
    }

    function showFavs(){
        itemsList.visible = true;
        itemsList.p = "none";
        itemsListTitle.text = "Избранные:";
        mainListItems.loadData("https://icookserver.online/getFavs.php?token="+load("token"));
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
                imgToken.source = "https://icookserver.online/qr_codes/"+request.responseText+".png";
                log("Token: "+request.responseText);
            } else
                log("unhandled status", request.status);
        }

        request.open("GET", "https://icookserver.online/getToken.php", true);
        request.send();

    }


    onStarted: { mainMenu.setFocus(); log("focused"); listenServer();}

    function listenServer(){
        log("Listening...");
        eventSystem.restart();
    }

        Timer {
            id: eventSystem;
            interval: 3000;
            repeat: false;
            running: false;
            onTriggered: {
                log(".");
                var request = new XMLHttpRequest();
                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;
                    if (request.status && request.status === 200) {
                        var responseT = request.responseText;
                        if (responseT != "0") {
                            log("RealTimeResponse: "+responseT);
                            if (responseT == "connected") {
                                toast.show("Подключено", 2500);
                                connectDialog.visible = false;

                                if (homePanel.lastSelected == "itemsList") {
                                    itemsList.setFocus();
                                }else if(homePanel.lastSelected == "compilationList"){
                                    compilationList.setFocus();
                                }else{
                                    topItemsView.setFocus();
                                }
                                
                            }else if (responseT == "update_menu") {
                                weekMenu.loadData("https://icookserver.online/getMenu.php?token="+load("token"));
                            }else{
                                itemViewPanel.showItemView(responseT, "main");
                                itemViewPanel.setFocus();
                            }
                        }
                    } else
                        log("RealTimeResponseError", request.status);
                }
                request.open("GET", "https://icookserver.online/events/events.php?token="+load("token"), true);
                request.send();
                eventSystem.restart();
            }

        }
}
