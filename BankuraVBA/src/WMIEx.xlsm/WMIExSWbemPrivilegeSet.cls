VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemPrivilegeSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemPrivilegeSet�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemPrivilegeSet�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemPrivilegeSet�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemPrivilegeSet�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393793(v=vs.80)>
' A collection of Privilege Overrides
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemPrivilegeSet
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
        Dim wrap As WMIExSWbemPrivilege: Set wrap = New WMIExSWbemPrivilege
        Set wrap.Origin = myItem
        mKeys.Add wrap, myItem.Identifier
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
    'Set mOrigin = CreateObject("WbemScripting.SWbemPrivilegeSet")
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
'*          Add a Privilege to this collection.
'*
'* @param iPrivilege xx
'* @param bIsEnabled xx
'* @return WMIExSWbemPrivilege
'*
'******************************************************************************
Function Add(iPrivilege As WbemPrivilegeEnum, Optional bIsEnabled As Boolean = True) As WMIExSWbemPrivilege
    Dim wrap As WMIExSWbemPrivilege: Set wrap = New WMIExSWbemPrivilege
    Set wrap.Origin = mOrigin.Add(iPrivilege, bIsEnabled)
    Set Add = wrap
    mKeys.Add wrap, iPrivilege
End Function

'******************************************************************************
'* [�T  �v] DeleteAll ���\�b�h
'* [��  ��] DeleteAll �̃��b�p�[���\�b�h�B
'*          Delete all items in this collection.
'*
'******************************************************************************
Sub DeleteAll()
    Call mOrigin.DeleteAll
    Set mKeys = Nothing
    Set mKeys = New Collection
End Sub

'******************************************************************************
'* [�T  �v] Item ���\�b�h�i���胁���o�[�j
'* [��  ��] Item �̃��b�p�[���\�b�h�B
'*          Get a named Privilege from this collection.
'*
'* @param iPrivilege xx
'* @return WMIExSWbemPrivilege
'*
'******************************************************************************
Function Item(iPrivilege As WbemPrivilegeEnum) As WMIExSWbemPrivilege
Attribute Item.VB_UserMemId = 0
    Dim wrap As WMIExSWbemPrivilege: Set wrap = New WMIExSWbemPrivilege
    Set wrap.Origin = mOrigin.Item(iPrivilege)
    Set Item = wrap
End Function

'******************************************************************************
'* [�T  �v] Remove ���\�b�h
'* [��  ��] Remove �̃��b�p�[���\�b�h�B
'*          Remove a Privilege from this collection.
'*
'******************************************************************************
Sub Remove(iPrivilege As WbemPrivilegeEnum)
    Call mOrigin.Remove(iPrivilege)

    Dim i As Long
    For i = 1 To mKeys.Count
        If mKeys(i) = iPrivilege Then
            mKeys.Remove i
            Exit Sub
        End If
    Next
End Sub

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