
import "js/constants.js" as constants;
import "MenuDelegate.qml";

        GridView {
            id: itemsMenuView;

            delegate: MenuDelegate {}

            model: ListModel { id: itemsModelMenu; }

            function loadData(url) {
                itemsMenuView.loading = true;

                var request = new XMLHttpRequest();

                emptyMenu.visible = false;
                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;

                    if (request.status && request.status === 200) {
                        log("response was received");
                        itemsModelMenu.reset();
                        //log(request.responseText);
                        if(request.responseText != "0 results[]"){

                            var catalog = JSON.parse(request.responseText);

                            catalog["data"].forEach(function (catalogItem) {

                                itemsModelMenu.append( {  id: catalogItem["item_id"],
                                                        title: catalogItem["title"],
                                                        date: catalogItem["date"],
                                                        kkal: catalogItem["kkal"] + "к.",
                                                        porsiya: catalogItem["porsiya"],
                                                        time: catalogItem["time"]+"м.",
                                                        type: catalogItem["type"] } );
                            });
                            weekMenu.exist = true;
                            itemsMenuView.loading = false;
                            itemsMenuView.setFocus();
                        }else{
                            weekMenu.exist = false;
                            emptyMenu.visible = true;
                            itemsMenuView.loading = false;
                            reloadMenu.setFocus();
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

            cellWidth: 220;
            cellHeight: 120;

            visible: !loading;

            focus: true;
            clip: true;
        }