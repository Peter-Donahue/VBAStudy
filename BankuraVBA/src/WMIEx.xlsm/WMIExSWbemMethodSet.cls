VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemMethodSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemMethodSet�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemMethodSet�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemMethodSet�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemMethodSet�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393723(v=vs.80)>
' A collection of Methods
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemMethodSet
Private mOrigin As Object
Private mKeys As Collection

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* �I���W�i��Object �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get Origin() As Object
    Set Origin = mOrigin
End Property
Property Set Origin(arg As Object)
    Set mOrigin = arg
    Set mKeys = New Collection
    Dim myItem As Object
    For Each myItem In mOrigin
        Dim wrap As WMIExSWbemMethod: Set wrap = New WMIExSWbemMethod
        Set wrap.Original = myItem
        mKeys.Add wrap, myItem.Name
    Next myItem
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe number of items in this collection.
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WbemScripting.SWbemMethodSet")
    'Set mKeys = New Collection
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
    Set mKeys = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Item ���\�b�h�i���胁���o�[�j
'* [��  ��] Item �̃��b�p�[���\�b�h�B
'*          Get a named Method from this collection.
'*
'* @param strName xx
'* @param iFlags xx
'* @return WMIExSWbemMethod
'*
'******************************************************************************
Function Item(strName As String, Optional iFlags As Long) As WMIExSWbemMethod
Attribute Item.VB_UserMemId = 0
    Dim wrap As WMIExSWbemMethod: Set wrap = New WMIExSWbemMethod
    Set wrap.Original = mOrigin.Item(strName, iFlags)
    Set Item = wrap
End Function
    

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------
'******************************************************************************
'* [�T  �v] NewEnum ���\�b�h
'* [��  ��] For Each �\���ŃC�e���[�^�[��Ԃ����߂̃��\�b�h�B
'*
'* @return �C�e���[�^�[
'******************************************************************************
Public Function NewEnum() As stdole.IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    Set NewEnum = mKeys.[_NewEnum]
End Function