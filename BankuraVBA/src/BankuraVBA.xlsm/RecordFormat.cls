VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "RecordFormat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ���R�[�h�t�H�[�}�b�g�N���X
'* [��  ��] ���ڂ̃t�H�[�}�b�g��`�������R�[�h�P�ʂő��˂��N���X�B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mCol As Collection
Private mRecordSetCol As Collection
Private mColumnCount As Long
Private mDataRowCount As Long

Private mErrMessage As String
Private mErrRowNo As Long
Private mErrColNo As Long

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get Item(Index) As Item
    Item = mCol.Item(Index)
End Property
Property Let Item(Index, arg As Item)
    mCol.Item(Index) = arg
End Property

'*-----------------------------------------------------------------------------
'* RecordSet �v���p�e�B�i�ǂݎ���p�j
'*-----------------------------------------------------------------------------
Property Get RecordSet() As Collection
    Set RecordSet = mRecordSetCol
End Property

'*-----------------------------------------------------------------------------
'* RecordDefinition �v���p�e�B�i�ǂݎ���p�j
'*-----------------------------------------------------------------------------
Property Get RecordDefinition() As Collection
    Set RecordDefinition = mCol
End Property

'*-----------------------------------------------------------------------------
'* ColumnCount �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get ColumnCount() As Long
    ColumnCount = mColumnCount
End Property
Property Let ColumnCount(arg As Long)
    mColumnCount = arg
End Property

'*-----------------------------------------------------------------------------
'* DataRowCount �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get DataRowCount() As Long
    DataRowCount = mDataRowCount
End Property
Property Let DataRowCount(arg As Long)
    mDataRowCount = arg
End Property

'*-----------------------------------------------------------------------------
'* ErrMessage �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get ErrMessage() As String
    ErrMessage = mErrMessage
End Property
Property Let ErrMessage(arg As String)
    mErrMessage = arg
End Property

'*-----------------------------------------------------------------------------
'* ErrRowNo �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get ErrRowNo() As Long
    ErrRowNo = mErrRowNo
End Property
Property Let ErrRowNo(arg As Long)
    mErrRowNo = arg
End Property

'*-----------------------------------------------------------------------------
'* mErrColNo �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get ErrColNo() As Long
    ErrColNo = mErrColNo
End Property
Property Let ErrColNo(arg As Long)
    mErrColNo = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mCol = New Collection
    Set mRecordSetCol = New Collection
End Sub
Private Sub Class_Terminate()
    Set mCol = Nothing
    Set mRecordSetCol = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] ���ڕ\���擾�E�ݒ菈���B
'* [��  ��] worksheet�̍��ڕ\��������擾���A�R���N�V�����ɍ��ڂ��ꊇ�ݒ肵�܂��
'*
'* @param dataSheet ���ڕ\���[�N�V�[�g
'* @param lStartRow ���ڕ\�f�[�^�J�n�s�ԍ�
'* @param lStartCol ���ڕ\�f�[�^�J�n��ԍ�
'* @param itemCount ���ڗ�
'*
'******************************************************************************
Public Function GetItemDataFromSheet(dataSheet As Worksheet, lStartRow As Long, lStartCol As Long, Optional colCount As Long) As Boolean
    mDataRowCount = 0
    Dim varr: varr = XlWorkSheetUtils.GetVariantDataFromSheet(dataSheet, lStartRow, lStartCol, colCount)
    If IsEmpty(varr) Then
        GetItemDataFromSheet = False
        Exit Function
    End If
    
    Call SetItems(varr)
    
    GetItemDataFromSheet = True
End Function


'******************************************************************************
'* [�T  �v] ���ڈꊇ�ݒ菈���B
'* [��  ��] ���ڈꊇ�ݒ肵�܂��
'*
'* @param vArr Variant�^2�����z��i���ڕ\�f�[�^�j
'*
'******************************************************************************
Private Sub SetItems(varr)
    Dim i As Long

    For i = LBound(varr, 1) To UBound(varr, 1)
        Call AddItem(varr, i)
    Next
    mColumnCount = UBound(varr, 1) - LBound(varr, 1) + 1
End Sub

