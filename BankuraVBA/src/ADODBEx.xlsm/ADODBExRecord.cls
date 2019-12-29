VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExRecord"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Record�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Record�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Record�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Record�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Represents a single row of data, either from a Recordset or from the provider.
' This record could represent a database record or some other type of object
' such as a file or directory, depending upon your provider.
'
' ���R�[�h�Z�b�g�܂��̓v���o�C�_�[����̃f�[�^�̒P��s��\���B
' ���̃��R�[�h�́A�v���o�C�_�[�ɉ����āA�f�[�^�x�[�X���R�[�h�܂��̓t�@�C����
' �f�B���N�g���Ȃǂ̑��̃^�C�v�̃I�u�W�F�N�g��\���ꍇ������B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Record
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
'* �E���̃v���p�e�B�́ARecord �I�u�W�F�N�g�����Ă���ꍇ�ɂ͒l�̐ݒ肨���
'*   �擾���\�ŁA�ڑ�������܂��͊J���Ă��� Connection �I�u�W�F�N�g�̎Q�Ƃ�
'*   �i�[�ł���B
'*   Record �I�u�W�F�N�g���J���Ă���ꍇ�͒l�̎擾�̂݉\�ŁA�J���Ă���
'*   Connection �I�u�W�F�N�g�̎Q�Ƃ��i�[����Ă���B
'* �EConnection �I�u�W�F�N�g�́AURL ���� Record �I�u�W�F�N�g���J���ꂽ�Ƃ���
'*   �ÖٓI�ɍ쐬�����B
'*   �����́A�J���Ă��� Connection �I�u�W�F�N�g�� Record ���J���ɂ́A
'*   Connection �I�u�W�F�N�g�����̃v���p�e�B�ɑ�����邩�A�܂��� Connection
'*   �I�u�W�F�N�g�� Open ���\�b�h�Ăяo���̃p�����[�^�[�Ƃ��Ďg�p����B
'*   record��������record�܂���recordset����J�����ꍇ�́A���̃��R�[�h�܂���
'*   recordset�I�u�W�F�N�g��Connection�I�u�W�F�N�g�Ɏ����I�Ɋ֘A�t������B
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
'* Fields �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�P�ȏ�̗�i�t�B�[���h�j��\���I�u�W�F�N�g��ԋp����B
'*-----------------------------------------------------------------------------
Property Get Fields() As ADODBExFields
Attribute Fields.VB_UserMemId = 0
    Dim wrap As ADODBExFields: Set wrap = New ADODBExFields
    Set wrap.Origin = mOrigin.Fields
    Set Fields = wrap
End Property

'*-----------------------------------------------------------------------------
'* Mode �v���p�e�B
'*
'* [��  ��]
'* �E�g�p�\�ȃf�[�^�ύX�����������B
'*   Record �I�u�W�F�N�g�̊���l�� adModeRead �B
'* �E���̃v���p�e�B�́A�I�u�W�F�N�g�����Ă���Ƃ��͓ǂݎ��/�������݉\�ŁA
'*   �I�u�W�F�N�g���J���Ă���Ƃ��͓ǂݎ���p�ɂȂ�B
'*-----------------------------------------------------------------------------
Property Get Mode() As ConnectModeEnum
    Mode = mOrigin.Mode
End Property
Property Let Mode(arg As ConnectModeEnum)
    mOrigin.Mode = arg
End Property

