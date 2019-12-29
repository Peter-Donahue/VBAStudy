VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExParameters"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Parameters�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Parameters�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Parameters�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Parameters�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Contains all the Parameter objects of a Command object.
'
' Command�I�u�W�F�N�g�̂��ׂĂ�Parameter�I�u�W�F�N�g���܂܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Parameters
Private mOrigin As Object
Private mKeys As Collection
    
'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* �I���W�i��Object �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get Origin() As Object
    Set Origin = mOrigin
End Property
Property Set Origin(arg As Object)
    Set mOrigin = arg
    Set mKeys = New Collection
    Dim myParam As Object
    For Each myParam In mOrigin
        Dim wrap As ADODBExParameter: Set wrap = New ADODBExParameter
        Set wrap.Origin = myParam
        mKeys.Add wrap, myParam.Name
    Next myParam
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�R���N�V�������̃I�u�W�F�N�g���������B
'* �ECount �v���p�e�B�ͤ����̃R���N�V�������̃I�u�W�F�N�g�̐��𒲂ׂ邽�߂�
'*   �g���
'* �E�R���N�V�����̃����o�[�� 0 ���珇�ɔԍ������蓖�Ă��邽�߁A���[�v���g��
'*   �ꍇ�͏�� 0 ����n�߂āA Count �v���p�e�B��� 1 �������l�ŏI��点��K�v
'*   ������B
'*   Microsoft Visual Basic �� Count �v���p�e�B���`�F�b�N�����ɃR���N�V������
'*   �����o�[�����[�v��������ɂ́A For Each...Next �R�}���h���g���B
'* �ECount �� 0 �̏ꍇ�A�R���N�V�����ɂ̓I�u�W�F�N�g���܂܂�Ă��Ȃ����Ƃ��Ӗ�
'*   ����B
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�R���N�V�����̓���̃����o�[�����̖��O�܂��͏����Ŏ����B
'* �EIndex�ɂ́A�R���N�V�������̃I�u�W�F�N�g�̖��O�܂��͏����ɕ]�������
'*   �o���A���g�^ ( Variant ) �̎����w��B
'* �EItem �v���p�e�B�́A�R���N�V�������̓���̃I�u�W�F�N�g��Ԃ����߂Ɏg���B
'*   �R���N�V�������� Item �� Index �����ɑΉ�����I�u�W�F�N�g���������Ȃ�
'*   �ꍇ�́A�G���[����������B
'*   �܂��A�R���N�V�����̒��ɂ͖��O�t���I�u�W�F�N�g���T�|�[�g���Ă��Ȃ����̂�
'*   ����B���̂悤�ȃR���N�V�����ł́A�����Q�Ƃ��g���K�v������B
'* �EItem �v���p�e�B�͂��ׂẴR���N�V�����̊���v���p�e�B�Ȃ̂Ť���̂������
'*   �\���`���ł��������ʂ�������
'*     collection.Item (Index)
'*     collection (Index)
'*-----------------------------------------------------------------------------
Property Get Item(Index) As ADODBExParameter
Attribute Item.VB_UserMemId = 0
    Dim wrap As ADODBExParameter: Set wrap = New ADODBExParameter
    Set wrap.Origin = mOrigin.Item(Index)
    Set Item = wrap
End Property


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("ADODB.Parameters")
    Set mKeys = New Collection
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
    Set mKeys = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Append���\�b�h
'* [��  ��] Append�̃��b�p�[���\�b�h�B
'*          �R���N�V�����ɃI�u�W�F�N�g��ǉ�����B
'*
'* @param Object �ǉ�����I�u�W�F�N�g
'*
'******************************************************************************
Sub Append(Object As Object)
    Call mOrigin.Append(Object)
    mKeys.Add Object, Object.Name
End Sub

'******************************************************************************
'* [�T  �v] Delete���\�b�h
'* [��  ��] Delete�̃��b�p�[���\�b�h�B
'*          Parameters �R���N�V��������I�u�W�F�N�g���폜����B
'*
'* @param Index �폜����I�u�W�F�N�g�̖��O�A�܂��̓R���N�V�������ł�
'*              �I�u�W�F�N�g�̈ʒu (�C���f�b�N�X)
'*
'******************************************************************************
Sub Delete(Index)
    Dim keyName: keyName = mOrigin.Item(Index).Name
    Call mOrigin.Delete(Index)
    Dim i As Long
    For i = 1 To mKeys.Count
        If mKeys(i) = keyName Then
            mKeys.Remove i
            Exit Sub
        End If
    Next
End Sub

'******************************************************************************
'* [�T  �v] Refresh���\�b�h
'* [��  ��] Refresh�̃��b�p�[���\�b�h�B
'*          �R���N�V�����̃I�u�W�F�N�g���X�V����B
'*          Command �I�u�W�F�N�g�Ŏw�肳�ꂽ�X�g�A�h�v���V�[�W���܂���
'*          �p�����[�^�[�����ꂽ�N�G���Ɋւ���v���o�C�_�[���̃p�����[�^�[
'*          ��񂪎擾�����B
'*          �v���o�C�_�[���X�g�A�h�v���V�[�W���̌Ăяo���܂��̓p�����[�^�[��
'*          ���ꂽ�N�G�����T�|�[�g���Ȃ��ꍇ�ɂ́A�R���N�V�����͋�ɂȂ�B
'*          Refresh ���\�b�h���Ăяo���O�ɁA Command �I�u�W�F�N�g��
'*          ActiveConnection �v���p�e�B��L���� Connection �I�u�W�F�N�g�ɁA
'*          CommandText �v���p�e�B��L���ȃR�}���h�ɁA CommandType �v���p�e�B
'*          �� adCmdStoredProc �ɁA���ꂼ��ݒ肷��K�v������B
'*          Refresh ���\�b�h���Ăяo���O�� Parameters �R���N�V�����ɃA�N�Z�X
'*          ����ƁA�����I�Ƀ��\�b�h���Ăяo����A�R���N�V�������X�V�����B
'*          [!����]
'*          Refresh ���\�b�h���g�p���ăv���o�C�_�[����p�����[�^�[�����擾���A
'*          1�܂��͕����̉ϒ��f�[�^�^�� Parameter �I�u�W�F�N�g���Ԃ����
'*          �ꍇ�AADO �̓p�����[�^�[�̍ő�\�T�C�Y�Ɋ�Â��ă����������蓖��
'*          �邽�߁A���s���ɃG���[����������B
'*          �G���[�������ɂ́A Execute ���\�b�h���Ăяo���O�ɁA������
'*          �p�����[�^�[�� Size �v���p�e�B�𖾎��I�ɐݒ肷��K�v������B
'*
'******************************************************************************
Sub Refresh()
    Call mOrigin.Refresh
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] NewEnum ���\�b�h
'* [��  ��] For Each �\���ŃC�e���[�^�[��Ԃ����߂̃��\�b�h�B
'*
'* @return �C�e���[�^�[
'******************************************************************************
Public Function NewEnum() As stdole.IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    Set NewEnum = mKeys.[_NewEnum]
End Function