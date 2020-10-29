VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ProgressController"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] �J��Ԃ������i���Ǘ��N���X
'* [��  ��] IEnumerator�C���^�t�F�[�X�����������J�Ԃ��f�[�^�������s���N���X
'*          �ɂ��āA�������X�^�[�g�����A�i���C�x���g���󂯎��B
'*          �i���󋵂��A�v���[���e�[�V�����p��IProgressReporter�C���^�t�F�[�X
'*          �����������N���X�ŕ\��������B
'*
'* [�Q  �l] https://qiita.com/kazu3516/items/1223ce0838dd4a8d2629
'*
'* @author Bankura
'* Copyright (c) 2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private WithEvents eventObject As EnumeratorEventObject
Attribute eventObject.VB_VarHelpID = -1
Private mProgressReporter As IProgressReporter
Private mIsReportable As Long

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* ProgressReporter �v���p�e�B
'*
'* �i�����|�[�g�I�u�W�F�N�g
'*-----------------------------------------------------------------------------
Public Property Get ProgressReporter() As IProgressReporter
    Set ProgressReporter = mProgressReporter
End Property
Public Property Set ProgressReporter(arg As IProgressReporter)
    Set mProgressReporter = arg
End Property

'*-----------------------------------------------------------------------------
'* IsReportable �v���p�e�B
'*
'* �i���̃��|�[�g���s�����ǂ����B
'*-----------------------------------------------------------------------------
Public Property Get IsReportable() As Boolean
    IsReportable = mIsReportable
End Property
Public Property Let IsReportable(arg As Boolean)
    mIsReportable = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    mIsReportable = True
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Start
'* [��  ��] �J��Ԃ��������J�n����B
'*
'* @param enumerator �J��Ԃ����������I�u�W�F�N�g
'*
'******************************************************************************
Public Sub Start(enumerator As IEnumerator)
    Set eventObject = enumerator.eventObject
    
    ' �i���\���J�n
    If Not mProgressReporter Is Nothing And mIsReportable Then
        mProgressReporter.Start enumerator
    End If

    ' �񋓊J�n
    On Error GoTo ErrorHandler
    enumerator.Start
    
    ' �i���\������
    If Not mProgressReporter Is Nothing And mIsReportable Then
        mProgressReporter.Finish enumerator
    End If
    Exit Sub
    
ErrorHandler:
    If Not mProgressReporter Is Nothing And mIsReportable Then
        mProgressReporter.Finish enumerator
    End If
    Err.Raise Err.Number, Err.Source, Err.Description
End Sub

'******************************************************************************
'* [�T  �v] eventObject_OnAction
'* [��  ��] �i�����|�[�g���ƂɌĂяo�����C�x���g�n���h���B
'*
'* @param sender �J��Ԃ����������I�u�W�F�N�g
'*
'******************************************************************************
Private Sub eventObject_OnAction(sender As IEnumerator)
    If Not mProgressReporter Is Nothing And mIsReportable Then
        mProgressReporter.Proceed sender
    End If
    DoEvents
End Sub