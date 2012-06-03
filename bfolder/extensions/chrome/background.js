function getClickHandler(){
    return function(info){
        var imgUrl = info.srcUrl;
        console.log(imgUrl);
        chrome.windows.create({
            "url":"popup.html",
            "width":300,
            "height":80,
            "type":"panel"
        },
            function(window){
                console.log("ofogg");
                var btn = document.getElementById("btn_send");
                //btn.
                window.remove()
            });
    };
};

chrome.contextMenus.create({
  "title" : "Send to pixchan.org",
  "type" : "normal",
  "contexts" : ["image"],
  "onclick" : getClickHandler()
});