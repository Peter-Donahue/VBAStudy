VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WinApiOleaut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WindowAPI oleaut �N���X
'* [��  ��] WindowAPI�́uoleaut.dll�v�̋@�\��񋟂���B
'*
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* WindowsAPI��`
'******************************************************************************
Private Declare PtrSafe Function DispCallFunc Lib "oleaut32" (ByVal pvInstance As LongPtr, ByVal oVft As LongPtr, ByVal cc_ As Long, ByVal vtReturn As Integer, ByVal cActuals As Long, ByRef prgvt As Integer, ByRef prgpvarg As LongPtr, ByRef pvargResult As Variant) As Long
Private Declare PtrSafe Function SafeArrayAllocDescriptor Lib "oleaut32" (ByVal cDims As Long, ByRef ppsaOut() As Any) As Long

'******************************************************************************
'* [�T  �v] WinApi_DispCallFunc
'* [��  ��] WindowsAPI�u DispCallFunc �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function WinApi_DispCallFunc(ByVal pvInstance As LongPtr, ByVal oVft As LongPtr, ByVal cc_ As Long, ByVal vtReturn As Integer, ByVal cActuals As Long, ByRef prgvt As Integer, ByRef prgpvarg As LongPtr, ByRef pvargResult As Variant) As Long
    WinApi_DispCallFunc = DispCallFunc(pvInstance, oVft, cc_, vtReturn, cActuals, prgvt, prgpvarg, pvargResult)
End Function

'******************************************************************************
'* [�T  �v] WinApi_SafeArrayAllocDescriptor
'* [��  ��] WindowsAPI�u SafeArrayAllocDescriptor �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function WinApi_SafeArrayAllocDescriptor(ByVal cDims As Long, ByRef ppsaOut() As Long) As Long
    WinApi_SafeArrayAllocDescriptor = SafeArrayAllocDescriptor(cDims, ppsaOut)
End Function

