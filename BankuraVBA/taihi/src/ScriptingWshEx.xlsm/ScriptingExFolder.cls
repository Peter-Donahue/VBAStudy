VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ScriptingExFolder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Scripting.Folder�N���X�̃��b�v�E�g���N���X
'* [��  ��] Scripting.Folder�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Scripting.Folder�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Scripting.Folder�N���X�ɂ��āB
' <https://docs.microsoft.com/ja-jp/office/vba/language/reference/user-interface-help/folder-object>
' �t�H���_�[�̂��ׂẴv���p�e�B�ɃA�N�Z�X�ł��܂��B
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As Scripting.Folder
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
'* �E�t�H���_�̑����B
'*-----------------------------------------------------------------------------
Property Get Attributes() As FileAttribute
    Attributes = mOrigin.Attributes
End Property
Property Let Attributes(arg As FileAttribute)
    mOrigin.Attributes = arg
End Property

'*-----------------------------------------------------------------------------
'* DateCreated �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�H���_�쐬���B
'*-----------------------------------------------------------------------------
Property Get DateCreated() As Date
    DateCreated = mOrigin.DateCreated
End Property

'*-----------------------------------------------------------------------------
'* DateLastAccessed �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�ŏI�t�H���_�A�N�Z�X���B
'*-----------------------------------------------------------------------------
Property Get DateLastAccessed() As Date
    DateLastAccessed = mOrigin.DateLastAccessed
End Property

'*-----------------------------------------------------------------------------
'* DateLastModified �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�ŏI�t�H���_�A�N�Z�X���B
'*-----------------------------------------------------------------------------
Property Get DateLastModified() As Date
    DateLastModified = mOrigin.DateLastModified
End Property

'*-----------------------------------------------------------------------------
'* Drive �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�H���_���܂ރh���C�u���擾���܂��B
'*-----------------------------------------------------------------------------
Property Get Drive() As ScriptingExDrive
    Dim wrap As ScriptingExDrive: Set wrap = New ScriptingExDrive
    Set wrap.Origin = mOrigin.Drive
    Set Drive = wrap
End Property

'*-----------------------------------------------------------------------------
'* Files �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�@�C���̃R���N�V�������擾���܂��B
'*-----------------------------------------------------------------------------
Property Get files() As ScriptingExFiles
    Dim wrap As ScriptingExFiles: Set wrap = New ScriptingExFiles
    Set wrap.Origin = mOrigin.files
    Set files = wrap
End Property

'*-----------------------------------------------------------------------------
'* IsRootFolder �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E���[�g �t�H���_�̏ꍇ�ɂ� True ��Ԃ��܂��B
'*-----------------------------------------------------------------------------
Property Get IsRootFolder() As Boolean
    IsRootFolder = mOrigin.IsRootFolder
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B
'*
'* [��  ��]
'* �E�t�H���_�����擾���܂��B
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property
Property Let Name(arg As String)
    mOrigin.Name = arg
End Property

'*-----------------------------------------------------------------------------
'* ParentFolder �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E1 ��̃t�H���_���擾���܂��B
'*-----------------------------------------------------------------------------
Property Get ParentFolder() As ScriptingExFolder
    Dim wrap As ScriptingExFolder: Set wrap = New ScriptingExFolder
    Set wrap.Origin = mOrigin.ParentFolder
    Set ParentFolder = wrap
End Property

'*-----------------------------------------------------------------------------
'* Path �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�t�H���_�̃p�X�B
'*-----------------------------------------------------------------------------
Property Get Path() As String
Attribute Path.VB_UserMemId = 0
    Path = mOrigin.Path
End Property

'*-----------------------------------------------------------------------------
'* ShortName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�Z�����O�B
'*-----------------------------------------------------------------------------
Property Get ShortName() As String
    ShortName = mOrigin.ShortName
End Property

'*-----------------------------------------------------------------------------
'* ShortPath �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�Z���p�X�B
'*-----------------------------------------------------------------------------
Property Get ShortPath() As String
    ShortPath = mOrigin.ShortPath
End Property

'*-----------------------------------------------------------------------------
'* Size �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�@�C������уT�u�t�H���_�̗e�ʁB
'*-----------------------------------------------------------------------------
Property Get Size() As Variant
    Size = mOrigin.Size
End Property

'*-----------------------------------------------------------------------------
'* SubFolders �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�t�H���_�̃R���N�V�������擾���܂��B
'*-----------------------------------------------------------------------------
Property Get SubFolders() As ScriptingExFolders
    Dim wrap As ScriptingExFolders: Set wrap = New ScriptingExFolders
    Set wrap.Origin = mOrigin.SubFolders
    Set SubFolders = wrap
End Property

'*-----------------------------------------------------------------------------
'* Type �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�^�C�v�L�q �B
'*-----------------------------------------------------------------------------
Property Get Type_() As Variant
    Type_ = mOrigin.Type
End Property


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Scripting.Folder")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Copy ���\�b�h
'* [��  ��] Copy �̃��b�p�[���\�b�h�B
'*          �w�肵���t�H���_���R�s�[���܂��
'*
'* @param Destination
'* @param OverWriteFiles  �ȗ��\�B
'*
'******************************************************************************
Sub Copy(Destination As String, Optional OverWriteFiles As Boolean = True)
    Call mOrigin.Copy(Destination, OverWriteFiles)
End Sub

'******************************************************************************
'* [�T  �v] CreateTextFile ���\�b�h
'* [��  ��] CreateTextFile �̃��b�p�[���\�b�h�B
'*          TextStream �I�u�W�F�N�g�Ƃ��ăt�@�C�����쐬���܂��
'*
'* @param FileName
'* @param Overwrite �ȗ��\�B
'* @param Unicode �ȗ��\�B
'* @return ScriptingExTextStream �t�@�C���̃X�g���[��
'*
'******************************************************************************
Function CreateTextFile(fileName As String, Optional Overwrite As Boolean = True, Optional Unicode As Boolean = False) As ScriptingExTextStream
    Dim wrap As ScriptingExTextStream: Set wrap = New ScriptingExTextStream
    Set wrap.Origin = mOrigin.CreateTextFile(fileName, Overwrite, Unicode)
    Set CreateTextFile = wrap
End Function

'******************************************************************************
'* [�T  �v] Delete ���\�b�h
'* [��  ��] Delete �̃��b�p�[���\�b�h�B
'*         �w�肵���t�H���_���폜���܂��
'*
'* @param Force �ȗ��\�B
'*
'******************************************************************************
Sub Delete(Optional Force As Boolean = False)
    Call mOrigin.Delete(Force)
End Sub

'******************************************************************************
'* [�T  �v] Move ���\�b�h
'* [��  ��] Move �̃��b�p�[���\�b�h�B
'*          �w�肵���t�H���_���ړ����܂��
'*
'* @param Destination
'*
'******************************************************************************
Sub Move(Destination As String)
    Call mOrigin.Move(Destination)
End Sub