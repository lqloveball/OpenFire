function init(){
	
	var layer=fl.getDocumentDOM().getTimeline().findLayerIndex("as");
	var num=0;
	if(layer==undefined){
		num=fl.getDocumentDOM().getTimeline().addNewLayer("as", "normal", true);
	}else{
		currentLayers=fl.getDocumentDOM().getTimeline().layers;
		for(var i=0;i<currentLayers.length;i++){
			if(currentLayers[i].name=='as')num=i;
		}
	}
	
	fl.getDocumentDOM().getTimeline().reorderLayer(num,0);
	fl.getDocumentDOM().getTimeline().setSelectedLayers(0,0,false);
	fl.getDocumentDOM().getTimeline().setSelectedFrames(0,1);
	var str='stop();'
	fl.getDocumentDOM().getTimeline().setFrameProperty("actionScript",str);
	
}