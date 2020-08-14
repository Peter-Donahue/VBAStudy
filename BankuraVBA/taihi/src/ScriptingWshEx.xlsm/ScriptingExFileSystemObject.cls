VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ScriptingExFileSystemObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Scripting.FileSystemObject�N���X�̃��b�v�E�g���N���X
'* [��  ��] Scripting.FileSystemObject�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Scripting.FileSystemObject�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Scripting.FileSystemObject�N���X�ɂ��āB
' <https://docs.microsoft.com/ja-jp/office/vba/language/reference/user-interface-help/filesystemobject-object>
' �R���s���[�^�[�̃t�@�C���V�X�e���ւ̃A�N�Z�X��񋟂��܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As Scripting.FileSystemObject
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
'* Drives �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�g�p�\�ȗe�ʂ��擾���擾����B
'*-----------------------------------------------------------------------------
Property Get Drives() As ScriptingExDrives
    Dim wrap As ScriptingExDrives: Set wrap = New ScriptingExDrives
    Set wrap.Origin = mOrigin.Drives
    Set Drives = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("Scripting.FileSystemObject")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] BuildPath ���\�b�h
'* [��  ��] BuildPath �̃��b�p�[���\�b�h�B
'*          �����̃p�X����і��O����p�X���쐬���܂��
'*
'* @param Path
'* @param Name
'* @return �p�X
'*
'******************************************************************************
Function BuildPath(Path As String, Name As String) As String
    BuildPath = mOrigin.BuildPath(Path, Name)
End Function

'******************************************************************************
'* [�T  �v] CopyFile ���\�b�h
'* [��  ��] CopyFile �̃��b�p�[���\�b�h�B
'*         �t�@�C�����R�s�[���܂��
'*
'* @param Source
'* @param Destination
'* @param OverWriteFiles �ȗ��\�B
'*
'******************************************************************************
Sub CopyFile(Source As String, Destination As String, Optional OverWriteFiles As Boolean = True)
    Call mOrigin.CopyFile(Source, Destination, OverWriteFiles)
End Sub

'******************************************************************************
'* [�T  �v] CopyFolder ���\�b�h
'* [��  ��] CopyFolder �̃��b�p�[���\�b�h�B
'*          �t�H���_���R�s�[���܂��
'*
'* @param Source
'* @param Destination
'* @param OverWriteFiles �ȗ��\�B
'*
'******************************************************************************
Sub CopyFolder(Source As String, Destination As String, Optional OverWriteFiles As Boolean = True)
    Call mOrigin.CopyFolder(Source, Destination, OverWriteFiles)
End Sub

'******************************************************************************
'* [�T  �v] CreateFolder ���\�b�h
'* [��  ��] CreateFolder �̃��b�p�[���\�b�h�B
'*          �t�H���_���쐬���܂��
'*
'* @param Path
'* @return ScriptingExFolder
'*
'******************************************************************************
Function CreateFolder(Path As String) As ScriptingExFolder
    Dim wrap As ScriptingExFolder: Set wrap = New ScriptingExFolder
    Set wrap.Origin = mOrigin.CreateFolder(Path)
    Set CreateFolder = wrap
End Function

'******************************************************************************
'* [�T  �v] CreateTextFile ���\�b�h
'* [��  ��] CreateTextFile �̃��b�p�[���\�b�h�B
'*          TextStream �I�u�W�F�N�g�Ƃ��ăt�@�C�����쐬���܂��
'*
'* @param FileName
'* @param Overwrite �ȗ��\�B
'* @param Unicode �ȗ��\�B
'* @return ScriptingExTextStream
'*
'******************************************************************************
Function CreateTextFile(fileName As String, Optional Overwrite As Boolean = True, Optional Unicode As Boolean = False) As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.CreateTextFile(fileName, Overwrite, Unicode)
    Set CreateTextFile = wrap
End Function

'******************************************************************************
'* [�T  �v] DeleteFile ���\�b�h
'* [��  ��] DeleteFile �̃��b�p�[���\�b�h�B
'*         �t�@�C�����폜���܂��
'*
'* @param FileSpec
'* @param Force �ȗ��\�B
'*
'******************************************************************************
Sub DeleteFile(FileSpec As String, Optional Force As Boolean = False)
    Call mOrigin.DeleteFile(FileSpec, Force)
End Sub

'******************************************************************************
'* [�T  �v] DeleteFolder ���\�b�h
'* [��  ��] DeleteFolder �̃��b�p�[���\�b�h�B
'*          �t�H���_���폜���܂��
'*
'* @param FolderSpec
'* @param Force �ȗ��\�B
'*
'******************************************************************************
Sub DeleteFolder(FolderSpec As String, Optional Force As Boolean = False)
    Call mOrigin.DeleteFolder(FolderSpec, Force)
End Sub