'*-----------------------------------------------------------------------------
'* ParentURL �v���p�e�B
'*
'* [��  ��]
'* �E���݂� Record �I�u�W�F�N�g�̐e Record ��������� URL ������������B
'* �EParentURL �v���p�e�B�́A Record �I�u�W�F�N�g���J�����߂Ɏg�p�����\�[�X
'*   �Ɉˑ�����B
'*   ���Ƃ��΁A ActiveConnection �v���p�e�B�ɂ���ĎQ�Ƃ����f�B���N�g���̑���
'*   �p�X���܂ރ\�[�X���g�p���� Record ���J�����Ƃ��ł���B
'* �E�����ŁA"second" �� "first" �̉��̃t�H���_�[�ł���Ƃ���B
'*   Record �I�u�W�F�N�g���J���ɂ́A���̂悤�ɂ���B
'*       Record.ActiveConnection = "https://first"
'*       Record.Open "second"
'*   ���̎��_�ŁA parenturl�v���p�e�B�̒l�� "https://first" �ŁA
'*   ActiveConnection�Ɠ����ł���B
'* �E�\�[�X�ɂ́A"https://first/second" �Ȃǂ̐�� URL ���w�肷�邱�Ƃ��ł���B
'*   parenturl�v���p�e�B�́A��L��https://first���x���� "" �ł���B
'*   parenturl�v���p�e�B�́A"https://first"�A��� "�b" �̃��x���ł���B
'* �E���̂悤�ȏꍇ�A���̃v���p�e�B�� Null �l�ɂȂ�B
'*   �E���݂̃��R�[�h�ɐe���Ȃ��ꍇ ( Record �I�u�W�F�N�g���f�B���N�g���̃��[�g
'*     ��\���ꍇ�Ȃ�)
'*   �ERecord �I�u�W�F�N�g�� URL �Ŏw��ł��Ȃ��G���e�B�e�B�ł���ꍇ
'* �E���̃v���p�e�B�͒l�̎擾�̂݉\�
'* �E[!����] ���̃v���p�e�B�́AMicrosoft OLE DB Provider for Internet Publishing
'*   �Ȃǂ̃h�L�������g �\�[�X �v���o�C�_�[�ł̂݃T�|�[�g�����B
'* �E[!����] http �X�L�[�����g�p���Ă��� URL �́AMicrosoft OLE DB Provider for
'*   Internet Publishing �������I�ɌĂяo���B
'* �E[!����] ���݂̃��R�[�h�� ADO Recordset �̃f�[�^ ���R�[�h���܂܂�Ă���
'*   �ꍇ�A ParentURL �v���p�e�B�ɃA�N�Z�X����ƁAURL ���擾�ł��Ȃ����Ƃ�����
'*   ���s���G���[����������B
'*-----------------------------------------------------------------------------
Property Get ParentURL() As String
    ParentURL = mOrigin.ParentURL
End Property
Property Let ParentURL(arg As String)
    mOrigin.ParentURL = arg
End Property

'*-----------------------------------------------------------------------------
'* Properties �v���p�e�B
'*
'* [��  ��]
'* �ECommand�ɐݒ肳��Ă���Properties�I�u�W�F�N�g���擾����B
'*-----------------------------------------------------------------------------
Property Get Properties() As ADODBExProperties
    Dim wrap As ADODBExProperties: Set wrap = New ADODBExProperties
    Set wrap.Origin = mOrigin.Properties
    Set Properties = wrap
End Property
Property Set Properties(arg As ADODBExProperties)
    Set mOrigin.Properties = arg.Origin
End Property

'*-----------------------------------------------------------------------------
'* RecordType �v���p�e�B
'*
'* [��  ��]
'* �ERecord �I�u�W�F�N�g�̎�ނ������B
'*-----------------------------------------------------------------------------
Property Get RecordType() As RecordTypeEnum
    RecordType = mOrigin.RecordType
End Property
Property Let RecordType(arg As RecordTypeEnum)
    mOrigin.RecordType = arg
End Property

