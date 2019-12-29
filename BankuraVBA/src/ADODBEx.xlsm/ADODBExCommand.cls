VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExCommand"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Command�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Command�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Command�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Command�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Used to define a specific command, such as a SQL query, intended to run against
' a data source.
'
' �f�[�^�\�[�X�ɑ΂��Ď��s���邱�Ƃ�ړI�Ƃ����ASQL�N�G���Ȃǂ̓���̃R�}���h��
' ��`���邽�߂Ɏg�p����܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Command
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
'* ActiveConnection �v���p�e�B
'*
'*   ���I�u�W�F�N�g�u���E�U��Command��ActiveConnection �v���p�e�B���m�F�����
'*     �^��Connection�ƂȂ��Ă��邪�A�ڑ���񕶎���iString�j���󂯎�邱�Ƃ�
'*     �\�̂��߁AVariant�^�Ƃ��Ă��܂��B
'*
'* [��  ��]
'* �EADODBExConnection/Connection�I�u�W�F�N�g�A�܂��͐ڑ���񕶎���iString�j
'*   ��ݒ肷��B
'* �ENothing��ݒ肷��ƁACommand�I�u�W�F�N�g�Ɍ��ݐݒ肳��Ă���Connection
'*   ����������B
'* �E�ڑ������Ă���ꍇ�ɂ͐ڑ��̒�`���i�[���ꂽ������^ ( String ) �̒l
'*   ���A�ڑ����J���Ă���ꍇ�ɂ͌��݂� Connection �I�u�W�F�N�g���i�[���ꂽ
'*   �o���A���g�^ ( Variant ) �̒l��ݒ�܂��͎擾����B
'*   ����́ANull �I�u�W�F�N�g�Q�ƁB
'*   ConnectionString �v���p�e�B�̐������Q�Ƃ��邱�ƁB
'* �E�J���Ă��� Connection �I�u�W�F�N�g�܂��͗L���Ȑڑ�����������̃v���p�e�B
'*   �ɐݒ肷��O�ɁA Command �I�u�W�F�N�g�ɑ΂��� Execute ���Ăяo�����Ƃ���
'*   �ƁA�G���[����������B
'* �EActiveConnection�v���p�e�B��Nothing�ɐݒ肷��ƌ��݂̐ڑ�����Command�I�u
'*   �W�F�N�g��؂藣���A�v���o�C�_�[���f�[�^�Ɋ֘A�t�����Ă��郊�\�[�X��
'*   �������B���̌�́A���� Command �I�u�W�F�N�g�𓯂��܂��͕ʂ� Connection
'*   �I�u�W�F�N�g�Ɋ֘A�t���邱�Ƃ��ł���B
'*   �v���o�C�_�[�ɂ���ẮA�v���p�e�B��Nothing�ɐݒ肵�Ȃ��Ă��A����ڑ���
'*   ��ʂ̐ڑ��Ƀv���p�e�B�ݒ��ύX���邱�Ƃ��ł���B
'* �ECommand �I�u�W�F�N�g�� Parameters �R���N�V�����Ƀv���o�C�_�[���狟������
'*   ���p�����[�^�[���i�[����Ă���ꍇ�́AActiveConnection �v���p�e�B��
'*   Nothing �ɐݒ肵����A���� Connection �I�u�W�F�N�g�ɐݒ肵���肷��ƁA
'*   �R���N�V�������N���A�����B
'*   ���Ƃ� Parameter �I�u�W�F�N�g���쐬���A������g�p���� Command �I�u�W�F
'*   �N�g�� Parameters �R���N�V�����Ƀf�[�^���i�[�����ꍇ�́AActiveConnection
'*   �v���p�e�B�� Nothing �⑼�� Connection �I�u�W�F�N�g�ɐݒ肵�Ă��AParameters
'*   �R���N�V�����͂��̂܂܎c�����B
'* �ECommand �I�u�W�F�N�g���֘A�t�����Ă��� Connection �I�u�W�F�N�g�����
'*   �ƁAActiveConnection �v���p�e�B�� Nothing �ɐݒ肳��B
'*   ���̃v���p�e�B�ɕ��Ă��� Connection �I�u�W�F�N�g��ݒ肷��ƁA
'*   �G���[����������B
'*-----------------------------------------------------------------------------
Property Get ActiveConnection() As Variant
    If IsObject(mOrigin.ActiveConnection) Then
        Dim wrap As ADODBExConnection: Set wrap = New ADODBExConnection
        Set wrap.Origin = mOrigin.ActiveConnection
        Set ActiveConnection = wrap
    Else
        ActiveConnection = mOrigin.ActiveConnection
    End If
