VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "SoundUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] �T�E���h�֘A���[�e�B���e�B�N���X
'* [��  ��] �����E���ʉ��E���y�֘A�̃��[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'*
'* [�ˁ@��]
'*
'* [�Q  �l] https://excel.syogyoumujou.com/vba/mci.html
'*          http://home.att.ne.jp/zeta/gen/excel/c04p04.htm
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* WindowsAPI��`
'******************************************************************************
Private Declare PtrSafe Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, Optional ByVal lpstrReturnString As String = vbNullString, Optional ByVal uReturnLength As Long = 0, Optional ByVal hwndback As LongPtr = 0) As Long
Private Declare PtrSafe Function Beep Lib "kernel32" (ByVal dwFreq As Long, ByVal dwDuration As Long) As Long
Private Declare PtrSafe Function MessageBeep Lib "user32" (ByVal wType As Long) As Long
Private Declare PtrSafe Function PlaySoundAPI Lib "winmm.dll" Alias "PlaySoundA" (ByVal lpszName As String, ByVal hModule As LongPtr, ByVal dwFlags As Long) As Long
Private Declare PtrSafe Function PlaySoundOfByteData Lib "winmm.dll" Alias "PlaySoundA" (ByRef pszSound As Byte, ByVal hModule As LongPtr, ByVal dwFlags As Long) As Long
Private Declare PtrSafe Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long

'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************
Private Const MCI_SEND_CON_FILENAME As String = "MySoundConnect"
Private Const SND_SYNC = &H0
Private Const SND_ASYNC = &H1
Private Const SND_NODEFAULT = &H2
Private Const SND_MEMORY = &H4
Private Const SND_LOOP = &H8
Private Const SND_NOSTOP = &H10

'******************************************************************************
'* �ϐ���`
'******************************************************************************
Private mIsSoundOpened As Boolean

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    mIsSoundOpened = False
End Sub
Private Sub Class_Terminate()
    Call CloseSound
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] PlaySoundJust
'* [��  ��] �I�����������t�@�C���������ɍĐ�����
'*
'* @param useByteData �o�C�g�f�[�^��
'* @return String xxx
'*
'******************************************************************************
Public Sub PlaySoundJust(Optional ByVal useByteData As Boolean = False)
    '�����t�@�C���̑I��
    Dim strFilePath As String
    strFilePath = Application.GetOpenFileName("�����t�@�C�� (*.wav),*.wav")
    If strFilePath <> "False" Then
        If useByteData Then
            Dim buf() As Byte
            Dim fileNum As Long:  fileNum = FreeFile
            Open strFilePath For Binary As fileNum
            ReDim buf(LOF(fileNum))
            Get fileNum, , buf
            Close fileNum
    
            PlaySoundOfByteData buf(0), 0, SND_ASYNC + SND_MEMORY
            Exit Sub
        End If
        PlaySoundAPI strFilePath, 0, SND_ASYNC
    End If
End Sub

'******************************************************************************
'* [�T  �v] OpenSound
'* [��  ��] �����t�@�C�����������ɓǂݍ��ݡ
'*
'******************************************************************************
Public Sub OpenSound()
    '�����t�@�C���̑I��
    Dim strFilePath As String
    strFilePath = Application.GetOpenFileName("�����t�@�C�� (*.wav;*.mid;*.mp3;*.wma),*.wav;*.mid;*.mp3;*.wma")
    If strFilePath <> "False" Then
        If 0 < InStrRev(strFilePath, ".") Then
            Call mciSendString("Open """ & strFilePath & """ alias " & MCI_SEND_CON_FILENAME)
            mIsSoundOpened = True
        End If
    End If
End Sub

'******************************************************************************
'* [�T  �v] CloseSound
'* [��  ��] �����t�@�C��������������N���A�
'* [��  ��] �u�b�N�����O�Ɏ��s���邱�ơ
'*
'******************************************************************************
Public Sub CloseSound()
    If mIsSoundOpened Then
        Call mciSendString("Close All")
        mIsSoundOpened = False
    End If
End Sub

'******************************************************************************
'* [�T  �v] PlaySound
'* [��  ��] �����t�@�C�����Đ��
'* [��  ��] ���O�ɉ����t�@�C����ǂݍ��܂Ȃ��ƁA�Đ��ł��Ȃ��
'*
'******************************************************************************
Public Sub PlaySound()
    Call mciSendString("Play " & MCI_SEND_CON_FILENAME & " from 0")
End Sub

'******************************************************************************
'* [�T  �v] PauseSound
'* [��  ��] �����t�@�C���̍Đ����ꎞ��~�
'*
'******************************************************************************
Public Sub PauseSound()
    Call mciSendString("Pause " & MCI_SEND_CON_FILENAME)
End Sub

'******************************************************************************
'* [�T  �v] ResumeSound
'* [��  ��] �����t�@�C���̍Đ��ꎞ��~�����
'*
'******************************************************************************
Public Sub ResumeSound()
    Call mciSendString("Resume " & MCI_SEND_CON_FILENAME)
End Sub

'******************************************************************************
'* [�T  �v] StopSound
'* [��  ��] �����t�@�C���̍Đ����~�
'*
'******************************************************************************
Public Sub StopSound()
    Call mciSendString("Stop " & MCI_SEND_CON_FILENAME)
End Sub

'******************************************************************************
'* [�T  �v] BeepSound
'* [��  ��] �����t�@�C���̍Đ����~�
'*
'* @param pitch ���̍���
'* @param length ���̒����imilliseconds�j
'*
'******************************************************************************
Public Sub BeepSound(pitch As Long, length As Long)
    Call Beep(pitch, length)
End Sub

Public Sub ErrorMessageBeep()
    Call MessageBeep(&H10&)
End Sub
Public Sub InformationMessageBeep()
    Call MessageBeep(&H1&)
End Sub
