VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemNamedValueSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemNamedValueSet�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemNamedValueSet�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemNamedValueSet�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemNamedValueSet�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393732(v=vs.80)>
' A collection of Named Values
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemNamedValueSet
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
        Dim wrap As WMIExSWbemNamedValue: Set wrap = New WMIExSWbemNamedValue
        Set wrap.Origin = myItem
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
    Set mOrigin = CreateObject("WbemScripting.SWbemNamedValueSet")
    Set mKeys = New Collection
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
'*          Add a named value to this collection.
'*
'* @param strName xx
'* @param varValue xx
'* @param iFlags xx
'* @return WMIExSWbemNamedValue
'*
'******************************************************************************
Function Add(strName As String, varValue, Optional iFlags As Long) As WMIExSWbemNamedValue
    Dim wrap As WMIExSWbemNamedValue: Set wrap = New WMIExSWbemNamedValue
    Set wrap.Origin = mOrigin.Add(strName, varValue, iFlags)
    Set Add = wrap
    mKeys.Add wrap, strName
End Function

'******************************************************************************
'* [�T  �v] Clone ���\�b�h
'* [��  ��] Clone �̃��b�p�[���\�b�h�B
'*          Make a copy of this collection.
'*
'* @return WMIExSWbemNamedValueSet
'*
'******************************************************************************
Function Clone() As WMIExSWbemNamedValueSet
    Dim wrap As WMIExSWbemNamedValueSet: Set wrap = New WMIExSWbemNamedValueSet
    Set wrap.Origin = mOrigin.Clone()
    Set Clone = wrap
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
'*          Get a named value from this Collection.
'*
'* @param strName xx
'* @param iFlags xx
'* @return WMIExSWbemNamedValue
'*
'******************************************************************************
Function Item(strName As String, Optional iFlags As Long) As WMIExSWbemNamedValue
Attribute Item.VB_UserMemId = 0
    Dim wrap As WMIExSWbemNamedValue: Set wrap = New WMIExSWbemNamedValue
    Set wrap.Origin = mOrigin.Item(strName, iFlags)
    Set Item = wrap
End Function

'******************************************************************************
'* [�T  �v] Remove ���\�b�h
'* [��  ��] Remove �̃��b�p�[���\�b�h�B
'*          Remove a named value from this collection.
'*
'* @param strName xx
'* @param iFlags xx
'*
'******************************************************************************
Sub Remove(strName As String, Optional iFlags As Long)
    Call mOrigin.Remove(strName, iFlags)

    Dim i As Long
    For i = 1 To mKeys.Count
        If mKeys(i) = strName Then
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