End Property
Property Let ActiveConnection(arg As Variant)
    If IsObject(arg) Then
        If TypeName(arg) = "ADODBExConnection" Then
            Set mOrigin.ActiveConnection = arg.Origin
        Else
            Set mOrigin.ActiveConnection = arg
        End If
    Else
        If TypeName(arg) = "Nothing" Then
            Set mOrigin.ActiveConnection = Nothing
        Else
            mOrigin.ActiveConnection = arg
        End If
    End If
End Property

'*-----------------------------------------------------------------------------
'* CommandStream �v���p�e�B
'*
'* [��  ��]
'* �ECommand�I�u�W�F�N�g�̓��͂Ƃ��Ďg�p�����X�g���[���������B
'* �ECommand�I�u�W�F�N�g�̓��͂Ƃ��Ďg�p�����X�g���[����ݒ�܂��͕Ԃ��B
'*   ���̃X�g���[���̌`���̓v���o�C�_�[�ŗL�ł���B
'*   �ڍׂɂ��ẮA�v���o�C�_�[�̃h�L�������g���Q�ƁB
'*   ���̃v���p�e�B�́ACommandText�v���p�e�B�Ɏ��Ă���B
'*   CommandText�v���p�e�B�́A�R�}���h�̓��͂ɕ�������w�肷�邽�߂Ɏg�p�����B
'* �ECommandStream��CommandText�͑��݂ɔr���I�ł���B
'*   ���[�U�[��CommandStream�v���p�e�B��ݒ肷��ƁACommandText�v���p�e�B�͋��
'*   ������i ""�j�ɐݒ肳���B
'*   ���[�U�[��CommandText�v���p�e�B��ݒ肷��ƁACommandStream�v���p�e�B��
'*   Nothing�ɐݒ肳���B
'* �ECommand.Parameters.Refresh�����Command.Prepare���\�b�h�̓���ͤ�v���o�C�_
'*   �[�ɂ���Ē�`�����
'*   �X�g���[�����̃p�����[�^�[�̒l�͍X�V�ł��Ȃ��
'* �E���̓X�g���[���́A�R�}���h�̃\�[�X��Ԃ�����ADO�I�u�W�F�N�g�ł͎g�p�ł�
'*   �Ȃ��B ���Ƃ��΁ARecordset��Source�����͂Ƃ��ăX�g���[��������Command
'*   �I�u�W�F�N�g�ɐݒ肳��Ă���ꍇ�ARecordset.Source��CommandText�v���p�e�B
'*   ��Ԃ��B
'*   ���̃v���p�e�B�ɂ́A�X�g���[���̃R���e���c�̑���ɋ�̕�����i ""�j����
'*   �܂��B
'* �E�iCommandStream�Ŏw�肳�ꂽ�j�R�}���h�X�g���[�����g�p����ꍇ�ACommandType
'*   �v���p�e�B�̗L����CommandTypeEnum�l��adCmdText��adCmdUnknown�݂̂ł���B
'*   ���̑��̒l�̓G���[�̌����ɂȂ�B
'*-----------------------------------------------------------------------------
Property Get CommandStream() As Variant
    If IsObject(mOrigin.CommandStream) Then
        Set CommandStream = mOrigin.CommandStream
    Else
        CommandStream = mOrigin.CommandStream
    End If
End Property
Property Set CommandStream(arg As Variant)
    If IsObject(arg) Then
        Set mOrigin.CommandStream = arg
    Else
        mOrigin.CommandStream = arg
    End If
End Property

'*-----------------------------------------------------------------------------
'* CommandText �v���p�e�B
'*
'* [��  ��]
'* �ESQL �X�e�[�g�����g�A�e�[�u�����A���� URL�A�܂��̓X�g�A�h �v���V�[�W����
'*   �Ăяo���ȂǁA�v���o�C�_�[�̃R�}���h���܂ޕ�����^ ( String ) �̒l��ݒ�
'*   �܂��͎擾����B����l�� "" (���� 0 �̕�����)�B
'* �ECommand �I�u�W�F�N�g�ŕ\�����R�}���h �e�L�X�g��ݒ�܂��͎擾����ɂ́A
'*   CommandText �v���p�e�B���g�p����B
'*   �ʏ�� SQL �X�e�[�g�����g���g�����A�X�g�A�h �v���V�[�W���̌Ăяo���ȂǁA
'*   �v���o�C�_�[���F������A���̎�ނ̃R�}���h �X�e�[�g�����g�ł����܂�Ȃ��B
'*   SQL �X�e�[�g�����g�́A����̕��@�܂��̓v���o�C�_�[�̃N�G�� �v���Z�b�T��
'*   �T�|�[�g����o�[�W�����ł���K�v������B
'* �ECommand �I�u�W�F�N�g�� Prepared �v���p�e�B�� True �ɐݒ肳��Ă��āA
'*   CommandText �v���p�e�B��ݒ肷��Ƃ��ɊJ���Ă����ڑ��� Command �I�u�W�F�N�g
'*   ���o�C���h����Ă���ꍇ�A Execute ���\�b�h�܂��� Open ���\�b�h���Ăяo��
'*   �ƁA�N�G�� (�܂�A�v���o�C�_�[���ۑ�����R���p�C�����ꂽ�N�G��) ������
'*   �����B
'* �ECommandType �v���p�e�B�̐ݒ�l�ɂ���ẮA CommandText �v���p�e�B���ύX
'*   �����ꍇ������B
'*   CommandText �v���p�e�B�͂��ł��ǂݏo�����Ƃ��ł��AADO ���R�}���h���s��
'*   �Ɏg�����ۂ̃R�}���h �e�L�X�g�̎Q�Ƃ��\�B
'* �E�t�@�C����f�B���N�g���Ȃǂ̃��\�[�X���w�肷�鑊�� URL ��ݒ肵����擾
'*   �����肷��ɂ́A CommandText �v���p�e�B���g���B
'*   ���\�[�X�́A��� URL �Ŗ����I�Ɏw�肳�ꂽ�ʒu��A�J���ꂽ Connection
'*   �I�u�W�F�N�g�ňÖٓI�Ɏw�肳�ꂽ�ʒu�ɑ΂��đ��ΓI�ł���B
'*-----------------------------------------------------------------------------
Property Get CommandText() As String
    CommandText = mOrigin.CommandText
End Property
Property Let CommandText(arg As String)
    mOrigin.CommandText = arg
End Property

'*-----------------------------------------------------------------------------
'* CommandTimeout �v���p�e�B
'*
'* [��  ��]
'* �E�R�}���h�����s�����܂ł̑ҋ@���Ԃ�b�P�ʂŎ����l��ݒ�܂��͎擾����B
'*   ����l�� 30 �B
'* �E�l�b�g���[�N �g���t�B�b�N��T�[�o�[�̉ߕ��ׂɂ����s���x��Ă��� Execute
'*   ���\�b�h�̌Ăяo�������������Ƃ��ł���悤�ɂ���ɂ́A Connection �I�u�W
'*   �F�N�g�܂��� Command �I�u�W�F�N�g�� CommandTimeout �v���p�e�B���g�p����B
'*   �R�}���h�̎��s����������O�� CommandTimeout �v���p�e�B�Őݒ肳�ꂽ���Ԃ�
'*   �o�߂���ƁA�G���[���������ăR�}���h�����������B
'*   �v���p�e�B�� 0 �ɐݒ肷��ƁA�R�}���h���s����������܂Ŗ����ɑҋ@����B
'*   �R�[�h���������ރv���o�C�_�[�ƃf�[�^ �\�[�X�� CommandTimeout �@�\���T�|�[
'*   �g���Ă��邱�Ƃ��m�F���邱�ƁB
'* �EConnection �I�u�W�F�N�g�� CommandTimeout �ݒ�́A���� Connection ���
'*   Command �I�u�W�F�N�g�� CommandTimeout �ݒ�ɉe�����Ȃ��B
'*   �܂�A Command �I�u�W�F�N�g�� CommandTimeout �v���p�e�B�́A Connection
'*   �I�u�W�F�N�g�� CommandTimeout �̒l���p�����Ȃ��B
'* �EConnection �I�u�W�F�N�g�ł́A CommandTimeout �v���p�e�B�� Connection ���J
'*   ���ꂽ����A�ǂݎ��/�������݂��\�B
'*-----------------------------------------------------------------------------
Property Get CommandTimeout() As Long
    CommandTimeout = mOrigin.CommandTimeout
End Property
Property Let CommandTimeout(arg As Long)
    mOrigin.CommandTimeout = arg
End Property

'*-----------------------------------------------------------------------------
'* CommandType �v���p�e�B
'*
'* [��  ��]
'* �ECommand �I�u�W�F�N�g�̌^�������B1 �܂��͕����� CommandTypeEnum �l��ݒ�
'*   �܂��͎擾����B
'* �E[!����] CommandType �ł́A adCmdFile �܂��� adCmdTableDirect ��
'*   CommandTypeEnum �l���g�p���Ȃ����ƁB
'*   �����̒l�́A Recordset �� Open ���\�b�h�� Requery ���\�b�h�̃I�v�V����
'*   �Ƃ��Ă̂ݎg�p���邱�Ƃ��ł���B
'* �ECommandType �v���p�e�B�́A CommandText �v���p�e�B�̕]�����œK�����邽�߂�
'*   �g�p����B
'* �ECommandType �v���p�e�B�̒l�� adCmdUnknown (����l) �Ɠ������ꍇ�A�p�t�H�[
'*   �}���X���ቺ���邱�Ƃ�����B
'*   ����́A CommandText �v���p�e�B�̌^�� SQL �X�e�[�g�����g�A�X�g�A�h�v���V�[
'*   �W���A�܂��̓e�[�u�����ł��邩�𒲂ׂ邽�߂Ƀv���o�C�_�[���Ăяo���K�v����
'*   �邽�߂ł���B
'*   �g���Ă���R�}���h�̎�ނ��킩���Ă���ꍇ�́A CommandType �v���p�e�B��
'*   �ݒ肷�邱�Ƃɂ��A�Y������R�[�h�ɒ��ڈړ��ł���B
'*   CommandType �v���p�e�B�� CommandText �v���p�e�B�̃R�}���h�̎�ނƈ�v����
'*   ���ꍇ�� Execute ���\�b�h���Ăяo���ƁA�G���[����������B
'*-----------------------------------------------------------------------------
Property Get CommandType() As CommandTypeEnum
    CommandType = mOrigin.CommandType
End Property
Property Let CommandType(arg As CommandTypeEnum)
    mOrigin.CommandType = arg
End Property

'*-----------------------------------------------------------------------------
'* Dialect �v���p�e�B
'*
'* [��  ��]
'* �ECommandText�܂���CommandStream�v���p�e�B�̕����������B
'*   �����́A������܂��̓X�g���[������͂��邽�߂Ƀv���o�C�_�[���g�p����\��
'*   �ƈ�ʓI�ȋK�����`����B
'* �EDialect�v���p�e�B�ɂ́A�R�}���h�e�L�X�g�܂��̓X�g���[���̕�����\���L����
'*   GUID���܂܂�Ă���B
'*   ���̃v���p�e�B�̃f�t�H���g�l��{C8B521FB-5CF3-11CE-ADE5-00AA0044773D}�B
'*   ����́A�v���o�C�_�[���R�}���h�e�L�X�g�܂��̓X�g���[���̉��ߕ��@��I������
'*   �K�v�����邱�Ƃ������B
'* �E���[�U�[�����̃v���p�e�B�̒l��ǂݎ���Ă�ADO�̓v���o�C�_�[�ɃN�G�������s
'*   ���Ȃ�� ����Command�I�u�W�F�N�g�Ɋi�[����Ă���l�̕�����\����Ԃ��
'* �E���[�U�[��Dialect�v���p�e�B��ݒ肷��ƤADO��GUID�����؂���w�肳�ꂽ�l��
'*   �L����GUID�łȂ��ꍇ�̓G���[�𔭐�������
'*   �v���o�C�_�̃h�L�������g���Q�Ƃ��ĤDialect�v���p�e�B�ŃT�|�[�g����Ă���
'*   GUID�l���m�F���邱�ơ
'*-----------------------------------------------------------------------------
Property Get Dialect() As String
    Dialect = mOrigin.Dialect
End Property
Property Let Dialect(arg As String)
    mOrigin.Dialect = arg
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�̖��O������������^ (String) �̒l��ݒ�܂��͎擾����B
'* �E�l�́A Command �I�u�W�F�N�g�ł͓ǂݎ��/�������݉\�B
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property
Property Let Name(arg As String)
    mOrigin.Name = arg
End Property

'*-----------------------------------------------------------------------------
'* NamedParameters �v���p�e�B
'*
'* [��  ��]
'* �E�p�����[�^�[�����v���o�C�_�[�ɓn�����ǂ����������
'* �E���̃v���p�e�B��true�̏ꍇ�AADO��Command�I�u�W�F�N�g��Parameter�R���N�V��
'*   ���̊e�p�����[�^�[��Name�v���p�e�B�̒l��n���B
'*   �v���o�C�_�[�́A�p�����[�^�[�����g�p���āACommandText�܂���CommandStream
'*   �v���p�e�B�̃p�����[�^�[�ƈ�v����B
'*   ���̃v���p�e�B��false�i�f�t�H���g�j�̏ꍇ�A�p�����[�^�[���͖�������A�v��
'*   �o�C�_�[�̓p�����[�^�[�̏������g�p���āACommandText�܂���CommandStream�v
'*   ���p�e�B�̃p�����[�^�[�ɒl����v������B
'*-----------------------------------------------------------------------------
Property Get NamedParameters() As Boolean
    NamedParameters = mOrigin.NamedParameters
End Property
Property Let NamedParameters(arg As Boolean)
    mOrigin.NamedParameters = arg
End Property

'*-----------------------------------------------------------------------------
'* Parameters �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �ECommand�ɐݒ肳��Ă���Parameters�I�u�W�F�N�g���擾����B
'*-----------------------------------------------------------------------------
Property Get Parameters() As ADODBExParameters
Attribute Parameters.VB_UserMemId = 0
    Dim wrap As ADODBExParameters: Set wrap = New ADODBExParameters
    Set wrap.Origin = mOrigin.Parameters
    Set Parameters = wrap
End Property

'*-----------------------------------------------------------------------------
'* Prepared �v���p�e�B
'*
'* [��  ��]
'* �E�R���p�C�����ꂽ�o�[�W�����̃R�}���h�����s�O�ɕۑ����邩�ǂ����������B
'* �ETrue �ɐݒ肳��Ă���ꍇ�́A�R�}���h�̏������K�v�ł��邱�Ƃ������B
'* �ECommand �I�u�W�F�N�g���ŏ��Ɏ��s����O�ɁA CommandText �v���p�e�B�Ŏw�肳
'*   �ꂽ�N�G���̏����ς� (�R���p�C���ς�) �o�[�W�������v���o�C�_�[�ŕۑ�����
'*   �ɂ́A Prepared �v���p�e�B���g�p����B
'*   ����ɂ���āA�R�}���h�̍ŏ��̎��s�͒x���Ȃ邱�Ƃ����邪�A�v���o�C�_�[��
'*   �R�}���h���R���p�C��������̓R���p�C���ς݂̃R�}���h���g�p�����̂ŁA
'*   �p�t�H�[�}���X�����シ��B
'* �E���̃v���p�e�B�� False �̏ꍇ�A�v���o�C�_�[�̓R���p�C���ς݃o�[�W������
'*   �쐬�����ɁA���� Command �I�u�W�F�N�g�����s����B
'* �E�v���o�C�_�[���R�}���h�̏������T�|�[�g���Ă��Ȃ��ꍇ�A���̃v���p�e�B��
'*   True �ɐݒ肷��ƁA�����ɃG���[���Ԃ���邱�Ƃ�����B
'*   �G���[��Ԃ��Ȃ��ꍇ�A�v���o�C�_�[�͒P�ɃR�}���h�̏����̗v���𖳎����A
'*   Prepared �v���p�e�B�� False �ɐݒ肷��B
'*-----------------------------------------------------------------------------
Property Get Prepared() As Boolean
    Prepared = mOrigin.Prepared
