//设置FLA的 SWC库路径
addSourcePath('../\src')
function addSourcePath(value){
	var inBool=false
	var Library = fl.getDocumentDOM().sourcePath ;
	var tempArr=Library.split(';')
	for(var i=0;i<tempArr.length;i++){
		var temp=String(tempArr[i])
		if(temp==value){
			fl.trace(temp);
			inBool=true
			break
		}
	}
	if(inBool){
		//fl.trace('不需要插入')
		return
	}
	else{
		fl.getDocumentDOM().sourcePath=fl.getDocumentDOM().sourcePath+";"+value
	}
}

