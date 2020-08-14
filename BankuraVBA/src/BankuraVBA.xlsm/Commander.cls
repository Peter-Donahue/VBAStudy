VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Commander"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] CUI�R�}���h���s�N���X
'* [��  ��] DOS�R�}���h�EPowershell���̃R�}���h���s�Ɋւ��鏈����񋟂���B
'*
'* [�Q  �l]�@https://thom.hateblo.jp/entry/2017/01/31/012913
'*
'* @author Bankura
'* Copyright (c) 2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* WindowsAPI��`
'******************************************************************************

'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mBaseCommand As String

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* BaseCommand �v���p�e�B
'*
'* ���s�R�}���h������̃t�H�[�}�b�g���i�[����B
'* ex) DOS�̏ꍇ�A"cmd.exe /c {0} > {1}"
'*     �i{0}=���s����R�}���h,{1}=�ꎞ�t�@�C���j
'*-----------------------------------------------------------------------------
Public Property Get BaseCommand() As String
    BaseCommand = mBaseCommand
End Property
Public Property Let BaseCommand(arg As String)
    mBaseCommand = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] GetCommandResultAsTextStream
'* [��  ��] �R�}���h�����s���A���s�������ʂ��ꎞ�t�@�C���ɕۑ�����B
'*          �ꎞ�t�@�C��������s���ʂ�TextStream�Ŏ擾����B
'*
'* @param commandString �R�}���h������
'* @param myTempPath �ꎞ�t�@�C���p�X�i�W���̃p�X�ȊO�ɂ������ꍇ�Ɏw��j
'* @return Object(Of Scripting.TextStream)
'******************************************************************************
Public Function GetCommandResultAsTextStream(commandString, Optional myTempPath) As Object

    ' �ꎞ�t�@�C���̎擾
    Dim tempPath As String
    If IsMissing(myTempPath) Then
        tempPath = FileUtils.GetTempFilePath
    Else
        tempPath = myTempPath
    End If
    
    ' ���s�R�}���h�\�z
    Dim execComandString As New StringEx
    Call execComandString.Append(mBaseCommand).PlaceHolder(commandString, tempPath)
    
    ' �R�}���h���s
    Call Core.Wsh.Run(execComandString.ToString, WshHide, True)
    Set GetCommandResultAsTextStream = IO.fso.OpenTextFile(tempPath, Base.ForReading)
End Function

'******************************************************************************
'* [�T  �v] GetCommandResult
'* [��  ��] �R�}���h�����s���A���s�������ʕ�������擾����B
'*
'* @param commandString �R�}���h������
'* @return String �R�}���h���s����
'******************************************************************************
Public Function GetCommandResult(commandString) As String
    Dim ret As String

    ' Scripting.TextStream
    Dim ts As Object

    Dim tempPath As String: tempPath = FileUtils.GetTempFilePath
    Set ts = GetCommandResultAsTextStream(commandString, tempPath)
    If ts.AtEndOfStream Then
        ret = ""
    Else
        ret = ts.ReadAll
    End If
    ts.Close
    Call IO.fso.DeleteFile(tempPath, True)
    GetCommandResult = ret
End Function

'******************************************************************************
'* [�T  �v] GetCommandResultAsArray
'* [��  ��] �R�}���h�����s���A���s�������ʂ��s���ɕ������������z��Ŏ擾����B
'*
'* @param commandString �R�}���h������
'* @return String() �R�}���h���s����
'******************************************************************************
Public Function GetCommandResultAsArray(commandString) As String()
    Dim ret() As String
    ret = Split(GetCommandResult(commandString), vbNewLine)
    GetCommandResultAsArray = ret
End Function

'******************************************************************************
'* [�T  �v] Exec
'* [��  ��] �R�}���h�����s���A���ʂ�CommandResult�I�u�W�F�N�g�Ɋi�[���ĕԋp����B
'*
'* @param commandString �R�}���h������
'* @return CommandResult���
'*
'******************************************************************************
Public Function Exec(commandString As String) As CommandResult
    ' �R�}���h���s
    Dim oExec: Set oExec = Core.Wsh.Exec(commandString)
    
    ' �R�}���h���s���ҋ@
    Do While (oExec.status = 0)
        Application.Wait [Now()] + 100 / 86400000
        DoEvents
    Loop
    
    ' ���s���ʐݒ�
    Dim res As CommandResult: Set res = New CommandResult
    res.ExitCd = oExec.ExitCode
    If oExec.ExitCode <> 0 Then
        ' �R�}���h���s������
        Dim errTxt As String: errTxt = oExec.StdErr.ReadAll
        res.StdErrTxt = errTxt
        Set Exec = res
        Exit Function
    End If

    ' ���펞����
    Dim varr As New ArrayEx
    While Not oExec.stdOut.AtEndOfStream
        varr.Add oExec.stdOut.ReadLine
    Wend
    res.StdOutList = varr.ToArray
    res.RowMax = varr.Length

    Set Exec = res

