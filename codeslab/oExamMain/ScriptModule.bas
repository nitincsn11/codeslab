Attribute VB_Name = "ScriptModule"
Option Explicit

Public Sub SetClientApplicationFlag(ByVal wb As webBrowser, ByVal VERSION As String)
On Error Resume Next
    Call wb.Document.parentWindow.execScript("window.sExamVersion = " & VERSION & ";")
End Sub

Public Function ShouldEndNow(ByVal wb As webBrowser) As Boolean
On Error Resume Next
    Call wb.Document.parentWindow.execScript("sExamEndNow = window.sExamEndNow ? true : false;")
    ShouldEndNow = wb.Document.Script.sExamEndNow
End Function

Public Sub TryExit(ByVal wb As webBrowser)
On Error Resume Next
    ' Call wb.Document.parentWindow.execScript("sExamEndNow = window.sExamEndNow; if (!sExamEndNow) try { sExamEndNow = examSubmitPapr(); } catch (e) {} ")
    Call wb.Document.parentWindow.execScript("sExamEndNow = true;")
End Sub

Public Sub WriteScriptCache(ByVal wb As webBrowser, ByVal cache As String)
On Error Resume Next
    Call wb.Document.parentWindow.execScript("window.CACHE = '" & cache & "';")
End Sub

Public Function ReadScriptCache(ByVal wb As webBrowser) As String
On Error Resume Next
    Call wb.Document.parentWindow.execScript("CACHE = window.CACHE;")
    ReadScriptCache = wb.Document.Script.cache
End Function

Public Function GetExitCommandVisible(ByVal wb As webBrowser) As Boolean
On Error Resume Next
    Call wb.Document.parentWindow.execScript("sExamExitCommandHide = window.sExamExitCommandHide ? true : false;")
    GetExitCommandVisible = Not wb.Document.Script.sExamExitCommandHide
End Function

Public Sub DisableBrowserFresh(ByVal wb As webBrowser)
    Dim snippet As String
    snippet = ""
    snippet = snippet & "var postDocKeydownHandler = document.onkeydown;                          "
    snippet = snippet & "document.onkeydown = function (event) {                                  "
    snippet = snippet & "    event = event || window.event;                                       "
    snippet = snippet & "    if (    /*(event.keyCode==8)   ||                  /* �����˸�ɾ���� */"
    snippet = snippet & "            (event.keyCode==116) ||                  /* ���� F5 ˢ�¼� */"
    snippet = snippet & "            (event.altKey)       ||                  /* ����Alt        */"
    snippet = snippet & "            (event.ctrlKey && event.keyCode==82)){   /* Ctrl + R       */"
    snippet = snippet & "        event.keyCode=0;                                                 "
    snippet = snippet & "        event.returnValue=false;                                         "
    snippet = snippet & "        return;                                                          "
    snippet = snippet & "    }                                                                    "
    snippet = snippet & "    try {                                                                "
    snippet = snippet & "        if (postDocKeydownHandler) { postDocKeydownHandler(event); }     "
    snippet = snippet & "    } catch (e) { }                                                      "
    snippet = snippet & "};                                                                       "

    Call wb.Document.parentWindow.execScript(snippet)
End Sub
