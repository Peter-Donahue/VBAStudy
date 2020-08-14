VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WorkSheetEx"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Worksheet�g���N���X
'* [��  ��] Worksheet�N���X��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* Enum��`
'******************************************************************************


'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As Worksheet


'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* �I���W�i��Object �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get Origin() As Worksheet
Attribute Origin.VB_UserMemId = 0
    Set Origin = mOrigin
End Property
Property Set Origin(arg As Worksheet)
    Set mOrigin = arg
End Property


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
'    Set mFso = CreateObject("Scripting.FileSystemObject")
'    Set mAdoStream = CreateObject("ADODB.Stream")
'    mCharSet = "UTF-8"
'    mLineSeparator = adLF
'    mHeaderExists = False
'    mValidFormat = True
End Sub
Private Sub Class_Terminate()
'    If Not mAdoStream Is Nothing Then
'        If mAdoStream.State <> adStateClosed Then
'            Call mAdoStream.Close
'        End If
'    End If
'    Set mAdoStream = Nothing
'    Set mFso = Nothing
'    Set mFile = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************
'******************************************************************************
'* [�T  �v] Init ���\�b�h
'* [��  ��] �������p���\�b�h�
'*
'* @param wb ���[�N�u�b�N
'* @param sheetName �V�[�g��
'* @return WorkSheetEx�I�u�W�F�N�g
'*
'******************************************************************************
Public Function Init(wb As Workbook, sheetName As String) As WorkSheetEx
    Set mOrigin = wb.Worksheets(sheetName)
    Set Init = Me
End Function

''******************************************************************************
''* [�T  �v] FileExists ���\�b�h
''* [��  ��] �t�@�C�������݂��邩�ǂ������肵�܂��
''*
''* @param targetFilePath �t�@�C���p�X�B�ȗ��\�B
''* @return ���茋��
''*
''******************************************************************************
'Public Function FileExists(Optional ByVal targetFilePath As String) As Boolean
'    Dim tempPath As String: tempPath = mFilePath
'    If targetFilePath <> "" Then
'        tempPath = targetFilePath
'    End If
'    FileExists = mFso.FileExists(tempPath)
'End Function
'
''******************************************************************************
''* [�T  �v] IsEmpty ���\�b�h
''* [��  ��] �t�@�C������t�@�C�����ǂ������肵�܂��
''*
''* @return ���茋��
''*
''******************************************************************************
'Public Function IsEmpty() As Boolean
'    IsEmpty = (mSize = 0)
'End Function
'
''******************************************************************************
''* [�T  �v] ShowCsvFileDialog ���\�b�h
''* [��  ��] CSV�t�@�C����I������_�C�A���O��\�����܂��
''*
''* @param initialFile �����\���p�t�@�C���p�X�B�ȗ��\�B
''* @return �I�������t�@�C���̃p�X
''*
''******************************************************************************
'Public Function ShowCsvFileDialog(Optional ByVal initialFile As String) As String
'    ShowCsvFileDialog = ""
'    With Application.FileDialog(msoFileDialogOpen)
'        .Filters.Clear
'        .Filters.Add "CSV�t�@�C��", "*.csv"
'        .InitialFileName = initialFile
'        .AllowMultiSelect = False
'        If .Show = True Then
'            mFilePath = .SelectedItems(1)
'            Set mFile = mFso.GetFile(mFilePath)
'            mSize = mFile.Size
'            ShowCsvFileDialog = mFilePath
'        End If
'    End With
'End Function
'
'
''******************************************************************************
''* [�T  �v] �e�L�X�g�t�@�C���Ǎ������B
''* [��  ��] �e�L�X�g�t�@�C�����s�P�ʂœǍ��݁AVariant�z��ɐݒ肵�ĕԋp����B
''*
''* @return �Ǎ��e�L�X�g�f�[�^�iVariant�z��j
''******************************************************************************
'Public Function ReadTextFileToVArray() As Variant
'
'    Dim lSize As Long, lCount As Long, i As Long, vRow, vArr()
'    With mAdoStream
'        .Mode = adModeReadWrite
'        .Type = adTypeText
'        .CharSet = mCharSet
'        .LineSeparator = mLineSeparator
'        .Open
'        .LoadFromFile mFilePath
'        lSize = Me.CountLine
'
'        '��t�@�C���͋�Variant�z��ŕԋp
'        If (mHeaderExists And lSize <= 1) Or (Not mHeaderExists And lSize = 0) Then
'            .Close
'            Exit Function
'        End If
'        '1�s�ڏ���
'        .Position = 0
'        vRow = SplitCsvRow(.ReadText(adReadLine), True)
'         If Not mHeaderExists Then
'            ReDim vArr(0 To lSize - 1, 0 To UBound(vRow))
'            For i = LBound(vRow) To UBound(vRow)
'                vArr(lCount, i) = vRow(i)
'            Next
'            lCount = lCount + 1
'        Else
'            ReDim vArr(0 To lSize - 2, 0 To UBound(vRow))
'        End If
'        Dim ColumnCount As Long: ColumnCount = UBound(vRow)
'
'        Dim statusBarTxt As String: statusBarTxt = "CSV�Ǎ��������F"
'        Application.StatusBar = statusBarTxt
'
'        '2�s�ڈȍ~����
'        Do While Not .EOS
'            vRow = SplitCsvRow(.ReadText(adReadLine), True)
'            If UBound(vRow) <> ColumnCount Then
'                .Close
'                ReadTextFileToVArray = Empty
'                mValidFormat = False
'                Exit Function
'            End If
'
'            If lCount Mod 5000 = 0 Then
'                statusBarTxt = statusBarTxt & "��"
'                Application.StatusBar = statusBarTxt
'                Call CheckEvents
'            End If
'
'            For i = LBound(vRow) To UBound(vRow)
'                vArr(lCount, i) = vRow(i)
'            Next
'            lCount = lCount + 1
'        Loop
'        .Close
'    End With
'
'    ReadTextFileToVArray = vArr
'End Function
'
''******************************************************************************
''* [�T  �v] CSV�s���������B
''* [��  ��] CSV��������J���}���Ƃɕ�������Variant�z��Ɋi�[���A�ԋp����B
''*          ���ڗ��[�́u"�v���폜����B
''*
''* @param line CSV�s
''* @param quotExist �_�u���N�H�[�g���ݗL���iTrue�F����j�B�ȗ��\�B
''* @param delimiter �f���~�^�B�ȗ��\�B
''* @return ������Variant�z��
''******************************************************************************
'Public Function SplitCsvRow(line As String, Optional ByVal quotExist As Boolean = False, Optional delimiter As String = ",") As Variant
'    If quotExist Then
'        Dim lQuoteCount As Long, lItemCount As Long, i As Long, tmpTxt As String, v()
'        For i = 1 To Len(line)
'            Select Case Mid(line, i, 1)
'                Case delimiter
'                    If lQuoteCount Mod 2 = 0 Then
'                        lItemCount = lItemCount + 1
'                    End If
'                Case """"
'                    lQuoteCount = lQuoteCount + 1
'            End Select
'        Next
'        ReDim v(lItemCount) As Variant
'        lQuoteCount = 0: lItemCount = 0
'        For i = 1 To Len(line)
'            Select Case Mid(line, i, 1)
'                Case delimiter
'                    If lQuoteCount Mod 2 = 0 Then
'                        v(lItemCount) = EditIncludeQuotItem(tmpTxt)
'                        tmpTxt = ""
'                        lItemCount = lItemCount + 1
'                    Else
'                        tmpTxt = tmpTxt & Mid(line, i, 1)
'                    End If
'                Case """"
'                    lQuoteCount = lQuoteCount + 1
'                    tmpTxt = tmpTxt & Mid(line, i, 1)
'                Case Else
'                    tmpTxt = tmpTxt & Mid(line, i, 1)
'            End Select
'        Next
'        If tmpTxt <> "" Then
'            v(lItemCount) = EditIncludeQuotItem(tmpTxt)
'        End If
'        SplitCsvRow = v
'    Else
'        SplitCsvRow = Split(line, delimiter)
'    End If
'End Function
'
''******************************************************************************
''* [�T  �v] �_�u���N�H�[�g���荀�ڕҏW�����B
''* [��  ��] �G�X�P�[�v����Ă���_�u���N�H�[�g�u""�v���u"�v�ɕϊ����A
''*          ���ڗ��[�́u"�v���폜����B
''*
''* @param text �_�u���N�H�[�g���荀��
''* @return �ҏW�㍀��
''******************************************************************************
'Private Function EditIncludeQuotItem(ByVal text As String) As String
'    text = Replace(text, """""", """")
'    If Left(text, 1) = """" And Right(text, 1) = """" Then
'        If Len(text) <= 2 Then
'            EditIncludeQuotItem = ""
'        Else
'            EditIncludeQuotItem = Mid(text, 2, Len(text) - 2)
'
'        End If
'    End If
'End Function
'
''******************************************************************************
''* [�T  �v] �e�L�X�g�̍s���擾�����B
''* [��  ��] �e�L�X�g�̍s�����擾����B
''* [���@�l] �Ăяo���O��Stream��Open����Ă��邱�ƁB
''*
''* @return �s��
''******************************************************************************
'Public Function CountLine() As Long
'    Dim lineCount As Long
'    With mAdoStream
'        .Position = 0
'        Do While Not .EOS
'            .SkipLine
'            lineCount = lineCount + 1
'        Loop
'    End With
'
'    CountLine = lineCount
'End Function
'
'