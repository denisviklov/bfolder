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
		<td align="center" style="vertical-align: bottom;">
			<a href="/full_image/${img.name}">
			<img src="/static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
			<center>${img.title}</center></a>
		</td>
    %endfor
    </tr>
</%def>