End Property
Property Let Prepared(arg As Boolean)
    mOrigin.Prepared = arg
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
'* State �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�I�u�W�F�N�g�̏�Ԃ��J���Ă��邩�A���Ă��邩�������B
'* �E�񓯊����\�b�h�����s����ΏۂɂȂ邷�ׂẴI�u�W�F�N�g�ɂ��Ĥ�I�u�W�F�N
'*   �g�̏�Ԃ��ڑ��A���s�A�擾�̂�����ł��邩�������
'* �EObjectStateEnum �̒l�ɂȂ钷�����^ ( Long ) �̒l��Ԃ��B
'*   ����l�� adStateClosed �B
'* �EState �v���p�e�B���g�p���Ĥ����̃I�u�W�F�N�g�̌��݂̏�Ԃ����ł����ׂ�
'*   ���Ƃ��ł���
'* �E�I�u�W�F�N�g�� State �v���p�e�B�́A�l�̑g�ݍ��킹�ɂȂ�ꍇ������B
'*   ���Ƃ��΁A�X�e�[�g�����g�����s���ł���ꍇ�A���̃v���p�e�B�̒l��
'*   adStateOpen �� adStateExecuting �̑g�ݍ��킹�ɂȂ�B
'* �EState �v���p�e�B�͒l�̎擾�̂݉\�
'*-----------------------------------------------------------------------------
Property Get State() As Long
    State = mOrigin.State
End Property
    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("ADODB.Command")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Cancel���\�b�h
'* [��  ��] Cancel�̃��b�p�[���\�b�h�B
'*          �ۗ����̔񓯊����\�b�h�Ăяo���̎��s���������B
'*          �񓯊����\�b�h�Ăяo�� (�܂�AadAsyncConnect�AadAsyncExecute�A
'*          �܂��� adAsyncFetch �I�v�V�������w�肵�ČĂяo���ꂽ���\�b�h) ��
'*          ���s�𒆎~����B
'*          Command�̏ꍇ�AExecute���Ō�̔񓯊��Ăяo�������~����郁�\�b�h�B
'*
'******************************************************************************
Sub Cancel()
    Call mOrigin.Cancel
End Sub

'******************************************************************************
'* [�T  �v] CreateParameter���\�b�h
'* [��  ��] CreateParameter�̃��b�p�[���\�b�h�B
'*          �w�肵���v���p�e�B���g�p���ĐV�KParameter�I�u�W�F�N�g���쐬����B
'*          ���O�A��ށA�����A�T�C�Y�A����ђl���w�肵�ĐV�K Parameter �I�u�W�F
'*          �N�g���쐬����B�����Ɏw�肵���l�́A�Ή����� Parameter �v���p�e�B��
'*          �������܂��B
'*          ���̃��\�b�h�́ACommand�I�u�W�F�N�g��Parameters�R���N�V������
'*          Parameter�I�u�W�F�N�g�������I�ɒǉ����Ȃ��B
'*          ����ɂ��A�R���N�V������Parameter�I�u�W�F�N�g��ǉ������Ƃ���
'*          ADO�����؂���l�����ǉ��̃v���p�e�B��ݒ�ł���B
'*          Type �����ŉϒ��f�[�^�^���w�肵���ꍇ�AParameters �R���N�V������
'*          �I�u�W�F�N�g��ǉ�����O�ɁASize ������n�����A�܂��� Parameter
'*          �I�u�W�F�N�g�� Size �v���p�e�B��ݒ肷��K�v������B
'*          ���̂悤�ɂ��Ȃ������ꍇ�̓G���[����������B
'*          Type �����ɐ��l�^ (adNumeric �܂��� adDecimal) ���w�肷��ꍇ�́A
'*          ������ NumericScale �v���p�e�B�� Precision �v���p�e�B���ݒ肷��K�v
'*          ������B
'*
'* @param Name      �ȗ��\�B Parameter �I�u�W�F�N�g���B
'* @param Type_     �ȗ��\�B Parameter �I�u�W�F�N�g�̃f�[�^�^�B
'* @param Direction �ȗ��\�B Parameter �I�u�W�F�N�g�̕����B
'* @param Size      �ȗ��\�B�p�����[�^�[�l�̍ő咷�B
'* @param Value     �ȗ��\�B Parameter �I�u�W�F�N�g�̒l�B
'* @return Parameter�I�u�W�F�N�g
'******************************************************************************
Function CreateParameter(Optional Name As String, _
                         Optional Type_ As DataTypeEnum = adEmpty, _
                         Optional Direction As ParameterDirectionEnum = adParamInput, _
                         Optional Size As Long, _
                         Optional Value) As ADODBExParameter
    Dim wrap As ADODBExParameter: Set wrap = New ADODBExParameter
    
    If IsMissing(Name) Then
        If IsMissing(Size) Then
            If IsMissing(Value) Then
                Set wrap.Origin = mOrigin.CreateParameter(, Type_, Direction)
            Else
                Set wrap.Origin = mOrigin.CreateParameter(, Type_, Direction, , Value)
            End If
        ElseIf IsMissing(Value) Then
            Set wrap.Origin = mOrigin.CreateParameter(, Type_, Direction, Size)
        Else
            Set wrap.Origin = mOrigin.CreateParameter(, Type_, Direction, Size, Value)
        End If
    Else
        If IsMissing(Size) Then
            If IsMissing(Value) Then
                Set wrap.Origin = mOrigin.CreateParameter(Name, Type_, Direction)
            Else
                Set wrap.Origin = mOrigin.CreateParameter(Name, Type_, Direction, , Value)
            End If
        ElseIf IsMissing(Value) Then
            Set wrap.Origin = mOrigin.CreateParameter(Name, Type_, Direction, Size)
        Else
            Set wrap.Origin = mOrigin.CreateParameter(Name, Type_, Direction, Size, Value)
        End If
    End If
    Set CreateParameter = wrap