'*-----------------------------------------------------------------------------
'* Source �v���p�e�B
'*
'* [��  ��]
'* �ERecord �ŕ\�����f�[�^�\�[�X�܂��̓I�u�W�F�N�g�������B
'* �ESource �v���p�e�B�́ARecord �I�u�W�F�N�g�� Open ���\�b�h�� Source ������
'*   �Ԃ��B
'*   ���̃v���p�e�B�ɂ͐�� URL �܂��͑��� URL �̕�������i�[�ł���B
'*   ��� URL ���g�p����ƁA ActiveConnection �v���p�e�B��ݒ肹���ɁA����
'*   Record �I�u�W�F�N�g���J�����Ƃ��ł���B
'*   ���̏ꍇ�A�Öق� Connection �I�u�W�F�N�g���쐬�����B
'* �ESource �v���p�e�B�ɂ́A���ɊJ���Ă��� Recordset �ւ̎Q�Ƃ��i�[�ł��A����
'*   �Q�Ƃ� Recordset ���̌��݂̍s��\�� Record �I�u�W�F�N�g���J���B
'* �E�܂��A Source �v���p�e�B�ɂ́A�v���o�C�_�[���� 1 �̃f�[�^�s��Ԃ� Command
'*   �I�u�W�F�N�g�ւ̎Q�Ƃ��i�[�ł���B
'* �EActiveConnection �v���p�e�B���ݒ肷��ꍇ�́A Source �v���p�e�B�͂��̐ڑ�
'*   �͈͓��ɑ��݂��铯���I�u�W�F�N�g���w���Ă���K�v������B���Ƃ��΁A�c��
'*   �[�\���̖��O��Ԃł́A Source �v���p�e�B�ɐ�� URL ���i�[����Ă���ꍇ�A
'*   �ڑ�������� URL �Ŏw�肳�ꂽ�m�[�h�͈͓̔��ɑ��݂���m�[�h���w���Ă���K�v
'*   ������B
'*   Source �v���p�e�B�ɑ��� URL ���i�[����Ă���ꍇ�A ActiveConnection �v���p
'*   �e�B�Őݒ肳�ꂽ�R���e�L�X�g���ł̂ݗL���ɂȂ�B
'* �ESource �v���p�e�B�́A Record �I�u�W�F�N�g�����Ă���ꍇ�͒l�̎擾�����
'*   �ݒ肪�\�ŁA Record �I�u�W�F�N�g���J���Ă���ꍇ�͒l�̎擾�̂݉\�B
'* �E[!����] http �X�L�[�}���g�p���Ă��� URL �͎����I�� Microsoft OLE DB
'*   Provider for Internet Publishing ���Ăяo���B
'*-----------------------------------------------------------------------------
Property Get Source() As Variant
    If IsObject(mOrigin.Source) Then
        Set Source = mOrigin.Source
    Else
        Source = mOrigin.Source
    End If
End Property
Property Let Source(arg As Variant)
    If IsObject(arg) Then
        Set mOrigin.Source = arg
    Else
        mOrigin.Source = arg
    End If
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
Property Get State() As ObjectStateEnum
    State = mOrigin.State
End Property
Property Let State(arg As ObjectStateEnum)
    mOrigin.State = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("ADODB.Record")
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
'*          Record�̏ꍇ�ACopyRecord�ADeleteRecord�AMoveRecord�A�܂��� Open��
'*          �Ō�̔񓯊��Ăяo�������~����郁�\�b�h�
'*
'******************************************************************************
Sub Cancel()
    Call mOrigin.Cancel
End Sub

'******************************************************************************
'* [�T  �v] CloseR���\�b�h
'* [��  ��] Close�̃��b�p�[���\�b�h�B
'*          �J���Ă���I�u�W�F�N�g����т���Ɋ֘A���邷�ׂẴI�u�W�F�N�g��
'*          ����B
'*
'*          �֘A���邷�ׂẴV�X�e�� ���\�[�X���������ꍇ�Ɏg�p����B
'*          �I�u�W�F�N�g����Ă�����������͍폜���ꂸ�A�v���p�e�B�ݒ��ύX
'*          ���Ă�����x�J�����Ƃ��ł���B
'*          �I�u�W�F�N�g�����������犮�S�ɍ폜����ɂ́A�I�u�W�F�N�g�������
'*          �ɁA�I�u�W�F�N�g�ϐ���Nothing�ɐݒ肷��B
'*          �I�u�W�F�N�g�����ƁA�֘A����f�[�^�A����уf�[�^�ɑ΂��邻��
'*          �I�u�W�F�N�g����̔r���A�N�Z�X���A���ׂĉ�������B
'*          ��� Open ���\�b�h���Ăяo���A���������ŁA�܂��͑�����ύX���āA
'*          �I�u�W�F�N�g���ēx�J�����Ƃ��ł���B
'*
'******************************************************************************
Sub CloseR()
    Call mOrigin.Close
End Sub

