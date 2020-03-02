
import "js/constants.js" as constants;
import "CategoryDelegate.qml";

        GridView {
            id: categoryView;

            radius: 30;

            property bool loading: false;

            cellWidth: 460;
            cellHeight: 120;

            visible: !loading;

            focus: true;
            clip: true;

            delegate: CategoryDelegate {}

            model: ListModel { id: categoryModel; }

            function loadData(url) {
                categoryView.loading = true;

                var request = new XMLHttpRequest();

                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;

                    if (request.status && request.status === 200) {
                        log("response was received");
                        //log(request.responseText);
                        categoryModel.reset();

                        var catalog = JSON.parse(request.responseText);

                        catalog["data"].forEach(function (catalogItem) {
                            log(catalogItem["id"] + " " + catalogItem["title"]);
                            categoryModel.append( {  id: catalogItem["id"],
                                                    cat: catalogItem["cat_id"],
                                                    title: catalogItem["title"],
                                                    description: catalogItem["description"],
                                                    poster: catalogItem["img"] } );
                        });

                        categoryView.loading = false;
                        
                        log("catalog was updated");
                    } else
                        log("unhandled status", request.status);
                }

                request.open("GET", url, true);
                request.send();

                log("request was sended:"+url);
            }
        }