End Function
                         
'******************************************************************************
'* [�T  �v] Execute���\�b�h
'* [��  ��] Execute�̃��b�p�[���\�b�h�B
'*          CommandText �v���p�e�B�Ŏw�肳�ꂽ�N�G���ASQL �X�e�[�g�����g�A
'*          �܂��̓X�g�A�h�v���V�[�W�������s����B
'*
'*          Command �I�u�W�F�N�g�ɑ΂��� Execute ���\�b�h���g�p����ƁA�I�u�W�F
'*          �N�g�� CommandText �v���p�e�B�Ŏw�肳��Ă���N�G�������s�����B
'*          �s��Ԃ��N�G���� CommandText �v���p�e�B�Ŏw�肳��Ă���ƁA���s��
'*          �������邷�ׂĂ̌��ʂ́A�V���� Recordset �I�u�W�F�N�g�Ɋi�[�����B
'*          �R�}���h���s��Ԃ��Ȃ��N�G���ł���ꍇ�A�v���o�C�_�[�͕���
'*          Recordset �I�u�W�F�N�g��Ԃ��B
'*          �A�v���P�[�V��������ɂ���ẮA Recordset ���K�v�Ȃ��Ƃ��͂���
'*          �߂�l�𖳎����Ă����܂�Ȃ��B
'*          �N�G���Ƀp�����[�^�[������ꍇ�AExecute�Ăяo���œn�����p�����[
'*          �^�[�l�ł������I�[�o�[���C�h���Ȃ�����ACommand�I�u�W�F�N�g��
'*          �p�����[�^�[�̌��݂̒l���g�p�����B
'*          Execute���\�b�h���Ăяo���Ƃ��Ɉꕔ�̃p�����[�^�[�̐V�����l���ȗ�
'*          ���邱�Ƃɂ��A�p�����[�^�[�̃T�u�Z�b�g���I�[�o�[���C�h�ł���B
'*          �p�����[�^�[���w�肷�鏇���́A���\�b�h���p�����[�^�[��n��������
'*          �����ł���B���Ƃ��΁A4�� (�܂��͂���ȏ�) �̃p�����[�^�[������A
'*          ��1�Ƒ�4�̃p�����[�^�[�ɑ΂��Ă̂ݐV�����l��n���ꍇ�́A
'*          parameters�����Ƃ��ēn���B
'*
'* @param RecordsAffected �ȗ��\�B���̑���̉e�����󂯂����R�[�h���B
'*                        �A�N�V�����N�G���܂��̓X�g�A�h�v���V�[�W���ɑ΂���
'*                        �̂ݓK�p�����B
'*                        ���ʂ�Ԃ��N�G���܂��̓X�g�A�h�v���V�[�W���ɂ����
'*                        �Ԃ���郌�R�[�h�̐���Ԃ��Ȃ��B
'*                        ���̏����擾����ɂ́A RecordCount�v���p�e�B���g�p
'*                        ����B Execute���\�b�h�́A adasyncexecute�Ŏg�p�����
'*                        ����ꍇ�͐���������Ԃ��Ȃ��B
'*                        �R�}���h���񓯊��I�Ɏ��s���ꂽ�ꍇ�A�e�����󂯂郌�R
'*                        �[�h�̐������\�b�h����߂�Ƃ��ɂ܂��F������Ȃ��\
'*                        �������邽�߂ł���B
'* @param Parameters      �ȗ��\�B SQL �X�e�[�g�����g�ɓn���p�����[�^�[�l�B
'*                        �o�̓p�����[�^�[�����̈����œn���Ăऐ������l�͕�
'*                        ����Ȃ��B
'* @param Options         �ȗ��\�ł��BMoveRecordOptionsEnum �l���w�肷��B
'*                        Command �I�u�W�F�N�g�� CommandText �v���p�e�B��
'*                        �v���o�C�_�[���]��������@������ �̒l�B
'*                        CommandTypeEnum �l����� ExecuteOptionEnum �l�̃r�b�g
'*                        �}�X�N�l���g�p�ł���B���Ƃ��΁ACommandText �v���p�e�B
'*                        �̒l���e�L�X�g�Ƃ��ĕ]������悤ADO�Ɏw�����A�R�}���h
'*                        �e�L�X�g�̎��s���ɐ�������邷�ׂẴ��R�[�h���R�}��
'*                        �h���j�����ĕԂ��Ȃ��悤�ɂ���ꍇ�́AadCmdText ��
'*                        adExecuteNoRecords ��g�ݍ��킹�Ďg�p�ł���B
'* @return Recordset �I�u�W�F�N�g�̎Q�Ƃ܂��� Nothing
'******************************************************************************
Function Execute(Optional RecordsAffected, _
                 Optional Parameters, _
                 Optional Options As Long = -1) As ADODBExRecordset
    Dim wrap As ADODBExRecordset: Set wrap = New ADODBExRecordset

    If IsMissing(RecordsAffected) Then
        If IsMissing(Parameters) Then
            Set wrap.Origin = mOrigin.Execute(, , Options)
        Else
            Set wrap.Origin = mOrigin.Execute(, Parameters, Options)
        End If
    ElseIf IsMissing(Parameters) Then
        Set wrap.Origin = mOrigin.Execute(RecordsAffected, , Options)
    Else
        Set wrap.Origin = mOrigin.Execute(RecordsAffected, Parameters, Options)
    End If
    Set Execute = wrap
