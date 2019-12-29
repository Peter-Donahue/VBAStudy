VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ShellExShellLinkObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Shell32.ShellLinkObject�N���X�̃��b�v�E�g���N���X
'* [��  ��] Shell32.ShellLinkObject�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Shell32.ShellLinkObject�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Shell32.ShellLinkObject�N���X�ɂ��āB
' <xxxxxxxxxxxxxx>
'
' Shell Link object
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As shell32.ShellLinkObject
'Private mOrigin As Object

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
End Property

'*-----------------------------------------------------------------------------
'* Arguments �v���p�e�B
'*
'* [��  ��]
'* �EGet the arguments for the link
'*-----------------------------------------------------------------------------
Property Get Arguments() As String
    Arguments = mOrigin.Arguments
End Property
Property Let Arguments(arg As String)
    mOrigin.Arguments = arg
End Property

'*-----------------------------------------------------------------------------
'* Description �v���p�e�B
'*
'* [��  ��]
'* �EGet the description for the link
'*-----------------------------------------------------------------------------
Property Get Description() As String
    Description = mOrigin.Description
End Property
Property Let Description(arg As String)
    mOrigin.Description = arg
End Property

'*-----------------------------------------------------------------------------
'* Hotkey �v���p�e�B
'*
'* [��  ��]
'* �EGet the Hotkey for the link
'*-----------------------------------------------------------------------------
Property Get Hotkey() As Long
    Hotkey = mOrigin.Hotkey
End Property
Property Let Hotkey(arg As Long)
    mOrigin.Hotkey = arg
End Property

'*-----------------------------------------------------------------------------
'* Path �v���p�e�B
'*
'* [��  ��]
'* �EGet the path of the link
'*-----------------------------------------------------------------------------
Property Get Path() As String
    Path = mOrigin.Path
End Property
Property Let Path(arg As String)
    mOrigin.Path = arg
End Property

'*-----------------------------------------------------------------------------
'* ShowCommand �v���p�e�B
'*
'* [��  ��]
'* �EGet the Show Command for the link
'*-----------------------------------------------------------------------------
Property Get ShowCommand() As Long
    ShowCommand = mOrigin.ShowCommand
End Property
Property Let ShowCommand(arg As Long)
    mOrigin.ShowCommand = arg
End Property

'*-----------------------------------------------------------------------------
'* Target �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet the target of a link object
'*-----------------------------------------------------------------------------
Property Get Target() As ShellExFolderItem
    Dim wrap As ShellExFolderItem: Set wrap = New ShellExFolderItem
    Set wrap.Origin = mOrigin.Target
    Set Target = wrap
End Property

'*-----------------------------------------------------------------------------
'* WorkingDirectory �v���p�e�B
'*
'* [��  ��]
'* �EGet the working directory for the link
'*-----------------------------------------------------------------------------
Property Get WorkingDirectory() As String
    WorkingDirectory = mOrigin.WorkingDirectory
End Property
Property Let WorkingDirectory(arg As String)
    mOrigin.WorkingDirectory = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Shell32.ShellLinkObject")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] GetIconLocation ���\�b�h
'* [��  ��] GetIconLocation �̃��b�p�[���\�b�h�B
'*          Get the IconLocation for the link.
'*
'* @param pbs
'* @return Long
'*
'******************************************************************************
Function GetIconLocation(pbs As String) As Long
    GetIconLocation = GetIconLocation(pbs)
End Function

'******************************************************************************
'* [�T  �v] FilterView ���\�b�h
'* [��  ��] FilterView �̃��b�p�[���\�b�h�B
'*          Tell the link to resolve itself.
'*
'* @param fFlags
'*
'******************************************************************************
Sub Resolve(fFlags As Long)
    Call Resolve(fFlags)
End Sub

'******************************************************************************
'* [�T  �v] FilterView ���\�b�h
'* [��  ��] FilterView �̃��b�p�[���\�b�h�B
'*          Tell the link to save the changes.
'*
'* @param vWhere
'*
'******************************************************************************
Sub Save(Optional vWhere)
    If IsMissing(vWhere) Then
        Call Save
    Else
        Call Save(vWhere)
    End If
End Sub

'******************************************************************************
'* [�T  �v] FilterView ���\�b�h
'* [��  ��] FilterView �̃��b�p�[���\�b�h�B
'*          Set the IconLocation for the link.
'*
'* @param bstrFilterText
'*
'******************************************************************************
Sub SetIconLocation(bs As String, iIcon As Long)
    Call mOrigin.SetIconLocation(bs, iIcon)
End Sub