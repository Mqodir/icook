    import "js/constants.js" as constants;

    Rectangle{
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
        opacity: 0;
        focus: true;

        property bool loading: false;
        property string selitem: "false";
        property string type: "false";

        visible: false;
        
        onBackPressed: { itemViewPanel.hideView(); }

        Behavior on opacity { animation: Animation { duration: 150; } }
        


        Image{
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.topMargin: 30;
            anchors.rightMargin: 15;
            width: 42;
            height: 42;
            source: "apps/icook/resources/info_42.png";

            BodyText{
                anchors.top: parent.top;
                anchors.right: parent.left;
                anchors.rightMargin: 8;
                anchors.topMargin: -8;
                text: "Пищевая ценность в процентах от дневной нормы.";
                color: "#555555";

                BodyText{
                    anchors.top: parent.bottom;
                    anchors.right: parent.right;
                    anchors.topMargin: 2;
                    text: constants.itemViewInfo;
                    color: "#555555";
                }
            }
        }

        Rectangle{
            id: itemViewData;
            anchors.top: appIcon.bottom;
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;
            anchors.leftMargin: 15;
            anchors.bottomMargin: 15;
            width: 600;
            radius: 30;
            color: "#fff4ef";

            BodyText{
                id: itemViewTitle;
                anchors.top: parent.top;
                anchors.left: parent.left;
                anchors.leftMargin: 15;
                anchors.topMargin: 12;
                text: "Борщ со свеклой и томатной пастой";
                color: "#444444";
            }

            Rectangle{
                anchors.top: itemViewTitle.bottom;
                anchors.left: parent.left;
                anchors.leftMargin: 12;
                anchors.topMargin: 13;
                width: 298;
                radius: 30;
                color: "#ffad71";
                height: 196;
                BodyText{
                    anchors.centerIn: parent;
                    text: "Загрузка…";
                    color: "#444444";
                }
            }

            Image{
                id: itemViewTitleImg;
                anchors.top: itemViewTitle.bottom;
                anchors.left: parent.left;
                anchors.leftMargin: 12;
                anchors.topMargin: 12;
                width: 298;
                height: 200;
                fillMode: PreserveAspectFit;
                source: "";
            }

            
            Image{
                anchors.top: itemViewTitleImg.top;
                anchors.left: itemViewTitleImg.right;
                anchors.leftMargin: 5;
                anchors.topMargin: 5;
                width: 42;
                height: 42;
                source: "apps/icook/resources/clock_42.png";

                BodyText{
                    id: itemViewTime;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.right;
                    anchors.leftMargin: 8;
                    text: "50 мин";
                    color: "#555555";
                }
            }


            Image{
                anchors.top: itemViewTitleImg.top;
                anchors.left: itemViewTitleImg.right;
                anchors.leftMargin: 5;
                anchors.topMargin: 49;
                width: 42;
                height: 42;
                source: "apps/icook/resources/chef_hat.png";

                BodyText{
                    id: itemViewDificulity;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.right;
                    anchors.leftMargin: 8;
                    text: "Сложность низкая";
                    color: "#555555";
                }
            }


            Image{
                anchors.top: itemViewTitleImg.top;
                anchors.left: itemViewTitleImg.right;
                anchors.leftMargin: 5;
                anchors.topMargin: 97;
                width: 42;
                height: 42;
                source: "apps/icook/resources/porsiya_42.png";

                BodyText{
                    id: itemViewPorsiya;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.right;
                    anchors.leftMargin: 8;
                    text: "4 порции";
                    color: "#555555";
                }
            }


            Image{
                anchors.top: itemViewTitleImg.top;
                anchors.left: itemViewTitleImg.right;
                anchors.leftMargin: 5;
                anchors.topMargin: 144;
                width: 42;
                height: 42;
                source: "apps/icook/resources/kkal.png";

                BodyText{
                    id: itemViewKkal;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.right;
                    anchors.leftMargin: 8;
                    text: "268 ККал";
                    color: "#555555";
                }
            }

            Rectangle{
                id: itemViewAddShopList;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                anchors.right: parent.right;
                height: 50;
                radius: 15;
                focus: true;
                color: "#ff6f00";
                anchors.bottomMargin: 15;
                anchors.leftMargin: 15;
                anchors.rightMargin: 90;

                borderWidth: 2;
                borderColor: activeFocus ? "#444444" : "#fff6ef";
                Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                    
                BodyText{
                    anchors.centerIn: parent;
                    text: "Добавить ингридиенты в список покупок";
                    color: "#ffffff";

                }

                onKeyPressed: {
                    if (key == "Up") {
                        itemViewDescription.setFocus();
                    }
                    if (key == "Left") {
                        itemViewDescription.setFocus();
                    }
                    if (key == "Right") {
                        itemViewAddFavorite.setFocus();
                    }
                    
                    if (key == "Select") {

                        log("AddFavorite");

                        var token = load("token");
                        log("TOKEN:"+token + " " + itemViewPanel.selitem);

                        var request = new XMLHttpRequest();

                        request.onreadystatechange = function() {
                            if (request.readyState !== XMLHttpRequest.DONE)
                                return;

                            if (request.status && request.status === 200) {
                                toast.show("Готово! Список покупок доступно в мобильном приложении.", 6000);
                            } else
                                log("unhandled status", request.status);
                        }

                        request.open("GET", "https://icookserver.online/addShopList.php?token="+token+"&item_id="+itemViewPanel.selitem, true);
                        request.send();
                    }

                }
            }

            Rectangle{
                id: itemViewAddFavorite;
                anchors.bottom: parent.bottom;
                anchors.left: itemViewAddShopList.right;
                anchors.right: parent.right;
                height: 50;
                radius: 15;
                focus: true;
                color: "#ff6f00";
                anchors.bottomMargin: 15;
                anchors.leftMargin: 8;
                anchors.rightMargin: 15;

                borderWidth: 2;
                borderColor: activeFocus ? "#444444" : "#fff6ef";
                Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                
                Image{
                    id: favIcon;
                    anchors.centerIn: parent;
                    source: "apps/icook/resources/fav_0.png";
                }

                onKeyPressed: {

                    if (key == "Up") {
                        itemViewDescription.setFocus();
                    }

                    if (key == "Left") {
                        itemViewAddShopList.setFocus();
                    }

                    if (key == "Right") {
                        stepsView.setFocus();
                    }
                    
                    if (key == "Select") {

                        favIcon.source = "apps/icook/resources/fav_1.png";
                        log("AddFavorite");

                        var token = load("token");
                        log("TOKEN:"+token + " " + itemViewPanel.selitem);

                        var request = new XMLHttpRequest();

                        request.onreadystatechange = function() {
                            if (request.readyState !== XMLHttpRequest.DONE)
                                return;

                            if (request.status && request.status === 200) {
                                toast.show("Готово !", 3000);
                            } else
                                log("unhandled status", request.status);
                        }

                        request.open("GET", "https://icookserver.online/addFav.php?token="+token+"&item_id="+itemViewPanel.selitem, true);
                        request.send();
                    }

                }
            }

            Rectangle{
                anchors.top: itemViewTitleImg.bottom;
                anchors.left: parent.left;
                anchors.right: parent.right;
                anchors.bottom: itemViewAddFavorite.top;
                anchors.leftMargin: 15;
                anchors.rightMargin: 15;
                anchors.bottomMargin: 15;
                anchors.topMargin: 10;
                radius: 15;
                color: "#fff4ef";

                borderWidth: 2;
                borderColor: itemViewDescription.activeFocus ? "#444444" : "#cccccc";
                Behavior on borderColor { animation: Animation { duration: 150; easingType: Linear; } }
                    

                ScrollingText{
                    id: itemViewDescription;
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.bottom: parent.bottom;
                    font: secondaryFont;
                    anchors.leftMargin: 8;
                    anchors.rightMargin: 8;
                    anchors.topMargin: 8;
                    anchors.bottomMargin: 8;
                    text: "Калории:268 ккал(11%);  Белки:-(-);  Жиры:14 г(17%);  Углеводы:-(-) Подавать рекомендуется с тонко нарезанным салом и ржаным хлебом.Калории:268 ккал(11%);  Белки:-(-);  Жиры:14 г(17%);  Углеводы:-(-) Подавать рекомендуется с тонко нарезанным салом и ржаным хлебом.Калории:268 ккал(11%);  Белки:-(-);  Жиры:14 г(17%);  Углеводы:-(-) Подавать рекомендуется с тонко нарезанным салом и ржаным хлебом.Калории:268 ккал(11%);  Белки:-(-);  Жиры:14 г(17%);  Углеводы:-(-) Подавать рекомендуется с тонко нарезанным салом и ржаным хлебом.Калории:268 ккал(11%);  Белки:-(-);  Жиры:14 г(17%);  Углеводы:-(-) Подавать рекомендуется с тонко нарезанным салом и ржаным хлебом.";
                    color: "#555555";

                    onKeyPressed: {
                        if (key == "Down" || key == "Right") {
                            itemViewAddShopList.setFocus();
                        }
                    }
                }
            }
            

        }

        Rectangle{
            anchors.top: appIcon.bottom;
            anchors.bottom: parent.bottom;
            anchors.left: itemViewData.right;
            anchors.right: parent.right;
            anchors.leftMargin: 15;
            anchors.rightMargin: 15;
            anchors.bottomMargin: 15;
            radius: 30;
            color: "#fff4ef";
            BodyText{
                id: stepsTitle;
                anchors.topMargin: 15;
                anchors.leftMargin: 15;
                anchors.top: parent.top;
                anchors.left: parent.left;
                text: "Как приготовить:";
                color: "#444444";
            }
            StepsView{
                id: stepsView;
                anchors.top: stepsTitle.bottom;
                anchors.bottom: parent.bottom;
                anchors.right: parent.right;
                anchors.left: parent.left;
                anchors.topMargin: 4;
                anchors.bottomMargin: 8;

                onKeyPressed: {
                    if (key == "Left") {
                        itemViewDescription.setFocus();
                    }
                }

            }

        }

        function showItemView(item_id, type) {
            itemViewPanel.visible = true;
            itemViewPanel.opacity = 1;
            favIcon.source = "apps/icook/resources/fav_0.png";
            icook.isMain = false;
            log("Show item:"+item_id);

            itemViewPanel.loading = true;
            itemViewPanel.selitem = item_id;
            itemViewPanel.type = type;
            var request = new XMLHttpRequest();

            request.onreadystatechange = function() {
                if (request.readyState !== XMLHttpRequest.DONE)
                    return;

                if (request.status && request.status === 200) {
                    log("response was received");
                    log(request.responseText);

                    if(request.responseText != "0 results"){
                        var itemMoreData = JSON.parse(request.responseText);
                        itemViewTitleImg.source = "https://icookserver.online/imgs/items/"+item_id+"_rec_round.png"
                        
                        if (itemMoreData["list_title"].length < 45) {
                            itemViewTitle.text = itemMoreData["list_title"];
                        }else{
                            itemViewTitle.text = itemMoreData["list_title"].substr(0, 45) + "...";
                        }
                        var pishSen = "";
                        if (itemMoreData["list_prop_kkal_value"] != "-") {
                            pishSen = pishSen + "Калории:" + itemMoreData["list_prop_kkal_value"] + "(" + itemMoreData["list_prop_kkal_percent"] + ");";
                        }
                        if (itemMoreData["list_prop_belki_value"] != "-") {
                            pishSen = pishSen + "\nБелки:" + itemMoreData["list_prop_belki_value"] + "(" + itemMoreData["list_prop_belki_percent"] + ");";
                        }
                        if (itemMoreData["list_prop_jiri_value"] != "-") {
                            pishSen = pishSen + "\nЖиры:" + itemMoreData["list_prop_jiri_value"] + "(" + itemMoreData["list_prop_jiri_percent"] + ");";
                        }
                        if (itemMoreData["list_prop_uglevodi_value"] != "-") {
                            pishSen = pishSen + "\nУглеводы:" + itemMoreData["list_prop_uglevodi_value"] + "(" + itemMoreData["list_prop_uglevodi_value"] + ");";
                        }

                        itemViewDescription.text = itemMoreData["list_about"] + "\n\nПИЩЕВАЯ ЦЕННОСТЬ НА ПОРЦИЮ:\n"+pishSen+"\n\nИНГРЕДИЕНТЫ:\n" + itemMoreData["list_ingr_string"];
                        itemViewKkal.text = itemMoreData["list_prop_kkal_value"];
                        itemViewPorsiya.text = itemMoreData["list_porsiya"];
                        itemViewDificulity.text = itemMoreData["list_dificulity"];

                        stepsView.loadData(itemMoreData["list_steps"]);

                    }else{
                        itemViewPanel.hideView();
                        toast.show("Нет данных!!!", 3000);
                    }

                    itemViewPanel.loading = false;
                    
                } else
                    log("unhandled status", request.status);
            }

            request.open("GET", "https://icookserver.online/getItem.php?id=" + item_id, true);
            request.send();

            itemViewDescription.setFocus();

        }

        function hideView() {
            itemViewPanel.visible = false;
            icook.isMain = true;
            itemViewPanel.opacity = 0;
            if(itemViewPanel.type == "top"){
                topItemsView.setFocus();
            }else{
                mainListItems.setFocus();
            }
            log("Hide");
        }

        Rectangle{
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            visible: itemViewPanel.loading;
            color: "#ffd8bd";
            SubheadText{
                anchors.centerIn: parent;
                text: "Загрузка…";
                color: "#555555";
            }
        }

        SubheadText{
            anchors.top: appIcon.top;
            anchors.left: appIcon.right;
            anchors.leftMargin: 0;
            anchors.topMargin: 35;
            text: "iCook";
            color: "#555555";
        }

    }