
$(function(){
	$('.input-large').autocomplete({
		source: '/search_autocomplete',
		minLength: 2,
		select: function(event, ui){}
	});
});

function reload_table(){
	$.ajax({
		url: '/table_reload',
		type: 'POST',
		success: function(data){
			$('#content_table').html(data);
			return true;
		}
	});
}