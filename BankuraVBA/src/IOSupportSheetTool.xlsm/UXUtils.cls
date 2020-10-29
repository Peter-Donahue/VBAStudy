VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "UXUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] UX/UI���[�e�B���e�B�N���X
'* [��  ��] �_�C�A���O���AUX/UI�Ɋւ��郆�[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* WindowsAPI��`
'******************************************************************************
Private Declare PtrSafe Function GetInputState Lib "user32" () As Long
Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare PtrSafe Function IsIconic Lib "user32" (ByVal hWnd As LongPtr) As Long
Private Declare PtrSafe Function ShowWindowAsync Lib "user32" (ByVal hWnd As LongPtr, ByVal nCmdShow As Long) As Long
Private Declare PtrSafe Function SetForegroundWindow Lib "user32" (ByVal hWnd As LongPtr) As Long
Private Declare PtrSafe Function PeekMessage Lib "user32" Alias "PeekMessageA" (lpMsg As msg, ByVal hWnd As LongPtr, ByVal wMsgFilterMin As Long, ByVal wMsgFilterMax As Long, ByVal wRemoveMsg As Long) As Long
Private Declare PtrSafe Function TranslateMessage Lib "user32" (lpMsg As msg) As Long
Private Declare PtrSafe Function DispatchMessage Lib "user32" Alias "DispatchMessageA" (lpMsg As msg) As LongPtr
Private Declare PtrSafe Function GetKeyboardState Lib "user32" (pbKeyState As Byte) As Long
Private Declare PtrSafe Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As LongPtr)
Private Declare PtrSafe Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal y As Long) As Long
Private Declare PtrSafe Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long

'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************

'******************************************************************************
'�\���̒�`
'******************************************************************************

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mTime As Variant

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] DoEvents���s����
'* [��  ��] DoEvents���œK�ȃ^�C�~���O�Ŏ��s����B
'*
'******************************************************************************
Public Sub CheckEvents()
    If GetInputState() Or (DateDiff("s", mTime, time) > 3) Then
        DoEvents
        mTime = time
    End If
End Sub

'******************************************************************************
'* [�T  �v] WaitFor
'* [��  ��] �w�肵���b������~����֐�
'*
'* @param second ��~����b��
'*
'******************************************************************************
Public Sub WaitFor(ByVal second As Integer)
    Dim futureTime As Date
    futureTime = DateAdd("s", second, Now)
    While Now < futureTime
        Sleep 100
        CheckEvents
    Wend
End Sub

'******************************************************************************
'* [�T  �v] ShowOpenFileDialog ���\�b�h
'* [��  ��] �t�@�C���_�C�A���O��\������B
'*          �V�[�g���w�肵�Ă���ꍇ�A�I�������t�@�C���p�X���w�肵��
'*          �V�[�g�̃Z���ɐݒ肷��B
'*
'* @param sheetName �V�[�g��
'* @param pos �Z���ʒu�iA1�`���j
'* @return String �I�������t�@�C���p�X
'*
'******************************************************************************
Public Function ShowOpenFileDialog(Optional sheetName As String, Optional pos As String = "A1") As String
    
    '�t�@�C���_�C�A���O�\��
    Dim fileName: fileName = Application.ShowOpenFileDialog
    If fileName <> False Then
        ShowOpenFileDialog = fileName
        If sheetName <> "" Then
            ThisWorkbook.Worksheets(sheetName).Range(pos).Value = fileName
        End If
    End If
End Function

'******************************************************************************
'* [�T  �v] ShowCsvFileDialog ���\�b�h
'* [��  ��] CSV�t�@�C����I������_�C�A���O��\�����܂��
'*
'* @param initialFile �����\���p�t�@�C���p�X�B�ȗ��\�B
'* @return �I�������t�@�C���̃p�X
'*
'******************************************************************************
Public Function ShowCsvFileDialog(Optional ByVal initialFile As String) As String
    ShowCsvFileDialog = ""
    With Application.FileDialog(msoFileDialogOpen)
        .Filters.Clear
        .Filters.Add "CSV�t�@�C��", "*.csv"
        .InitialFileName = initialFile
        .AllowMultiSelect = False
        If .Show = True Then
            ShowCsvFileDialog = .SelectedItems(1)
        End If
    End With
End Function

'******************************************************************************
'* [�T  �v] ShowCsvSaveFileDialog ���\�b�h
'* [��  ��] CSV�t�@�C����ۑ�����_�C�A���O��\������
'*
'* @param initialFile �����\���p�t�@�C���p�X�B�ȗ��\�B
'* @return �ۑ��t�@�C���̃p�X
'*
'******************************************************************************
Public Function ShowCsvSaveFileDialog(Optional ByVal initialFile As String) As String
    Dim fileName As Variant
    fileName = Application.GetSaveAsFilename(initialFile, "CSV�t�@�C��,*.csv")
    If fileName = False Then
        Exit Function
    End If
    ShowCsvSaveFileDialog = CStr(fileName)
