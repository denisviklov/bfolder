<html>
    <head>
        <meta charset="utf-8">
        <title>${img.title}</title>
        <link rel="stylesheet" href="/static/css/bootstrap.min.css">
        <script src="/static/js/jquery-1.7.2.min.js"></script>
        <script src="/static/js/bootstrap.js"></script>
        <script src="/static/js/common.js"></script>
    </head>
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
            			<input type="submit" class="btn btn-large" value="Скачать">
            		</form>
            	</div>
        	</div>
        </div>
    </body>
</html>