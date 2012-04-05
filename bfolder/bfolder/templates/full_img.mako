<html>
    <head>
        <meta charset="utf-8">
        <title>${img.title}</title>
        <link rel="stylesheet" href="/static/css/bootstrap.min.css">
        <script src="/static/js/jquery-1.7.2.min.js"></script>
        <script src="/static/js/bootstrap.js"></script>
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
            	<center><h2>${img.title}</h2></center>
            	<div class="span12">
            		<center>
						<img src="/static/img/pack/${img.name}_full.jpg" alt="${img.title}" title="${img.title}">          		
            		</center>
            		<form action="/download_image" method="post">
            			<input type="hidden" name="file_name" value="${img.name}">
            			<input type="submit" class="btn btn-primary btn-large" value="Скачать">
            		</form>
            		<a class='btn' href="#" id="voit_dec">
            			<i class="icon-arrow-down"></i>
            		</a>
            		<span style="font-size: 18px;" id="rait">60</span>
            		<a class="btn" href="#" id="voit_inc">
            			<i class="icon-arrow-up"></i>
            		</a>
            		<center>
	            		<form action="/add_comment" method="post" id="comment">
	            			<input type="hidden" name="file_name" value="${img.name}">
	            			<textarea name="comment" cols="100" rows="4" required form="comment"></textarea>
	            			<input type="submit" class="btn" value="Отправить"/>
	            		</form>
	            		<div>
	            			%for c in comments:
	            				${c.body}
	            			%endfor
	            		</div>
            		</center>
            	</div>
        	</div>
        </div>
    </body>
</html>