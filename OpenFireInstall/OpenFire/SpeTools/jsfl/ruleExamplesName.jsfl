//按方向命名实例名
var fla=fl.getDocumentDOM();
//init('mc_',1)
function init(name,type){
	var selectionArr= fla.selection; 
	//fl.trace(selectionArr.length)
	if(Number(type)==0){
		selectionArr.sort(sortOnX)
		//selectionArr.sort(sortOnY)
	}
	else {
		selectionArr.sort(sortOnY)
	}
	for(var i=0;i<selectionArr.length;i++){
		var temp=selectionArr[i]
		//fl.trace(temp+':'+temp.x+'/'+temp.y)
		//fl.trace(temp+':'+temp.symbolType)
		if(temp.symbolType=='movie clip'||temp.symbolType=='button'||temp.symbolType=='compiled clip'||temp.symbolType=='video'){
			temp.name=name+i
		}
	}
}
function sortOnX(a,b) {
    var aPrice = a.x
    var bPrice = b.x
    if(aPrice > bPrice) {
        return 1;
    } else if(aPrice < bPrice) {
        return -1;
    } else  {
        return 0;
    }
}
function sortOnY(a,b) {
    var aPrice = a.y
    var bPrice = b.y
    if(aPrice > bPrice) {
        return 1;
    } else if(aPrice < bPrice) {
        return -1;
    } else  {
        return 0;
    }
}