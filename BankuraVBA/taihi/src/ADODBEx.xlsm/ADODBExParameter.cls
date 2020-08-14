VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExParameter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Parameter�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Parameter�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Parameter�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Parameter�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Represents a parameter or argument associated with a Command object, based on
' a parameterized query or stored procedure.
'
' �p�����[�^�[�����ꂽ�N�G���܂��̓X�g�A�h�v���V�[�W���Ɋ�Â��āACommand�I�u�W
' �F�N�g�Ɋ֘A�t����ꂽ�p�����[�^�[�܂��͈�����\���B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Parameter
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
'* �EAttributes �v���p�e�B�͒l�̎擾����ѐݒ肪�\�ŁA���̒l�� 1 �܂��͕���
'*   �� ParameterAttributesEnum �l�̍��v�ɂȂ�B����l�� adParamSigned �B
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
'* Direction �v���p�e�B
'*
'* [��  ��]
'* �EParameter ���A���̓p�����[�^�[�A�o�̓p�����[�^�[�A�܂��͓��o�͗����̃p��
'*   ���[�^�[��\���Ă��邩����邢�ͤ�X�g�A�h �v���V�[�W������̖߂�l�ł��邩
'*   �������B
'* �EDirection �v���p�e�B�́A�v���V�[�W���Ƃ̃p�����[�^�[�̂����̕��@���w
'*   �肷�邽�߂Ɏg���B
'*   Direction �v���p�e�B�͓ǂݎ��/�������݉\�ɂȂ��Ă���B
'*   ����ɂ��A�p�����[�^�[�����擾���邽�߂� ADO ������ȏ�v���o�C�_�[
'*   ���Ăяo���Ȃ��悤�ɂ���ꍇ�ɁA���̏���ݒ肵����A���̏���Ԃ��Ȃ�
'*   �v���o�C�_�[�𑀍삵����ł���B
'* �E�v���o�C�_�[�̒��ɂ́A�X�g�A�h �v���V�[�W���̃p�����[�^�[�̓��o�͂̕���
'*   ���m�F�ł��Ȃ����̂�����B
'*   ���̏ꍇ�́A�N�G�������s����O�� Direction �v���p�e�B��ݒ肷��K�v��
'*   ����B
'*-----------------------------------------------------------------------------
Property Get Direction() As ParameterDirectionEnum
    Direction = mOrigin.Direction
End Property
Property Let Direction(arg As ParameterDirectionEnum)
    mOrigin.Direction = arg
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�̖��O�������l��ݒ�܂��͎擾����B
'* �EParameters �R���N�V�����ɒǉ�����Ă��Ȃ� Parameter �I�u�W�F�N�g�ł́A
'*   Name �v���p�e�B�͓ǂݎ��/�������݉\�B
'*   �ǉ����ꂽ Parameter �I�u�W�F�N�g�Ƃ��̑��̃I�u�W�F�N�g�ł́A Name �v���p
'*   �e�B�͓ǂݎ���p�B���O�̓R���N�V�������ň�ӂłȂ��Ă����܂�Ȃ��B
'* �E�I�u�W�F�N�g�� Name �́A�����Q�ƂŎ擾�ł��A���̌�́A���̖��O�Œ��ڃI�u
'*   �W�F�N�g���Q�Ƃł���B���Ƃ��΁Arstmain �v���p�e�B (20) ���g�p����B
'*   Name �͍X�V�\�ɂȂ�A��ł��̃v���p�e�B���Q�Ƃ���ƁA�X�V�̍X�V���\
'*   �ɂȂ�A���̃v���p�e�B�� rstmain. �v���p�e�B ("�X�V�\��") �ƌĂԂ��Ƃ�
'*   �ł���B
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property
Property Let Name(arg As String)
    mOrigin.Name = arg
End Property

'*-----------------------------------------------------------------------------
'* NumericScale �v���p�e�B
'*
'* [��  ��]
'* �E���l�̌����������B���l�̏����_�ȉ��̌����������o�C�g�^ (Byte) �̒l��ݒ�
'*   �܂��͎擾����B
'*-----------------------------------------------------------------------------
Property Get NumericScale() As Byte
    NumericScale = mOrigin.NumericScale
End Property
Property Let NumericScale(arg As Byte)
    mOrigin.NumericScale = arg
End Property

'*-----------------------------------------------------------------------------
'* Precision �v���p�e�B
'*
'* [��  ��]
'* �E���l�̐��x�������B�l��\�����߂Ɏg�p����ő包���������o�C�g�^ (Byte) ��
'*   �l��ݒ�܂��͎擾����B
'*-----------------------------------------------------------------------------
Property Get Precision() As Byte
    Precision = mOrigin.Precision
