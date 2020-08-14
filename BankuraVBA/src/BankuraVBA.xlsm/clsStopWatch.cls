VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsStopWatch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'���@�\�X�g�b�v�E�H�b�`�N���X
'By���Ƃ肿���
'
'ver 1.0 : 2019/2/3 : ����            https://www.excel-chunchun.com/entry/2019/02/03/233535
'ver 2.0 : 2019/2/5 : �啝�Ȏd�l�ύX  https://www.excel-chunchun.com/entry/2019/02/05/014303
'ver 2.1 : 2019/2/7 : API��ύX

Private Const class_name = "clsTimer"

'���G���[�R�[�h�͓K��
Private Const NOSTART_ERROR_CODE = 8001
Private Const NORESET_ERROR_CODE = 8002
Private Const NOSTART_ERROR_MESSAGE = "�^�C�}�[���J�n����Ă��܂���B"
Private Const NORESET_ERROR_MESSAGE = "�^�C�}�[������������Ă��܂���B"

Private StartNum As Long
Private LapNum   As Long
Private PauseNum As Long  '��~���Ԃ̈ꎞ�L���ϐ�
Private LapTimes As Collection
Private DefaultFormat As String

#If VBA7 Then
    #If Win64 Then
        Private Declare PtrSafe Function GetTickCount64 Lib "kernel32" () As LongPtr
    #Else
        Private Declare PtrSafe Function GetTickCount Lib "kernel32" () As Long
    #End If
#Else
    Private Declare Function GetTickCount Lib "kernel32" () As Long
#End If

#If VBA7 Then
    Private Declare PtrSafe Function timeGetTime Lib "winmm.dll" () As Long
#Else
    Private Declare Function timeGetTime Lib "winmm.dll" () As Long
#End If

'�ʓ|�Ȃ̂�32bit��64bit�̌^�𑵂���
Public Function GetTime() As Long

'#If Win64 Then
'    GetTime = CLng(GetTickCount64)
'#Else
'    GetTime = GetTickCount
'#End If
    GetTime = timeGetTime()

End Function

'������
Private Sub Class_Initialize()

    Call Reset
    
End Sub

'�X�^�[�g�F�v�����J�n�^�ĊJ
Public Sub Start(Optional defFormat As String = "")
    If defFormat <> "" Then DefaultFormat = defFormat

    '��~���Ă������ԕ����J�n���Ԃɑ������ƂŒ�������킹��
    StartNum = StartNum + (GetTime - PauseNum)
    LapNum = LapNum + (GetTime - PauseNum)
    PauseNum = 0
    
End Sub

'���Z�b�g�F�S�Ă̎��Ԃ�������
Public Sub Reset()

    StartNum = 0
    LapNum = 0
    PauseNum = 0
    Set LapTimes = New Collection
    
End Sub

'�|�[�Y�F�ꎞ��~����~���Ԃ��L��
Public Sub Pause()
    If StartNum = 0 Then err.Raise NOSTART_ERROR_CODE, class_name, NOSTART_ERROR_MESSAGE
    
    PauseNum = GetTime

End Sub

'�X�v���b�g�F�J�n����̌o�ߎ���
Public Function SplitTime(Optional ByVal timeFormat As String = "") As Variant
    If StartNum = 0 Then err.Raise NOSTART_ERROR_CODE, class_name, NOSTART_ERROR_MESSAGE
    Dim tm As Long
    
    tm = (GetTime - StartNum)

    If timeFormat = "" Then timeFormat = DefaultFormat
    If timeFormat = "" Then
        SplitTime = tm
    Else
        SplitTime = GetTimeFormat(tm, timeFormat)
    End If
    
End Function

'���b�v�F���O�̌v������̌o�ߎ���
Public Function LapTime(Optional ByVal timeFormat As String = "") As Variant
    If StartNum = 0 Then err.Raise NOSTART_ERROR_CODE, class_name, NOSTART_ERROR_MESSAGE
    Dim tm As Long
    
    tm = (GetTime - LapNum)
    LapNum = GetTime

    If timeFormat = "" Then timeFormat = DefaultFormat
    If timeFormat = "" Then
        LapTime = tm
    Else
        LapTime = GetTimeFormat(tm, timeFormat)
    End If
    LapTimes.Add LapTime
    
End Function

'���b�v�^�C���̃R���N�V������Ԃ�
Public Property Get Laps() As Variant
    If StartNum = 0 Then err.Raise NOSTART_ERROR_CODE, class_name, NOSTART_ERROR_MESSAGE
    
    If LapTimes.count = 0 Then
        Laps = Split(vbNullString)
    Else
        Dim arr() As Variant
        ReDim arr(1 To LapTimes.count)
        Dim i As Long
        For i = 1 To LapTimes.count
            arr(i) = LapTimes(i)
        Next
        Laps = arr
    End If
    
End Property

'�~���Z�R���h����C�ӂ̏����ɕϊ�
Private Function GetTimeFormat(tm As Long, timeFormat As String) As Variant

    Select Case True
        Case timeFormat = "s"
            GetTimeFormat = CDbl(tm) / 1000
            
        Case timeFormat = "ms"
            GetTimeFormat = tm
            
        Case timeFormat Like "*ms"
            GetTimeFormat = Right(String(10, " ") & Format(tm, timeFormat), 10)
        
        Case timeFormat Like "*s"
            GetTimeFormat = Right(String(10, " ") & Format(CDbl(tm) / 1000, timeFormat), 10)
        
        Case Else
            GetTimeFormat = Format(tm, timeFormat)
    End Select
            
End Function