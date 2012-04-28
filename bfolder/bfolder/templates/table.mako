<!--<% link_attr={"class": "btn small"} %>  
<% curpage_attr={"class": "btn primary small disabled"} %>  
<% dotdot_attr={"class": "btn small disabled"} %> 
${pager.pager(format="$link_previous ~2~ $link_next",
								symbol_previous="<<",
								symbol_next=">>",
								link_attr=link_attr,
								curpage_attr=curpage_attr,
								dotdot_attr=dotdot_attr)} -->
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