// ActionScript file

var myVBScript:XML =<vbscript>
					<![CDATA[
					Function myBox (txt)
					myBox = MsgBox(txt, 1)
					End Function 
					]]>
					</vbscript>
var myVBScript1:XML =<vbscript>
					<![CDATA[
	Option Explicit
	
	Function BrowseFolder( myStartLocation )
	MsgBox("start")
	Const MY_COMPUTER   = &H11&
	Const WINDOW_HANDLE = 0 
	
	Dim numOptions, objFolder, objFolderItem
	Dim objPath, objShell, strPath, strPrompt
	
	strPrompt = "Select a folder:"
	numOptions = 0     
	Set objShell = CreateObject( "Shell.Application" )
	If UCase( myStartLocation ) = "MY COMPUTER" Then
	Set objFolder = objShell.Namespace( MY_COMPUTER )
	Set objFolderItem = objFolder.Self
	strPath = objFolderItem.Path
	Else
	strPath = myStartLocation
	End If
	
	Set objFolder = objShell.BrowseForFolder( WINDOW_HANDLE, strPrompt, _
	numOptions, strPath )
	
	If objFolder Is Nothing Then
	BrowseFolder = ""
	Exit Function
	End If
	
	Set objFolderItem = objFolder.Self
	objPath = objFolderItem.Path
	
	BrowseFolder = objPath
	MsgBox("end")
	End Function
					]]>
					</vbscript>


import flash.external.ExternalInterface; 

function InjectVBBrowseForFolder():* {
	//BrowseForFolder();
}
function InjectVB(vbXML):* {
	var CRLF = String.fromCharCode(13)+String.fromCharCode(10);
	var vb = vbXML.toString();
	var vb_arr = vb.split(CRLF);
	var jsvb="function(){" + CRLF;
	jsvb += " var temp='';" + CRLF;
	for (var i = 0; i <vb_arr.length; i++) {
		var vbTemp = vb_arr[i];
		jsvb+=" temp+=('" + vbTemp + "' + String.fromCharCode(13));" + CRLF;
	}
	jsvb+= "window.execScript(temp, 'vbscript');" + CRLF;
	jsvb+= "}";
	trace(jsvb);
	ExternalInterface.call(jsvb);
} 
function alert(txt) {
	ExternalInterface.call("alert", txt);
} 
function doIt(){
//	InjectVB(myVBScript);
	InjectVB(myVBScript1);
	var holyCow = ExternalInterface.call("BrowseFolder","");//, "Hey it works!",'&H0001',"");
	// holyCow = 1: Clicked OK
	// holyCow = 2: Clicked Cancel or Window Close Box
//	alert("You clicked: " + String(holyCow));
} 