'******************************************************************************
'* [�T  �v] CopyRecord���\�b�h
'* [��  ��] CopyRecord�̃��b�p�[���\�b�h�B
'*          Record �ŕ\�����G���e�B�e�B��ʂ̏ꏊ�ɃR�s�[����B
'*          Source �� Destination �̒l�͈قȂ��Ă���K�v������B
'*          �l���������ꍇ�A���s���G���[����������B
'*          �T�[�o�[���A�p�X���A���\�[�X���̂����A���Ȃ��Ƃ� 1 ���قȂ��Ă���
'*          �K�v������B
'*          Source �̎q (�T�u�f�B���N�g���Ȃ�) �͂��ׂāAadCopyNonRecursive ��
'*          �w�肳��Ă���ꍇ�������A���̂Ƃ���ɃR�s�[�����B
'*          �T�u�f�B���N�g�����R�s�[����ꍇ�́ADestination �� Source �̃T�u�f
'*          �B���N�g�����w�肵�Ȃ����ƁB
'*          �w�肵���ꍇ�̓R�s�[���삪�������Ȃ��B
'*          Destination �Ɋ����̃G���e�B�e�B (�t�@�C���A�f�B���N�g���Ȃ�) ��
'*          �w�肷��ꍇ�AadCopyOverWrite ���w�肵�Ă��Ȃ���΁A���̃��\�b�h��
'*          ���s����B
'*          adCopyOverWrite�I�v�V������T�d�Ɏg�p���邱�ơ���Ƃ��Τ�t�@�C��
'*          ���f�B���N�g���ɃR�s�[����Ƃ��ɂ��̃I�v�V�������w�肷��Ƥ�f�B���N
'*          �g�����폜���꤃t�@�C���ɒu����������
'*          [!����] http �X�L�[�����g�p���Ă��� URL �́AMicrosoft OLE DB
'*          Provider for Internet Publishing �������I�ɌĂяo���B
'*
'* @param Source      �ȗ��\�B�R�s�[���̃G���e�B�e�B (�t�@�C���A�f�B���N�g��
'*                    �Ȃ�) ���w�肷�� URL�B
'*                    Source ���ȗ������ꍇ�A�܂��͋�̕�������w�肵��
'*                    �ꍇ�A���݂� Record �ŕ\����Ă���t�@�C���܂��̓f�B���N
'*                    �g�����R�s�[�����B
'* @param Destination �ȗ��\�BSource �̃R�s�[��̏ꏊ���w�肷�� URL�B
'* @param UserName    �ȗ��\�BDestination �ւ̃A�N�Z�X�����ݒ肳��Ă���
'*                    �ꍇ�A�A�N�Z�X���������[�U�[ID�B
'* @param Password    �ȗ��\�BUserName ���m�F���邽�߂̃p�X���[�h�B
'* @param Options     �ȗ��\�B���̃��\�b�h�̓�����w��B
'* @param Async       �ȗ��\�B�u�[���^ ( Boolean ) �̒l���w��B�l�� True ��
'*                    �ꍇ�A���̓���͔񓯊��Ŏ��s�����B
'* @return �ʏ��Destination �̒l���ԋp�B
'*         �������A���ۂɕԂ����l�̓v���o�C�_�[�ɂ���ĈقȂ�B
'******************************************************************************
Function CopyRecord(Optional Source As String, _
                    Optional Destination As String, _
                    Optional UserName As String, _
                    Optional Password As String, _
                    Optional Options As CopyRecordOptionsEnum = adCopyUnspecified, _
                    Optional Async As Boolean = False) As String
    CopyRecord = mOrigin.CopyRecord(Source, Destination, UserName, Password, Options, Async)
End Function
                    
