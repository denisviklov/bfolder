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
            		
            			Два.ч — это система форумов, где можно общаться быстро и свободно, 
            			где любая точка зрения имеет право на жизнь. 
            			Здесь нет регистрации и подписываться не нужно, хотя это не избавляет вас от необходимости соблюдать правила. 
            			Все форумы (кроме /Б/реда), а их список находится снизу, имеют собственную чётко ограниченную тематику. 
            			Словом, всё, что не запрещено правилами отдельно взятого форума и относится к его тематике, на этом форуме разрешено.
            		
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