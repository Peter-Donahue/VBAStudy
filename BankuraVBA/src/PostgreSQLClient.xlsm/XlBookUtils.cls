VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "XlBookUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Excel Book���[�e�B���e�B�N���X
'* [��  ��] Excel Book�Ɋւ��郆�[�e�B���e�B��񋟂���B
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
'* [�T  �v] ChangeExcelFiles2007Format ���\�b�h
'* [��  ��] �w��t�H���_����A2003�`��Excel�t�@�C�����J���AOffice2007�`��
'*          �t�H�[�}�b�g�ixlsx�܂���xlsm�j�ŕۑ�����B
'*
'* @param srcPath Excel�t�@�C�����i�[����Ă���t�H���_
'* @param destPath �ۑ���t�H���_
'* @param format Excel�t�H�[�}�b�g�ixlOpenXMLWorkbook�j
'******************************************************************************
Public Sub ChangeExcelFiles2007Format(srcPath As String, destPath As String)
    Dim strXlsFileName As String
    strXlsFileName = Dir(FileUtils.AddPathSeparator(srcPath) & "*.xls*")

    Do Until strXlsFileName = ""
        If LCase(Right(strXlsFileName, 3)) = "xls" Then
            Workbooks.Open fileName:=FileUtils.AddPathSeparator(srcPath) & strXlsFileName
            Application.DisplayAlerts = False
            If ActiveWorkbook.HasVBProject = True Then
                ActiveWorkbook.SaveAs fileName:=FileUtils.AddPathSeparator(destPath) & strXlsFileName & "m", FileFormat:=xlOpenXMLWorkbookMacroEnabled
            Else
                ActiveWorkbook.SaveAs fileName:=FileUtils.AddPathSeparator(destPath) & strXlsFileName & "x", FileFormat:=xlOpenXMLWorkbook
            End If
            ActiveWorkbook.Close
            Application.DisplayAlerts = True
        End If
        strXlsFileName = Dir()
    Loop
End Sub

'******************************************************************************
'* [�T  �v] ChangeExcelFilesFormatXlsx ���\�b�h
'* [��  ��] �w��t�H���_����AExcel�t�@�C�����J���Axlsx�`����
'*          �ۑ�����B
'*
'* @param srcPath Excel�t�@�C�����i�[����Ă���t�H���_
'* @param destPath �ۑ���t�H���_
'******************************************************************************
Public Sub ChangeExcelFilesFormatXlsx(srcPath As String, destPath As String)
    Dim strXlsFileName As String
    strXlsFileName = Dir(FileUtils.AddPathSeparator(srcPath) & "*.xls*")

    Do Until strXlsFileName = ""
        Call ChangeExcelFileFormatXlsx(strXlsFileName, srcPath, destPath)
        strXlsFileName = Dir()
    Loop
End Sub

'******************************************************************************
'* [�T  �v] ChangeExcelFileFormatXlsx ���\�b�h
'* [��  ��] Excel�t�@�C�����J���Axlsx�`���ŕۑ�����B
'*
'* @param xlsFileName Excel�t�@�C����
'* @param srcPath Excel�t�@�C�����i�[����Ă���t�H���_
'* @param destPath �ۑ���t�H���_
'******************************************************************************
Public Sub ChangeExcelFileFormatXlsx(xlsFileName As String, srcPath As String, destPath As String)
    Workbooks.Open fileName:=FileUtils.AddPathSeparator(srcPath) & xlsFileName

    Dim displayAlertsState As Boolean: displayAlertsState = Application.DisplayAlerts
    If Application.DisplayAlerts Then Application.DisplayAlerts = False

    ActiveWorkbook.SaveAs fileName:=FileUtils.AddPathSeparator(destPath) & Split(xlsFileName, ".")(0) & ".xlsx", FileFormat:=xlOpenXMLWorkbook
    ActiveWorkbook.Close
    
    Application.DisplayAlerts = displayAlertsState
End Sub

