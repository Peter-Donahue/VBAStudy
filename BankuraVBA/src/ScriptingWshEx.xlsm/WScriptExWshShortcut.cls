VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WScriptExWshShortcut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WScript.WshShortcut�N���X�̃��b�v�E�g���N���X
'* [��  ��] WScript.WshShortcut�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WScript.WshShortcut�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WScript.WshShortcut�N���X�ɂ��āB
' �V���[�g�J�b�g�ւ̃I�u�W�F�N�g�Q�Ƃ��쐬���܂��B
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364438(v=msdn.10)>
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As IWshRuntimeLibrary.WshShortcut
Private mOrigin As Object
    
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
'* �E Arguments �B
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
'* �E�V���[�g�J�b�g�̐�����Ԃ��܂��B
'*-----------------------------------------------------------------------------
Property Get Description() As String
    Description = mOrigin.Description
End Property
Property Let Description(arg As String)
    mOrigin.Description = arg
End Property

'* FullName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�V���[�g�J�b�g �I�u�W�F�N�g�̃����N��ւ̐�΃p�X��Ԃ��܂��B
'*-----------------------------------------------------------------------------
Property Get FullName() As String
    FullName = mOrigin.FullName
End Property

'*-----------------------------------------------------------------------------
'* Hotkey �v���p�e�B
'*
'* [��  ��]
'* �E�L�[�̑g�ݍ��킹���V���[�g�J�b�g�Ɋ��蓖�Ă邩�A���蓖�Ă�ꂽ�L�[��
'*   �g�ݍ��킹�����ʂ��܂��B
'*-----------------------------------------------------------------------------
Property Get Hotkey() As String
    Hotkey = mOrigin.Hotkey
End Property
Property Let Hotkey(arg As String)
    mOrigin.Hotkey = arg
End Property

'*-----------------------------------------------------------------------------
'* IconLocation �v���p�e�B
'*
'* [��  ��]
'* �E�A�C�R�����V���[�g�J�b�g�Ɋ��蓖�Ă邩�A���蓖�Ă�ꂽ�A�C�R�������ʂ��܂��B
'*-----------------------------------------------------------------------------
Property Get IconLocation() As String
    IconLocation = mOrigin.IconLocation
End Property
Property Let IconLocation(arg As String)
    mOrigin.IconLocation = arg
End Property

'*-----------------------------------------------------------------------------
'* RelativePath �v���p�e�B
'*
'* [��  ��]
'* �E RelativePath �B
'*-----------------------------------------------------------------------------
Property Get RelativePath() As String
    RelativePath = mOrigin.RelativePath
End Property
Property Let RelativePath(arg As String)
    mOrigin.RelativePath = arg
End Property

'*-----------------------------------------------------------------------------
'* TargetPath �v���p�e�B
'*
'* [��  ��]
'* �E�V���[�g�J�b�g�̎��s�\�t�@�C���ւ̃p�X�ł��B
'*-----------------------------------------------------------------------------
Property Get TargetPath() As String
    TargetPath = mOrigin.TargetPath
End Property
Property Let TargetPath(arg As String)
    mOrigin.TargetPath = arg
End Property

'*-----------------------------------------------------------------------------
'* WindowStyle �v���p�e�B
'*
'* [��  ��]
'* �E�E�B���h�E�X�^�C�����V���[�g�J�b�g�Ɋ��蓖�Ă邩�A�V���[�g�J�b�g��
'*   �E�B���h�E �X�^�C���̎�ނ����ʂ��܂��B
'*     1   �E�B���h�E���A�N�e�B�u�ɂ��ĕ\�����܂��
'*         �E�B���h�E���ŏ����܂��͍ő剻����Ă���ꍇ�ͤ���̃T�C�Y�ƈʒu�ɖ߂�܂��
'*     3   �E�B���h�E���A�N�e�B�u�ɂ���ő剻�E�B���h�E�Ƃ��ĕ\�����܂��
'*     7   �E�B���h�E���ŏ���������ɏ�ʂƂȂ�E�B���h�E���A�N�e�B�u�ɂ��܂��
'*
'*-----------------------------------------------------------------------------
Property Get WindowStyle() As Long
    WindowStyle = mOrigin.WindowStyle
End Property
Property Let WindowStyle(arg As Long)
    mOrigin.WindowStyle = arg
End Property

'*-----------------------------------------------------------------------------
'* WorkingDirectory �v���p�e�B
'*
'* [��  ��]
'* �E��ƃf�B���N�g�����V���[�g�J�b�g�Ɋ��蓖�Ă邩�A�V���[�g�J�b�g�̍��
'*   �f�B���N�g�������ʂ��܂��B
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
    'Set mOrigin = CreateObject("WScript.WshShortcut")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Save ���\�b�h
'* [��  ��] Save �̃��b�p�[���\�b�h�B
'*          �V���[�g�J�b�g �I�u�W�F�N�g��ۑ����܂��B
'*
'******************************************************************************
Sub Save()
    Call mOrigin.Save
End Sub

'******************************************************************************
'* [�T  �v] Load ���\�b�h
'* [��  ��] Load �̃��b�p�[���\�b�h�B
'*          �B�����\�b�h�B
'*
'* @param PathLink
'******************************************************************************
Sub Load(PathLink As String)
    Call mOrigin.Load(PathLink)
End Sub