/**
*
* 工具开发安装面板
*
*/
fl.trace('初始化安装主文件与主文件夹');
var appSwf='OpenFire.swf';
var appFile='OpenFire';

var setupFileURI=fl.scriptURI.slice(0,fl.scriptURI.lastIndexOf('/'))+'/';
var setupSwf=setupFileURI+appSwf;
var setupFile=setupFileURI+appFile+'/';
var setupLibraries=setupFileURI+'Libraries/OpenFire/'

var winFileURL=fl.configURI+'WindowSWF/'//+'demo/';
var librariesUrl=fl.configURI+'Libraries/OpenFire/'

installOpenFire()
function installOpenFire(){
	fl.outputPanel.clear()
	fl.trace('检测原文件位置:'+setupFileURI)
	fl.trace('检查扩展面板安装环境....')
	if(!FLfile.exists(winFileURL)){
		FLfile.createFolder(winFileURL)
	}
	fl.trace('开始安装....')
	//-----swf-----
	fl.trace('开始安装主文件:'+appSwf)
	var url=winFileURL+appSwf
	if(FLfile.exists(url))FLfile.remove(url)
	FLfile.copy(setupSwf,url)
	
	//----libraries---
	var url=librariesUrl
	//if(FLfile.exists(url))FLfile.remove(url);
	fl.trace('开始安装扩展的jsfl类库');
	copyFileChildren(setupLibraries,url)
	fl.trace('jsfl类库安装完成');
	//------libraries end----
	//-----file--------
	fl.trace('开始安装扩展文件夹:'+appFile)
	var url=winFileURL+appFile+'/'
	if(FLfile.exists(url))FLfile.remove(url);
	copyFileChildren(setupFile,url)
	fl.trace('安装完成......');	
	fl.trace('请重新启动你的FLASH IDE')
}
/*
* 拷贝文件夹下的所有文件到目标文件夹
*/
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
