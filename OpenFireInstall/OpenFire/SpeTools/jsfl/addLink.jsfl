﻿//添加连接代码
var fla=fl.getDocumentDOM();
function addAs3(){
	var btnName=''
	var selectionArr= fla.selection; 
	var temp=selectionArr[0];
	//fl.trace(temp)
	//fl.trace(temp.name)
	if(temp==null){
		alert('你未选择任何元件')
		return
	}
	if(temp.symbolType=='movie clip'||temp.symbolType=='button'){
		if(temp.name==''){
			var userName = prompt("为元件输入一个名字", ""); 
			fl.trace(userName)
			if(userName!=''&&userName!=null){
				temp.name=userName
				addScript(temp)
			}
			else{
				alert('因为你没为元件输入一个名字，所以不能添加连接代码')
			}
			//temp.name=''
		}else{
			addScript(temp)
		}
	}else{
		alert('你选择的元件无法进行添加连接代码')
	}
}

function addAs2(){
	var selectionArr= fla.selection; 
	var btn=selectionArr[0];
	var str="on(release){ \n"
	str+='	getURL("#","_blank");\n'

	str+='}'
	btn.actionScript=str;
}
//添加代码
function addScript(btn){
	/*
	var layer=fl.getDocumentDOM().getTimeline().findLayerIndex("as")
	var num=0
	if(layer==undefined){
		num=fl.getDocumentDOM().getTimeline().addNewLayer("as", "normal", true)
	}else{
		currentLayers=fl.getDocumentDOM().getTimeline().layers;
		for(var i=0;i<currentLayers.length;i++){
			if(currentLayers[i].name=='as')num=i;
		}
	}
	
	//把as换到第一层
	fl.getDocumentDOM().getTimeline().reorderLayer(num,0);
	//选择第一层 也就是as层
	fl.getDocumentDOM().getTimeline().setSelectedLayers(0,0,false);
	
	
	//计算是否关键帧 把所有关键帧放进一个数组
	var frameArray = fl.getDocumentDOM().getTimeline().layers[0].frames; 
	var n = frameArray.length; 
	var arr=new Array()
	for (i=0; i<n; i++) { 
		if (i==frameArray[i].startFrame) { 
			arr.push(i)
		} 
	}
	if(arr.indexOf(fl.getDocumentDOM().getTimeline().currentFrame)==-1){
		//非关键帧转成关键帧
		fl.getDocumentDOM().getTimeline().convertToBlankKeyframes(fl.getDocumentDOM().getTimeline().currentFrame);
	}else{
		//关键帧直接选择关键帧
		fl.getDocumentDOM().getTimeline().setSelectedFrames(fl.getDocumentDOM().getTimeline().currentFrame,fl.getDocumentDOM().getTimeline().currentFrame);
	}
	*/
	var layer=btn.layer;
	//开始添加代码
	var str=btn.name+".addEventListener(MouseEvent.CLICK,"+btn.name+"ClickFun)\n";
	str+="function "+ btn.name+"ClickFun(e:MouseEvent):void \n"
	str+="{ \n"
	str+="    navigateToURL(new URLRequest('#'), '_blank') \n"
	str+="} \n"
	fl.getDocumentDOM().getTimeline().setFrameProperty("actionScript",str);
}