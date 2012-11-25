<%def name="create()">
	<script src="/static/js/admin-panel.js"></script>
	<div id="admin_panel">
		<div class="navbar navbar-inverse navbar-fixed-top">
	    	<div class="navbar-inner">
		    	<div class="container">
		    		<a class="brand" href="#">PixchanAdmin</a>
		    		<ul class="nav">
		    			<!-- <li class="active"><a href="#">Home</a></li> -->
		    			<li id="not_select" style="margin-top: 10px;">Ни одной картинки еще не выбрано</li>
		    			<li><a id="del_all" href="#" style="display: none;">Удалить все</button></li>
		    		</ul>
		    	</div>
	    	</div>
	    </div>
    </div>
</%def>