'******************************************************************************
'* [�T  �v] DeleteRecord���\�b�h
'* [��  ��] DeleteRecord�̃��b�p�[���\�b�h�B
'*          Record �ŕ\�����G���e�B�e�B���폜����B
'*          ���̃��\�b�h�̏I����ARecord �ŕ\����Ă���I�u�W�F�N�g�ɑ΂��鑀��
'*          �����s����ꍇ������B
'*          DeleteRecord ���Ăяo������� Record �����K�v������B
'*          ����́A�v���o�C�_�[���f�[�^ �\�[�X�� Record �����X�V���邩�ɂ��A
'*          Record �̓��삪�\���ł��Ȃ��Ȃ邱�Ƃ����邽�߂ł���B
'*          ���̃��R�[�h�����R�[�h�Z�b�g����擾���ꂽ�ꍇ�A���̑���̌��ʂ͂���
'*          �Ƀ��R�[�h�Z�b�g�ɔ��f����Ȃ��B
'*          recordset ���ŐV�̏��ɍX�V����ɂ́A���R�[�h�Z�b�g�������������
'*          ����J���������A�܂���recordset�̍ăN�G�������s���邩�A Update���\�b
'*          �h��Resync���\�b�h�����s����B
'*          [!����] http �X�L�[�����g�p���Ă��� URL �́AMicrosoft OLE DB
'*          Provider for Internet Publishing �������I�ɌĂяo���B
'*
'* @param Source �ȗ��\�B�폜����G���e�B�e�B (�t�@�C���A�f�B���N�g���Ȃ�) ��
'*               �\�� URL�BSource ���ȗ����邩�A�܂��͋�̕�������w�肵���ꍇ�A
'*               ���� Record �ŕ\����Ă���G���e�B�e�B���폜�����B
'*               Record ���R���N�V���� ���R�[�h (�f�B���N�g���ȂǁARecordType
'*               �� adCollectionRecord �ł������) �ł���ꍇ�́A���ׂĂ̎q
'*               (�T�u�f�B���N�g���Ȃ�) ���폜�����B
'* @param Async  �ȗ��\�B�u�[���^ ( Boolean ) �̒l���w�肷��B
'*               True �̂Ƃ��́A�폜���삪�񓯊��Ŏ��s����邱�Ƃ������B
'* @return �Ԃ����l�̓v���o�C�_�[�ɂ���ĈقȂ�B
'******************************************************************************
Function DeleteRecord(Optional Source As String, _
                      Optional Async As Boolean) As String

    DeleteRecord = mOrigin.DeleteRecord(Source, Async)
End Function


'******************************************************************************
'* [�T  �v] GetChildren���\�b�h
'* [��  ��] GetChildren�̃��b�p�[���\�b�h�B
'*          �e�s���R���N�V���� Record �̎q��\�� Recordset ��ԋp����B
'*          �Ԃ���� Recordset �ɂǂ̂悤�ȗ񂪂��邩�́A�v���o�C�_�[�ɂ����
'*          ���܂�B���Ƃ��΁A�h�L�������g �\�[�X �v���o�C�_�[�́A��Ƀ��\�[�X
'*          �� Recordset ��Ԃ��B
'*
'* @return �e�s�����݂� Record �I�u�W�F�N�g�̎q��\�� Recordset �I�u�W�F�N�g�B
'*         ���Ƃ��΁A�f�B���N�g����\�� Record �̎q�́A�e�f�B���N�g���Ɋ܂܂��
'*         �t�@�C���ƃT�u�f�B���N�g���ƂȂ�B
'******************************************************************************
Function GetChildren() As ADODBExRecordset
    Dim wrap As ADODBExRecordset: Set wrap = New ADODBExRecordset
    Set wrap.Origin = mOrigin.GetChildren
    Set GetChildren = wrap
End Function

