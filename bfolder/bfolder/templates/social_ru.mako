<div class="social_icons">
	<span class='st_vkontakte_vcount' id="vkontakte" displayText='Vkontakte'></span>
    <span class='st_facebook_vcount' id="facebook" displayText='Facebook'></span>
    <span class='st_googleplus_vcount' id="googleplus" displayText='Google +'></span>
</div>
<script>
		stWidget.addEntry({
                 "service":"vkontakte",
                 "element":document.getElementById('vkontakte'),
                 "url":"http://pixchan.org/full_image//${img.name}",
                 "title":"${img.title}",
                 "type":"large",
                 "image":"http://pixchan.org/static/img/pack/${img.name}_full.jpg"
         });
         
         stWidget.addEntry({
                 "service":"facebook",
                 "element":document.getElementById('facebook'),
                 "url":"http://pixchan.org/full_image//${img.name}",
                 "title":"${img.title}",
                 "type":"large",
                 "image":"http://pixchan.org/static/img/pack/${img.name}_full.jpg"
         });
         
         stWidget.addEntry({
                 "service":"googleplus",
                 "element":document.getElementById('googleplus'),
                 "url":"http://pixchan.org/full_image//${img.name}",
                 "title":"${img.title}",
                 "type":"large",
                 "image":"http://pixchan.org/static/img/pack/${img.name}_full.jpg"
         });
</script>