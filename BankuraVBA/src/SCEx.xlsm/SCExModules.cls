VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "SCExModules"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] MSScriptControl.Modules �N���X�̃��b�v�E�g���N���X
'* [��  ��] MSScriptControl.Modules �N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          MSScriptControl.Modules �N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' MSScriptControl.Modules �N���X�ɂ��āB
' Collection of modules.
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As MSScriptControl.Modules
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
    Dim myItem As Object
    For Each myItem In mOrigin
        Dim wrap As SCExModule: Set wrap = New SCExModule
        Set wrap.Origin = myItem
        mKeys.Add wrap, myItem.Name
    Next myItem
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �ENumber of modules.
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet a module indexed by position or module name.
'*-----------------------------------------------------------------------------
Property Get Item(Index) As SCExModule
Attribute Item.VB_UserMemId = 0
    Dim wrap As SCExModule: Set wrap = New SCExModule
    Set wrap.Origin = mOrigin.Item(Index)
    Set Item = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("MSScriptControl.Module")
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
'* [�T  �v] Add ���\�b�h
'* [��  ��] Add �̃��b�p�[���\�b�h�B
'*          Add a new module.
'*
'* @param Name xx
'* @param Object xx
'* @return Module
'*
'******************************************************************************
Function Add(Name As String, Optional Object) As SCExModule
    Dim wrap As SCExModule: Set wrap = New SCExModule
    Set wrap.Origin = mOrigin.Add(Name, Object)
    Set Add = wrap
    mKeys.Add wrap, Name
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