'******************************************************************************
'* [�T  �v] MoveRecord���\�b�h
'* [��  ��] MoveRecord�̃��b�p�[���\�b�h�B
'*          Record �ŕ\�����G���e�B�e�B��ʂ̏ꏊ�Ɉړ�����B
'*          Source �� Destination �̒l�͈قȂ��Ă���K�v������B
'*          �l���������ꍇ�A���s���G���[����������B
'*          �T�[�o�[���A�p�X���A����у��\�[�X���̂����A���Ȃ��Ƃ� 1 ���قȂ�
'*          �Ă���K�v������B
'*          Internet Publishing Provider ���g�p���Ĉړ������t�@�C���ł́A
'*          Options �œ��Ɏw��̂Ȃ�����A�ړ������t�@�C�����̂��ׂẴn�C�p
'*          �[�e�L�X�g�����N���X�V�����B
'*          Destination �Ɋ����̃I�u�W�F�N�g (���Ƃ��΁A�t�@�C���܂��̓f�B���N
'*          �g��) ���w�肷��ꍇ�AadMoveOverWrite ���w�肳��Ă��Ȃ��ƁA����
'*          ���\�b�h�͎��s����B
'*          [!����] adMoveOverWrite �I�v�V�����͏\���ɒ��ӂ��Ďg�p���邱�ƁB
'*          ���Ƃ��΁A�t�@�C�����f�B���N�g���Ɉړ�����Ƃ��ɂ��̃I�v�V�������w
'*          �肵�Ă���ƁA�ړ���̃f�B���N�g���� "�폜" ����A�ړ����̃t�@�C��
'*          �ɒu����������B
'*          ���̑���̏I����A Record �I�u�W�F�N�g�̈ꕔ�̑��� ( ParentURL
'*          �v���p�e�B�Ȃ�) �͍X�V����Ȃ��Ȃ�B
'*          Record �I�u�W�F�N�g�̃v���p�e�B���X�V����ɂ́A Record ����A��
'*          �̃t�@�C���܂��̓f�B���N�g�����ړ����ꂽ�ꏊ�� URL �ł�����x�J��
'*          ���ƁB
'*          Recordset ����擾���� Record �̏ꍇ�A�t�@�C���܂��̓f�B���N�g����
'*          �ړ���̏ꏊ�́A Recordset �ɂ����ɂ͔��f����Ȃ��B
'*          ���f����ɂ́A Recordset ������������Ă�����x�J�����ƁB
'*          [!����] http �X�L�[�����g�p���Ă��� URL �́AMicrosoft OLE DB
'*          Provider for Internet Publishing �������I�ɌĂяo���B
'*
'* @param Source      �ȗ��\�B�ړ����� Record ������ URL�B
'*                    Source ���ȗ����邩�A�܂��͋󕶎�����w�肷��ƁA����
'*                    Record �ŕ\�����I�u�W�F�N�g���ړ�����B
'*                    ���Ƃ��΁ARecord ���t�@�C����\���Ă���ꍇ�́A�t�@�C��
'*                    �̓��e�� Destination �Ŏw�肵���ꏊ�Ɉړ������B
'* @param Destination �ȗ��\�B Source �̈ړ���̏ꏊ���w�肷�� URL�B
'* @param UserName    �ȗ��\�B Destination �ւ̃A�N�Z�X�����ݒ肳��Ă���
'*                    �ꍇ�A�A�N�Z�X���������[�U�[ ID�B
'* @param Password    �ȗ��\�B UserName ���m�F���邽�߂̃p�X���[�h�B
'* @param Options     �ȗ��\�B���̃��\�b�h�̓�����w��B
'* @param Async       �ȗ��\�B �u�[���l�BTrue�̏ꍇ�A���̑���͔񓯊��ł���
'*                    ���Ƃ��w��B
'* @return �ʏ��Destination �̒l���ԋp�B
'*         �������A���ۂɕԂ����l�̓v���o�C�_�[�ɂ���ĈقȂ�B
'******************************************************************************
Function MoveRecord(Optional Source As String, _
                    Optional Destination As String, _
                    Optional UserName As String, _
                    Optional Password As String, _
                    Optional Options As MoveRecordOptionsEnum = adMoveUnspecified, _
                    Optional Async As Boolean = False) As String
    MoveRecord = mOrigin.MoveRecord(Source, Destination, UserName, Password, Options, Async)
End Function


