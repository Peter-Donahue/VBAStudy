VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "XlWorkSheetUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Excel WorkSheet Cell/Range���[�e�B���e�B�N���X
'* [��  ��] Excel WorkSheet Cell/Range�Ɋւ��郆�[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
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
'* [�T  �v] �V�[�g�\��t�������B
'* [��  ��] Variant�z��f�[�^���V�[�g�ɏo�͂���B
'*
'* @param dataSheet ���[�N�V�[�g
'* @param vArray Variant�z��f�[�^
'* @param lStartRow �f�[�^�J�n�s�ԍ�
'* @param lStartCol �f�[�^�J�n��ԍ�
'*
'******************************************************************************
Public Sub InjectVariantArrayToCells(ByVal dataSheet As Worksheet, vArray, lStartRow As Long, lStartCol As Long)
    If ArrayUtils.IsEmptyArray(vArray) Then Exit Sub
    dataSheet.Cells(lStartRow, lStartCol).Resize(UBound(vArray, 1) + 1, UBound(vArray, 2) + 1).Value = vArray
End Sub

'******************************************************************************
'* [�T  �v] ���Ԑݒ菈���B
'* [��  ��] ���ԂɘA�Ԃ��o�͂���B
'*
'* @param dataSheet ���[�N�V�[�g
'* @param lStartRow �f�[�^�J�n�s�ԍ�
'* @param lStartCol �f�[�^�J�n��ԍ�
'* @param rowNum �ԍ���
'*
'******************************************************************************
Public Sub InjectNumbersToIndexCells(ByVal dataSheet As Worksheet, lStartRow As Long, lStartCol As Long, rownum As Long)
    If rownum < 1 Then
        Exit Sub
    End If
    With dataSheet
        .Cells(lStartRow, lStartCol) = 1
        If rownum > 1 Then
            .Cells(lStartRow, lStartCol).AutoFill _
              Destination:=.Range(.Cells(lStartRow, lStartCol), .Cells(lStartRow + rownum - 1, lStartCol)), Type:=xlLinearTrend
        End If
    End With
End Sub

'******************************************************************************
'* [�T  �v] �V�[�g�ی���������B
'* [��  ��] �V�[�g�̕ی����������B
'*
'* @param sheetName �V�[�g��
'* @param sheetPassword �ی�p�X���[�h
'* @param wb ���[�N�u�b�N�I�u�W�F�N�g
'*
'******************************************************************************
Public Sub UnprotectSheet(sheetName As String, Optional sheetPassword As String, Optional wb As Workbook)
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    '�V�[�g�ی����
    If sheetPassword = "" Then
        wb.Sheets(sheetName).Unprotect
    Else
        wb.Sheets(sheetName).Unprotect Password:=sheetPassword
    End If
End Sub

'******************************************************************************
'* [�T  �v] �V�[�g�ی쏈���B
'* [��  ��] �V�[�g�̕ی������B
'*
'* @param sheetName �V�[�g��
'* @param sheetPassword �ی�p�X���[�h
'* @param wb ���[�N�u�b�N�I�u�W�F�N�g
'*
'******************************************************************************
Public Sub ProtectSheet(sheetName As String, Optional sheetPassword As String, Optional wb As Workbook)
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    With wb.Sheets(sheetName)
        .EnableOutlining = True  '�A�E�g���C���L��
        .EnableAutoFilter = True '�I�[�g�t�B���^�L��
        
        '�V�[�g�ی�
        If sheetPassword = "" Then
            .Protect Contents:=True, UserInterfaceOnly:=True
        Else
            .Protect Contents:=True, UserInterfaceOnly:=True, Password:=sheetPassword
        End If
    End With
End Sub

'******************************************************************************
'* [�T  �v] GotoSheet
'* [��  ��] �u�b�N�̎w�肵���V�[�g�E�A�h���X�ֈړ�����B
'*
'* @param sheetName �ړ���V�[�g��
'* @param strAddr �ړ���Z���̃A�h���X
'* @param wb ���[�N�u�b�N�I�u�W�F�N�g
'*
'******************************************************************************
Public Sub GotoSheet(sheetName As String, Optional strAddr As String = "A1", Optional wb As Workbook)
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    wb.Activate
    wb.Worksheets(sheetName).Select
    wb.Worksheets(sheetName).Range(strAddr).Activate
