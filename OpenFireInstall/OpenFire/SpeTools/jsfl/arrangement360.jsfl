
Point=function(_x,_y){
	//fl.trace(_x)
	if(_x!=undefined)this.x=_x;
	else this.x=0
	if(_y!=undefined)this.y=_y;
	else this.y=0
	//fl.trace(this.x+'/'+this.y)
}

Point.prototype.toString=function(){
	return '[ x:'+this.x+'/ y:'+this.y+' ]'
}

/*将一个角度转化为在0~360度之间*/
function fixAngle(angle) {
	angle%= 360;
	return angle < 0?angle + 360:angle;
}
/**
根据 角度  长度 原始点位置 确定 坐标点
*/
function getRPoint(angle,long,point) {
	
	if(point==undefined)point=new Point()
	angle = fixAngle(angle)
	angle = angle * Math.PI / 180;
	if (long == undefined) long = 100;
	var newpoint = new Point(Math.cos(angle) * long + point.x, Math.sin(angle) * long + point.y)
	return newpoint
}

function setArrangement(long) {
	long=Number(long);
	var selectionArr= fl.getDocumentDOM().selection; 
	var angle=360/selectionArr.length;
	//fl.trace('setArrangement:'+selectionArr.length+'/'+angle);
	for(var i=0;i<selectionArr.length;i++){
		var mc=selectionArr[i];
		var pt=getRPoint(angle*i,long,new Point(0,0))
		//fl.trace('rp:'+pt);
		mc.x=pt.x>>0;
		mc.y=pt.y>>0;
	}
}