VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExProperty"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Property�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Property�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Property�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Property�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Represents a characteristic of an ADO object that is defined by the provider.
' ADO objects have two types of properties: built-in and dynamic.
' Built-in properties are those properties implemented in ADO and immediately
' available to any new object.
' The Property object is a container for dynamic properties, defined by the
' underlying provider.
'
' �v���o�C�_�[�ɂ���Ē�`�����ADO�I�u�W�F�N�g�̓�����\���B
' ADO�I�u�W�F�N�g�ɂ́A�g�ݍ��݂Ɠ��I��2��ނ̃v���p�e�B������B �g�ݍ��݃v��
' �p�e�B�́AADO�Ŏ�������A�V�����I�u�W�F�N�g�ł����Ɏg�p�ł���v���p�e�B�B
' Property�I�u�W�F�N�g�́A��ɂȂ�v���o�C�_�[�ɂ���Ē�`����铮�I�v���p�e�B
' �̃R���e�i�[�ł���B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Property
Private mOrigin As Object
    
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
End Property

'*-----------------------------------------------------------------------------
'* Attributes �v���p�e�B
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�� 1 �܂��͕����̑����������B
'* �EAttributes �v���p�e�B�͒l�̎擾�̂݉\�ŁA���̒l�� 1 �܂��͕�����
'*   PropertyAttributesEnum �l�̍��v�ɂȂ�
'* �E�����̑�����ݒ肷��ꍇ�́A�Y������萔�̍��v���g�p�ł���B
'*   �v���p�e�B�̒l��݊����̂Ȃ��萔���܂ލ��v�ɐݒ肷��Ƥ�G���[����������
'* �E���̃v���p�e�B�ͤ�N���C�A���g����Connection�I�u�W�F�N�g�ł͎g�p�ł��Ȃ��
'*-----------------------------------------------------------------------------
Property Get Attributes() As Long
    Attributes = mOrigin.Attributes
End Property
Property Let Attributes(arg As Long)
    mOrigin.Attributes = arg
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�̖��O�������l��ݒ�܂��͎擾����B
'* �E�l�́A  Property �I�u�W�N�g�ł͓ǂݎ���p�ɂȂ�B
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property
Property Let Name(arg As String)
    mOrigin.Name = arg
End Property

'*-----------------------------------------------------------------------------
'* Type �v���p�e�B�iType���\���̂���Type_�ɕύX�j
'*
'* [��  ��]
'* �E����̎�ނ܂��̓f�[�^�^�������B
'*-----------------------------------------------------------------------------
Property Get Type_() As DataTypeEnum
    Type_ = mOrigin.Type
End Property
Property Let Type_(arg As DataTypeEnum)
    mOrigin.Type = arg
End Property

'*-----------------------------------------------------------------------------
'* Value �v���p�e�B�i���胁���o�[�j
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�Ɋ��蓖�Ă�ꂽ�l�������B
'* �EValue �v���p�e�B�͂��܂��܂ȗv���ɂ���Ēl�̎擾�Ɛݒ肪�\�ȏꍇ�ƁA
'*   �l�̎擾�݂̂��\�ȏꍇ������B
'* �EADO �ł́A Value �v���p�e�B���g�p���ă����O�o�C�i���f�[�^��ݒ肨���
'*   �擾�\�B
'*-----------------------------------------------------------------------------
Property Get Value() As Variant
Attribute Value.VB_UserMemId = 0
    If IsObject(mOrigin.Value) Then
        Set Value = mOrigin.Value
    Else
        Value = mOrigin.Value
    End If
End Property
Property Let Value(arg As Variant)
    If IsObject(arg) Then
        Set mOrigin.Value = arg
    Else
        mOrigin.Value = arg
    End If
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Public Sub Class_Initialize()
    'Set mOrigin = CreateObject("ADODB.Property")
End Sub
Public Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub