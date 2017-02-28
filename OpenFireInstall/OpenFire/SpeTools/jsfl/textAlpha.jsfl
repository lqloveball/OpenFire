
function init(){
	var selectObjArray = fl.getDocumentDOM().selection;
	for(var i=0;i<selectObjArray.length;i++){
		//fl.trace("fl.getDocumentDOM().selection["+i+"] = " + selectObjArray[i]);
		var el=selectObjArray[i]
		el.x=Math.round(el.x)
		el.y=Math.round(el.y)
	} 
	fl.getDocumentDOM().removeAllFilters()
	fl.getDocumentDOM().addFilter('blurFilter')
	fl.getDocumentDOM().setFilterProperty('blurX', 0, 0)
	fl.getDocumentDOM().setFilterProperty('blurY', 0, 0)
}
function test(){
	fl.trace('test')
}