VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ShellExFolderItems3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Shell32.FolderItems3�N���X�̃��b�v�E�g���N���X
'* [��  ��] Shell32.FolderItems3�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Shell32.FolderItems3�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Shell32.FolderItems3�N���X�ɂ��āB
' <xxxxxxxxxxxxxx>
'
' Definition of interface FolderItems Version 3
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As shell32.FolderItems3
'Private mOrigin As Object
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
        Dim wrap As ShellExFolderItem: Set wrap = New ShellExFolderItem
        Set wrap.Origin = myItem
        mKeys.Add wrap, myItem.Name
    Next myItem
End Property

'*-----------------------------------------------------------------------------
'* Application �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet Application object
'*-----------------------------------------------------------------------------
Property Get Application() As Object
    Set Application = mOrigin.Application
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet count of items in the folder
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* Parent �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet Parent object
'*-----------------------------------------------------------------------------
Property Get Parent() As Object
    Set Parent = mOrigin.Parent
End Property

'*-----------------------------------------------------------------------------
'* Verbs �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet the list of verbs common to all the items
'*-----------------------------------------------------------------------------
Property Get Verbs() As ShellExFolderItemVerbs
Attribute Verbs.VB_UserMemId = 0
    Dim wrap As ShellExFolderItemVerbs: Set wrap = New ShellExFolderItemVerbs
    Set wrap.Origin = mOrigin.Verbs()
    Set Verbs = wrap
End Property

    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Shell32.FolderItems3")
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
'* [�T  �v] Filter ���\�b�h
'* [��  ��] Filter �̃��b�p�[���\�b�h�B
'*          Set a wildcard filter to apply to the items returned
'*
'* @param grfFlags
'* @param bstrFileSpec
'******************************************************************************
Sub Filter(grfFlags As Long, bstrFileSpec As String)
    Call mOrigin.Filter(grfFlags, bstrFileSpec)
End Sub
    
'******************************************************************************
'* [�T  �v] InvokeVerbEx ���\�b�h
'* [��  ��] InvokeVerbEx �̃��b�p�[���\�b�h�B
'*          Extended version of InvokeVerb for a collection of Folder Items
'*
'* @param vVerb
'* @param vArgs
'*
'******************************************************************************
Sub InvokeVerbEx(Optional vVerb, Optional vArgs)
    If IsMissing(vVerb) Then
        If IsMissing(vArgs) Then
            Call mOrigin.InvokeVerbEx
        Else
            Call mOrigin.InvokeVerbEx(, vArgs)
        End If
    ElseIf IsMissing(vArgs) Then
        Call mOrigin.InvokeVerbEx(vVerb)
    Else
        Call mOrigin.InvokeVerbEx(vVerb, vArgs)
    End If
End Sub

'******************************************************************************
'* [�T  �v] Item ���\�b�h
'* [��  ��] Item �̃��b�p�[���\�b�h�B
'*          Return the figure for the given index
'*
'* @param index
'* @return ShellExFolderItem
'******************************************************************************
Function Item(Optional index) As ShellExFolderItem
    Dim wrap As ShellExFolderItem: Set wrap = New ShellExFolderItem
    If IsMissing(index) Then
       Set wrap.Origin = mOrigin.Item
    Else
       Set wrap.Origin = mOrigin.Item(index)
    End If
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