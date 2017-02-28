//批量修改库原件名
var lib = fl.getDocumentDOM().library;
function init(value){
	//fl.outputPanel.clear()
	//fl.trace('处理项目库中元件重命名 start')
	var libArr=fl.getDocumentDOM().library.getSelectedItems()
	/*
	var lib = fl.getDocumentDOM().library;
	lib.setItemProperty('symbolType', 'button');
	if (lib.getItemProperty('linkageImportForRS') == true) {
		lib.setItemProperty('linkageImportForRS', false);
	}
	else {
		lib.setItemProperty('linkageExportForAS', false);
		lib.setItemProperty('linkageExportForRS', false);
	}
	lib.setItemProperty('scalingGrid',  false);
	*/
	for(i=0;i<libArr.length;i++){
		var item=libArr[i]
		//设置选择的元件
		item.name=value+i
	}
}