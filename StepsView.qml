
import "js/constants.js" as constants;
import "StepDelegate.qml";

        GridView {
            id: stepView;

            cellWidth: 605;
            cellHeight: 170;

            focus: true;
            clip: true;

            delegate: StepDelegate {}

            model: ListModel { id: stepModel; }

            function loadData(data) {

                stepModel.reset();
                log("LoadSteps!!!")
                var catalog = data;
                if(catalog != null){
                    log("JsonLoads!!!")
                    catalog.forEach(function (catalogItem) {
                        log(catalogItem["text"] + " " + catalogItem["img"]);
                        stepModel.append( {     text: catalogItem["text"],
                                                img: catalogItem["img"] } );
                    });
                }

            }
        }