'******************************************************************************
'* [�T  �v] DriveExists ���\�b�h
'* [��  ��] DriveExists �̃��b�p�[���\�b�h�B
'*          �f�B�X�N �h���C�u�܂��̓l�b�g���[�N �h���C�u�����݂��邩�ǂ���
'*          ���肵�܂��
'*
'* @param DriveSpec
'* @return ���茋��
'*
'******************************************************************************
Function DriveExists(DriveSpec As String) As Boolean
    DriveExists = mOrigin.DriveExists(DriveSpec)
End Function

'******************************************************************************
'* [�T  �v] FileExists ���\�b�h
'* [��  ��] FileExists �̃��b�p�[���\�b�h�B
'*          �t�@�C�������݂��邩�ǂ������肵�܂��
'*
'* @param FileSpec
'* @return ���茋��
'*
'******************************************************************************
Function FileExists(FileSpec As String) As Boolean
    FileExists = mOrigin.FileExists(FileSpec)
End Function

'******************************************************************************
'* [�T  �v] FolderExists ���\�b�h
'* [��  ��] FolderExists �̃��b�p�[���\�b�h�B
'*          �p�X�����݂��邩�ǂ������肵�܂��
'*
'* @param FolderSpec
'* @return ���茋��
'*
'******************************************************************************
Function FolderExists(FolderSpec As String) As Boolean
    FolderExists = mOrigin.FolderExists(FolderSpec)
End Function

'******************************************************************************
'* [�T  �v] GetAbsolutePathName ���\�b�h
'* [��  ��] GetAbsolutePathName �̃��b�p�[���\�b�h�B
'*          �p�X�̊�\����Ԃ��܂��
'*
'* @param Path
'* @return ��΃p�X
'*
'******************************************************************************
Function GetAbsolutePathName(Path As String) As String
    GetAbsolutePathName = mOrigin.GetAbsolutePathName(Path)
End Function

'******************************************************************************
'* [�T  �v] GetBaseName ���\�b�h
'* [��  ��] GetBaseName �̃��b�p�[���\�b�h�B
'*          �p�X�̃x�[�X����Ԃ��܂��
'*
'* @param Path
'* @return �p�X�̃x�[�X��
'*
'******************************************************************************
Function GetBaseName(Path As String) As String
    GetBaseName = mOrigin.GetBaseName(Path)
End Function

'******************************************************************************
'* [�T  �v] GetDrive ���\�b�h
'* [��  ��] GetDrive �̃��b�p�[���\�b�h�B
'*          �f�B�X�N�h���C�u���܂��̓l�b�g���[�N�h���C�u��UNC �����擾���܂��
'*
'* @param DriveSpec
'* @return ScriptingExDrive �f�B�X�N�h���C�u���^�l�b�g���[�N�h���C�u��UNC��
'*
'******************************************************************************
Function GetDrive(DriveSpec As String) As ScriptingExDrive
    Dim wrap As ScriptingExDrive: Set wrap = New ScriptingExDrive
    Set wrap.Origin = mOrigin.GetDrive(DriveSpec)
    Set GetDrive = wrap
End Function


'******************************************************************************
'* [�T  �v] GetDriveName ���\�b�h
'* [��  ��] GetDriveName �̃��b�p�[���\�b�h�B
'*          �p�X�̃h���C�u����Ԃ��܂��
'*
'* @param Path
'* @return �p�X�̃h���C�u��
'*
'******************************************************************************
Function GetDriveName(Path As String) As String
    GetDriveName = mOrigin.GetDriveName(Path)
End Function


'******************************************************************************
'* [�T  �v] GetExtensionName ���\�b�h
'* [��  ��] GetExtensionName �̃��b�p�[���\�b�h�B
'*          �p�X�̊g���q��Ԃ��܂��
'*
'* @param Path
'* @return �p�X�̊g���q
'*
'******************************************************************************
Function GetExtensionName(Path As String) As String
    GetExtensionName = mOrigin.GetExtensionName(Path)
End Function

'******************************************************************************
'* [�T  �v] GetFile ���\�b�h
'* [��  ��] GetFile �̃��b�p�[���\�b�h�B
'*         �t�@�C�����擾���܂��
'*
'* @param FilePath
'* @return ScriptingExFile �t�@�C��
'*
'******************************************************************************
Function GetFile(FilePath As String) As ScriptingExFile
    Dim wrap As ScriptingExFile: Set wrap = New ScriptingExFile
    Set wrap.Origin = mOrigin.GetFile(FilePath)
    Set GetFile = wrap
End Function

'******************************************************************************
'* [�T  �v] GetFileName ���\�b�h
'* [��  ��] GetFileName �̃��b�p�[���\�b�h�B
'*         �p�X�̃t�@�C������Ԃ��܂��
'*
'* @param Path
'* @return �t�@�C����
'*
'******************************************************************************
Function GetFileName(Path As String) As String
    GetFileName = mOrigin.GetFileName(Path)
End Function