'******************************************************************************
'* [�T  �v] ���ڐݒ菈���B
'* [��  ��] Item�ɒl��ݒ肵�R���N�V�����ɒǉ����܂��
'*
'* @param vArr Variant�^2�����z��i���ڕ\�f�[�^�j
'* @param rownum �z��s�i1�����Y�����j
'*
'******************************************************************************
Private Sub AddItem(varr, rownum As Long)
    Dim itm As Item
    Set itm = New Item
    itm.Name = varr(rownum, 1)
    If varr(rownum, 2) = "��" Then
        itm.required = True
    End If
    Select Case varr(rownum, 3)
        Case "���p"
            itm.Attr = AttributeEnum.attrHalf
        Case "���p�p��"
            itm.Attr = AttributeEnum.attrHalfAlphaNumeric
        Case "���p�p���L��"
            itm.Attr = AttributeEnum.attrHalfAlphaNumericSymbol
        Case "���l"
            itm.Attr = AttributeEnum.attrNumeric
        Case "�S�p�J�^�J�i"
            itm.Attr = AttributeEnum.attrZenKatakana
        Case "�S�p�Ђ炪��"
            itm.Attr = AttributeEnum.attrZenHiragana
        Case "���t"
            itm.Attr = AttributeEnum.attrDate
        Case "�X�֔ԍ�"
            itm.Attr = AttributeEnum.attrZipCode
        Case "�d�b�ԍ�"
            itm.Attr = AttributeEnum.attrTelNo
        Case "���[���A�h���X"
            itm.Attr = AttributeEnum.attrMailAddress
        Case Else
            itm.Attr = AttributeEnum.attrString
    End Select
    Select Case varr(rownum, 4)
        Case "�Œ�"
            itm.KindOfDigits = KindOfDigitsEnum.digitFixed
        Case "�ȓ�"
            itm.KindOfDigits = KindOfDigitsEnum.digitWithin
        Case "�͈�"
            itm.KindOfDigits = KindOfDigitsEnum.digitRange
        Case Else
            itm.KindOfDigits = KindOfDigitsEnum.digitNone
    End Select
    If varr(rownum, 5) <> "" And VBA.IsNumeric(varr(rownum, 5)) Then
        itm.MinNumOfDigits = CLng(varr(rownum, 5))
    End If
    If varr(rownum, 6) <> "" And VBA.IsNumeric(varr(rownum, 6)) Then
        itm.MaxNumOfDigits = CLng(varr(rownum, 6))
    End If
    itm.Pattern = varr(rownum, 7)
    If UBound(varr, 2) = 13 Then
        If varr(rownum, 8) <> "" And VBA.IsNumeric(varr(rownum, 8)) Then
            itm.InputCsvColNo = varr(rownum, 8)
        End If
        itm.InitValueKind = varr(rownum, 9)
        itm.InitValue = varr(rownum, 10)
        If varr(rownum, 11) = "��" Then
            itm.OutputTarget = True
        End If
        itm.OutputEditKind = varr(rownum, 12)
        itm.OutputEditValue = varr(rownum, 13)
    End If
    mCol.Add itm
End Sub

'******************************************************************************
'* [�T  �v] ���؏����B
'* [��  ��] ���R�[�h�f�[�^�����؂��܂��
'*
'* @param vArr Variant�^2�����z��i���R�[�h�f�[�^�j
'* @return ���،���
'*
'******************************************************************************
Public Function Validate(varr)
    If mColumnCount <> (UBound(varr, 2) - LBound(varr, 2) + 1) Then
        Validate = False
        Exit Function
    End If
    Dim statusBarTxt As String: statusBarTxt = "CSV�f�[�^���ؒ��F"
    Application.StatusBar = statusBarTxt
    
    Dim i As Long, j As Long, itm As Item, Index As Long
    Index = 1
    For i = LBound(varr, 1) To UBound(varr, 1)

        If i Mod 5000 = 0 Then
            statusBarTxt = statusBarTxt & "��"
            Application.StatusBar = statusBarTxt
            Call UXUtils.CheckEvents
        End If
            
        For j = LBound(varr, 2) To UBound(varr, 2)
            Set itm = mCol(Index)
            itm.value = varr(i, j)
            If Not itm.Validate Then
                Validate = False
                Call SetErrorMessage(itm, i, j)
                Exit Function
            End If
            Index = Index + 1
        Next
        Index = 1
    Next
    Validate = True
End Function

'******************************************************************************
'* [�T  �v] ���b�Z�[�W�ݒ菈���B
'* [��  ��] �G���[�������ڂ���G���[���b�Z�[�W���擾���Đݒ肵�܂��
'*
'* @param itm �G���[��������
'* @param rownum �G���[�����f�[�^�s�ԍ�
'* @param colnum �G���[�����f�[�^��ԍ�
'*
'******************************************************************************
Private Sub SetErrorMessage(ByVal itm As Item, ByVal rownum As Long, ByVal colnum As Long)
    mErrMessage = "[�s" + CStr(rownum) + " ��" + CStr(colnum) + "]  " + itm.Name + vbNewLine + vbNewLine + _
          itm.GetErrorMessage
    mErrRowNo = rownum
    mErrColNo = colnum
End Sub

'******************************************************************************
'* [�T  �v] ���R�[�h���擾�E�ݒ菈���B
'* [��  ��] worksheet�̃f�[�^�\��������擾���A�R���N�V�����ɍ��ڂ�
'*          �ꊇ�ݒ肵�܂��
'*
'* @param dataSheet data�\���[�N�V�[�g
'* @param lStartRow data�\�f�[�^�J�n�s�ԍ�
'* @param lStartCol data�\�f�[�^�J�n��ԍ�
'* @param itemCount ���ڗ�
'*
'******************************************************************************
Public Function GetRecordDataFromSheet(dataSheet As Worksheet, lStartRow As Long, lStartCol As Long, Optional colCount As Long, Optional ignoreColnum As Long) As Boolean
    mDataRowCount = 0
    Dim rng As Range: Set rng = XlWorkSheetUtils.GetActualUsedRangeFromSheet(dataSheet, lStartRow, lStartCol, colCount, ignoreColnum)
    If rng Is Nothing Then
        mErrMessage = "�f�[�^�����͂���Ă��܂���B"
        mErrRowNo = 1
        mErrColNo = 1
        GetRecordDataFromSheet = False
        Exit Function
    End If
    Dim varr: varr = rng
    mDataRowCount = UBound(varr, 1) - LBound(varr, 1) + 1
    
    GetRecordDataFromSheet = SetDataItems(varr)
