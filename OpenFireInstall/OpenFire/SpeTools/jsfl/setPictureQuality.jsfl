//批量修改图片质量
/**
type 图片类型
allowSmoothing 是否平滑
value 图片的质量
*/
function setBitmapData(type,allowSmoothing,value){
	/*
	var lib = fl.getDocumentDOM().library;
	lib.setItemProperty('allowSmoothing', false);
	lib.setItemProperty('compressionType', 'lossless');
	//
	var lib = fl.getDocumentDOM().library;
	lib.setItemProperty('allowSmoothing', true);
	lib.setItemProperty('compressionType', 'lossless');
	//
	var lib = fl.getDocumentDOM().library;
	lib.setItemProperty('allowSmoothing', false);
	lib.setItemProperty('compressionType', 'photo');
	lib.setItemProperty('useImportedJPEGQuality', false);
	lib.setItemProperty('quality', 30);
	//
	var lib = fl.getDocumentDOM().library;
	lib.setItemProperty('allowSmoothing', false);
	lib.setItemProperty('compressionType', 'lossless');
	*/
	var lib = fl.getDocumentDOM().library;
	if(allowSmoothing=='true')lib.setItemProperty('allowSmoothing', true);
	else lib.setItemProperty('allowSmoothing', false);
	
	if(type=='png'){
		lib.setItemProperty('compressionType', 'lossless');
	}else{
		lib.setItemProperty('compressionType', 'photo');
		lib.setItemProperty('useImportedJPEGQuality', false);
		value=Number(value)
		if(value<1)value=1
		if(value>100)value=100
		lib.setItemProperty('quality', value);
	}
}

///图片类型
function setPNG(){
	lib.setItemProperty('compressionType', 'lossless');
}
//设置图片平滑
function setAllowSmoothing(bool){
	var lib = fl.getDocumentDOM().library;
	if(bool=='true')lib.setItemProperty('allowSmoothing', true);
	else lib.setItemProperty('allowSmoothing', false);
}