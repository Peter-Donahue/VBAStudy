VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WinApiOleacc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WindowAPI oleacc �N���X
'* [��  ��] WindowAPI�́uoleacc.dll�v�̋@�\��񋟂���B
'*
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* WindowsAPI��`
'******************************************************************************
Private Declare PtrSafe Function ObjectFromLresult Lib "oleacc" (ByVal lResult As LongPtr, riid As Any, ByVal wParam As LongPtr, ppvObject As Any) As LongPtr


'******************************************************************************
'* [�T  �v] WinApi_ObjectFromLresult
'* [��  ��] WindowsAPI�u ObjectFromLresult �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function WinApi_ObjectFromLresult(ByVal lResult As LongPtr, riid As LongPtr, ByVal wParam As LongPtr, ppvObject As Object) As LongPtr
    WinApi_ObjectFromLresult = ObjectFromLresult(lResult, riid, wParam, ppvObject)
End Function