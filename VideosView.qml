
import "js/constants.js" as constants;
import "VideoDelegate.qml";

        GridView {
            id: videosView;

            delegate: VideoDelegate {}

            model: ListModel { id: videosModelMain; }

            function loadData(url) {
                videosView.loading = true;

                var request = new XMLHttpRequest();

                request.onreadystatechange = function() {
                    if (request.readyState !== XMLHttpRequest.DONE)
                        return;

                    if (request.status && request.status === 200) {
                        log("response was received");
                        videosModelMain.reset();
                        log(request.responseText);
                        if(request.responseText != "0 results[]"){

                            var catalog = JSON.parse(request.responseText);

                            catalog["data"].forEach(function (catalogItem) {
                                log(catalogItem["list_title"] + " " + catalogItem["list_video_url"]);
                                videosModelMain.append( {  id: catalogItem["list_id"],
                                                        title: catalogItem["list_title"],
                                                        video_url: catalogItem["list_video_url"],
                                                        poster: "https://icookserver.online/imgs/videos/"+catalogItem["list_id"]+".png" } );
                            });

                            videosView.loading = false;
                            videosView.setFocus();
                        }else{
                            log("Videos is empty");
                            mainMenu.setFocus();
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

            cellWidth: constants.itemVideo["width"] + 10;
            cellHeight: constants.itemVideo["height"];

            visible: !loading;

            focus: true;
            clip: true;
        }