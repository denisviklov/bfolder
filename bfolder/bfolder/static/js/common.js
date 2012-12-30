
$(function(){
	$('.input-large').autocomplete({
		source: '/search_autocomplete',
		minLength: 2,
		select: function(event, ui){}
	});
	
	$('#from-thread-download').submit(function(){
		var form_data = $(this).serialize();
		$.ajax({
			url: '/collection/create',
			contents: 'json',
			type: 'POST',
			data: form_data,
			success: function(response){
				reload_table();
			},
		});
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