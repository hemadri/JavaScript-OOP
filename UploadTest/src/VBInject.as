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
	Const BIF_returnonlyfsdirs   = &H0001
	Const BIF_dontgobelowdomain  = &H0002
	Const BIF_statustext         = &H0004
	Const BIF_returnfsancestors  = &H0008
	Const BIF_editbox            = &H0010
	Const BIF_validate           = &H0020
	Const BIF_browseforcomputer  = &H1000
	Const BIF_browseforprinter   = &H2000
	Const BIF_browseincludefiles = &H4000
	
	Function BrowseForFolderTitle()
	On Error Resume Next
	Dim file
	MsgBox("before activex")
			file = BrowseForFolder( _
			"Select a file or folder to copy", _
			BIF_returnonlyfsdirs + BIF_browseincludefiles, _
			"")
	MsgBox("after activex")
		If file = "-5" Then 
		WScript.Echo "Not possible to select files in root folder"
		Else
		If file = "-1" Then 
		WScript.Echo "No object selected; Cancel clicked"
		Else
		WScript.Echo "Object: ", file
		End If
		End If 
	On Error GoTo 0
	End Function
	
	Function BrowseForFolder(title, flag, dir)
	On Error Resume Next
	
	Dim oShell, oItem, tmp
	
	Set oShell = WScript.CreateObject("Shell.Application")
	
	Set oItem = oShell.BrowseForFolder(&H0, title, flag, dir)
	If Err.Number <> 0 Then
	If Err.Number = 5 Then
	BrowseForFolder= "-5"
	Err.Clear
	Set oShell = Nothing
	Set oItem = Nothing
	Exit Function
	End If
	End If
	
	BrowseForFolder = oItem.ParentFolder.ParseName(oItem.Title).Path
	
	If Err<> 0 Then
	If Err.Number = 424 Then          
	BrowseForFolder = "-1"
	Else
	Err.Clear
	tmp = InStr(1, oItem.Title, ":")
	If tmp > 0 Then           
	
	BrowseForFolder = _   
	Mid(oItem.Title, (tmp - 1), 2) & "\"
	End If
	End If
	End If
	
	Set oShell = Nothing
	Set oItem = Nothing
	On Error GoTo 0
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
	var holyCow = ExternalInterface.call("BrowseForFolderTitle");//, "Hey it works!",'&H0001',"");
	// holyCow = 1: Clicked OK
	// holyCow = 2: Clicked Cancel or Window Close Box
//	alert("You clicked: " + String(holyCow));
} 
