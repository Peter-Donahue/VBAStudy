VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WScriptExWshExec"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WScript.WshExec�N���X�̃��b�v�E�g���N���X
'* [��  ��] WScript.WshExec�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WScript.WshExec�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WScript.WshExec�N���X�ɂ��āB
' Exec ���g���Ď��s�����X�N���v�g�̃X�e�[�^�X����񋟂��܂��B
' �܂��AStdIn�AStdOut�A����� StdErr �̊e�X�g���[���ւ̃A�N�Z�X���񋟂��܂��B
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364375(v=msdn.10)>�B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As IWshRuntimeLibrary.wshExec
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
'* ExitCode �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EExitCode�B
'*-----------------------------------------------------------------------------
Property Get ExitCode() As Long
    ExitCode = mOrigin.ExitCode
End Property

'*-----------------------------------------------------------------------------
'* ProcessID �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EProcessID�B
'*-----------------------------------------------------------------------------
Property Get ProcessID() As Long
    ProcessID = mOrigin.ProcessID
End Property

'*-----------------------------------------------------------------------------
'* Status �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EExec���\�b�h���g���Ď��s�����X�N���v�g�̃X�e�[�^�X����Ԃ��܂��B
'*-----------------------------------------------------------------------------
Property Get Status() As WshExecStatus
    Status = mOrigin.Status
End Property

'*-----------------------------------------------------------------------------
'* StdErr �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EExec �I�u�W�F�N�g�� stderr �o�̓X�g���[���ւ̃A�N�Z�X��񋟂��܂��B
'*-----------------------------------------------------------------------------
Property Get StdErr() As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.StdErr
    Set StdErr = wrap
End Property

'*-----------------------------------------------------------------------------
'* StdIn �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EExec �I�u�W�F�N�g�� stdin ���̓X�g���[����񋟂��܂��B
'* �EExec �ŋN�����ꂽ�v���Z�X�Ƀf�[�^�������n���ꍇ�� StdIn �v���p�e�B���g�p���܂��B
'*-----------------------------------------------------------------------------
Property Get StdIn() As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.StdIn
    Set StdIn = wrap
End Property

'*-----------------------------------------------------------------------------
'* StdOut �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EExec �I�u�W�F�N�g�̏������ݐ�p�� stdout �o�̓X�g���[����񋟂��܂��B
'* �E�X�N���v�g����W���o�͂ɑ��M���ꂽ�S���̃R�s�[ (�ǂݎ���p) ���i�[����܂��B
'*-----------------------------------------------------------------------------
Property Get StdOut() As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.StdOut
    Set StdOut = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WScript.WshExec")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Terminate���\�b�h
'* [��  ��] Terminate�̃��b�p�[���\�b�h�B
'*          Exec ���\�b�h�ɂ���ĊJ�n���ꂽ�v���Z�X���I������悤�ɃX�N���v�g
'*          �G���W���Ɏw�����܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364387%28v%3dmsdn.10%29>
'*
'******************************************************************************
Sub Terminate()
    Call mOrigin.Terminate
End Sub

