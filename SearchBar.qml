
Rectangle{
        id: editItem;
        radius: 18;

        property string text;
        property int maxLen;
        property bool clearAfterMaxlenReached: false;
        //property Validator validator;
        property string ignoreChars: "#*";
        property string mask: "*";
        property string hint: "Поиск";

        property bool alwaysShowCursor: false;

        property bool handleDelete: true;
        property bool passwordMode: false;
        property Color textColor;
        borderColor: activeFocus ? constants.colorsSearchBorder["active"] : constants.colorsSearchBorder["inactive"];
        focus: true;
        color: activeFocus ? constants.colorsSearch["active"] : constants.colorsSearch["inactive"];

        borderWidth: 2;
        
        Behavior on color { animation: Animation { duration: 400; easingType: Linear; } }

        Behavior on borderColor { animation: Animation { duration: 400; easingType: Linear; } }

        onActiveFocusChanged: {
            log("focus: "+activeFocus);
            if (activeFocus){
                cursorBlinkTimer.restart();
                cursorRect.opacity = 1;
                editItem.text = "";
            }
            else{
                cursorBlinkTimer.stop();
                cursorRect.opacity = 0;
                editItem.text = "";
            }
        }

        Image{
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.topMargin: 5;
            anchors.leftMargin: 5;
            opacity: 0.8;
            source: "apps/icook/resources/search.png";
            fillMode: PreserveAspectFit;
        }

        Rectangle {
            id: cursorRect;
            anchors.top: parent.top;
            anchors.left: editText.right;
            anchors.topMargin: 8;
            anchors.bottomMargin: 8;
            anchors.leftMargin: 2;
            opacity: 0;
            width: 2;
            height: 24;
            color: editText.color;

            Behavior on opacity {
                animation: Animation {
                    duration: 300;
                }
            }
        }

        BodyText {
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.topMargin: 8;
            anchors.leftMargin: 50;
            color: "#555555";
            text: editItem.hint;
            opacity: editText.text == "" ? 0.8 : 0;

            Behavior on opacity {
                animation: Animation {
                    duration: 100;
                }
            }
        }

        BodyText {
            id: editText;
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.topMargin: 8;
            anchors.leftMargin: 45;
            color: "#555555";
            text: "";


            function updateText() {
                log("text changed " + editItem.text);

                var line = editItem.text;
                if (editItem.maxLen > 0)
                    line = line.substr(0, editItem.maxLen);

                if (!editItem.passwordMode)
                    editText.text = line;
                else
                    editText.text = new Array(line.length + 1).join(mask);
            }

        }

        onTextChanged: {
            editText.updateText();
        }

        onKeyPressed: {
            if (!recursiveVisible)
                return false;

            log(key);

            var keyUsed = false;

            if (key == "Backspace" && editItem.handleDelete) {
                removeChar();
                keyUsed = true;
            } else if (key == "Space") {
                editItem.text += " ";
                keyUsed = true;
            } else if (key.length == 1) {
                if (editItem.ignoreChars.indexOf(key) != -1)
                    return true;

                key = key.toLowerCase();
                var futureValue;

                if (editItem.maxLen == 0 || editItem.text.length < editItem.maxLen)
                    futureValue = editItem.text + key;
                else if (editItem.clearAfterMaxlenReached)
                    futureValue = key;
                else
                    return true;

                editItem.text = futureValue;

                //if (text.length == editItem.maxLen)
                    //editItem.maxLenReached();

                keyUsed = true;
            } else if( key == "Left" ){
                btnMenu.setFocus();
            }
            return keyUsed;
        }

        function removeChar() {
            if (editItem.text.length == 0)
                return;

            var text = editItem.text;
            var i = text.length - 1;

            while (i > 0 && (text[i] & 0xc0) == 0x80)
                i--;

            editItem.text = text.substr(0, i);
        }

        function clear() {
            editItem.text = "";
            editText.width = 0;
        }


        Timer {
            id: cursorBlinkTimer;
            interval: 500;
            repeat: true;
            
            onTriggered: {
                if (cursorRect.opacity == 0) {
                    cursorRect.opacity = 1;
                }else{
                    cursorRect.opacity = 0;
                }
            }
        }


    onCompleted: {
        editText.updateText();
    }
}