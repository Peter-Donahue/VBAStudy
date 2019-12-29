VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ADODBExError"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] ADODB.Error�N���X�̃��b�v�E�g���N���X
'* [��  ��] ADODB.Error�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          ADODB.Error�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' ADODB.Error�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/previous-versions/ms805115%28v%3dmsdn.10%29>
' <https://docs.microsoft.com/ja-jp/sql/ado/reference/ado-api/connection-object-ado?view=sql-server-2017>
' <https://docs.microsoft.com/ja-jp/office/client-developer/access/desktop-database-reference/ado-api-reference>
'
' Contains details about data access errors that pertain to a single operation
' involving the provider.
'
' �v���o�C�_�[���֗^����P��̑���Ɋ֘A����f�[�^�A�N�Z�X�G���[�Ɋւ���ڍׂ�
' �܂܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As ADODB.Error
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
'* Description �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�G���[�̓��e��\��������̒l��ԋp����B
'* �EDescription �v���p�e�B�́A�G���[�̊ȒP�Ȑ������擾���邽�߂Ɏg���B
'*   �v���O�����őΏ��ł��Ȃ��G���[��܂��͏������邱�Ƃ��]�܂����Ȃ��G���[��
'*   ���̃v���p�e�B�̓��e��\�����ă��[�U�[�Ɍx������
'*   ������ͤADO �܂��̓v���o�C�_�[����n�����
'* �E�v���o�C�_�[�́A����̃G���[ �e�L�X�g�� ADO �ɓn���B
'*   ADO �́A�󂯎�����v���o�C�_�[ �G���[�܂��͌x�����Ƃ� Error �I�u�W�F�N
'*   �g�� Errors �R���N�V�����ɒǉ�����B
'*   �v���o�C�_�[���n���G���[���g���[�X����ɂ́A Errors �R���N�V�������
'*   ����B
'*-----------------------------------------------------------------------------
Property Get Description() As String
Attribute Description.VB_UserMemId = 0
    Description = mOrigin.Description
End Property

'*-----------------------------------------------------------------------------
'* HelpContext �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�w���v�t�@�C���̃g�s�b�N�̃R���e�L�X�gID��ԋp����B
'* �EHelpFile �v���p�e�B�Ńw���v �t�@�C�����w�肳��Ă���ꍇ�AHelpContext
'*   �v���p�e�B���g���ē���̃w���v �g�s�b�N�������I�ɕ\���ł���B
'*   �Y������w���v �g�s�b�N���Ȃ��ꍇ�AHelpContext �v���p�e�B�� 0 ��Ԃ��A
'*   HelpFile �v���p�e�B�͒��� 0 �̕����� ("") ��Ԃ��B
'*-----------------------------------------------------------------------------
Property Get HelpContext() As Long
    HelpContext = mOrigin.HelpContext
End Property

'*-----------------------------------------------------------------------------
'* HelpFile �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�w���v�t�@�C���ւ̊��S�ȃp�X��ԋp����B
'* �EHelpFile �v���p�e�B�Ńw���v �t�@�C�����w�肳��Ă���ꍇ�AHelpContext
'*   �v���p�e�B���g���ē���̃w���v �g�s�b�N�������I�ɕ\���ł���B
'*   �Y������w���v �g�s�b�N���Ȃ��ꍇ�AHelpContext �v���p�e�B�� 0 ��Ԃ��A
'*   HelpFile �v���p�e�B�͒��� 0 �̕����� ("") ��Ԃ��B
'*-----------------------------------------------------------------------------
Property Get HelpFile() As String
    HelpFile = mOrigin.HelpFile
End Property

'*-----------------------------------------------------------------------------
'* NativeError �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�w�肳�ꂽ Error �I�u�W�F�N�g�Ńv���o�C�_�[�ŗL�̃G���[�R�[�h�������B
'* �ENativeError �v���p�e�B�́A����� Error �I�u�W�F�N�g�́A�f�[�^�x�[�X�ŗL��
'*   �G���[�����擾���邽�߂Ɏg�p����B
'*   ���Ƃ��΁AMicrosoft ODBC Provider for OLE DB �� Microsoft SQL Server �f�[
'*   �^�x�[�X���g���ꍇ�ASQL Server ���瑗�M���ꂽ�l�C�e�B�u�G���[�R�[�h�́A
'*   ODBC �� ODBC Provider ���o�R���� ADO �� NativeError �v���p�e�B�ɓn�����B
'*-----------------------------------------------------------------------------
Property Get NativeError() As Long
    NativeError = mOrigin.NativeError
