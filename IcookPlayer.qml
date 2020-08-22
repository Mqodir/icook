import controls.Player;

    Player {
        id: videoPlayer;
        visible: true;
        anchors.fill: parent;
        focus: true;
        isFullscreen: true;


        function playVideoById(v_url) {
        	icookPlayerParent.visible = true;
        	videoPlayer.setFocus();
            var request = new XMLHttpRequest();
            request.open("POST", "https://icookserver.online", true);

            request.onreadystatechange = function() {
                if (request.readyState !== XMLHttpRequest.DONE)
                    return;

                if (request.status === 200) {
                    log("response was received");
                    videoPlayer.abort();
                    var url_trash = v_url;
                    log(url_trash);
                    videoPlayer.playUrl(url_trash);
                    videoPlayer.setFocus();
                } else
                    log("unhandled status", request.status);
            }
            request.send();
        }


        onBackPressed: {
            log("player abort");
            videoPlayer.abort();
            icookPlayerParent.visible = false;
            if (icookPlayerParent.showFrom == "playlist") {
            	videoList.setFocus();
            }
        }

        onFinished: {
            icookPlayerParent.visible = false;
        }

    }