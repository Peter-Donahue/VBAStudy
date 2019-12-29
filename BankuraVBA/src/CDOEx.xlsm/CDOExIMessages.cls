VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CDOExIMessages"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] CDO.IMessages�N���X�̃��b�v�E�g���N���X
'* [��  ��] CDO.IMessages�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          CDO.IMessages�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* [�Q  �l] <xx>
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' CDO.IMessages�N���X�ɂ��āB
' <xx>
' Defines methods and properties used to manage a collection of Message objects on the file system. Returned by IDropDirectory.GetMessages.
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As CDO.IMessages
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
        Dim wrap As CDOExMessage: Set wrap = New CDOExMessage
        Set wrap.Origin = myItem
        mKeys.Add wrap, wrap
    Next
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe number of message objects in the collection.
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* FileName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EReturns the name of the file containing the specified message in the file system.
'*-----------------------------------------------------------------------------
Property Get FileName(var) As String
    FileName = mOrigin.FileName(var)
End Property

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �EReturns the message specified by index from the collection.
'*-----------------------------------------------------------------------------
Property Get Item(Index As Long) As CDOExMessage
Attribute Item.VB_UserMemId = 0
    Dim wrap As CDOExMessage: Set wrap = New CDOExMessage
    Set wrap.Origin = mOrigin.Item(Index)
    Set Item = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("CDO.IMessages")
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
'* [�T  �v] Delete ���\�b�h
'* [��  ��] Delete �̃��b�p�[���\�b�h�B
'*          Deletes the specified message object in the collection.
'*
'* @param Index xx
'*
'******************************************************************************
Sub Delete(Index As Long)
    Call mOrigin.Delete(Index)

    Dim i As Long
    For i = 1 To mKeys.Count
        If mKeys(i) = Index Then
            mKeys.Remove i
            Exit Sub
        End If
    Next
End Sub

'******************************************************************************
'* [�T  �v] DeleteAll ���\�b�h
'* [��  ��] DeleteAll �̃��b�p�[���\�b�h�B
'*          Deletes all message objects in the collection.
'*
'******************************************************************************
Sub DeleteAll()
    Call mOrigin.DeleteAll
    Set mKeys = Nothing
    Set mKeys = New Collection
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