End Function


'******************************************************************************
'* [�T  �v] RunExplorer
'* [��  ��] �G�N�X�v���[�����N������B
'*
'******************************************************************************
Public Sub RunExplorer()
    Core.Wsh.Run "explorer.exe"
End Sub

'******************************************************************************
'* [�T  �v] RunCalc
'* [��  ��] �d����N������B
'*
'******************************************************************************
Public Sub RunCalc()
    Core.Wsh.Run "calc.exe"
    Core.Wsh.AppActivate "�d��"
End Sub

'******************************************************************************
'* [�T  �v] RunTaskManager
'* [��  ��] �^�X�N �}�l�[�W���[���N������B
'*
'******************************************************************************
Public Sub RunTaskManager()
    Core.Wsh.Run "taskmgr.exe /7"
    Core.Wsh.AppActivate "�^�X�N �}�l�[�W���["
End Sub

'******************************************************************************
'* [�T  �v] RunSystemProperties
'* [��  ��] �V�X�e���̃v���p�e�B���N������B
'*
'******************************************************************************
Public Sub RunSystemProperties()
    Core.Wsh.Run "sysdm.cpl"
    Core.Wsh.AppActivate "�V�X�e���̃v���p�e�B"
End Sub

'******************************************************************************
'* [�T  �v] RunEventViewer
'* [��  ��] �C�x���g �r���[�A�[���N������B
'*
'******************************************************************************
Public Sub RunEventViewer()
    Core.Wsh.Run "eventvwr.msc /s"
    Core.Wsh.AppActivate "�C�x���g �r���[�A�["
End Sub

'******************************************************************************
'* [�T  �v] RunComputerManagement
'* [��  ��] �R���s���[�^�[�̊Ǘ����N������B
'*
'******************************************************************************
Public Sub RunComputerManagement()
    Core.Wsh.Run "compmgmt.mSc"
    Core.Wsh.AppActivate "�R���s���[�^�[�̊Ǘ�"
End Sub

'******************************************************************************
'* [�T  �v] RunMsInfo
'* [��  ��] �V�X�e�������N������B
'*
'******************************************************************************
Public Sub RunMsInfo()
    Core.Wsh.Run "msinfo32.exe"
    Core.Wsh.AppActivate "�V�X�e�����"
End Sub

'******************************************************************************
'* [�T  �v] RunInternetOption
'* [��  ��] �C���^�[�l�b�g �I�v�V�������N������B
'*
'******************************************************************************
Public Sub RunInternetOption()
    Core.Wsh.Run "inetcpl.cpl"
    Core.Wsh.AppActivate "�C���^�[�l�b�g�̃v���p�e�B"
End Sub

'******************************************************************************
'* [�T  �v] RunPerformanceMonitor
'* [��  ��] �p�t�H�[�}���X ���j�^�[���N������B
'*
'******************************************************************************
Public Sub RunPerformanceMonitor()
    Core.Wsh.Run "perfmon.exe"
    Core.Wsh.AppActivate "�p�t�H�[�}���X ���j�^�["
End Sub

'******************************************************************************
'* [�T  �v] RunResourceMonitor
'* [��  ��] ���\�[�X ���j�^�[���N������B
'*
'******************************************************************************
Public Sub RunResourceMonitor()
    Core.Wsh.Run "resmon.exe"
    Core.Wsh.AppActivate "���\�[�X ���j�^�["
End Sub

'******************************************************************************
'* [�T  �v] RunRegistoryEditor
'* [��  ��] ���W�X�g�� �G�f�B�^�[���N������B
'*
'******************************************************************************
Public Sub RunRegistoryEditor()
    Core.Wsh.Run "regedt32.exe"
    Core.Wsh.AppActivate "���W�X�g�� �G�f�B�^�["
End Sub

'******************************************************************************
'* [�T  �v] RunTaskScheduler
'* [��  ��] �^�X�N �X�P�W���[�����N������B
'*
'******************************************************************************
Public Sub RunTaskScheduler()
    Core.Wsh.Run "taskschd.msc /s"
    Core.Wsh.AppActivate "�^�X�N �X�P�W���[��"
End Sub

'******************************************************************************
'* [�T  �v] RunServices
'* [��  ��] �T�[�r�X���N������B
'*
'******************************************************************************
Public Sub RunServices()
    Core.Wsh.Run "services.msc"
    Core.Wsh.AppActivate "�T�[�r�X"
End Sub

'******************************************************************************
'* [�T  �v] RunCharmap
'* [��  ��] �����R�[�h�\���N������B
'*
'******************************************************************************
Public Sub RunCharmap()
    Core.Wsh.Run "charmap.exe"
    Core.Wsh.AppActivate "�����R�[�h�\"
End Sub
