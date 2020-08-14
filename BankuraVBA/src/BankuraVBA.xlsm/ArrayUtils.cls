VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ArrayUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] �z�񑀍샆�[�e�B���e�B�N���X
'* [��  ��] �z�񑀍���s�����[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'*
'* [�ˁ@��] <�����ˑ�>
'*           Base, ValidateUtils
'*          <�O���ˑ�>
'*           Ariawase Core, Ext, ArrayEx
'* [�Q  �l] https://qiita.com/nukie_53/items/9a7a1eb07eff50ae1e8b
'*          https://blog.sgnet.co.jp/2017/01/vba.html
'*
'* @author Bankura
'* Copyright (c) 2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************

'******************************************************************************
'* �ϐ���`
'******************************************************************************
Private mWinApi As WinAPI

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
Public Property Get EmptyLongArray() As Long()

    Dim apiResult As Long
    apiResult = mWinApi.SafeArrayAllocDescriptor(1, EmptyLongArray)
    If apiResult <> 0 Then err.Raise 5
End Property

Public Property Get EmptyVariantArray() As Variant()
    Let EmptyVariantArray = VBA.Array()
End Property

Public Property Get EmptyStringArray() As String()
    Let EmptyStringArray = VBA.Split(VBA.vbNullString)
End Property

Public Property Get EmptyByteArray() As Byte()
    Let EmptyByteArray = VBA.vbNullString
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mWinApi = Base.GetWinAPI()
End Sub
Private Sub Class_Terminate()
    Set mWinApi = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************
'******************************************************************************
'* [�T  �v] ToVArrayFlattened
'* [��  ��] Variant�^�z�����Variant�z��ƒl�����݂���ꍇ�ɁA
'*          Variant�z��̒l��W�J���l������Variant�^�z��ɕϊ�����
'*
'* @param vArray Variant�^�z��
'* @return Variant �ϊ���Variant�^�z��
'*
'******************************************************************************
Public Function ToVArrayFlattened(ByRef vArray As Variant) As Variant
    Dim arr As ArrayEx: Set arr = New ArrayEx
    
    Call AddAllFromHierarchicalArray(arr, vArray)
    ToVArrayFlattened = arr.ToArray
End Function

'******************************************************************************
'* [�T  �v] AddAllFromHierarchicalArray
'* [��  ��] Variant�^�z�����Variant�z��ƒl�����݂���ꍇ�A
'*          �܂��z����̔z��ɂ���ɔz�񂪊i�[�����K�w�\���ɂȂ��Ă���ꍇ�A
'*          ArrayEx�I�u�W�F�N�g�ɑS�Ă̗v�f���i�[����i�t���b�g���j�
'*
'* @param arr ArrayEx
'* @param vArray Variant�^�z��
'*
'******************************************************************************
Public Sub AddAllFromHierarchicalArray(ByVal arr As ArrayEx, ByRef vArray As Variant)
    If ValidateUtils.IsPrimitive(vArray) Then
        arr.AddVal vArray
    ElseIf IsObject(vArray) Then
        arr.AddObj vArray
    ElseIf VBA.IsArray(vArray) Then
        Dim v
        For Each v In vArray
            Call AddAllFromHierarchicalArray(arr, v)
        Next
    End If
End Sub

'******************************************************************************
'* [�T  �v] GetDimension
'* [��  ��] �w�肳�ꂽVariant�z��̎�������ԋp����
'*
'* @param vArray ��������z��
'* @return Integer ������(�z��ł͂Ȃ��ꍇ-1)
'*
'******************************************************************************
Public Function GetDimension(ByRef vArray As Variant) As Integer
    On Error GoTo ErrorHandler
    GetDimension = Core.ArrRank(vArray)
    Exit Function
ErrorHandler:
    GetDimension = -1
End Function

'******************************************************************************
'* [�T  �v] GetLength
'* [��  ��] �w�肳�ꂽVariant�z��̗v�f����ԋp����
'*
'*
'* @param vArray ��������z��
'* @param dimmention ����
'* @return Long �v�f��(�z��ł͂Ȃ��ꍇ-1)
'*
'******************************************************************************
Public Function GetLength(ByRef vArray As Variant, Optional dimmention As Integer = 1) As Long
    On Error GoTo ErrorHandler
    GetLength = Core.ArrLen(vArray, dimmention)
    Exit Function
ErrorHandler:
    GetLength = -1
End Function

'******************************************************************************
'* [�T  �v] IsRedim
'* [��  ��] �w�肳�ꂽ�z�񂪏������ς݂����肷��
'*
'* @param vArray ��������z��
'* @return Boolean ���茋��(True:�������ς�)
'*
'******************************************************************************
Public Function IsRedim(ByRef vArray As Variant) As Boolean
    On Error Resume Next
    err.Clear
    IsRedim = CBool(UBound(vArray))
    IsRedim = (err.Number = 0)
End Function

'******************************************************************************
'* [�T  �v] IsEmptyArray
'* [��  ��] �w�肳�ꂽ�z�񂪖��������E��z�񂩔��肷��
'*
'* @param vArray ��������z��
'* @return Boolean ���茋��(True:���������E��)
'*
'******************************************************************************
Public Function IsEmptyArray(ByRef vArray As Variant) As Boolean
    IsEmptyArray = False
    If IsRedim(vArray) Then
        If UBound(vArray) = -1 Then
            IsEmptyArray = True
        End If
    Else
        IsEmptyArray = True
    End If
End Function

'******************************************************************************
'* [�T  �v] Is2DArray
'* [��  ��] �w�肳�ꂽ�z��2�����z�񂩔��肷��
'*
'* @param vArray ��������z��
'* @return Boolean ���茋��(True:2�����z��)
'*
'******************************************************************************
Public Function Is2DArray(ByRef vArray As Variant) As Boolean
    If GetDimension(vArray) = 2 Then
        Is2DArray = True
        Exit Function
    End If
    Is2DArray = False
End Function

'******************************************************************************
'* [�T  �v] ArrayRank
'* [��  ��] �z��̎�����ԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @return As Integer
'******************************************************************************
Public Function ArrayRank(ByVal arr As Variant) As Integer
    ArrayRank = Core.ArrRank(arr)
End Function

'******************************************************************************
'* [�T  �v] ArrayLen
'* [��  ��] �z��̒����i�v�f���j��ԋp����B�������w��\�B�f�t�H���g�͂P�����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @param dimen As Integer
'* @return As Long
'******************************************************************************
Public Function ArrayLen(ByVal arr As Variant, Optional ByVal dimen As Integer = 1) As Long
    ArrayLen = Core.ArrLen(arr, dimen)
End Function

'******************************************************************************
'* [�T  �v] ArrayEquals
'* [��  ��] �Q�̈ꎟ���z����r���A�C�R�[���ł����True��ԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr1 As Variant(Of Array(Of T))
'* @param arr2 As Variant(Of Array(Of T))
'* @param swAllowNull As Boolean
'* @return As Variant(Of Boolean Or Null Or Empty)
'******************************************************************************
Public Function ArrayEquals( _
    ByVal arr1 As Variant, ByVal arr2 As Variant, _
    Optional ByVal swAllowNull As Boolean = False _
    ) As Variant
    ArrayEquals = Core.ArrEquals(arr1, arr2, swAllowNull)
End Function

'******************************************************************************
'* [�T  �v] ArrayCompare
'* [��  ��] �Q�̈ꎟ���z��ix,y�j���r���Ax=y�ł����0�Ax<y�ł����-1�Ax>y
'*          �ł����1��ԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr1 As Variant(Of Array(Of T))
'* @param arr2 As Variant(Of Array(Of T))
'* @return As Variant(Of Integer Or Null)
'******************************************************************************
Public Function ArrayCompare( _
    ByVal arr1 As Variant, ByVal arr2 As Variant, _
    Optional ByVal swAllowNull As Boolean = False _
    ) As Variant
    ArrayCompare = Core.ArrCompare(arr1, arr2, swAllowNull)
End Function

'******************************************************************************
'* [�T  �v] ArrayIndexOf
'* [��  ��] �ꎟ���z�񂩂�w�肵���l�ƈ�v����v�f�̃C���f�b�N�X��ԋp����B
'*          �l�̑{���J�n�ʒu�Ɨv�f����C�ӎw��\�B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @param val As Variant(Of T)
'* @param ixStart As Variant(Of Long)
'* @param cnt As Variant(Of Long)
'* @return As Long
'******************************************************************************
Public Function ArrayIndexOf( _
    ByVal arr As Variant, ByVal val As Variant, _
    Optional ByVal ixStart As Variant, Optional ByVal cnt As Variant _
    ) As Long
    ArrayIndexOf = Core.ArrIndexOf(arr, val, ixStart, cnt)
End Function

'******************************************************************************
'* [�T  �v] ArrayReverse
'* [��  ��] �ꎟ���z��̗v�f�̕��я��𔽓]������B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'******************************************************************************
Public Sub ArrayReverse(ByRef arr As Variant)
    Call Core.ArrRev(arr)
End Sub

'******************************************************************************
'* [�T  �v] ArraySort
'* [��  ��] �ꎟ���z��̃\�[�g���s���B�f�t�H���g�͏����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @param orderAsc As Boolean
'******************************************************************************
Public Sub ArraySort(ByRef arr As Variant, Optional ByVal orderAsc As Boolean = True)
    Call Core.ArrSort(arr, orderAsc)
End Sub

'******************************************************************************
'* [�T  �v] ArrayUniq
'* [��  ��] �ꎟ���z��̏d���v�f��r������B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function ArrayUniq(ByVal arr As Variant) As Variant
    ArrayUniq = Core.ArrUniq(arr)
End Function

'******************************************************************************
'* [�T  �v] ArrayConcat
'* [��  ��] �ꎟ���z��ƈꎟ���z������́i�}�[�W�j���ĕԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr1 As Variant(Of Array(Of T))
'* @param arr2 As Variant(Of Array(Of T))
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function ArrayConcat(ByVal arr1 As Variant, ByVal arr2 As Variant) As Variant
    ArrayConcat = Core.ArrConcat(arr1, arr2)
End Function

'******************************************************************************
'* [�T  �v] ArraySlice
'* [��  ��] �ꎟ���z����X���C�X�i�ꕔ��z��Ƃ��Đ؂�o�j���ĕԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @param ixStart As Variant(Of Long)
'* @param ixEnd As Variant(Of Long)
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function ArraySlice( _
    ByVal arr As Variant, _
    Optional ByVal ixStart As Variant, Optional ByVal ixEnd As Variant _
    ) As Variant
    ArraySlice = Core.ArrSlice(arr, ixStart, ixEnd)
End Function

'******************************************************************************
'* [�T  �v] ArrayFlatten
'* [��  ��] �W���O�z��̃t���b�g���B�W���O�z����ꎟ���z��ɕϊ����ĕԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param jagArray As Variant(Of Array(Of Array(Of T)))
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function ArrayFlatten(ByVal jagArr As Variant) As Variant
    ArrayFlatten = Core.ArrFlatten(jagArr)
End Function

'******************************************************************************
'* [�T  �v] ArrayToCollection
'* [��  ��] �ꎟ���z���Collection�I�u�W�F�N�g�ɕϊ�����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @return As Collection(Of T)
'******************************************************************************
Public Function ArrayToCollection(ByVal arr As Variant) As Collection
    Set ArrayToCollection = Core.ArrToClct(arr)
End Function

'******************************************************************************
'* [�T  �v] CollectionToArray
'* [��  ��] Collection�I�u�W�F�N�g���ꎟ���z��ɕϊ�����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param clct As Collection(Of T)
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function CollectionToArray(ByVal clct As Collection) As Variant
    CollectionToArray = Core.ClctToArr(clct)
End Function

'******************************************************************************
'* [�T  �v] JagArrayToArray2D
'* [��  ��] �W���O�z���񎟌��z��ɕϊ����ĕԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param jagArr As Variant(Of Array(Of Array(Of T))
'* @return As Variant(Of Array(Of T, T))
'******************************************************************************
Public Function JagArrayToArray2D(ByVal jagArr As Variant) As Variant
    JagArrayToArray2D = Core.JagArrToArr2D(jagArr)
End Function

'******************************************************************************
'* [�T  �v] Array2DToJagArray
'* [��  ��] �񎟌��z����W���O�z��ɕϊ����ĕԋp����B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param arr2D As Variant(Of Array(Of T, T))
'* @return As Variant(Of Array(Of Array(Of T))
'******************************************************************************
Public Function Array2DToJagArray(ByVal arr2D As Variant) As Variant
    Array2DToJagArray = Core.Arr2DToJagArr(arr2D)
End Function

'******************************************************************************
'* [�T  �v] AssocArrayToDictionary
'* [��  ��] �A�z�z���Dictionary�I�u�W�F�N�g�ɕϊ�����B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param aarr Variant(Of Array(Of Tupple))
'* @return Object(Of Dictionary)
'******************************************************************************
Public Function AssocArrayToDictionary(ByVal aarr As Variant) As Object
    Set AssocArrayToDictionary = Ext.AssocArrToDict(aarr)
End Function

'******************************************************************************
'* [�T  �v] DictionaryToAssocArray
'* [��  ��] Dictionary�I�u�W�F�N�g��A�z�z��ɕϊ�����B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param dict
'* @return Variant(Of Array(Of Tupple))
'******************************************************************************
Public Function DictionaryToAssocArray(ByVal dict As Object) As Variant
    DictionaryToAssocArray = Ext.DictToAssocArr(dict)
End Function

'******************************************************************************
'* [�T  �v] EnumeratorToArray
'* [��  ��] �J��Ԃ������iFor Each�j�\�ȃI�u�W�F�N�g���ꎟ���z��ɕϊ�����B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param enumr As Enumerator(Of T)
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function EnumeratorToArray(ByVal enumr As Object) As Variant
    EnumeratorToArray = Ext.EnumeratorToArr(enumr)
End Function

'******************************************************************************
'* [�T  �v] ArrayRange
'* [��  ��] �w�肵���͈͂̐��l�̔z����쐬����B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fromVal As Variant(Of T)
'* @param toVal As Variant(Of T)
'* @param stepVal As Variant(Of T)
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function ArrayRange( _
    ByVal fromVal As Variant, ByVal toVal As Variant, Optional ByVal stepVal As Variant = 1 _
    ) As Variant
    ArrayRange = Ext.ArrRange(fromVal, toVal, stepVal)
End Function

'******************************************************************************
'* [�T  �v] ArrayMap
'* [��  ��] �z��̑S�v�f�ɑ΂��Ďw�肵���t�@���N�V�����̏�����K�p����B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func(Of T, U)
'* @param arr As Variant(Of Array(Of T))
'* @return As Variant(Of Array(Of U))
'******************************************************************************
Public Function ArrayMap(ByVal fun As Func, ByVal arr As Variant) As Variant
    ArrayMap = Ext.ArrMap(fun, arr)
End Function

'******************************************************************************
'* [�T  �v] ArrayZip
'* [��  ��] �Q�̔z��ɑ΂��Ďw�肵���t�@���N�V�����̏�����K�p��
'*          �P�̔z���Ԃ��B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func(Of T, U, R)
'* @param arr1 As Variant(Of Array(Of T))
'* @param arr2 As Variant(Of Array(Of U))
'* @return As Variant(Of Array(Of R))
'******************************************************************************
Public Function ArrayZip( _
    ByVal fun As Func, ByVal arr1 As Variant, ByVal arr2 As Variant _
    ) As Variant
    ArrayZip = Ext.ArrZip(fun, arr1, arr2)
End Function

'******************************************************************************
'* [�T  �v] ArrayFilter
'* [��  ��] �z��ɑ΂��Ďw�肵���t�B���^�����p�̃t�@���N�V������K�p���A
'*          �����Ɉ�v����v�f�݂̂̔z���Ԃ��B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func(Of T, Boolean)
'* @param arr As Variant(Of Array(Of T))
'* @return As Variant(Of Array(Of T))
'******************************************************************************
Public Function ArrayFilter(ByVal fun As Func, ByVal arr As Variant) As Variant
    ArrayFilter = Ext.ArrFilter(fun, arr)
End Function

'******************************************************************************
'* [�T  �v] ArrayGroupBy
'* [��  ��] �z��ɑ΂��Ďw�肵���O���[�s���O�����p�̃t�@���N�V������K�p���A
'*          ���ʂ�Ԃ��B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func(Of T, K)
'* @param arr As Variant(Of Array(Of T))
'* @return As Variant(Of Array(Of Tuple`2(Of K, T)))
'******************************************************************************
Public Function ArrayGroupBy(ByVal fun As Func, ByVal arr As Variant) As Variant
    ArrayGroupBy = Ext.ArrGroupBy(fun, arr)
End Function

'******************************************************************************
'* [�T  �v] ArrayFold
'* [��  ��] ��ݍ��݊֐��B�z����̗v�f�ɑ΂��Ďw�肵�����Z�p�t�@���N�V����
'*          ��K�p���A���̌��ʂƎ��̗v�f�ɂ܂��t�@���N�V������K�p����
'*          �Ƃ������������J��Ԃ��ŏI�I�Ȍ��ʂ�Ԃ��B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func(Of U, T, U)
'* @param arr As Variant(Of Array(Of T))
'* @param seedv As Variant(Of U)
'* @return As Variant(Of U)
'******************************************************************************
Public Function ArrayFold( _
    ByVal fun As Func, ByVal arr As Variant, Optional ByVal seedv As Variant _
    ) As Variant
    ArrayFold = Ext.ArrFold(fun, arr, seedv)
End Function

'******************************************************************************
'* [�T  �v] ArrayScan
'* [��  ��] �z��̊e�v�f�ɑ΂��ČJ��Ԃ��w�肵�����Z�p�t�@���N�V������K�p���A
'*          �ݐς����v�Z���ʂ̃��X�g��Ԃ��B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func(Of U, T, U)
'* @param arr As Variant(Of Array(Of T))
'* @param seedv As Variant(Of U)
'* @return As Variant(Of Array(Of U))
'******************************************************************************
Public Function ArrayScan( _
    ByVal fun As Func, ByVal arr As Variant, Optional ByVal seedv As Variant _
    ) As Variant
    ArrayScan = Ext.ArrScan(fun, arr, seedv)
End Function

'******************************************************************************
'* [�T  �v] ArrayUnfold
'* [��  ��] Fold�̋t�B�����l����w�肵�����Z�p�t�@���N�V������K�p�����X�g��
'*          ��������B
'*          Ariawase��Ext���W���[�����b�p�[���\�b�h�B
'*
'* @param fun As Func
'* @param seedv As Variant(Of T)
'* @return As Variant(Of Array(Of U))
'******************************************************************************
Public Function ArrayUnfold(ByVal fun As Func, ByVal seedv As Variant) As Variant
    ArrayUnfold = Ext.ArrUnfold(fun, seedv)
End Function

'******************************************************************************
'* [�T  �v] RedimPreserve2D
'* [��  ��] 2�����z���1�����ڂ̒�����ύX����B
'*          �Y�����̊J�n��1�n�܂�ɕύX�����B
'*
'* @param orgArray 2�����z��
'* @param legthTo 1�����ڂ̒���
'* @return Variant �ύX��2�����z��
'******************************************************************************
Public Function RedimPreserve2D(ByVal orgArray, ByVal lengthTo) As Variant
    Dim transedArray()
    transedArray = WorksheetFunction.Transpose(orgArray)
    ReDim Preserve transedArray(1 To UBound(transedArray, 1), 1 To lengthTo)
    RedimPreserve2D = WorksheetFunction.Transpose(transedArray)
End Function

'******************************************************************************
'* [�T  �v] SetDefaultTo2DArrayRow
'* [��  ��] 2�����z��̎w��s�ɑ΂��āA�S�ẴJ������Ƀf�t�H���g�l��ݒ肷��B
'*
'* @param v2DArr 2�����z��
'* @param rowNum �w��s
'* @param defaultVal �f�t�H���g�l
'* @return Variant �ύX��2�����z��
'******************************************************************************
Public Function SetDefaultTo2DArrayRow(ByRef v2DArr As Variant, ByVal rownum As Long, ByVal defaultVal As Variant) As Variant
    Dim i As Long
    For i = LBound(v2DArr, 2) To UBound(v2DArr, 2)
        v2DArr(rownum, i) = defaultVal
    Next
    SetDefaultTo2DArrayRow = v2DArr
End Function

'******************************************************************************
'* [�T  �v] Copy1DArrayTo2DArrayRow
'* [��  ��] 2�����z��̎w��s�ɑ΂��āA1�����z��̒l��ݒ肷��B
'*
'* @param v2DArr 2�����z��
'* @param rowNum �w��s
'* @param v1DArr 1�����z��
'* @return Variant �ύX��2�����z��
'******************************************************************************
Public Function Copy1DArrayTo2DArrayRow(ByRef v2DArr As Variant, ByVal rownum As Long, ByRef v1DArr As Variant) As Variant
    Dim i As Long
    For i = LBound(v2DArr, 2) To UBound(v2DArr, 2)
        v2DArr(rownum, i) = v1DArr(i)
    Next
    Copy1DArrayTo2DArrayRow = v2DArr
End Function

'******************************************************************************
'* [�T  �v] Create2DArrayFromPreExisting
'* [��  ��] ���ɑ��݂���2�����z��Ɠ����v�f���̐V����2�����z����쐬����B
'*
'* @param v2DArr 2�����z��
'* @return Variant �V�K2�����z��
'******************************************************************************
Public Function Create2DArrayFromPreExisting(ByRef v2DArr As Variant) As Variant
    Create2DArrayFromPreExisting = Create2DArray(LBound(v2DArr, 1), UBound(v2DArr, 1), LBound(v2DArr, 2), UBound(v2DArr, 2))
End Function

'******************************************************************************
'* [�T  �v] Create2DArray
'* [��  ��] �V����2�����z����쐬����B
'*
'* @param lower1 1�����J�n�C���f�b�N�X
'* @param upper1 1�����I���C���f�b�N�X
'* @param lower2 2�����J�n�C���f�b�N�X
'* @param upper2 2�����I���C���f�b�N�X
'* @return Variant 2�����z��
'******************************************************************************
Public Function Create2DArray(ByVal lower1 As Long, ByVal upper1 As Long, ByVal lower2 As Long, ByVal upper2 As Long) As Variant
    Dim vNew2DArr As Variant
    ReDim vNew2DArr(lower1 To upper1, lower2 To upper2) As Variant
    Create2DArray = vNew2DArr
End Function

'******************************************************************************
'* [�T  �v] Create2DArrayEasy
'* [��  ��] �V����2�����z����쐬����B�J�n�C���f�b�N�X��0�Œ�
'*
'* @param upper1 1�����I���C���f�b�N�X
'* @param upper2 2�����I���C���f�b�N�X
'* @return Variant 2�����z��
'******************************************************************************
Public Function Create2DArrayEasy(ByVal upper1 As Long, ByVal upper2 As Long) As Variant
    Dim vNew2DArr As Variant
    ReDim vNew2DArr(0 To upper1, 0 To upper2) As Variant
    Create2DArrayEasy = vNew2DArr
End Function

'******************************************************************************
'* [�T  �v] Create2DArrayWithValue
'* [��  ��] �V����2�����z����쐬����B�ȉ��̂悤�ɒl��ݒ肷��B
'*            Create2DArrayWithValue(Array(1,2,3),
'*                                   Array(4,5,6),
'*                                   Array(7,8,9))
'*
'* @param lower1 1�����J�n�C���f�b�N�X
'* @param upper1 1�����I���C���f�b�N�X
'* @param lower2 2�����J�n�C���f�b�N�X
'* @param upper2 2�����I���C���f�b�N�X
'* @return Variant 2�����z��
'******************************************************************************
Public Function Create2DArrayWithValue(ParamArray arrList() As Variant) As Variant
    If IsMissing(arrList) Then
        GoTo InValidParam
    End If
    
    Dim v, c As Long, rownum As Long, colnum As Long
    c = 0: rownum = 0: colnum = 0
    
    For Each v In arrList
        If Not IsArray(v) Then
            GoTo InValidParam
        End If
        If colnum = 0 Then
            colnum = GetLength(v)
        Else
            colnum = GetLength(v)
            If colnum <> c Then GoTo InValidParam
        End If
        c = GetLength(v)
        rownum = rownum + 1
    Next
    
    Dim vNew2DArr: vNew2DArr = Create2DArrayEasy(rownum - 1, colnum - 1)
    Dim i As Long: i = LBound(vNew2DArr)

    For Each v In arrList
        Call Copy1DArrayTo2DArrayRow(vNew2DArr, i, v)
        i = i + 1
    Next
        
    Create2DArrayWithValue = vNew2DArr

    Exit Function
InValidParam:
    Create2DArrayWithValue = Empty
End Function

'******************************************************************************
'* [�T  �v] Copy2DArray
'* [��  ��] 2�����z������R�s�[���ĐV����2�����z����쐬����B
'*          �J�n�C���f�b�N�X��0�Œ�B
'*
'* @param source2DArr �R�s�[��2�����z��
'* @param start1DIdx 1�����J�n�C���f�b�N�X
'* @param end1DIdx   1�����I���C���f�b�N�X
'* @param start2DIdx 2�����J�n�C���f�b�N�X
'* @param end2DIdx   2�����I���C���f�b�N�X
'* @return Variant 2�����z��
'******************************************************************************
Public Function Copy2DArray(ByRef source2DArr As Variant, _
                            Optional ByVal start1DIdx As Long = -1, Optional ByVal end1DIdx As Long = -1, _
                            Optional ByVal start2DIdx As Long = -1, Optional ByVal end2DIdx As Long = -1) As Variant
    If start1DIdx < 0 Then start1DIdx = LBound(source2DArr, 1)
    If end1DIdx < 0 Then end1DIdx = UBound(source2DArr, 1)
    If start2DIdx < 0 Then start2DIdx = LBound(source2DArr, 2)
    If end2DIdx < 0 Then end2DIdx = UBound(source2DArr, 2)

    Dim vNew2DArr As Variant: vNew2DArr = Create2DArray(0, end1DIdx - start1DIdx, 0, end2DIdx - start2DIdx)
    
    Dim i As Long, j As Long
    Dim x As Long, y As Long
    x = 0
    For i = start1DIdx To end1DIdx
        y = 0
        For j = start2DIdx To end2DIdx
            vNew2DArr(x, y) = source2DArr(i, j)
            y = y + 1
        Next j
        x = x + 1
    Next i
    Copy2DArray = vNew2DArr
End Function

'******************************************************************************
'* [�T  �v] Contains
'* [��  ��] 1�����z��Ɏw�肵�����ڂ��܂܂�邩�`�F�b�N����B
'*
'* @param varr 1�����z��
'* @param itm ����
'* @return Boolean �`�F�b�N���ʁiTrue�F�܂ށj
'******************************************************************************
Public Function Contains(ByRef varr As Variant, ByVal itm As Variant) As Boolean
    Dim v As Variant
    For Each v In varr
        If Core.Eq(v, itm) Then
            Contains = True
            Exit Function
        End If
    Next
    Contains = False
End Function

'******************************************************************************
'* [�T  �v] ArrayInsert
'* [��  ��] ���ڂ�1�����z��̎w��ʒu�ɒǉ�����B
'*
'* @param varr 1�����z��
'* @param itm ����
'* @return Variant �ǉ���1�����z��
'******************************************************************************
Public Function ArrayInsert(ByRef varr As Variant, ByVal idx As Long, ByVal itm As Variant) As Variant
    If idx < LBound(varr) Or UBound(varr) + 1 < idx Then
        ArrayInsert = varr
        Exit Function
    ElseIf idx = LBound(varr) Then
        If LBound(varr) = UBound(varr) Then
            Dim ax As New ArrayEx
            ArrayInsert = ax.Add(itm).ToArray
            Exit Function
        End If
        Dim ax1 As New ArrayEx
        ArrayInsert = ax1.AddAll(itm, varr).ToArray
        Exit Function
    ElseIf idx = UBound(varr) + 1 Then
        Dim ax2 As New ArrayEx
        ArrayInsert = ax2.AddAll(varr, itm).ToArray
        Exit Function
    End If

    Dim arr1: arr1 = Core.ArrSlice(varr, LBound(varr), idx - 1)
    Dim arr2: arr2 = Core.ArrSlice(varr, idx, UBound(varr))
    Dim ax3 As New ArrayEx
    ArrayInsert = ax3.AddAll(arr1, itm, arr2).ToArray
End Function

'******************************************************************************
'* [�T  �v] ArrayInsertAll
'* [��  ��] ���ځi�����j���w��ʒu�ɒǉ�����B
'*
'* @param varr 1�����z��
'* @param itms ����
'* @return Variant �ǉ���1�����z��
'******************************************************************************
Public Function ArrayInsertAll(ByRef varr As Variant, ByVal idx As Long, ParamArray itms() As Variant) As Variant
    If IsMissing(itms) Then
        ArrayInsertAll = varr
        Exit Function
    End If
    Dim tmp: tmp = itms
    If idx < LBound(varr) Or UBound(varr) + 1 < idx Then
        ArrayInsertAll = varr
        Exit Function
    ElseIf idx = LBound(varr) Then
        If LBound(varr) = UBound(varr) Then
            Dim ax1 As New ArrayEx
            ArrayInsertAll = ax1.AddAll(tmp).ToArray
            Exit Function
        End If
        Dim ax2 As New ArrayEx
        ArrayInsertAll = ax2.AddAll(tmp, varr).ToArray
        Exit Function
    ElseIf idx = UBound(varr) + 1 Then
        Dim ax3 As New ArrayEx
        ArrayInsertAll = ax3.AddAll(varr, tmp).ToArray
        Exit Function
    End If
    
    Dim arr1: arr1 = Core.ArrSlice(varr, LBound(varr), idx - 1)
    Dim arr2: arr2 = Core.ArrSlice(varr, idx, UBound(varr))
    Dim ax As New ArrayEx
    
    ArrayInsertAll = ax.AddAll(arr1, tmp, arr2).ToArray
End Function

'******************************************************************************
'* [�T  �v] ArrayLastIndexOf
'* [��  ��] �ꎟ���z�񂩂�w�肵���l�ƈ�v����v�f�̃C���f�b�N�X��ԋp����B
'*          �Ō�����猟�����čŏ��Ɉ�v�������̂�ԋp�B
'*          �l�̑{���J�n�ʒu�Ɨv�f����C�ӎw��\�B
'*
'* @param arr As Variant(Of Array(Of T))
'* @param val As Variant(Of T)
'* @param ixStart As Variant(Of Long)
'* @param cnt As Variant(Of Long)
'* @return As Long
'******************************************************************************
Public Function ArrayLastIndexOf(ByVal arr As Variant, ByVal val As Variant, _
    Optional ByVal ixStart As Variant, Optional ByVal cnt As Variant _
    ) As Long
    
    If Not IsArray(arr) Then err.Raise 13
    
    Dim ixLast As Long:  ixLast = UBound(arr)
    Dim aLen As Long: aLen = Core.ArrLen(arr)
    If IsMissing(ixStart) Then ixStart = ixLast
    If IsNumeric(ixStart) Then ixStart = CLng(ixStart) Else err.Raise 13
    If ixStart < 0 Or ixStart > ixLast Then err.Raise 5
    If IsMissing(cnt) Then cnt = aLen
    If IsNumeric(cnt) Then cnt = CLng(cnt) Else err.Raise 13
    cnt = Min(cnt, aLen)
    
    ArrayLastIndexOf = -1
    
    Dim i As Long
    For i = ixStart To ixStart - cnt + 1 Step -1
        If Equals(arr(i), val, True) Then
            ArrayLastIndexOf = i
            GoTo Escape
        End If
    Next
    
Escape:
End Function

'******************************************************************************
'* [�T  �v] Remove
'* [��  ��] 1�����z��̍ŏ��Ɍ�����������̗v�f���폜����B
'*
'* @param varr 1�����z��
'* @param itm ����
'* @return Variant �폜��1�����z��
'******************************************************************************
Public Function Remove(ByRef varr As Variant, ByVal itm As Variant) As Variant
    Dim idx As Long: idx = ArrayIndexOf(varr, itm)
    Remove = RemoveAt(varr, idx)
End Function

'******************************************************************************
'* [�T  �v] RemoveAt
'* [��  ��] 1�����z��̎w�肵���C���f�b�N�X�ɂ���v�f���폜����B
'*
'* @param varr 1�����z��
'* @param idx �C���f�b�N�X
'* @return Variant �폜��1�����z��
'******************************************************************************
Public Function RemoveAt(ByRef varr As Variant, ByVal idx As Long) As Variant
    If idx < LBound(varr) Or UBound(varr) < idx Then
        RemoveAt = varr
        Exit Function
    ElseIf idx = LBound(varr) Then
        If LBound(varr) = UBound(varr) Then
            RemoveAt = Me.EmptyVariantArray
            Exit Function
        End If
        RemoveAt = Core.ArrSlice(varr, idx + 1, UBound(varr))
        Exit Function
    ElseIf idx = UBound(varr) Then
        RemoveAt = Core.ArrSlice(varr, LBound(varr), idx - 1)
        Exit Function
    End If
    
    Dim arr1: arr1 = Core.ArrSlice(varr, LBound(varr), idx - 1)
    Dim arr2: arr2 = Core.ArrSlice(varr, idx + 1, UBound(varr))
    Dim ax As New ArrayEx
    RemoveAt = ax.AddAll(arr1, arr2).ToArray
End Function

'******************************************************************************
'* [�T  �v] RemoveRange
'* [��  ��] 1�����z��̗v�f�͈̔͂��폜����B
'*
'* @param varr 1�����z��
'* @param idx1 �J�n�C���f�b�N�X
'* @param idx2 �I���C���f�b�N�X
'* @return Variant �폜��1�����z��
'******************************************************************************
Public Function RemoveRange(ByRef varr As Variant, ByVal idx1 As Long, ByVal idx2 As Long) As Variant
    If idx1 < LBound(varr) Or UBound(varr) < idx1 Or idx2 < LBound(varr) Or UBound(varr) < idx2 Or idx1 > idx2 Then
        RemoveRange = varr
        Exit Function
    ElseIf idx1 = LBound(varr) Then
        If LBound(varr) = UBound(varr) Then
            RemoveRange = Me.EmptyVariantArray
            Exit Function
        End If
        If idx2 = UBound(varr) Then
            RemoveRange = Me.EmptyVariantArray
            Exit Function
        End If
        RemoveRange = Core.ArrSlice(varr, idx2 + 1, UBound(varr))
        Exit Function
    ElseIf idx1 = UBound(varr) Then
        RemoveRange = Core.ArrSlice(varr, LBound(varr), UBound(varr) - 1)
        Exit Function
    ElseIf idx2 = UBound(varr) Then
        RemoveRange = Core.ArrSlice(varr, LBound(varr), idx1 - 1)
        Exit Function
    End If
    
    Dim arr1: arr1 = Core.ArrSlice(varr, LBound(varr), idx1 - 1)
    Dim arr2: arr2 = Core.ArrSlice(varr, idx2 + 1, UBound(varr))
    Dim ax As New ArrayEx
    RemoveRange = ax.AddAll(arr1, arr2).ToArray
End Function

'******************************************************************************
'* [�T  �v] Repeat
'* [��  ��] �w�肵���v�f���w��񐔕��ǉ�����1�����z����쐬����B
'*
'* @param itm ����
'* @param count ����
'* @return Variant 1�����z��
'******************************************************************************
Public Function Repeat(ByVal itm As Variant, ByVal count As Long) As Variant
    If count <= 0 Then
        Repeat = EmptyVariantArray
        Exit Function
    End If
    Dim varr
    ReDim varr(0 To count - 1)
    Dim i As Long
    For i = 0 To count - 1
        If IsObject(itm) Then
            Set varr(i) = itm
        Else
            varr(i) = itm
        End If
    Next
    Repeat = varr
End Function


'******************************************************************************
'* [�T  �v] ToString
'* [��  ��] JSON������ɕϊ�����B
'*
'* @param varr 1�����z��
'* @param count ����
'* @return String 1�����z��
'******************************************************************************
Public Function ToString(ByRef varr As Variant) As String
    Dim strx As StringEx: Set strx = New StringEx

    strx.Append "["
    Dim i As Long
    For i = LBound(varr) To UBound(varr)
        strx.Append VariantUtils.ToString(varr(i))
        If i < UBound(varr) Then
            strx.Append ", "
        End If
    Next
    strx.Append "]"
    ToString = strx.ToString
End Function