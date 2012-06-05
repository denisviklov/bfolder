self.port.on("show", function(){
    var btn_send = document.getElementById("btn_send");
    btn_send.onclick = function(){
        var img_title = document.getElementById("img_title").value;
        document.getElementById("img_title").value = "";
        self.postMessage(img_title);   
    };
});