'******************************************************************************
'* [�T  �v] OpenR���\�b�h
'* [��  ��] Open�̃��b�p�[���\�b�h�B
'*          ������ Record �I�u�W�F�N�g���J�����A�܂��� Record �ŕ\�����V����
'*          �A�C�e�� (�t�@�C���A�f�B���N�g���Ȃ�) ���쐬����B
'*          Source �ɂͤ���̒l���w��ł���
'*            �EURL�BURL �̃v���g�R���� http �̏ꍇ�A����ł̓C���^�[�l�b�g
'*              �v���o�C�_�[���Ăяo�����BURL �����s�\�X�N���v�g (�g���q
'*              �� .ASP �̃y�[�W�Ȃ�) ���܂ރm�[�h���w���Ă���ꍇ�A����ł͎�
'*              �s���ꂽ�R���e���c�ł͂Ȃ��A���̃\�[�X���܂� Record ���J�����B
'*              ���̓���� Options �������g�p���ďC������B
'*            �ERecord �I�u�W�F�N�g�B�ʂ� Record ����J���ꂽ Record �I�u�W�F�N
'*              �g�́A���� Record �I�u�W�F�N�g�𕡐�����B
'*            �ECommand �I�u�W�F�N�g�B�J���ꂽ Record �I�u�W�F�N�g�́A Command
'*              �����s���邱�Ƃɂ���ĕԂ��ꂽ�P��̍s��\���B
'*              ���ʂɕ����̍s���܂܂��ꍇ�A���R�[�h�ɂ͍ŏ��̍s�̓��e������A
'*              Errors �R���N�V�����ɃG���[���ǉ�����邱�Ƃ�����B
'*            �ESQL SELECT �X�e�[�g�����g�B�J���ꂽ Record �I�u�W�F�N�g�́A����
'*              ��̓��e�����s���邱�Ƃɂ���ĕԂ��ꂽ�P��̍s��\���B
'*              ���ʂɕ����̍s���܂܂��ꍇ�A���R�[�h�ɂ͍ŏ��̍s�̓��e������A
'*              Errors �R���N�V�����ɃG���[���ǉ�����邱�Ƃ�����B
'*            �E�e�[�u�����
'*          Record �I�u�W�F�N�g���AURL �ŃA�N�Z�X�ł��Ȃ��G���e�B�e�B (�f�[�^
'*          �x�[�X����h������ Recordset �̍s�Ȃ�) ��\���ꍇ�A ParentURL
'*          �v���p�e�B�̒l�A����� adRecordURL �萔�ŃA�N�Z�X����t�B�[���h
'*          �̒l�͂������ Null �ɂȂ�B
'*          [!����] http �̌n���g�p���Ă��� URL �́AMicrosoft OLE DB
'*          Provider for Internet Publishing �������I�ɌĂяo���B
'*
'* @param Source           �ȗ��\�BRecord �I�u�W�F�N�g�ŕ\�����G���e�B�e�B
'*                         �� URL�A Command �A�J���ꂽ Recordset �܂��͕ʂ�
'*                         Record �I�u�W�F�N�g�ASQL SELECT �X�e�[�g�����g���܂�
'*                         ������A�܂��̓e�[�u������\���l���w��B
'* @param ActiveConnection �ȗ��\�B�ڑ�������܂��͊J���ꂽ Connection �I�u
'*                         �W�F�N�g�B
'* @param Mode             �ȗ��\�B���ʂ� Record �I�u�W�F�N�g�̃A�N�Z�X���[�h
'*                         �� ConnectModeEnum �l�Ŏw��B
'* @param CreateOptions    �ȗ��\�B�����̃t�@�C���܂��̓f�B���N�g�����J�����A
'*                         �V�����t�@�C���܂��̓f�B���N�g�����쐬���邩��
'*                         RecordCreateOptionsEnum �l�Ŏw��B
'*                         ����l�̏ꍇ�A�A�N�Z�X ���[�h�� Mode �v���p�e�B����
'*                         �擾�����B
'*                         ���̃p�����[�^�[�́ASource �p�����[�^�[�� URL ����
'*                         �܂�Ă��Ȃ��Ɩ��������B
'* @param Options          �ȗ��\�BRecord ���J���Ƃ��̃I�v�V������
'*                         RecordOpenOptionsEnum �l�Ŏw��B�����̒l�͑g�ݍ�
'*                         �킹�邱�Ƃ��\�B
'* @param UserName         �ȗ��\�BSource �ւ̃A�N�Z�X�����ݒ肳��Ă���ꍇ
'*                         �A�N�Z�X���������[�U�[ ID �B
'* @param Password         �ȗ��\�BUserName ���m�F���邽�߂̃p�X���[�h�B
'*
'******************************************************************************
Sub OpenR(Optional Source, _
          Optional ActiveConnection, _
          Optional Mode As ConnectModeEnum = adModeUnknown, _
          Optional CreateOptions As RecordCreateOptionsEnum = adFailIfNotExists, _
          Optional Options As RecordOpenOptionsEnum = adOpenRecordUnspecified, _
          Optional UserName As String, _
          Optional Password As String)
          
    If IsMissing(Source) Then
        If IsMissing(ActiveConnection) Then
            Call mOrigin.Open(, , Mode, CreateOptions, Options, UserName, Password)
        Else
            Call mOrigin.Open(, ActiveConnection, Mode, CreateOptions, Options, UserName, Password)
        End If
    Else
        If IsMissing(ActiveConnection) Then
            Call mOrigin.Open(Source, , Mode, CreateOptions, Options, UserName, Password)
        Else
            Call mOrigin.Open(Source, ActiveConnection, Mode, CreateOptions, Options, UserName, Password)
        End If
    End If
End Sub