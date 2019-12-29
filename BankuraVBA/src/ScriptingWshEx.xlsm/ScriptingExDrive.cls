VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ScriptingExDrive"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Scripting.Drive�N���X�̃��b�v�E�g���N���X
'* [��  ��] Scripting.Drive�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Scripting.Drive�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Scripting.Drive�N���X�ɂ��āB
' <https://docs.microsoft.com/ja-jp/office/vba/language/reference/user-interface-help/drive-object>
' ����̃f�B�X�N �h���C�u�܂��̓l�b�g���[�N���L�̃v���p�e�B�ɃA�N�Z�X�ł��܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As Scripting.Drive
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
'* AvailableSpace �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�g�p�\�ȃf�B�X�N�e�ʁi�o�C�g�P�ʁj���擾���܂��B
'* �E�ʏ�AFreeSpace �v���p�e�B ���Ԃ��l�Ɠ���
'*   �iOS ���A�f�B�X�N�N�H�[�^�@�\���T�|�[�g���Ă���ꍇ�́A
'*     �Ⴄ�l�ɂȂ�\��������j�B
'*-----------------------------------------------------------------------------
Property Get AvailableSpace() As Variant
    AvailableSpace = mOrigin.AvailableSpace
End Property


'*-----------------------------------------------------------------------------
'* DriveLetter �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�h���C�u�����擾���܂��iC �� D �Ȃǁj�B
'*-----------------------------------------------------------------------------
Property Get DriveLetter() As String
    DriveLetter = mOrigin.DriveLetter
End Property


'*-----------------------------------------------------------------------------
'* DriveType �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�h���C�u�̎�ށB
'*-----------------------------------------------------------------------------
Property Get DriveType() As DriveTypeConst
    DriveType = mOrigin.DriveType
End Property

'*-----------------------------------------------------------------------------
'* FileSystem �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�@�C���V�X�e���̎�ށiFAT�ANTFS�ACDFS �Ȃǁj�B
'*-----------------------------------------------------------------------------
Property Get FileSystem() As String
    FileSystem = mOrigin.FileSystem
End Property

'*-----------------------------------------------------------------------------
'* FreeSpace �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�h���C�u�̋󂫗e�ʁi�o�C�g�P�ʁj���擾����B
'* �E�ʏ�AAvailableSpace �v���p�e�B ���Ԃ��l�Ɠ���
'*   �iOS ���A�f�B�X�N�N�H�[�^�@�\���T�|�[�g���Ă���ꍇ�́A
'*     �Ⴄ�l�ɂȂ�\��������j�B
'*-----------------------------------------------------------------------------
Property Get FreeSpace() As Variant
    FreeSpace = mOrigin.FreeSpace
End Property

'*-----------------------------------------------------------------------------
'* IsReady �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�f�B�X�N���g�p�\���ǂ������ׂ܂��B
'* �ECD-ROM �� DVD �f�B�X�N�Ȃǂ̏ꍇ�́A���f�B�A���}������Ă��邩�ǂ�����
'*   �m�F���邱�Ƃ��ł��܂��B
'* �E�h���C�u�̏������ł��Ă���ꍇ�́ATrue �A�ł��Ă��Ȃ��ꍇ�́AFalse�B
'*-----------------------------------------------------------------------------
Property Get IsReady() As Boolean
    IsReady = mOrigin.IsReady
End Property

'*-----------------------------------------------------------------------------
'* Path �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�h���C�u�̃p�X�B
'*-----------------------------------------------------------------------------
Property Get Path() As String
Attribute Path.VB_UserMemId = 0
    Path = mOrigin.Path
End Property

'*-----------------------------------------------------------------------------
'* RootFolder �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E���[�g�t�H���_�B
'*-----------------------------------------------------------------------------
Property Get RootFolder() As ScriptingExFolder
    Dim wrap As ScriptingExFolder: Set wrap = New ScriptingExFolder
    Set wrap.Origin = mOrigin.RootFolder()
    Set RootFolder = wrap
End Property

'*-----------------------------------------------------------------------------
'* SerialNumber �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�f�B�X�N�̃V���A���ԍ��B
'* �ECD-ROM�h���C�u�Ȃǂł́A�}������Ă��郁�f�B�A�̃V���A���i���o�[�B
'*-----------------------------------------------------------------------------
Property Get SerialNumber() As Long
    SerialNumber = mOrigin.SerialNumber
End Property

'*-----------------------------------------------------------------------------
'* ShareName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�h���C�u�̃l�b�g���[�N���L���B
'* �E�w�肵���h���C�u���l�b�g���[�N�h���C�u�łȂ��ꍇ�́A���� 0 �̕�����i�h�h�j
'*-----------------------------------------------------------------------------
Property Get ShareName() As String
    ShareName = mOrigin.ShareName
End Property

'*-----------------------------------------------------------------------------
'* TotalSize �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�h���C�u�̑S�̗̂e�ʁi�o�C�g�P�ʁj��Ԃ��B
'*-----------------------------------------------------------------------------
Property Get TotalSize() As Variant
    TotalSize = mOrigin.TotalSize
End Property

'*-----------------------------------------------------------------------------
'* VolumeName �v���p�e�B
'*
'* [��  ��]
'* �E�h���C�u�̃{�����[�����B
'*-----------------------------------------------------------------------------
Property Get VolumeName() As String
    VolumeName = mOrigin.VolumeName
End Property
Property Let VolumeName(arg As String)
    mOrigin.VolumeName = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Scripting.Drive")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************
'�Ȃ�

