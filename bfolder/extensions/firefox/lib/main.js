var contextMenu = require('context-menu');
var request = require('request');
var panel = require('panel');
var data = require('self').data;
var notifications = require("notifications");



var myPanel = panel.Panel({
    height: 80,
    contentURL: data.url("dialog.html"),
    contentScriptFile: data.url("get_data.js")
});

var menuItem = contextMenu.Item({
    label: "Send to pixchan.org",
    context: contextMenu.SelectorContext("img"),
    contentScript: 'self.on("click", function(node){self.postMessage(node.src);});',
    onMessage: function(im){
        //making new request for send to server
        var req = request.Request({
        url: "http://pixchan.org/img_from_client",
        content: {q: "", img_title: ""},
        onComplete: function(response){
            myPanel.hide();
            notifications.notify({
              title: "Pixchan.org",
              text: response.text
            });
        }    
    });
        myPanel.show();
        myPanel.on("message", function(addonMessage) {
            req.content['q'] = im;
            req.content['img_title'] = addonMessage;
            req.get(); 
        });
        myPanel.port.emit("show");
        
    }
})