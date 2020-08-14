VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExErrors"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Errors�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Errors�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Errors�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Errors�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Contains all the Error objects created in response to a single provider-related
' failure.
'
' �P��̃v���o�C�_�[�֘A�̏�Q�ɉ����č쐬���ꂽ���ׂĂ�Error�I�u�W�F�N�g����
' �܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Errors
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
    Dim myError As Object
    For Each myError In mOrigin
        Dim wrap As ADODBExError: Set wrap = New ADODBExError
        Set wrap.Origin = myError
        mKeys.Add wrap, myError.Name
    Next myError
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
Property Get Item(Index) As ADODBExError
Attribute Item.VB_UserMemId = 0
    Dim wrap As ADODBExError: Set wrap = New ADODBExError
    Set wrap.Origin = mOrigin.Item(Index)
    Set Item = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("ADODB.Errors")
    'Set mKeys = New Collection
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
    Set mKeys = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Clear���\�b�h
'* [��  ��] Clear�̃��b�p�[���\�b�h�B
'*          Errors �R���N�V�������炷�ׂĂ� Error �I�u�W�F�N�g���폜����B
'*          Errors �R���N�V������ Clear ���\�b�h�́A�R���N�V�������������
'*          ���ׂĂ� Error �I�u�W�F�N�g���폜����ꍇ�Ɏg�p����B
'*          �G���[����������ƁA Errors �R���N�V�����͎����I�ɃN���A����A
'*          �V�����G���[�Ɋ�Â� Error �I�u�W�F�N�g���i�[�����B
'*          �v���p�e�B�ƃ��\�b�h�̒��ɂ́A Errors �R���N�V������ Error �I�u�W
'*          �F�N�g�Ƃ��Čx����Ԃ��Ă��A�v���O�����̎��s���~���Ȃ����̂�����B
'*          Recordset �I�u�W�F�N�g�� Resync ���\�b�h�A UpdateBatch ���\�b�h�A
'*          �܂��� CancelBatch ���\�b�h���Ăяo���O�A Connection �I�u�W�F�N�g
'*          �� Open ���\�b�h���Ăяo���O�A�܂��� Recordset �I�u�W�F�N�g��
'*          Filter �v���p�e�B��ݒ肷��O�ɁA Errors �R���N�V������ Clear ��
'*          �\�b�h���Ăяo���K�v������B
'*          ����ɂ��A Errors �R���N�V������ Count �v���p�e�B��ǂݎ��A
'*          �Ԃ��ꂽ�x���𒲂ׂ邱�Ƃ��ł���B
'*
'******************************************************************************
Sub Clear()
    Call mOrigin.Clear
    Set mKeys = Nothing
    Set mKeys = New Collection
End Sub

'******************************************************************************
'* [�T  �v] Refresh���\�b�h
'* [��  ��] Refresh�̃��b�p�[���\�b�h�B
'*          Errors�R���N�V�����̃I�u�W�F�N�g���X�V����
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