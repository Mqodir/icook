
import "js/constants.js" as constants;
import "CompilationDelegate.qml";

        GridView {
            id: compilationView;

            radius: 30;

            property bool loading: false;

            cellWidth: 460;
            cellHeight: 120;

            visible: !loading;

            focus: true;
            clip: true;

            delegate: CompilationDelegate {}

            model: ListModel { id: compilationModel; }

            function loadData(url) {
                compilationView.loading = true;

                var request = new XMLHttpRequest();

                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;

                    if (request.status && request.status === 200) {
                        log("response was received");
                        //log(request.responseText);
                        compilationModel.reset();

                        var catalog = JSON.parse(request.responseText);

                        catalog["data"].forEach(function (catalogItem) {
                            log(catalogItem["id"] + " " + catalogItem["title"]);
                            compilationModel.append( {  id: catalogItem["id"],
                                                    cat: catalogItem["cat_id"],
                                                    title: catalogItem["title"],
                                                    description: catalogItem["description"],
                                                    poster: catalogItem["img"] } );
                        });

                        compilationView.loading = false;
                        compilationView.setFocus();
                        log("catalog was updated");
                    } else
                        log("unhandled status", request.status);
                }

                request.open("GET", url, true);
                request.send();

                log("request was sended:"+url);
            }
        }