End Property
Property Let Precision(arg As Byte)
    mOrigin.Precision = arg
End Property

'*-----------------------------------------------------------------------------
'* Properties �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �ECommand�ɐݒ肳��Ă���Properties�I�u�W�F�N�g���擾����B
'*-----------------------------------------------------------------------------
Property Get Properties() As ADODBExProperties
    Dim wrap As ADODBExProperties: Set wrap = New ADODBExProperties
    Set wrap.Origin = mOrigin.Properties
    Set Properties = wrap
End Property

'*-----------------------------------------------------------------------------
'* Size �v���p�e�B
'*
'* [��  ��]
'* �EParameter �I�u�W�F�N�g�̍ő�T�C�Y���o�C�g���܂��͕������Ŏ����B
'* �EParameter �I�u�W�F�N�g�� Value �v���p�e�B�Őݒ�܂��͎擾�ł���l�̍ő�T
'*   �C�Y�𒲂ׂ�ɂ́ASize �v���p�e�B���g�p����B
'* �EParameter �I�u�W�F�N�g�Ƃ��ĉϒ��f�[�^�^ (���Ƃ��΁AadVarChar �Ȃǂ̂���
'*   �Ă̕�����^ (String)) ���w�肵���ꍇ�AParameters �R���N�V�����ɂ��̃I�u�W
'*   �F�N�g��ǉ�����O�ɁA�I�u�W�F�N�g�� Size �v���p�e�B��ݒ肷��K�v������A
'*   ���̐ݒ���s��Ȃ��ƃG���[����������B
'* �EParameter �I�u�W�F�N�g�� Command �I�u�W�F�N�g�� Parameters �R���N�V������
'*   ���ɒǉ�����Ă���ꍇ�ɁA���̃f�[�^�^���ϒ��f�[�^�^�ɕύX�����ꍇ�́A
'*   Command �I�u�W�F�N�g�����s����O�� Parameter �I�u�W�F�N�g�� Size �v���p�e
'*   �B��ݒ肷��K�v������A���̐ݒ���s��Ȃ��ƃG���[����������B
'* �ERefresh ���\�b�h���g�p���ăv���o�C�_�[����p�����[�^�[�����擾�����Ƃ�
'*   �ɁA�ϒ��f�[�^�^�� Parameter �I�u�W�F�N�g���Ԃ��ꂽ�ꍇ�A�\�ȍő�T�C
'*   �Y�Ɋ�Â��ăp�����[�^�[�Ƀ����������蓖�Ă��邪�A���ꂪ�����Ŏ��s����
'*   �G���[���������邱�Ƃ�����B
'*   �G���[���������ɂ́A�R�}���h�����s����O�ɁA�����I�ɂ����̃p�����[�^�[
'*   �� Size �v���p�e�B��ݒ肷�邱�ƁB
'* �ESize �v���p�e�B�ͤ�l�̎擾����ѐݒ肪�\�
'*-----------------------------------------------------------------------------
Property Get Size() As Long
    Size = mOrigin.Size
End Property
Property Let Size(arg As Long)
    mOrigin.Size = arg
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
'* �E[!����] Parameter �I�u�W�F�N�g�̏ꍇ�AADO �̓v���o�C�_�[�����x����
'*   Value �v���p�e�B���擾����B
'*   �R�}���h�Ɋ܂܂�� Parameter �� Value �v���p�e�B����ŁA���̃R�}���h����
'*   Recordset ���쐬����ꍇ�́A Value �v���p�e�B���擾����O�ɁA Recordset
'*   �����K�v������B
'*   ���̂悤�ɂ��Ȃ��ƁA�v���o�C�_�[�ɂ���ẮA Value �v���p�e�B����ɂȂ�A
'*   �������l���i�[����Ȃ��ꍇ������B
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
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("ADODB.Parameter")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] AppendChunk���\�b�h
'* [��  ��] AppendChunk�̃��b�p�[���\�b�h�B
'*          �傫�ȃT�C�Y�̕�����܂��̓o�C�i���f�[�^���i�[����ۂɎg�p�B
'*          Parameter�I�u�W�F�N�g��Attributes�v���p�e�B��adParamLong�r�b�g��
'*          True �ɐݒ肳��Ă���ƁA���̃p�����[�^�[�ɑ΂���AppendChunk���\
'*          �b�h���g�p�\�B
'*
'* @param Val �I�u�W�F�N�g�ɒǉ�����f�[�^
'******************************************************************************
Sub AppendChunk(Val)
    Call mOrigin.AppendChunk(Val)
End Sub