End Sub

'******************************************************************************
'* [�T  �v] InitializeWorkSheets
'* [��  ��] ���[�N�V�[�g������
'*
'* @param varMakeSheets �쐬����V�[�g���̔z��
'* @param varFormSheets �쐬����V�[�g�̃t�H�[�}�b�g�ƂȂ�V�[�g���̔z��
'* @param strAfShName     �쐬�ʒu�̊�ƂȂ�V�[�g�̖���
'*                        �i���̃V�[�g�̉E���ɍ쐬����j
'* @return Boolean �������ʁiTrue:���� False�F�ُ�j
'******************************************************************************
Public Function InitializeWorkSheets(varMakeSheets As Variant, _
                                     varFormSheets As Variant, _
                                     strAfShName As String) As Boolean
    On Error GoTo ErrorHandler
    If IsArray(varMakeSheets) <> IsArray(varFormSheets) Then GoTo ErrorHandler

    ' �z��ł͂Ȃ��ꍇ������ɏ���
    If Not IsArray(varMakeSheets) And Not IsArray(varFormSheets) Then
        If DeleteWorkSheet(varMakeSheets) = False Then GoTo ErrorHandler
        ThisWorkbook.Worksheets(varFormSheets).Copy After:=Worksheets(strAfShName)
        ActiveSheet.Name = varMakeSheets
        InitializeWorkSheets = True
        Exit Function
    End If
    
    If UBound(varMakeSheets) <> UBound(varFormSheets) Then GoTo ErrorHandler

    ' �쐬���郏�[�N�V�[�g�Ɠ����̃V�[�g������΍폜
    If DeleteWorkSheets(varMakeSheets) = False Then GoTo ErrorHandler
    
    ' ���[�N�V�[�g���쐬
    Dim i As Long
    For i = LBound(varMakeSheets) To UBound(varMakeSheets)
        ThisWorkbook.Worksheets(varFormSheets(i)).Copy After:=Worksheets(strAfShName)
        ActiveSheet.Name = varMakeSheets(i)
    Next i

    InitializeWorkSheets = True
    Exit Function
    
ErrorHandler:
    InitializeWorkSheets = False
End Function

'******************************************************************************
'* [�T  �v] DeleteWorkSheets
'* [��  ��] ���[�N�V�[�g�폜
'*
'* @param delSheetNames �폜����V�[�g���̔z��
'* @param wb �u�b�N�I�u�W�F�N�g
'* @return Boolean �������ʁiTrue:���� False�F�ُ�j
'*
'******************************************************************************
Public Function DeleteWorkSheets(delSheetNames As Variant, Optional ByRef wb As Workbook) As Boolean
    On Error GoTo ErrorHandler
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    
    If Not IsArray(delSheetNames) Then
        DeleteWorkSheets = Me.DeleteWorkSheet(delSheetNames, wb)
        Exit Function
    End If

    Dim ws As Worksheet
    Dim delSheetName As Variant
    For Each delSheetName In delSheetNames
        Call Me.DeleteWorkSheet(delSheetName, wb)
    Next

    DeleteWorkSheets = True
    Exit Function

ErrorHandler:
    DeleteWorkSheets = False
End Function

'******************************************************************************
'* [�T  �v] DeleteWorkSheet
'* [��  ��] ���[�N�V�[�g�폜
'*
'* @param sheetName �폜����V�[�g��
'* @param wb �u�b�N�I�u�W�F�N�g
'* @return Boolean �������ʁiTrue:���� False�F�ُ�j
'*
'******************************************************************************
Public Function DeleteWorkSheet(ByVal sheetName As String, Optional ByRef wb As Workbook) As Boolean
    On Error GoTo ErrorHandler
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    
    If Me.SheetExists(sheetName, wb) Then
        wb.Worksheets(sheetName).Delete
    End If
    DeleteWorkSheet = True
    Exit Function
ErrorHandler:
    DeleteWorkSheet = False
End Function

'******************************************************************************
'* [�T  �v] �V�[�g���݃`�F�b�N����
'* [��  ��] �V�[�g�����݂��邩���肷��B
'*
'* @param sheetName �V�[�g��
'* @param wb �u�b�N�I�u�W�F�N�g
'* @return Boolean �������ʁiTrue:���݂��� False�F���݂��Ȃ��j
'*
'******************************************************************************
Public Function SheetExists(ByVal sheetName As String, Optional ByRef wb As Workbook) As Boolean
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    
    '�V�[�g�̌���
    Dim ws As Worksheet
    For Each ws In wb.Worksheets
        If ws.Name = sheetName Then
            SheetExists = True
            Exit Function
        End If
    Next
    
    SheetExists = False
End Function

'******************************************************************************
'* [�T  �v] SheetExistsNoOpen
'* [��  ��] �V�[�g�����݂��邩���u�b�N���J�����ɔ��肷��
'*
'* @param bookFolderPath �u�b�N���z�u����Ă���t�H���_�p�X
'* @param bookName �u�b�N��
'* @param sheetName �V�[�g��
'* @return Boolean �������ʁiTrue:���݂��� False�F���݂��Ȃ��j
'*
'******************************************************************************
Public Function SheetExistsNoOpen(bookFolderPath As String, _
                                  bookName As String, _
                                  sheetName As String) As Boolean
    Dim v As Variant
    On Error Resume Next
    v = ExecuteExcel4Macro("'" & bookFolderPath & "[" & bookName & "]" & sheetName & "'!R1C1")
    If CStr(v) = "�G���[ 2023" Then
        SheetExistsNoOpen = False
    Else
        SheetExistsNoOpen = True
    End If
End Function


'******************************************************************************
'* [�T  �v] �ŏI�s�擾�����B
'* [��  ��] Worksheet��UsedRange�������瑖�����A�ŏI�s�ԍ����擾����
'*
'* @param dataSheet ���[�N�V�[�g
'* @param ignoreColnum �����ΏۊO�̗�ԍ�
'* @return �ŏI�s�ԍ�
'*
'******************************************************************************
Public Function GetFinalRow(ByVal dataSheet As Worksheet, Optional ignoreColnum As Long) As Long
    Dim ret As Long
    Dim i As Long, cnta As Long
    With dataSheet.UsedRange
        For i = .Rows.Count To 1 Step -1
            cnta = WorksheetFunction.CountA(.Rows(i))
            If cnta > 0 Then
                If cnta <> 1 Then
                    ret = i
                    Exit For
                Else
                    If ignoreColnum > 0 Then
                        If .Cells(i, ignoreColnum) = "" Then
                            ret = i
                            Exit For
                        End If
                    Else
                        ret = i
                        Exit For
                    End If
                End If
            End If
        Next
        If ret > 0 Then
            ret = ret + .row - 1
        End If
    End With
    GetFinalRow = ret
End Function

'******************************************************************************
'* [�T  �v] �ŏI��擾�����B
'* [��  ��] Worksheet��UsedRange���E���瑖�����A�ŏI��ԍ����擾����
'*
'* @param dataSheet ���[�N�V�[�g
'* @return �ŏI��ԍ�
'*
'******************************************************************************
Public Function GetFinalCol(ByVal dataSheet As Worksheet) As Long
    Dim ret As Long
    Dim i As Long
    With dataSheet.UsedRange
        For i = .Columns.Count To 1 Step -1
            If WorksheetFunction.CountA(.Columns(i)) > 0 Then
                ret = i
                Exit For
            End If
        Next
        If ret > 0 Then
            ret = ret + .Column - 1
        End If
    End With
    GetFinalCol = ret
End Function

'******************************************************************************
'* [�T  �v] �w���ŏI���͍s�擾�����B
'* [��  ��] �w���̍ŏI���͍s�ԍ����擾����
'*
'* @param dataSheet ���[�N�V�[�g
'* @param startRow �Ώۗ�̔ԍ�
'* @return �ŏI�s�ԍ�
'*
'******************************************************************************
Public Function GetFinalKeyRow(ByVal dataSheet As Worksheet, StartCol As Long) As Long
    GetFinalKeyRow = dataSheet.Cells(Rows.Count, StartCol).End(xlUp).row
End Function

'******************************************************************************
'* [�T  �v] �w��s�ŏI���͗�擾�����B
'* [��  ��] �w��s�̍ŏI���͗�ԍ����擾����
'*
'* @param dataSheet ���[�N�V�[�g
'* @param startRow �Ώۍs�̔ԍ�
'* @return �ŏI��ԍ�
'*
'******************************************************************************
Public Function GetFinalKeyCol(ByVal dataSheet As Worksheet, StartRow As Long) As Long
    GetFinalKeyCol = dataSheet.Cells(StartRow, Columns.Count).End(xlToLeft).Column
End Function

'******************************************************************************
'* [�T  �v] �\���擾�����B
'* [��  ��] worksheet�̕\��������擾���AVariant�z���ԋp���܂��
'*
'* @param dataSheet ���[�N�V�[�g
'* @param lStartRow �f�[�^�J�n�s�ԍ�
'* @param lStartCol �f�[�^�J�n��ԍ�
'* @param itemCount ���ڗ�
'*
'******************************************************************************
Public Function GetVariantDataFromSheet(dataSheet As Worksheet, lStartRow As Long, lStartCol As Long, Optional colCount As Long)
    Dim lMaxRow As Long: lMaxRow = GetFinalKeyRow(dataSheet, lStartCol)
    Dim lMaxCol As Long
    If colCount = 0 Then
        lMaxCol = GetFinalKeyCol(dataSheet, lStartRow)
    Else
        lMaxCol = lStartCol + colCount - 1
    End If
    
    '���R�[�h�����݂��Ȃ��ꍇ
    If lMaxRow < lStartRow Or lMaxCol < lStartCol Then
        GetVariantDataFromSheet = Empty
        Exit Function
    End If
    
    Dim vArr: vArr = dataSheet.Range(dataSheet.Cells(lStartRow, lStartCol), dataSheet.Cells(lMaxRow, lMaxCol))
    
    GetVariantDataFromSheet = vArr
End Function

'******************************************************************************
'* [�T  �v] �g�p�Z���͈̓N���A�����B
'* [��  ��] worksheet�̃f�[�^�\�̎g�p�Z���͈͂��N���A���܂��
'*
'* @param dataSheet data�\���[�N�V�[�g
'* @param lStartRow data�\�f�[�^�J�n�s�ԍ�
'* @param lStartCol data�\�f�[�^�J�n��ԍ�
'* @param itemCount ���ڗ�
'* @param ignoreColnum �����ΏۊO�̗�ԍ�
'*
'******************************************************************************
Public Sub ClearActualUsedRangeFromSheet(dataSheet As Worksheet, _
                                         lStartRow As Long, _
                                         lStartCol As Long, _
                                         Optional colCount As Long, _
                                         Optional ignoreColnum As Long)
    Dim rng As Range
    Set rng = GetActualUsedRangeFromSheet(dataSheet, lStartRow, lStartCol, colCount, ignoreColnum)
    If rng Is Nothing Then
        Exit Sub
    End If
    rng.ClearContents
End Sub

'******************************************************************************
'* [�T  �v] ���g�p�͈͍s�폜�����B
'* [��  ��] worksheet�̃f�[�^�\�̖��g�p�͈͍s���폜���܂��iUsedRange���k���j�
'*
'* @param dataSheet data�\���[�N�V�[�g
'* @param lStartRow data�\�f�[�^�J�n�s�ԍ�
'*
'******************************************************************************
Public Sub DeleteNoUsedRange(dataSheet As Worksheet, lStartRow As Long)
    Dim delStartRow As Long
    Dim delEndRow As Long
    
    Dim rng As Range
    Set rng = GetActualUsedRangeFromSheet(dataSheet, lStartRow, 1)
    If rng Is Nothing Then
        delStartRow = lStartRow
    Else
        delStartRow = rng.Item(rng.Count).row + 1
    End If
    delEndRow = dataSheet.UsedRange.Item(dataSheet.UsedRange.Count).row
    
    If delStartRow > delEndRow Then
        Exit Sub
    End If
    With dataSheet
        .Range(.Rows(delStartRow), .Rows(delEndRow)).Delete
    End With
End Sub

