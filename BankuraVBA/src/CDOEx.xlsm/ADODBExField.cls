VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExField"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Field�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Field�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Field�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Field�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Represents a column of data with a common data type. Each Field object
' corresponds to a column in the Recordset.
'
' ���ʂ̃f�[�^�^�̃f�[�^�̗��\���B
' �eField�I�u�W�F�N�g�́ARecordset�̗�ɑΉ����Ă���B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Field
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
'* ActualSize �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�B�[���h�̒l�̎��ۂ̒�����ԋp����B
'* �EField�I�u�W�F�N�g�̒l�̒����𔻒f�ł��Ȃ��ꍇ�́AadUnknown ���ԋp�����B
'*-----------------------------------------------------------------------------
Property Get ActualSize() As Long
    ActualSize = mOrigin.ActualSize
End Property

'*-----------------------------------------------------------------------------
'* Attributes �v���p�e�B
'*
'* [��  ��]
'* �E1�܂��͕�����FieldAttributeEnum�l�̍��v��ԋp����B
'* �E�ʏ�͒l�̎擾�̂݉\�B
'* �ERecord��Fields�R���N�V�����ɒǉ����ꂽ�V����Field�I�u�W�F�N�g�̏ꍇ�́A
'*   Field��Value�v���p�e�B���w�肵�AFields�R���N�V������Update���\�b�h���Ă�
'*   �o�����Ƃɂ���ĐV����Field���f�[�^�v���o�C�_�[�ɂ���Đ���ɒǉ����ꂽ
'*   ����ɂ̂݁AAttributes�̒l�̎擾�Ɛݒ�̗������\�B
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
'* DataFormat �v���p�e�B
'*
'* [��  ��]
'* �EMSDN���Ɍf�ڂ���Ă��Ȃ��v���p�e�B�B
'* �E���Ԃ�StdDataFormat�I�u�W�F�N�g�BStdDataFormat�I�u�W�F�N�g��Microsoft Data
'*   Formatting Object Library���Q�Ɛݒ�ɒǉ�����Ɗm�F�ł���Ƃ̂��ƁB
'* �E�ȉ��̂悤�Ɏg�p����B
'*   Set dft = New StdFormat.StdDataFormat
'*   dft.Type = fmtCustom
'*   dft.Format = "Currency"
'*   Set rs.Fields("Price").DataFormat = dft
'*   Debug.Print rs!Price '�ʉ݌^�̃t�H�[�}�b�g�ŕ\��
'*-----------------------------------------------------------------------------
Property Get DataFormat() As Variant
    Set DataFormat = mOrigin.DataFormat
End Property
Property Set DataFormat(arg As Variant)
    Set mOrigin.DataFormat = arg
End Property

'*-----------------------------------------------------------------------------
'* DefinedSize �v���p�e�B
'*
'* [��  ��]
'* �EField�I�u�W�F�N�g�̃f�[�^�e�ʁi�t�B�[���h�̒�`�T�C�Y�i�o�C�g�j�j��ԋp����B
'*-----------------------------------------------------------------------------
Property Get DefinedSize() As Long
    DefinedSize = mOrigin.DefinedSize
End Property
Property Let DefinedSize(arg As Long)
    mOrigin.DefinedSize = arg
End Property

    
'*-----------------------------------------------------------------------------
'* Name �v���p�e�B
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�̖��O��ԋp����B
'* �E�ʏ�͒l�̎擾�̂݉\�B
'* �ERecord��Fields�R���N�V�����ɒǉ����ꂽ�V����Field�I�u�W�F�N�g�̏ꍇ�́A
'*   Field��Value�v���p�e�B���w�肵�AFields�R���N�V������Update���\�b�h���Ă�
'*   �o�����Ƃɂ���ĐV����Field���f�[�^�v���o�C�_�[�ɂ���Đ���ɒǉ����ꂽ
'*   ����ɂ̂݁AName�̒l�̎擾�Ɛݒ�̗������\�B
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
'* �EField �I�u�W�F�N�g�̐��l�̏����_�ȉ��̌�����ԋp����B
'* �E�ʏ�͒l�̎擾�̂݉\�B
'* �ERecord��Fields�R���N�V�����ɒǉ����ꂽ�V����Field�I�u�W�F�N�g�̏ꍇ�́A
'*   Field��Value�v���p�e�B���w�肵�AFields�R���N�V������Update���\�b�h���Ă�
'*   �o�����Ƃɂ���ĐV����Field���f�[�^�v���o�C�_�[�ɂ���Đ���ɒǉ����ꂽ
'*   ����ɂ̂݁ANumericScale�̒l�̎擾�Ɛݒ�̗������\�B
'*-----------------------------------------------------------------------------
Property Get NumericScale() As Byte
    NumericScale = mOrigin.NumericScale
End Property
Property Let NumericScale(arg As Byte)
    mOrigin.NumericScale = arg
End Property

'*-----------------------------------------------------------------------------
'* OriginalValue �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�ύX���s����O�̃��R�[�h�ɑ��݂��Ă���Field�̒l��ԋp����B
'*-----------------------------------------------------------------------------
Property Get OriginalValue() As Variant
    OriginalValue = mOrigin.OriginalValue
End Property

