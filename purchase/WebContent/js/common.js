function updateCombox(id,value){
	$('#' + id).combobox({
		onLoadSuccess: function(){
			$('#' + id).combobox('select',value);
		}
	});
}