'******************************************************************************
'* [�T  �v] �g�p�Z���͈͎擾�����B
'* [��  ��] worksheet�̃f�[�^�\�̎g�p�Z���͈͂��擾����
'*
'* @param dataSheet data�\���[�N�V�[�g
'* @param lStartRow data�\�f�[�^�J�n�s�ԍ�
'* @param lStartCol data�\�f�[�^�J�n��ԍ�
'* @param itemCount ���ڗ�
'* @param ignoreColnum �����ΏۊO�̗�ԍ�
'* @return �g�p�Z���͈�
'*
'******************************************************************************
Public Function GetActualUsedRangeFromSheet(dataSheet As Worksheet, lStartRow As Long, lStartCol As Long, Optional colCount As Long, Optional ignoreColnum As Long) As Range
    Dim lMaxRow As Long: lMaxRow = GetFinalRow(dataSheet, ignoreColnum)
    Dim lMaxCol As Long
    If colCount = 0 Then
        lMaxCol = GetFinalCol(dataSheet)
    Else
        lMaxCol = lStartCol + colCount - 1
    End If

    '���R�[�h�����݂��Ȃ��ꍇ
    If lMaxRow < lStartRow Or lMaxCol < lStartCol Then
        Set GetActualUsedRangeFromSheet = Nothing
        Exit Function
    End If
    
    Set GetActualUsedRangeFromSheet = dataSheet.Range(dataSheet.Cells(lStartRow, lStartCol), dataSheet.Cells(lMaxRow, lMaxCol))
End Function

'******************************************************************************
'* [�T  �v] SetHyperLink
'* [��  ��] �n�C�p�[�����N��ǉ�����i�t�H���g�E�t�H���g�T�C�Y�̕ύX�����Ȃ��j
'*
'* @param sh �V�[�g�I�u�W�F�N�g
'* @param row �s�ԍ�
'* @param col ��ԍ�
'* @param strLinkAddress �����N�A�h���X
'*
'******************************************************************************
Public Sub SetHyperLink(sh As Worksheet, row As Long, col As Long, strLinkAddress As String)
    Dim strFontName As String
    Dim iFontSize As Integer
    With sh
        strFontName = .Range(.Cells(row, col), .Cells(row, col)).Font.Name
        iFontSize = sh.Range(.Cells(row, col), .Cells(row, col)).Font.size

        .Hyperlinks.Add Anchor:=.Range(.Cells(row, col), .Cells(row, col)), _
                          Address:=strLinkAddress
                        
        .Range(.Cells(row, col), .Cells(row, col)).Font.Name = strFontName
        .Range(.Cells(row, col), .Cells(row, col)).Font.size = iFontSize
    End With
End Sub

'******************************************************************************
'* [�T  �v] �V�[�g�R�s�[����
'* [��  ��] �t�H�[�}�b�g�ƂȂ�V�[�g���R�s�[���A�V�[�g��+ n�̖���
'*          �in�͏d�����Ȃ��ԍ��j�����āA�Ώۂ�Worksheet�I�u�W�F�N�g��ԋp�B
'*
'* @param formatSheetName �t�H�[�}�b�g�ƂȂ�R�s�[���V�[�g
'* @param destSheetName �쐬����V�[�g��
'* @param wb �Ώۂ̃��[�N�u�b�N
'* @param countAppend �ԍ���t�^���邩
'* @return �쐬�����V�[�g�I�u�W�F�N�g
'******************************************************************************
Public Function CopySheet(ByVal formatSheetName As String, ByVal destSheetName As String, _
                   Optional ByRef wb As Workbook, Optional ByVal countAppend As Boolean = False) As Worksheet
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    
    Dim cnt As Long: cnt = 0
    If countAppend Then
        cnt = 1
        Do While SheetExists(destSheetName & cnt, wb)
            cnt = cnt + 1
        Loop
    End If
    
    Dim tmpVisible As Excel.XlSheetVisibility
    tmpVisible = wb.Worksheets(formatSheetName).Visible
    wb.Worksheets(formatSheetName).Visible = xlSheetVisible
    
    wb.Worksheets(formatSheetName).Copy After:=wb.Worksheets(formatSheetName)
    wb.ActiveSheet.Name = destSheetName & IIf(cnt > 0, CStr(cnt), "")
    Set CopySheet = wb.ActiveSheet
    
    wb.Worksheets(formatSheetName).Visible = tmpVisible
End Function