'******************************************************************************
'* [�T  �v] GetFileVersion ���\�b�h
'* [��  ��] GetFileVersion �̃��b�p�[���\�b�h�B
'*         Retrieve the file version of the specified file into a string
'*
'* @param FileName
'* @return file version
'*
'******************************************************************************
Function GetFileVersion(fileName As String) As String
    GetFileVersion = mOrigin.GetFileVersion(fileName)
End Function

'******************************************************************************
'* [�T  �v] GetFolder ���\�b�h
'* [��  ��] GetFolder �̃��b�p�[���\�b�h�B
'*         �t�H���_���擾���܂��
'*
'* @param FilePath
'* @return ScriptingExFolder �t�H���_
'*
'******************************************************************************
Function GetFolder(FolderPath As String) As ScriptingExFolder
    Dim wrap As ScriptingExFolder: Set wrap = New ScriptingExFolder
    Set wrap.Origin = mOrigin.GetFolder(FolderPath)
    Set GetFolder = wrap
End Function

'******************************************************************************
'* [�T  �v] GetParentFolderName ���\�b�h
'* [��  ��] GetParentFolderName �̃��b�p�[���\�b�h�B
'*         1 ��̃t�H���_�̃p�X��Ԃ��܂��
'*
'* @param Path
'* @return 1��̃t�H���_�p�X
'*
'******************************************************************************
Function GetParentFolderName(Path As String) As String
    GetParentFolderName = mOrigin.GetParentFolderName(Path)
End Function

'******************************************************************************
'* [�T  �v] GetSpecialFolder ���\�b�h
'* [��  ��] GetSpecialFolder �̃��b�p�[���\�b�h�B
'*         �e�V�X�e���t�H���_�̈ʒu���擾���܂��
'*
'* @param SpecialFolder
'* @return ScriptingExFolder �e�V�X�e���t�H���_�̈ʒu
'*
'******************************************************************************
Function GetSpecialFolder(SpecialFolder As SpecialFolderConst) As ScriptingExFolder
    Dim wrap As ScriptingExFolder: Set wrap = New ScriptingExFolder
    Set wrap.Origin = mOrigin.GetSpecialFolder(SpecialFolder)
    Set GetSpecialFolder = wrap
End Function

'******************************************************************************
'* [�T  �v] GetStandardStream ���\�b�h
'* [��  ��] GetStandardStream �̃��b�p�[���\�b�h�B
'*         �e�V�X�e���t�H���_�̈ʒu���擾���܂��
'*
'* @param StandardStreamType
'* @param Unicode �ȗ��\�B
'* @return ScriptingExTextStream �e�V�X�e���t�H���_�̈ʒu
'*
'******************************************************************************
Function GetStandardStream(StandardStreamType As StandardStreamTypes, Optional Unicode As Boolean = False) As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.GetStandardStream(StandardStreamType, Unicode)
    Set GetStandardStream = wrap
End Function

'******************************************************************************
'* [�T  �v] GetTempName ���\�b�h
'* [��  ��] GetTempName �̃��b�p�[���\�b�h�B
'*         �ꎞ�t�@�C���̖��O�Ƃ��Ďg�p���閼�O���쐬���܂��
'*
'* @return �ꎞ�t�@�C���̖��O
'*
'******************************************************************************
Function GetTempName() As String
    GetTempName = mOrigin.GetTempName()
End Function

'******************************************************************************
'* [�T  �v] MoveFile ���\�b�h
'* [��  ��] MoveFile �̃��b�p�[���\�b�h�B
'*          �t�@�C�����ړ����܂��
'*
'* @param Source
'* @param Destination
'*
'******************************************************************************
Sub MoveFile(Source As String, Destination As String)
    Call mOrigin.MoveFile(Source, Destination)
End Sub

'******************************************************************************
'* [�T  �v] MoveFolder ���\�b�h
'* [��  ��] MoveFolder �̃��b�p�[���\�b�h�B
'*          �t�H���_���ړ����܂��
'*
'* @param Source
'* @param Destination
'*
'******************************************************************************
Sub MoveFolder(Source As String, Destination As String)
    Call mOrigin.MoveFolder(Source, Destination)
End Sub

'******************************************************************************
'* [�T  �v] OpenTextFile ���\�b�h
'* [��  ��] OpenTextFile �̃��b�p�[���\�b�h�B
'*          �t�@�C���� TextStream �I�u�W�F�N�g�Ƃ��ĊJ���܂��
'*
'* @param FileName
'* @param IOMode �ȗ��\�B
'* @param Create �ȗ��\�B
'* @param Format �ȗ��\�B
'* @return ScriptingExTextStream �t�@�C���X�g���[��
'*
'******************************************************************************
Function OpenTextFile(fileName As String, _
                      Optional IOMode As IOMode = ForReading, _
                      Optional Create As Boolean = False, _
                      Optional Format As Tristate = TristateFalse) As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.OpenTextFile(fileName, IOMode, Create, Format)
    Set OpenTextFile = wrap
End Function

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------