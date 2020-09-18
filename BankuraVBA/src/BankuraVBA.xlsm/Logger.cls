VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Logger"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Logger�N���X
'* [��  ��] ���O�o�͗p�̃N���X�B
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* Enum��`
'******************************************************************************
Public Enum LogLevelEnum
    lvNone
    lvFatal
    lvWarn
    lvInfo
    lvTrace
End Enum

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mLogOutputLevel As LogLevelEnum
Private mIwConsoleOutEnabled As Boolean
Private mLogDirPath As String
Private mLogFileName As String
Private mLogFilePath As String
Private mStatusBarOutEnabled As Boolean
Private mUserName As String

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* LogOutputLevel �v���p�e�B
'* ���O�o�̓��x��
'*-----------------------------------------------------------------------------
Public Property Get LogOutputLevel() As LogLevelEnum
    LogOutputLevel = mLogOutputLevel
End Property
Public Property Let LogOutputLevel(arg As LogLevelEnum)
    mLogOutputLevel = arg
End Property

'*-----------------------------------------------------------------------------
'* IwConsoleOutEnabled �v���p�e�B
'* �C�~�f�B�G�C�g�E�B���h�E�o�͉�
'*-----------------------------------------------------------------------------
Public Property Get IwConsoleOutEnabled() As Boolean
    IwConsoleOutEnabled = mIwConsoleOutEnabled
End Property
Public Property Let IwConsoleOutEnabled(arg As Boolean)
    mIwConsoleOutEnabled = arg
End Property

'*-----------------------------------------------------------------------------
'* LogDirPath �v���p�e�B
'* ���O�o�͐�f�B���N�g��
'*-----------------------------------------------------------------------------
Public Property Get LogDirPath() As String
    LogDirPath = mLogDirPath
End Property
Public Property Let LogDirPath(arg As String)
    mLogDirPath = FileUtils.AddPathSeparator(arg)
    mLogFilePath = mLogDirPath & mLogFileName
End Property

'*-----------------------------------------------------------------------------
'* LogFileName �v���p�e�B
'* ���O�t�@�C����
'*-----------------------------------------------------------------------------
Public Property Get LogFileName() As String
    LogFileName = mLogFileName
End Property
Public Property Let LogFileName(arg As String)
    mLogFileName = arg
    mLogFilePath = mLogDirPath & mLogFileName
End Property

'*-----------------------------------------------------------------------------
'* StatusBarOutEnabled �v���p�e�B
'* �X�e�[�^�X�o�[�\����
'*-----------------------------------------------------------------------------
Public Property Get StatusBarOutEnabled() As Boolean
    StatusBarOutEnabled = mStatusBarOutEnabled
End Property
Public Property Let StatusBarOutEnabled(arg As Boolean)
    mStatusBarOutEnabled = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    mLogOutputLevel = LogLevelEnum.lvNone
    mIwConsoleOutEnabled = False
    mLogDirPath = ""
    mLogFileName = ""
    mStatusBarOutEnabled = False
    mUserName = Base.GetWshNetwork.UserName
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Init ���\�b�h
'* [��  ��] �������p���\�b�h�
'*
'* @param myLogLevel     ���O�o�̓��x��
'* @param iwFlg          �C�~�f�B�G�C�g�E�B���h�E�o�͉�
'* @param strLogDirPath  ���O�o�͐�f�B���N�g��
'* @param strLogFileName ���O�t�@�C����
'* @param rotateFileSize ���O���[�e�[�g�t�@�C���T�C�Y�i�f�t�H���g10MB�j
'* @return Logger�I�u�W�F�N�g
'*
'******************************************************************************
Public Function Init(ByVal myLogLevel As LogLevelEnum, _
                     ByVal iwFlg As Boolean, _
                     ByVal strLogDirPath As String, _
                     ByVal strLogFileName As String, _
                     Optional ByVal rotateFileSize As Long = 10485760) As Logger
    mLogOutputLevel = myLogLevel
    mIwConsoleOutEnabled = iwFlg
    LogDirPath = strLogDirPath
    LogFileName = strLogFileName
    
    ' ���O���[�e�[�V����
    If Dir(mLogFilePath) <> "" Then
        If FileLen(mLogFilePath) > rotateFileSize Then
            Name mLogFilePath As mLogFilePath & "." & Format(Now, "yyyymmdd-hhmm")
        End If
    End If
    
    Set Init = Me
End Function

'******************************************************************************
'* [�T  �v] Trace
'* [��  ��] Trace���O���o�͂���B
'*
'* @param strLogText ���O�ɏo�͂���e�L�X�g
'******************************************************************************
Public Sub Trace(strLogText As String)
    Call Log(strLogText, LogLevelEnum.lvTrace)
End Sub

'******************************************************************************
'* [�T  �v] Info
'* [��  ��] Info���O���o�͂���B
'*
'* @param strLogText ���O�ɏo�͂���e�L�X�g
'******************************************************************************
Public Sub Info(strLogText As String)
    Call Log(strLogText, LogLevelEnum.lvInfo)
End Sub

'******************************************************************************
'* [�T  �v] Warn
'* [��  ��] Warn���O���o�͂���B
'*
'* @param strLogText ���O�ɏo�͂���e�L�X�g
'******************************************************************************
Public Sub Warn(strLogText As String)
    Call Log(strLogText, LogLevelEnum.lvWarn)
End Sub

'******************************************************************************
'* [�T  �v] Fatal
'* [��  ��] Fatal���O���o�͂���B
'*
'* @param strLogText ���O�ɏo�͂���e�L�X�g
'******************************************************************************
Public Sub Fatal(strLogText As String)
    Call Log(strLogText, LogLevelEnum.lvFatal)
End Sub

'******************************************************************************
'* [�T  �v] Log
'* [��  ��] ���O���o�͂���B
'*
'* @param strLogText ���O�ɏo�͂���e�L�X�g
'* @param myLogLevel ���O���x��
'******************************************************************************
Public Sub Log(strLogText As String, myLogLevel As LogLevelEnum)
    On Error GoTo ErrorHandler

    If mLogOutputLevel = LogLevelEnum.lvNone And mIwConsoleOutEnabled = False Then
        Exit Sub
    End If

    Dim strLogLevel As String
    Select Case myLogLevel
        Case LogLevelEnum.lvFatal
            strLogLevel = "FATAL"
        Case LogLevelEnum.lvWarn
            strLogLevel = "WARN"
        Case LogLevelEnum.lvInfo
            strLogLevel = "INFO"
        Case Else
            strLogLevel = "TRACE"
    End Select
    
    Dim strOutMsg As String
    strOutMsg = GetTimestampString() & " [" & strLogLevel & "] [" & mUserName & "] " & strLogText
    If myLogLevel <= mLogOutputLevel Then
        Dim lngFileNum As Long: lngFileNum = FreeFile()
        Open mLogFilePath For Append As #lngFileNum
        Print #lngFileNum, strOutMsg
        Close #lngFileNum
    End If
    If mIwConsoleOutEnabled Then
        Debug.Print strOutMsg
    End If
    Exit Sub
ErrorHandler:
    Debug.Print GetTimestampString() & " [FATAL] �G���[�������FNumber=" & Err.Number & " Description=" & Err.Description
    Debug.Print GetTimestampString() & " [CAUTION] ���O�o�͕s�B�C�~�f�B�G�C�g�E�B���h�E�o�͂ɐؑցB"
    mIwConsoleOutEnabled = True
    mLogOutputLevel = LogLevelEnum.lvNone
    Debug.Print strOutMsg
End Sub

'******************************************************************************
'* [�T  �v] OutStatusBar
'* [��  ��] �X�e�[�^�X�o�[�Ɏw�肵���e�L�X�g��\������B
'*
'* @param textStr �X�e�[�^�X�o�[�ɕ\������e�L�X�g
'******************************************************************************
Public Sub OutStatusBar(textStr As String)
    If mStatusBarOutEnabled Then
        Application.StatusBar = textStr
    End If
End Sub

'******************************************************************************
'* [�T  �v] GetTimestampString
'* [��  ��] ���ݎ����̔N���������b�~���b���uYYYY/MM/DD HH:NN:SS.000�v�`����
'*          ������Ŏ擾����B
'*
'* @return String ���ݎ���������
'******************************************************************************
Private Function GetTimestampString() As String
    Dim dblTimer As Double
    Dim hour As Integer
    Dim minute As Integer
    Dim second As Integer
    Dim mSec As Double
    
    dblTimer = CDbl(Timer)
    hour = dblTimer \ 3600
    minute = (dblTimer Mod 3600) \ 60
    second = dblTimer Mod 60
    mSec = Fix((dblTimer - Fix(dblTimer)) * 1000)

    GetTimestampString = Format(Now, "yyyy/mm/dd") & " " & Format(hour, "00") & ":" & _
                         Format(minute, "00") & ":" & Format(second, "00") & "." & Format(mSec, "000")
End Function