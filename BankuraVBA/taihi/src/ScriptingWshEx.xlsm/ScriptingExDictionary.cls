VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ScriptingExDictionary"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Scripting.Dictionary�N���X�̃��b�v�E�g���N���X
'* [��  ��] Scripting.Dictionary�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Scripting.Dictionary�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* [�Q  �l] <https://miau.hatenablog.com/entry/20110203/1296706824>
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Scripting.Dictionary�N���X�ɂ��āB
' <https://docs.microsoft.com/ja-jp/office/vba/language/reference/user-interface-help/dictionary-object>
' �f�[�^ �L�[/�A�C�e���̃y�A��ۑ�����I�u�W�F�N�g�B
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As Scripting.Dictionary
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
    Dim k
    For Each k In mOrigin.Keys
        Call mKeys.Add(k)
    Next
End Property

'*-----------------------------------------------------------------------------
'* CompareMode �v���p�e�B
'*
'* [��  ��]
'* �E��������r���郁�\�b�h��ݒ肷��B�l�̎擾���\�B
'*-----------------------------------------------------------------------------
Property Get CompareMode() As CompareMethod
    CompareMode = mOrigin.CompareMode
End Property
Property Let CompareMode(arg As CompareMethod)
    mOrigin.CompareMode = arg
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�f�B�N�V���i�����̍��ڐ����擾����B
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property


'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i���胁���o�[�j
'*
'* [��  ��]
'* �E�w�肵���L�[�ɑ΂��鍀�ڂ�ݒ肵�܂��B�l�̎擾���\�B
'* �E<�g��>�w�肵���L�[�����݂��Ă���ꍇ�́A�폜��ɐݒ肵�܂��B
'*-----------------------------------------------------------------------------
Property Get Item(Key)
Attribute Item.VB_UserMemId = 0
    If IsObject(mOrigin(Key)) Then
        Set Item = mOrigin(Key)
    Else
        Item = mOrigin(Key)
    End If
End Property
Property Set Item(Key, arg)
    If mOrigin.Exists(Key) Then
        Me.Remove Key
    End If
    If IsObject(arg) Then
        Set mOrigin.Item(Key) = arg
    Else
        mOrigin.Item(Key) = arg
    End If
End Property

'*-----------------------------------------------------------------------------
'* Key �v���p�e�B
'*
'* [��  ��]
'* �E�L�[��ʂ̃L�[�ɕύX����B
'*-----------------------------------------------------------------------------
'Property Get Key(KeyValue)
'    Key = mOrigin.Key(KeyValue)
'End Property
Property Let Key(KeyValue, arg)
    If mOrigin.Exists(KeyValue) Then
        mOrigin.Key(KeyValue) = arg
        
        Dim i As Long
        For i = 1 To mKeys.Count
            If mKeys(i) = KeyValue Then
                mKeys.Remove i
                mKeys.Add arg
                Exit Property
            End If
        Next
    End If
End Property

'*-----------------------------------------------------------------------------
'* HashVal �v���p�e�B�i��\���F�ǂݎ���p�j
'*
'* [��  ��]
'* �E�f�B�N�V���i�����̍��ڐ����擾����B
'*-----------------------------------------------------------------------------
Property Get HashVal(KeyValue)
    HashVal = mOrigin.HashVal(KeyValue)
End Property
    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("Scripting.Dictionary")
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
'* [�T  �v] Add���\�b�h
'* [��  ��] Add�̃��b�p�[���\�b�h�B
'*          �f�B�N�V���i���ɐV�����L�[����э��ڂ�ǉ�����
'*
'* @param Key  �L�[
'* @param Item ���ڒl
'******************************************************************************
Sub Add(Key, Item)
    Call mOrigin.Add(Key, Item)
    Call mKeys.Add(Key)
    Exit Sub
End Sub

'******************************************************************************
'* [�T  �v] Exists���\�b�h
'* [��  ��] Exists�̃��b�p�[���\�b�h�B
'*          �w�肵���L�[���f�B�N�V���i���Ɋ܂܂�Ă��邩�ǂ����������B
'*
'* @param Key �L�[
'* @return �`�F�b�N���ʁiTrue:���݂���AFalse:���݂��Ȃ��j
'******************************************************************************
Function Exists(Key) As Boolean
    Exists = mOrigin.Exists(Key)
End Function
                         
'******************************************************************************
'* [�T  �v] Items���\�b�h
'* [��  ��] Items�̃��b�p�[���\�b�h�B
'*          �f�B�N�V���i�����̂��ׂĂ̍��ڂ��܂ޔz����擾����
'*
'* @return �f�B�N�V���i�����̂��ׂĂ̍��ڂ��܂ޔz��
'******************************************************************************
Function Items()
    Items = mOrigin.Items()
End Function

'******************************************************************************
'* [�T  �v] Keys���\�b�h
'* [��  ��] Keys�̃��b�p�[���\�b�h�B
'*          �f�B�N�V���i�����̂��ׂẴL�[���܂ޔz����擾����
'*
'* @return �f�B�N�V���i�����̂��ׂẴL�[���܂ޔz��
'******************************************************************************
Function Keys()
    Keys = mOrigin.Keys()
End Function

'******************************************************************************
'* [�T  �v] Remove���\�b�h
'* [��  ��] Remove�̃��b�p�[���\�b�h�B
'*          �w�肵���L�[���f�B�N�V���i������폜����
'*
'* @param Key �L�[
'******************************************************************************
Sub Remove(Key)
    Dim i As Long
    i = 1
    If TypeName(Key) = "String" Then
        Call mOrigin.Remove(Key)
    Else
        Dim k
        For Each k In mOrigin.Keys
            If mKeys(Key) = k Then
                Call mOrigin.Remove(k)
                mKeys.Remove Key
                Exit Sub
            End If
            i = i + 1
        Next
    End If
    Exit Sub
End Sub

'******************************************************************************
'* [�T  �v] RemoveAll���\�b�h
'* [��  ��] RemoveAll�̃��b�p�[���\�b�h�B
'*          �f�B�N�V���i�����炷�ׂĂ̏����폜����
'*
'******************************************************************************
Sub RemoveAll()
    Call mOrigin.RemoveAll
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