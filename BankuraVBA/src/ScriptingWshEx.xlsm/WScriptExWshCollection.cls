VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WScriptExWshCollection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WScript.WshCollection�N���X�̃��b�v�E�g���N���X
'* [��  ��] WScript.WshCollection�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WScript.WshCollection�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WScript.WshCollection�N���X�ɂ��āB
' Windows �̓���t�H���_�̃R���N�V����WshSpecialFolders �I�u�W�F�N�g�Ƃ���
' �g�p���܂��B
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364437(v=msdn.10)>�B
'
' �܂��AWScript.Network��EnumNetworkDrives,EnumPrinterConnections���\�b�h��
' �߂�l�Ƃ��Ă��g�p���܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As IWshRuntimeLibrary.WshCollection
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
    Dim v
    For Each v In mOrigin
        mKeys.Add v
    Next
End Property

'*-----------------------------------------------------------------------------
'* length �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�R���N�V�������̃I�u�W�F�N�g���������B
'*-----------------------------------------------------------------------------
Property Get length() As Long
    length = mOrigin.length
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WScript.WshCollection")
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
'* [�T  �v] Count���\�b�h
'* [��  ��] Count�̃��b�p�[���\�b�h�B
'*          �R���N�V�����̗v�f����ԋp�B
'*
'* @return �R���N�V�����̗v�f��
'*
'******************************************************************************
Function Count() As Long
    Count = mOrigin.Count
End Function

'******************************************************************************
'* [�T  �v] Item���\�b�h�i���胁���o�[�j
'* [��  ��] Item�̃��b�p�[���\�b�h�B
'*          �R���N�V�����̗v�f��ԋp�B
'*
'* @param Index �R���N�V�������ł̃I�u�W�F�N�g�̈ʒu (�C���f�b�N�X)
'* @return �R���N�V�����̗v�f
'*
'******************************************************************************
Function Item(Index)
Attribute Item.VB_UserMemId = 0
    Item = mOrigin.Item(Index)
End Function

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
    'Set NewEnum = mOrigin.[_NewEnum]
    Set NewEnum = mKeys.[_NewEnum]
End Function