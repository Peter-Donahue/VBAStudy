VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CDOExIBodyParts"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] CDO.IBodyParts�N���X�̃��b�v�E�g���N���X
'* [��  ��] CDO.IBodyParts�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          CDO.IBodyParts�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* [�Q  �l] <xx>
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' CDO.IBodyParts�N���X�ɂ��āB
' <xx>
' Defines methods and properties used to manage a collection of BodyPart objects.
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As CDO.IBodyParts
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
        Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
        Set wrap.Origin = myItem
        mKeys.Add wrap, wrap
    Next
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EReturns the number of BodyPart objects in the collection.
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �EThe specified BodyPart object in the collection.
'*-----------------------------------------------------------------------------
Property Get Item(Index As Long) As CDOExIBodyPart
Attribute Item.VB_UserMemId = 0
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.Item(Index)
    Set Item = wrap
End Property

    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("CDO.IBodyParts")
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
'*          Adds a BodyPart object to the collection at the specified index, and returns the newly added object.
'*
'* @param Index
'* @return IBodyPart
'*
'******************************************************************************
Function Add(Optional Index As Long = -1) As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.Add(Index)
    Set Add = wrap
    mKeys.Add wrap, wrap
End Function


'******************************************************************************
'* [�T  �v] Delete ���\�b�h
'* [��  ��] Delete �̃��b�p�[���\�b�h�B
'*          Deletes the specified BodyPart object from the collection. Can use the index or a reference to the object.
'*
'* @param varBP xx
'*
'******************************************************************************
Sub Delete(varBP)
    Call mOrigin.Delete(varBP)

    Dim i As Long
    For i = 1 To mKeys.Count
        If mKeys(i) = varBP Then
            mKeys.Remove i
            Exit Sub
        End If
    Next
End Sub

'******************************************************************************
'* [�T  �v] DeleteAll ���\�b�h
'* [��  ��] DeleteAll �̃��b�p�[���\�b�h�B
'*          Deletes all BodyPart objects in the collection.
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