End Function

'******************************************************************************
'* [�T  �v] ShowFolderDialog ���\�b�h
'* [��  ��] �t�H���_�_�C�A���O��\������
'*
'* @param sheetName �V�[�g��
'* @param pos �Z���ʒu�iA1�`���j
'* @return String �I�������t�@�C���p�X
'*
'******************************************************************************
Public Function ShowFolderDialog(Optional sheetName As String, Optional pos As String = "A1") As String
    On Error GoTo ErrorHandler
    
    '�t�H���_�_�C�A���O�\��
    Dim objPath As Object
    Set objPath = Base.GetShell().BrowseForFolder(0, "�t�H���_��I�����Ă�������", &H1)
    If Not objPath Is Nothing Then
        ShowFolderDialog = CStr(objPath.items.Item.Path)
        If sheetName <> "" Then
            ThisWorkbook.Worksheets(sheetName).Range(pos).Value = CStr(objPath.items.Item.Path)
        End If
    End If
    Exit Function
    
ErrorHandler:
    Call MsgBox("�w��ł��Ȃ��t�H���_�ł��B" & vbNewLine & "�ʂ̃t�H���_���w�肵�Ă��������B", vbOKOnly)
End Function

'******************************************************************************
'* [�T  �v] ShowForeground
'* [��  ��] �w�肳�ꂽ�E�B���h�E���őO�ʉ�����֐�
'*
'* @param  hwnd �ΏۃE�B���h�E�̃n���h���ԍ�
'*
'******************************************************************************
Public Sub ShowForeground(ByVal hWnd As LongPtr)
    If IsIconic(hWnd) Then
        Call ShowWindowAsync(hWnd, SW_RESTORE)
    End If
    Call SetForegroundWindow(hWnd)
End Sub

'******************************************************************************
'* [�T  �v] ShowForegroundMax
'* [��  ��] �w�肳�ꂽ�E�B���h�E���őO�ʉ��E�ő剻����֐�
'*
'* @param hwnd �ΏۃE�B���h�E�̃n���h���ԍ�
'*
'******************************************************************************
Public Sub ShowForegroundMax(ByVal hWnd As LongPtr)
    Call ShowWindowAsync(hWnd, SW_SHOWMAXIMIZED)
    Call SetForegroundWindow(hWnd)
End Sub

'******************************************************************************
'* [�T  �v] ShowMinimizedNoActive
'* [��  ��] �w�肳�ꂽ�E�B���h�E���ŏ����i�A�N�e�B�u�����Ȃ��j����֐�
'*
'* @param hwnd �ΏۃE�B���h�E�̃n���h���ԍ�
'*
'******************************************************************************
Public Sub ShowMinimizedNoActive(ByVal hWnd As LongPtr)
    If Not IsIconic(hWnd) Then
        Call ShowWindowAsync(hWnd, SW_SHOWMINNOACTIVE)
    End If
End Sub

'******************************************************************************
'* [�T  �v] DoEventsForPaint
'* [��  ��] DoEvents��֏����BWM_PAINT���b�Z�[�W�݂̂���������B
'*
'******************************************************************************
Public Sub DoEventsForPaint()
    Dim message  As msg
    If PeekMessage(message, 0, WM_PAINT, WM_PAINT, PM_REMOVE) Then
        Call TranslateMessage(message)
        Call DispatchMessage(message)
    End If
End Sub

'******************************************************************************
'* [�T  �v] ChangeNumLockOn
'* [��  ��] NumLock�L�[���I�t�̏ꍇ�̓I���ɂ���B
'*
'******************************************************************************
Public Sub ChangeNumLockOn()
    Dim bState  As Boolean
    Dim keys(0 To 255) As Byte
    
    Call GetKeyboardState(keys(0))
    bState = keys(VK_NUMLOCK)
    
    If Not bState Then
        Call keybd_event(VK_NUMLOCK, &H45, KEYEVENTF_EXTENDEDKEY Or 0, 0)
        Call keybd_event(VK_NUMLOCK, &H45, KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0)
    End If
End Sub

'******************************************************************************
'* [�T  �v] ChangeMousePoint
'* [��  ��] �}�E�X�J�[�\���̈ʒu��ύX����B
'*
'******************************************************************************
Public Sub ChangeMousePoint(x As Long, y As Long)
    Dim mousePoint As POINTAPI
    Dim mousePSet As Long
    
    ' �}�E�X�J�[�\���ʒu�w��
    mousePSet = SetCursorPos(x, y)
    
'    ' �}�E�X�J�[�\���ʒu�擾
'    Call GetCursorPos(mousePoint)
'    With mousePoint
'        x = .x
'        y = .y
'    End With
End Sub
