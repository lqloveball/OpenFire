//快速对选取对象进行位置取整
//init()
function init(value){
	var selectObjArray = fl.getDocumentDOM().selection;
	for(var i=0;i<selectObjArray.length;i++){
		//fl.trace("fl.getDocumentDOM().selection["+i+"] = " + selectObjArray[i]);
		var el=selectObjArray[i]
		el.x=Math.round(el.x)
		el.y=Math.round(el.y)
	}
}