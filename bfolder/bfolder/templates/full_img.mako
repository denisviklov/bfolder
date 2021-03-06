## -*- coding: utf-8 -*-
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>${img.title}</title>
        <link rel="stylesheet" href="/static/css/bootstrap.css">
        <script src="/static/js/jquery-1.7.2.min.js"></script>
        <script src="/static/js/bootstrap.js"></script>
        <script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
        <script type="text/javascript">stLight.options({
        	publisher: "da2e1ef7-42cd-4c60-a78d-f01dbcd67adf"
        	});
        </script>
    </head>
    <script>
    	$(function(){
    		$('a[id^="voit"]').click(function(){
    			var action = $(this).attr('id').split('_')[1];
    			var oid = $('input[name = "file_name"]').val();
    			$.ajax({
    				url: '/voit',
    				data: {'oid': oid, 'action': action},
    				type: 'POST',
    				success: function(data){
    					$('#rait').text(data['rait']);
    				}
    			})
    		})
    	})
    </script>
    <body style="background-color: #F8F8F8;">
        <div class="container">
            <div class="row">
            	<div class="span2" style="margin-top: 20px;">
            		<form action="/download_image" method="post">
            			<input type="hidden" name="file_name" value="${img.name}">
            			<input type="submit" class="btn btn-primary btn-large" value="${_(u'Скачать')}">
            		</form>
            		<a class='btn' href="#" id="voit_dec">
            			<i class="icon-arrow-down"></i>
            		</a>
            		<span style="font-size: 18px;" id="rait">
            			%if img.raiting:
            				${img.raiting}
            			%else:
            				0
            			%endif
            		</span>
            		<a class="btn" href="#" id="voit_inc">
            			<i class="icon-arrow-up"></i>
            		</a>
            		<p style="margin-top: 20px;"><a href="${back}" style="font-size: 18px;">${_(u"Назад")}</a></p>
            	</div>
            	<div class="span10" style="margin-top: 10px;" align="center">
            			<h2>${img.title}</h2>
						<img src="/static/img/pack/${img.name}_full.jpg" alt="${img.title}" title="${img.title}">
						<br>
						%if locale == 'ru':
							<%include file="social_ru.mako"/>
						%else:
							<%include file="social_en.mako"/>
						%endif
	            		<form action="/add_comment" method="post" id="comment" style="margin-top: 10px;">
	            			<input type="hidden" name="file_name" value="${img.name}">
	            			<textarea name="comment" cols="10" rows="4" required form="comment"></textarea><br/>
	            			<input type="submit" class="btn" value="${_(u'Отправить')}"/>
	            		</form>
	            		<div>
	            			%for c in comments:
	            				<div class="well" style="margin-bottom: 10px;">
	            					<p>${h.time_pretify(c.time)}</p>
	            					<p>${c.body}</p>
	            				</div>
	            			%endfor
	            		</div>       		
            	</div>
        	</div>
        </div>
		<script type="text/javascript">
				(function (d, w, c) {
				    (w[c] = w[c] || []).push(function() {
				        try {
				            w.yaCounter13819918 = new Ya.Metrika({id:13819918, enableAll: true});
				        } catch(e) {}
				    });
				    
				    var n = d.getElementsByTagName("script")[0],
				        s = d.createElement("script"),
				        f = function () { n.parentNode.insertBefore(s, n); };
				    s.type = "text/javascript";
				    s.async = true;
				    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";
				
				    if (w.opera == "[object Opera]") {
				        d.addEventListener("DOMContentLoaded", f);
				    } else { f(); }
				})(document, window, "yandex_metrika_callbacks");
		</script>
		<noscript>
			<div>
				<img src="//mc.yandex.ru/watch/13819918" style="position:absolute; left:-9999px;" alt="" />
				</div>
		</noscript>
		<script type="text/javascript">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-36084820-1']);
		  _gaq.push(['_setDomainName', 'pixchan.org']);
		  _gaq.push(['_setAllowLinker', true]);
		  _gaq.push(['_trackPageview']);
		
		  (function() {
		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		</script>
    </body>
</html>
