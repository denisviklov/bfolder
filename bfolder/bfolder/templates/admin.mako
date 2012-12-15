<%def name="create()">
	<script src="/static/js/admin-panel.js"></script>
	<div id="admin_panel">
		<div class="navbar navbar-inverse navbar-fixed-top">
	    	<div class="navbar-inner">
		    	<div class="container">
		    		<a class="brand" href="#">PixchanAdmin</a>
		    	    <form class="navbar-form pull-left" style="display: none;" id="editor-form">
                        <input id="name-editor-fld" type="text" class="span2" style="height: 30px;">
                        <select style="width: 120px;" id="locale_select">
                            <option value="en">Английский</option>
                            <option value="ru">Русский</option>
                        </select>
                        <button class="btn btn-success" id="edit">Редактировать</button>
                        <button class="btn btn-danger" id="delete">Удалить</button>
                    </form>
		    		<ul class="nav">
		    			<!-- <li class="active"><a href="#">Home</a></li> -->
		    			<li id="not_select" style="margin-top: 10px;">Ни одной картинки еще не выбрано</li>
		    			<li><a id="del_all" href="javascript:void(0)" style="display: none;">Удалить все</a></li>
		    			<li><a href="/logout" style="margin-left: 80%;">Выйти</a></li>
		    		</ul>
		    	</div>
	    	</div>
	    </div>
    </div>
</%def>