End Function


'******************************************************************************
'* [�T  �v] ���R�[�h���ꊇ�ݒ菈���B
'* [��  ��] ���R�[�h�����ꊇ�ݒ肵�܂��
'*
'* @param vArr Variant�^2�����z��i���R�[�h���f�[�^�j
'*
'******************************************************************************
Public Function SetDataItems(varr) As Boolean
    Dim i As Long, j As Long, itm As Item, Index As Long
    Dim recordCol As Collection
    For i = LBound(varr, 1) To UBound(varr, 1)
        Set recordCol = New Collection

        Index = 1
        For j = LBound(varr, 2) To UBound(varr, 2)
            Set itm = CopyItem(mCol(Index))
            itm.ForOutput = True
            itm.value = varr(i, j)
            
            If Not itm.Validate Then
                SetDataItems = False
                Call SetErrorMessage(itm, i, j)
                Exit Function
            End If
            recordCol.Add itm
            Index = Index + 1
        Next
        mRecordSetCol.Add recordCol
    Next
    SetDataItems = True
End Function

'******************************************************************************
'* [�T  �v] Item�R�s�[�����B
'* [��  ��] Item�I�u�W�F�N�g�̃R�s�[��ԋp���܂��
'*
'* @param itm Item�I�u�W�F�N�g
'* @return �R�s�[����Item�I�u�W�F�N�g
'*
'******************************************************************************
Public Function CopyItem(itm As Item) As Item
    Dim newItem As Item: Set newItem = New Item
    newItem.Name = itm.Name
    newItem.value = itm.value
    newItem.required = itm.required
    newItem.Attr = itm.Attr
    newItem.KindOfDigits = itm.KindOfDigits
    newItem.MinNumOfDigits = itm.MinNumOfDigits
    newItem.MaxNumOfDigits = itm.MaxNumOfDigits
    newItem.Pattern = itm.Pattern
    newItem.InitValueKind = itm.InitValueKind
    newItem.InitValue = itm.InitValue
    newItem.InputCsvColNo = itm.InputCsvColNo
    newItem.OutputTarget = itm.OutputTarget
    newItem.OutputEditKind = itm.OutputEditKind
    newItem.OutputEditValue = itm.OutputEditValue
    Set CopyItem = newItem
End Function

'******************************************************************************
'* [�T  �v] �t�H�[���pVariant�z��擾�����B
'* [��  ��] �Ǎ����R�[�h�f�[�^���t�H�[����`���Ɋ�Â��A�t�H�[���p�f�[�^
'*          �ɕϊ����ԋp���܂��
'*
'* @param vArr Variant�^2�����z��i�Ǎ����R�[�h�f�[�^�j
'* @return Variant�^2�����z��i�t�H�[���p�f�[�^�j
'*
'******************************************************************************
Public Function GetFormVariantData(varr) As Variant
    Dim vFormArr()
    ReDim vFormArr(0 To UBound(varr, 1) - LBound(varr, 1), 0 To mColumnCount - 1)
    
    Dim sInfo As SettingInfo: Set sInfo = GetSettingInfo()
    Dim statusBarTxt As String: statusBarTxt = "�V�[�g�f�[�^�ϊ��������F"
    Application.StatusBar = statusBarTxt

    Dim i As Long, j As Long, itm As Item, Index As Long, val As String
    For i = LBound(vFormArr, 1) To UBound(vFormArr, 1)

        If i Mod 5000 = 0 Then
            statusBarTxt = statusBarTxt & "��"
            Application.StatusBar = statusBarTxt
            Call UXUtils.CheckEvents
        End If
        
        Index = 1
        For j = LBound(vFormArr, 2) To UBound(vFormArr, 2)
            Set itm = mCol(Index)
            
            '�l���擾
            If itm.InputCsvColNo = 0 Then
                val = ""
            Else
                val = varr(i, itm.InputCsvColNo - 1)
            End If
            
            If itm.InitValueKind <> "" Then
                If itm.InitValueKind = "�f�t�H���g" Then
                    val = itm.InitValue
                ElseIf itm.InitValueKind = "�}�X�^�ϊ��iCode��Value�j" Then
                    val = sInfo.GetMasterValueByCode(itm.InitValue, val)
                ElseIf itm.InitValueKind = "�}�X�^�ϊ��iValue��Code�j" Then
                    val = sInfo.GetMasterCodeByValue(itm.InitValue, val)
                End If
            End If
            vFormArr(i, j) = val
            Index = Index + 1
        Next
    Next
    GetFormVariantData = vFormArr
End Function