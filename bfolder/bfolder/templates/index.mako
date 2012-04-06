<html>
    <head>
        <meta charset="utf-8">
        <title>2ch image hosting</title>
        <link rel="stylesheet" href="static/css/bootstrap.css">
        <script src="static/js/jquery-1.7.2.min.js"></script>
        <script src="static/js/bootstrap.js"></script>
        <script src="static/js/common.js"></script>
        <script src="static/js/jquery-ui-1.8.18.custom.min.js"></script>
        <link rel="stylesheet" href="static/css/smoothness/jquery-ui-1.8.18.custom.css">
    </head>
    <body style="background-color: #F8F8F8;">
        <div class="container">
        	<div class="row">
            	<div class="span6" style="vertical-align: baseline;">
            			<div style="margin-top: 40px;">
            			<b>pixChan</b> — это сервис хранения картинок для имиджборд.<br>
            			Здесь можно хранить свои олдфажные паки "колобков", рожь и прочих butthurt'ов.
            			Все пикчи участвуют в рейтинге и поиске.<br>
            			Надеюсь тебе понравится Аноним.
            			</div>
            	</div>
            	<div class="span6"><img src="static/img/2ch_tian_logo_small_small.jpg"></div>
            	<% link_attr={"class": "btn small"} %>  
  				<% curpage_attr={"class": "btn primary small disabled"} %>  
  				<% dotdot_attr={"class": "btn small disabled"} %> 
            	<div class="span12">
            		<div class="ui-widget">
	            		<form class="well form-search" method="post">
	            			<center>
		            			<input type="text" class="input-large search-query" name="q" style="width: 600px; height: 40px; font-size: 22px;">
		            			<button class="btn" type="submit" style="height: 40px; width: 60px;">
		            				<i class="icon-search"></i>
		            			</button>
	            			</center>
	            		</form>
            		</div>
            		${pager.pager(format="$link_previous ~2~ $link_next",
            										symbol_previous="<<",
            										symbol_next=">>",
            										link_attr=link_attr,
            										curpage_attr=curpage_attr,
            										dotdot_attr=dotdot_attr)}
                	<center>
	                	<table>
							${makerow(pager.items[:5])}
							${makerow(pager.items[5:10])}
							${makerow(pager.items[10:15])}
							${makerow(pager.items[15:])}
	                	</table>
                	</center>
          	</div>
        </div>
        
		        <div class="footer">
					<span style="text-align: center;"><b>Smart Media Machines &copy;</b></span>
		        </div>

    </body>
</html>

<%def name="makerow(row)">
    <tr>
    %for img in row:
		<td align="center" style="vertical-align: bottom;">
			<img src="static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
			<center><a href="/full_image/${img.name}">${img.title}</a></center>
		</td>
    %endfor
    </tr>
</%def>