End Function

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] SQL�\�������B
'* [��  ��] SQL�̖����p�����[�^���u?�v����u��������B
'* [�Q  �l] <http://kagen88.blogspot.com/2012/12/adodbcommand.html>
'*
'* @return SQL������
'******************************************************************************
' adArray
' adBigInt
' adBinary
' adBoolean
' adBSTR
' adChapter
' adChar
' adCurrency
' adDate
' adDBDate
' adDBTime
' adDBTimeStamp
' adDecimal
' adDouble
' adEmpty
' adError
' adFileTime
' adGUID
' adIDispatch
' adInteger
' adIUnknown
' adLongVarBinary
' adLongVarChar
' adLongVarWChar
' adNumeric
' adPropVariant
' adSingle
' adSmallInt
' adTinyInt
' adUnsignedBigInt
' adUnsignedInt
' adUnsignedSmallInt
' adUnsignedTinyInt
' adUserDefined
' adVarBinary
' adVarChar
' adVariant
' adVarNumeric
' adVarWChar
' adWChar
Public Function PrintSql() As String
    Dim p As ADODBExParameter
    Dim v As Variant
    Dim i As Integer
    Dim s As String
    i = 1
    ReDim v(Me.Parameters.Count)
    For Each p In mOrigin.Parameters
        Select Case p.Type_
            '�����̓j�[�Y�ɉ����ă^�C�v��ǉ�
            Case adInteger
                v(i) = p.Value
            Case Else
                v(i) = "'" & p.Value & "'"
        End Select
        i = i + 1
    Next
    s = mOrigin.CommandText
    For i = 1 To UBound(v)
        s = Replace(s, "?", v(i), 1, 1)
    Next
    PrintSql = s
End Function