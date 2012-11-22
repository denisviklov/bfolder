<div class="social_icons">
    <span class='st_facebook_vcount' id="facebook" displayText='Facebook'></span>
    <span class='st_googleplus_vcount' id="googleplus" displayText='Google +'></span>
</div>
<script>
         stWidget.addEntry({
                 "service":"facebook",
                 "element":document.getElementById('facebook'),
                 "url":"http://pixchan.me/full_image/${img.name}",
                 "title":"${img.title}",
                 "image":"http://pixchan.me/static/img/pack/${img.name}_full.jpg"
         });
         
         stWidget.addEntry({
                 "service":"googleplus",
                 "element":document.getElementById('googleplus'),
                 "url":"http://pixchan.me/full_image/${img.name}",
                 "title":"${img.title}",
                 "image":"http://pixchan.me/static/img/pack/${img.name}_full.jpg"
         });
</script>
