
import "js/constants.js" as constants;
import "TopItemDelegate.qml";

        GridView {
            id: topItemsView;

            delegate: TopItemDelegate {}

            model: ListModel { id: itemsModel; }

            function loadData(url) {
                topItemsView.loading = true;

                var request = new XMLHttpRequest();

                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;

                    if (request.status && request.status === 200) {
                        log("response was received");
                        //log(request.responseText);
                        itemsModel.reset();

                        var catalog = JSON.parse(request.responseText);

                        catalog["data"].forEach(function (catalogItem) {
                            log(catalogItem["list_id"] + " " + catalogItem["list_title"]);
                            itemsModel.append( {  id: catalogItem["list_id"],
                                                    type: "recomend",
                                                    title: catalogItem["list_title"],
                                                    description: catalogItem["list_about"],
                                                    kkal: catalogItem["list_kkal"] + "к.",
                                                    porsiya: catalogItem["list_porsiya"],
                                                    time: catalogItem["list_time"]+"м.",
                                                    poster: "https://icookserver.online/imgs/items/"+catalogItem["list_id"]+"_circle.png" } );
                        });

                        topItemsView.loading = false;

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