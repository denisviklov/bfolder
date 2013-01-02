<center>
	<table style="margin-top: 10px;">
		${makerow(pager.items[:5])}
		${makerow(pager.items[5:10])}
		${makerow(pager.items[10:15])}
		${makerow(pager.items[15:])}
	</table>
</center>

<%def name="makerow(row)">
    <tr>
        %for img in row:
            %if img.type == 'collection':
                <td align="center" style="vertical-align: bottom;">
                    <a href="/collections/${img.id.__str__()}">
                    <img src="/static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
                    <input type="hidden" name="locale" value="${img.lang}">
                    <center>Пак "${img.title}" картинок ${img.length}</center></a>
                </td>        
            %else:   
                <td align="center" style="vertical-align: bottom;">
                    <a href="/full_image/${img.name}">
                    <img src="/static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
                    <input type="hidden" name="locale" value="${img.lang}">
                    <center>${img.title}</center></a>
                </td>
            %endif
        %endfor
    </tr>
</%def>