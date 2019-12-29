VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ShellExDShellFolderViewEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Shell32.DShellFolderViewEvents�N���X�̃��b�v�E�g���N���X
'* [��  ��] Shell32.DShellFolderViewEvents�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Shell32.DShellFolderViewEvents�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Shell32.DShellFolderViewEvents�N���X�ɂ��āB
' <xxx>
'
' Event interface for ShellFolderView.
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As shell32.DShellFolderViewEvents
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

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Shell32.DShellFolderViewEvents")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] BeginDrag ���\�b�h
'* [��  ��] BeginDrag �̃��b�p�[���\�b�h�B
'*          user started to drag an item (return false to cancel).
'*
'******************************************************************************
Function BeginDrag() As Boolean
    BeginDrag = mOrigin.BeginDrag
End Function

'******************************************************************************
'* [�T  �v] DefaultVerbInvoked ���\�b�h
'* [��  ��] DefaultVerbInvoked �̃��b�p�[���\�b�h�B
'*          the default verb (double click) was invoked on an items in the view (return false to cancel).
'*
'******************************************************************************
Function DefaultVerbInvoked() As Boolean
    DefaultVerbInvoked = mOrigin.DefaultVerbInvoked
End Function

'******************************************************************************
'* [�T  �v] EnumDone ���\�b�h
'* [��  ��] EnumDone �̃��b�p�[���\�b�h�B
'*          The folder has finished enumerating (flashlight is gone).
'*
'******************************************************************************
Sub EnumDone()
    Call mOrigin.EnumDone
End Sub

'******************************************************************************
'* [�T  �v] SelectionChanged ���\�b�h
'* [��  ��] SelectionChanged �̃��b�p�[���\�b�h�B
'*          The Selection in the view changed.
'*
'******************************************************************************
Sub SelectionChanged()
    Call mOrigin.SelectionChanged
End Sub

'******************************************************************************
'* [�T  �v] VerbInvoked ���\�b�h
'* [��  ��] VerbInvoked �̃��b�p�[���\�b�h�B
'*          A verb was invoked on an items in the view (return false to cancel).
'*
'******************************************************************************
Function VerbInvoked() As Boolean
    VerbInvoked = mOrigin.VerbInvoked
End Function