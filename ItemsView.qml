
import "js/constants.js" as constants;
import "ItemDelegate.qml";

        GridView {
            id: itemsView;

            delegate: ItemDelegate {}

            model: ListModel { id: itemsModelMain; }

            function loadData(url) {
                itemsView.loading = true;

                var request = new XMLHttpRequest();

                empty.visible = false;
                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;

                    if (request.status && request.status === 200) {
                        log("response was received");
                        itemsModelMain.reset();
                        log(request.responseText);
                        if(request.responseText != "0 results[]"){

                            var catalog = JSON.parse(request.responseText);

                            catalog["data"].forEach(function (catalogItem) {
                                log(catalogItem["list_id"] + " " + catalogItem["list_title"]);
                                itemsModelMain.append( {  id: catalogItem["list_id"],
                                                        type: "recomend",
                                                        title: catalogItem["list_title"],
                                                        description: catalogItem["list_about"],
                                                        kkal: catalogItem["list_kkal"] + "к.",
                                                        porsiya: catalogItem["list_porsiya"],
                                                        time: catalogItem["list_time"]+"м.",
                                                        poster: "http://icookserver.000webhostapp.com/imgs/items/"+catalogItem["list_id"]+"_circle.png" } );
                            });

                            itemsView.loading = false;
                            itemsView.setFocus();
                        }else{
                            if (itemsList.p == "search") {
                                toast.show("Поиск не дал результатов", 2500);
                                itemsList.visible = false;
                                topItemsView.setFocus();
                            }else{
                                empty.visible = true;
                                itemsView.loading = false;
                                mainMenu.setFocus();
                            }
                        }
                        log("catalog was updated");
                    } else
                        log("unhandled status", request.status);
                }

                request.open("GET", url, true);
                request.send();

                log("request was sended:"+url);
            }



            property bool loading: false;

            cellWidth: constants.itemTop["width"] + 10;
            cellHeight: constants.itemTop["height"];

            visible: !loading;

            focus: true;
            clip: true;
        }