'******************************************************************************
'* [�T  �v] ExtractKeyData
'* [��  ��] �w�肵���V�[�g�̃f�[�^(1��)�𒊏o���A�ʃV�[�gA��ɓ\�t����B
'*          �V�[�g���ƃf�[�^���L�ڂ���Ă����̐擪�Z���̍s��ԍ����w��
'*          ���邱�Ƃɂ��Ώۂ̐擪�Z������Ō�̃Z���܂ł̃f�[�^�𒊏o
'*          ����B��s�Əd������f�[�^�͏��O����B
'*
'* @param inputSheetName �Ǎ����V�[�g��
'* @param startRow �Ǎ���̐擪�Z���s�ԍ�
'* @param startCol �Ǎ���̐擪�Z����ԍ�
'* @param outputSheetName �o�͐�V�[�g��
'* @return Boolean �������ʁiTrue:���� False�F�ُ�j
'*
'******************************************************************************
Public Function ExtractKeyData(inputSheetName As String, StartRow As Integer, StartCol As Integer, _
                           outputSheetName As String) As Boolean
           
    Dim myDic As Object, myKey As Variant
    Dim c As Variant, varData As Variant
    Set myDic = CreateObject("Scripting.Dictionary")
    
    ' ���͏����擾
    With Worksheets(inputSheetName)
        varData = .Range(.Cells(StartRow, StartCol), .Cells(Rows.Count, StartCol).End(xlUp)).Value
    End With

    '��f�[�^�A�d���f�[�^�����O
    If IsArray(varData) Then
        For Each c In varData
            If Not c = Empty Then
                If Not myDic.Exists(c) Then
                    myDic.Add c, Null
                End If
            End If
        Next
    Else
        myDic.Add varData, Null
    End If
    myKey = myDic.keys
    
    With Worksheets(outputSheetName)
        '�Ǎ���̃V�[�g���N���A
        .Range("A:A").ClearContents

        '�Ǎ���V�[�g�Ƀf�[�^���o��
        .Range("A1").Resize(myDic.Count) = Application.WorksheetFunction.Transpose(myKey)
        
        '�\�[�g����
        .Range("A1").Resize(myDic.Count).Sort Key1:=.Range("A1")
    End With
    Set myDic = Nothing
    ExtractKeyData = True
    Exit Function
End Function

'******************************************************************************
'* [�T  �v] ExtractKeyData2
'* [��  ��] �w�肵���V�[�g�̃f�[�^(1��)�𒊏o���A�ʃV�[�gA��ɓ\�t����B
'*          �V�[�g���ƃf�[�^���L�ڂ���Ă����̐擪�Z���̍s��ԍ����w��
'*          ���邱�Ƃɂ��Ώۂ̐擪�Z������Ō�̃Z���܂ł̃f�[�^�𒊏o
'*          ����B��s�Əd������f�[�^�͏��O����B
'*
'* @param inputSheet �Ǎ����V�[�g
'* @param startRow �Ǎ���̐擪�Z���s�ԍ�
'* @param startCol �Ǎ���̐擪�Z����ԍ�
'* @return Variant �f�[�^�z��
'*
'******************************************************************************
Public Function ExtractKeyData2(inputSheet As Workbook, StartRow As Integer, StartCol As Integer) As Variant
    On Error GoTo ErrorHandler
           
    Dim myDic As Object, myKey As Variant
    Dim c As Variant, varData As Variant
    Set myDic = CreateObject("Scripting.Dictionary")
    
    ' ���͏����擾
    With inputSheet
        varData = .Range(.Cells(StartRow, StartCol), .Cells(Rows.Count, StartCol).End(xlUp)).Value
    End With

    '��f�[�^�A�d���f�[�^�����O
    If IsArray(varData) Then
        For Each c In varData
            If Not c = Empty Then
                If Not myDic.Exists(c) Then
                    myDic.Add c, Null
                End If
            End If
        Next
    Else
        myDic.Add varData, Null
    End If
    myKey = myDic.keys
    ExtractKeyData2 = Application.WorksheetFunction.Transpose(myKey)
    Set myDic = Nothing

    Exit Function
ErrorHandler:
    ExtractKeyData2 = False
End Function

'******************************************************************************
'* [�T  �v] IsBookOpened
'* [��  ��] �I�[�v���ς݃u�b�N�̑��݃`�F�b�N�B
'*
'* @param bookName �u�b�N
'* @return Boolean ���茋�ʁiTrue:���� False�F���݂��Ȃ��j
'*
'******************************************************************************
Public Function IsBookOpened(bookName As String) As Boolean
    Dim wb As Workbook

    ' Excel�N���`�F�b�N
    For Each wb In Application.Workbooks
        If wb.Name = Dir(bookName) Then
            IsBookOpened = False
            Exit Function
        End If
    Next
    IsBookOpened = True
End Function


Public Sub ClearBookAuthor(Optional ByRef wb As Workbook)
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    wb.BuiltinDocumentProperties("Author").Value = " "
    wb.BuiltinDocumentProperties("Last Author").Value = " "
End Sub

Public Sub RemoveBookInformationAndSave(Optional ByRef wb As Workbook)
    If wb Is Nothing Then
        Set wb = ThisWorkbook
    End If
    With wb
        .RemoveDocumentInformation xlRDIAll
        .RemoveDocumentInformation xlRDIComments
        .RemoveDocumentInformation xlRDIDocumentProperties
        .RemoveDocumentInformation xlRDIRemovePersonalInformation
        .RemoveDocumentInformation xlRDIPrinterPath
        .RemovePersonalInformation = False
        Dim dp As DocumentProperty
        Dim tmpUserName As String
        tmpUserName = Application.UserName
        Application.UserName = "unknown"
         For Each dp In .BuiltinDocumentProperties
            If dp.Type = msoPropertyTypeString Then
                dp.Value = ""
            End If
        Next
        .Save
        Application.UserName = tmpUserName
    End With
End Sub