End Property

'*-----------------------------------------------------------------------------
'* Number �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EError �I�u�W�F�N�g����ӂɎ��ʂ��鐔�l�������B
'* �EErrorValueEnum �萔�̂����ꂩ�ɑΉ�����l��ԋp����
'* �ENumber �v���p�e�B�ͤ���������G���[�𒲂ׂ邽�߂Ɏg�p����
'*   �v���p�e�B�̒l�ͤ�G���[�����ɑΉ�������ӂȐ��l�ł���
'* �EErrors�R���N�V�����́A16�i�`���i0x80004005�Ȃǁj�܂���long�l�i2147467259
'*   �Ȃǁj��HRESULT��Ԃ��B
'*   ������HRESULT�́AOLE DB�܂���OLE���̂Ȃǂ̊�b�ƂȂ�R���|�[�l���g�ɂ�
'*   ���Ĕ�������\��������B
'*-----------------------------------------------------------------------------
Property Get Number() As Long
    Number = mOrigin.Number
End Property

'*-----------------------------------------------------------------------------
'* Source �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�G���[�̔������̃I�u�W�F�N�g�܂��̓A�v���P�[�V�����̖��O�������B
'* �E�G���[�������������̃I�u�W�F�N�g�܂��̓A�v���P�[�V�����̖��O���m�F�����
'*   �́A error�I�u�W�F�N�g��Source�v���p�e�B���g�p����B
'*   ����́A�I�u�W�F�N�g�̃N���X���܂��̓v���O���� ID �ł���\��������B
'*   ADO �̃G���[�ɂ��ẮA�v���p�e�B�̒l�� **ADODB. *** (objectname) �B
'*   objectname�́A�G���[�𔭐��������I�u�W�F�N�g�̖��O�ł���B
'*   ADOX ����� ADO MD �̏ꍇ�A�l�͂��ꂼ�� *adox. * * * objectname�����
'*   *adomd.nethttp * * objectname�ƂȂ�B
'* �EError �I�u�W�F�N�g�� Source �v���p�e�B�A Number �v���p�e�B�A�����
'*   Description �v���p�e�B�̃G���[���Ɋ�Â��āA�G���[��K�؂ɏ������邽��
'*   �̃R�[�h���������Ƃ��ł���B
'* �EError �I�u�W�F�N�g�� Source �v���p�e�B�͓ǂݎ���p�B
'*-----------------------------------------------------------------------------
Property Get Source() As String
    Source = mOrigin.Source
End Property

'*-----------------------------------------------------------------------------
'* SQLState �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E����� Error �I�u�W�F�N�g�� SQL ��Ԃ������B
'* �EANSI SQL �W���ɏ������A�G���[�R�[�h������ 5 �����̕�����^�̒l��Ԃ��B
'* �ESQL �X�e�[�g�����g�̏������ɃG���[�����������ꍇ�ɁA�v���o�C�_�[���Ԃ�
'*   5 �����̃G���[�R�[�h���擾����ɂ� SQLState �v���p�e�B���g�p����B
'*   ���Ƃ��΁AMicrosoft OLE DB Provider for ODBC �� Microsoft SQL Server �f�[
'*   �^�x�[�X�Ƌ��Ɏg�p����ꍇ�AODBC �ɌŗL�̃G���[�A�܂��� Microsoft SQL
'*   Server �ɋN������G���[�Ɋ�Â��āAODBC ���� SQL ��Ԃ̃G���[�R�[�h������
'*   ���ꂽ��AODBC �G���[�Ƀ}�b�v�����B
'*   �����̃G���[�R�[�h�� ANSI SQL �W���ŋK�肳��Ă��邪�A�������@�̓f�[�^
'*   �\�[�X�ɂ���ĈقȂ�ꍇ������B
'*-----------------------------------------------------------------------------
Property Get SQLState() As String
    SQLState = mOrigin.SQLState
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("ADODB.Error")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub