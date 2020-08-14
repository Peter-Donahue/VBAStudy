VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "MathUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ���l���Z���[�e�B���e�B�N���X
'* [��  ��] ���l���Z���s�����[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'*
'* [�ˁ@��]
'*
'* [�Q  �l] https://github.com/RelaxTools/Hidennotare/wiki/StringUtils
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
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

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] LShift
'* [��  ��] ���V�t�g�
'*
'* @param val �l
'* @param digit ���V�t�g���錅��
'* @return String �V�t�g����
'******************************************************************************
Public Function LShift(ByVal val As Long, ByVal digit As Long) As Long
    LShift = val * (2 ^ digit)
End Function

'******************************************************************************
'* [�T  �v] RShift
'* [��  ��] �E�V�t�g�
'*
'* @param val �l
'* @param digit �E�V�t�g���錅��
'* @return String �V�t�g����
'******************************************************************************
Public Function RShift(val As Long, digit As Long) As Long
    RShift = val \ (2 ^ digit)
End Function

'******************************************************************************
'* [�T  �v] Min
'* [��  ��] �w�肵���v�f�̂����ŏ��̗v�f��ԋp����
'*
'* @param arr() �Ώۗv�f�i�����j
'* @return Variant �ŏ��̗v�f
'******************************************************************************
Public Function Min(ParamArray parr() As Variant) As Variant
    Dim tmp: tmp = parr
    Dim arr: arr = ArrayUtils.ToVArrayFlattened(tmp)
    Dim ret: ret = Empty
    
    Dim ub As Variant: ub = UBound(arr)
    If ub < 0 Then
        Min = ret
        Exit Function
    End If
    
    Dim i As Long
    If IsObject(arr(0)) Then
        Set ret = arr(0)
        For i = 1 To ub
            If Compare(arr(i), ret) = -1 Then Set ret = arr(i)
        Next
    Else
        Let ret = arr(0)
        For i = 1 To ub
            If Compare(arr(i), ret) = -1 Then Let ret = arr(i)
        Next
    End If
    Min = ret
End Function

'******************************************************************************
'* [�T  �v] Max
'* [��  ��] �w�肵���v�f�̂����ő�̗v�f��ԋp����
'*
'* @param arr() �Ώۗv�f�i�����j
'* @return Variant �ő�̗v�f
'******************************************************************************
Public Function Max(ParamArray parr() As Variant) As Variant
    Dim tmp: tmp = parr
    Dim arr: arr = ArrayUtils.ToVArrayFlattened(tmp)
    Dim ret: ret = Empty
    
    Dim ub As Variant: ub = UBound(arr)
    If ub < 0 Then
        Max = ret
        Exit Function
    End If
    
    Dim i As Long
    If IsObject(arr(0)) Then
        Set ret = arr(0)
        For i = 1 To ub
            If Compare(arr(i), ret) = 1 Then Set ret = arr(i)
        Next
    Else
        Let ret = arr(0)
        For i = 1 To ub
            If Compare(arr(i), ret) = 1 Then Let ret = arr(i)
        Next
    End If
    Max = ret
End Function

'******************************************************************************
'* [�T  �v] IsInt
'* [��  ��] �������ǂ����`�F�b�N�
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param num �Ώ�Variant�l
'* @return Boolean �`�F�b�N���ʁiTrue�F�����j
'******************************************************************************
Public Function IsInt(ByVal num As Variant) As Boolean
    IsInt = Core.IsInt(num)
End Function

'******************************************************************************
'* [�T  �v] ARound
'* [��  ��] �l�̌ܓ����̒[���������s���B
'*          Ariawase��Core���W���[�����b�p�[���\�b�h�B
'*
'* @param num �Ώۂ̏������܂ސ��l
'* @param digits �[���������s��������n�ʂ�n+1������
'* @param rndup �؂�グ���s�����i�f�t�H���g:5 �l�̌ܓ��j
'* @return Variant(Of Decimal) �[���������s�������ʂ̐��l
'******************************************************************************
Public Function ARound( _
    ByVal num As Variant, Optional ByVal digits As Integer = 0, Optional rndup As Integer = 5 _
    ) As Variant
    ARound = Core.ARound(num, digits, rndup)
End Function