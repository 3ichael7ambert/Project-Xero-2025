/// @description  partArray_add(item);
/// @param item
function partArray_add(argument0) {
	/*--------------------------------------
	Return and array with an additional item
	----------------------------------------*/

	var _item = argument0;
	if(is_array(_partArray)){
	    _partArray[array_length(_partArray)] = _item;
	}else{
	    _partArray[0] = _item;
	}



}
