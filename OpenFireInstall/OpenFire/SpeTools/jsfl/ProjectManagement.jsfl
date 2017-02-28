
//--------XML END=---------
//获项目路径
function browseFolder(){
	var url=fl.browseForFolderURL()
	return url;
}

//设置代码路径
function addSourcePath(value){
	if(value==undefined)value='..\\src'
	var inBool=false
	var Library = fl.getDocumentDOM().sourcePath ;
	var tempArr=Library.split(';')
	for(var i=0;i<tempArr.length;i++){
		var temp=String(tempArr[i])
		if(temp==value){
			//fl.trace(temp);
			inBool=true
			break
		}
	}
	if(inBool){
		return
	}
	else{
		fl.getDocumentDOM().sourcePath=fl.getDocumentDOM().sourcePath+";"+value
	}
}
//swc路径
function setLibrary(value){
	if(value==undefined)value='..\\libs'
	var inBool=false
	var Library = fl.getDocumentDOM().externalLibraryPath ;
	var tempArr=Library.split(';')
	for(var i=0;i<tempArr.length;i++){
		var temp=String(tempArr[i])
		if(temp==value){
			inBool=true
			break
		}
	}	
	if(inBool){
		return
	}
	else{
		fl.getDocumentDOM().externalLibraryPath=fl.getDocumentDOM().externalLibraryPath+";"+value
	}
}

/**
*设置发布路径
*/
function  setFlaBinPath(value){
	var xml=fl.getDocumentDOM().exportPublishProfileString('Default'); 
	xml=XML(xml)
	var filePath = fl.getDocumentDOM().name;
	filePath=filePath.slice(0,filePath.lastIndexOf('.fla'));  
	filePath=filePath+'.swf';
	
	if(value==undefined)value='..\\bin'
	value=value+"\\";
	xml.PublishFormatProperties.flashFileName=value+filePath
	xml.PublishFormatProperties.flashDefaultName=0
	xml.PublishFormatProperties.defaultNames=0
	fl.getDocumentDOM().importPublishProfileString(xml.toString());
	//fl.trace(xml.PublishFormatProperties)
}
function setFlaByConfig(src,swc,bin,otherCode){
	
	addSourcePath('..\\'+src);
	addSourcePath('..\\'+otherCode);
	setLibrary('..\\'+swc);
	setFlaBinPath('..\\'+bin)
}

function setFla(){
	addSourcePath('..\\src');
	addSourcePath('..\\otherCode');
	setLibrary('..\\libs');
	setFlaBinPath("..\\bin")
}

function copyFileChildren(setup,copy){
	//fl.trace('setup>>:'+setup+' to   '+copy)
	var attr = FLfile.getAttributes(setup)
	if(attr && (attr.indexOf("D") != -1)){
		FLfile.createFolder(copy)
	}else{
		FLfile.copy(setup,copy)
	}
	var files=FLfile.listFolder(setup,"files")
	if(files.length!=0){
		for(var i=0;i<files.length;i++){
			var temp=files[i];
			var setupUrl=setup+temp;
			var copyUrl=copy+temp;
			copyFileChildren(setupUrl,copyUrl)
	   }
	}
	
	var directories=FLfile.listFolder(setup,"directories")
	if(directories.length!=0){
		for(var i=0;i<directories.length;i++){
			var temp=directories[i]+'/';
			var setupUrl=setup+temp;
			var copyUrl=copy+temp;
			copyFileChildren(setupUrl,copyUrl)
	   }
	}
}

function copyOtherCode(copyURI){
	if(copyURI==undefined){
		alert('设置拷贝路径');
	}
	if(!FLfile.exists(copyURI)){
			FLfile.createFolder(copyURI)
	}
	if(!FLfile.exists(copyURI)){
		alert('拷贝路径错误');
	}
	fl.trace('准备拷贝第3方库')
	var codeUrl=fl.as3PackagePaths;
	var codeArr=codeUrl.split(';');
	for(var i=0;i<codeArr.length;i++){
		var codeUrl=codeArr[i];
		if(codeUrl!='..\\src'&&codeUrl!='..\\otherCode'&&codeUrl!='src'){
			codeUrl=FLfile.platformPathToURI(codeUrl)
			if(FLfile.exists(codeUrl)){
				if(codeUrl.lastIndexOf('/')!=(codeUrl.length-1)){
				   codeUrl=codeUrl+'/'
				}
				//FLfile.copy(codeUrl,copyURI)
				copyFileChildren(codeUrl,copyURI)
				fl.trace('拷贝库:'+codeUrl)
			}
		}
	}
	fl.trace('第3方库拷贝完成!')
}
//copyOtherCode("file:///D|/otherCode/")


