VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WinApiWininet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WindowAPI wininet �N���X
'* [��  ��] WindowAPI�́uwininet.dll�v�̋@�\��񋟂���B
'*
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* WindowsAPI��`
'******************************************************************************
Private Declare PtrSafe Function DeleteUrlCacheEntry Lib "wininet" Alias "DeleteUrlCacheEntryA" (ByVal lpszUrlName As String) As Long



'******************************************************************************
'* [�T  �v] WinApi_DeleteUrlCacheEntry
'* [��  ��] WindowsAPI�u DeleteUrlCacheEntry �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function WinApi_DeleteUrlCacheEntry(ByVal lpszUrlName As String) As Long
    WinApi_DeleteUrlCacheEntry = DeleteUrlCacheEntry(lpszUrlName)
End Function