'*-----------------------------------------------------------------------------
'* Precision �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E���l�^�� Field �I�u�W�F�N�g�̐��x�i�ő包���������o�C�g�^�̒l�j��ԋp����B
'* �E�ʏ�͒l�̎擾�̂݉\�B
'* �ERecord��Fields�R���N�V�����ɒǉ����ꂽ�V����Field�I�u�W�F�N�g�̏ꍇ�́A
'*   Field��Value�v���p�e�B���w�肵�AFields�R���N�V������Update���\�b�h���Ă�
'*   �o�����Ƃɂ���ĐV����Field���f�[�^�v���o�C�_�[�ɂ���Đ���ɒǉ����ꂽ
'*   ����ɂ̂݁APrecision�̒l�̎擾�Ɛݒ�̗������\�B
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
'* �EProperties�I�u�W�F�N�g�����b�v����ADODBExProperties�I�u�W�F�N�g��ԋp����B
'* �E����Recordset�I�u�W�F�N�g�ɐݒ肳��Ă���Properties�I�u�W�F�N�g��ԋp�B
'*-----------------------------------------------------------------------------
Property Get Properties() As ADODBExProperties
    Dim wrap As ADODBExProperties: Set wrap = New ADODBExProperties
    Set wrap.Origin = mOrigin.Properties
    Set Properties = wrap
End Property

'*-----------------------------------------------------------------------------
'* Status �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EField�I�u�W�F�N�g�̃X�e�[�^�X�̒l��ԋp����B
'* �E����l��adFieldOK�B
'* �E�X�V�����s�����ꍇ��G���[���Ԃ���Status�v���p�e�B�͑���ƃG���[�X�e�[�^�X
'*   �R�[�h�̑g�ݍ��킹�l������� �e�t�B�[���h��Status�v���p�e�B���g�p���Ĥ�t�B�[
'*   ���h���ǉ���ύX��܂��͍폜����Ȃ��������R�𔻒f�\�
'* �E�t�B�[���h�̒ǉ��A�ύX�A�܂��͍폜�Ɋւ�����́A���̃v���p�e�B��ʂ���
'*   �񍐂����B���Ƃ��΁A���[�U�[���t�B�[���h���폜����ƁAFields�R���N�V����
'*   �ō폜�̃}�[�N���t������B ���[�U�[�������������Ȃ��t�B�[���h���폜���悤
'*   �Ƃ������߂�Update�Ăяo�����G���[��Ԃ����ꍇ�A���̃t�B�[���h�̃X�e�[�^�X
'*   ��adFieldPermissionDenied�܂���adFieldPendingDelete�ɂȂ�B
'*-----------------------------------------------------------------------------
Property Get Status() As FieldStatusEnum
    Status = mOrigin.Status
End Property

'*-----------------------------------------------------------------------------
'* Type_ �v���p�e�B�i�ǂݎ���p�j�iType���\���̂���Type_�ɕύX�j
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�̃f�[�^�^��ԋp����B
'* �EType���\���Ŏg�p�ł��Ȃ����߁AType_�ɕύX�B
'* �E�ʏ�͒l�̎擾�̂݉\�B
'* �ERecord��Fields�R���N�V�����ɒǉ����ꂽ�V����Field�I�u�W�F�N�g�̏ꍇ�́A
'*   Field��Value�v���p�e�B���w�肵�AFields�R���N�V������Update���\�b�h���Ă�
'*   �o�����Ƃɂ���ĐV����Field���f�[�^�v���o�C�_�[�ɂ���Đ���ɒǉ����ꂽ
'*   ����ɂ̂݁AType�̒l�̎擾�Ɛݒ�̗������\�B
'*-----------------------------------------------------------------------------
Property Get Type_() As DataTypeEnum
    Type_ = mOrigin.Type
End Property
Property Let Type_(arg As DataTypeEnum)
    mOrigin.Type_ = arg
End Property

'*-----------------------------------------------------------------------------
'* UnderlyingValue �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�f�[�^�x�[�X����Field�I�u�W�F�N�g�̌��݂̒l��ԋp����B
'*-----------------------------------------------------------------------------
Property Get UnderlyingValue() As Variant
    UnderlyingValue = mOrigin.UnderlyingValue
End Property

'*-----------------------------------------------------------------------------
'* Value �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �EField�I�u�W�F�N�g�̌��݂̒l��ԋp����B
'* �E���R�[�h��Fields�R���N�V�����ɒǉ������V����Field�I�u�W�F�N�g�̏ꍇ�
'*   ���̃v���p�e�B��ݒ肷��O�ɂ܂�Value�v���p�e�B��ݒ肵�A�X�V�����s����
'*   �K�v������
'*-----------------------------------------------------------------------------
Property Get Value() As Variant
Attribute Value.VB_UserMemId = 0
    Value = mOrigin.Value
End Property
Property Let Value(arg As Variant)
    mOrigin.Value = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Public Sub Class_Initialize()
    'Set mOrigin = CreateObject("ADODB.Field")
End Sub
Public Sub Class_Terminate()
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
'* @param Data �I�u�W�F�N�g�ɒǉ�����f�[�^
'******************************************************************************
Sub AppendChunk(data)
    Call mOrigin.AppendChunk(data)
End Sub

'******************************************************************************
'* [�T  �v] GetChunk���\�b�h
'* [��  ��] GetChunk�̃��b�p�[���\�b�h�B
'*          �傫�ȃT�C�Y�̕�����܂��̓o�C�i���f�[�^���擾����ۂɎg�p�B
'*
'* @Length �f�[�^�T�C�Y���w��
'******************************************************************************
Sub GetChunk(Length As Long)
    Call mOrigin.GetChunk(Length)
End Sub

