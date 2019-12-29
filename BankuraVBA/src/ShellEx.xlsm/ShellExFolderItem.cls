VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ShellExFolderItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Shell32.FolderItem�N���X�̃��b�v�E�g���N���X
'* [��  ��] Shell32.FolderItem�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Shell32.FolderItem�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Shell32.FolderItem�N���X�ɂ��āB
' <xxxxxxxxxxxxxx>
'
' Definition of interface FolderItem
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As shell32.FolderItem
'Private mOrigin As Object

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
'* Application �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet Application object
'*-----------------------------------------------------------------------------
Property Get Application() As Object
    Set Application = mOrigin.Application
End Property

'*-----------------------------------------------------------------------------
'* GetFolder �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIf item is a folder return folder object
'*-----------------------------------------------------------------------------
Property Get GetFolder() As Object
    Set GetFolder = mOrigin.GetFolder
End Property

'*-----------------------------------------------------------------------------
'* GetLink �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIf item is link return link object
'*-----------------------------------------------------------------------------
Property Get GetLink() As Object
    Set GetLink = mOrigin.GetLink
End Property

'*-----------------------------------------------------------------------------
'* IsBrowsable �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIs the item browsable?
'*-----------------------------------------------------------------------------
Property Get IsBrowsable() As Boolean
    IsBrowsable = mOrigin.IsBrowsable
End Property

'*-----------------------------------------------------------------------------
'* IsFileSystem �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIs the item a file system object?
'*-----------------------------------------------------------------------------
Property Get IsFileSystem() As Boolean
    IsFileSystem = mOrigin.IsFileSystem
End Property

'*-----------------------------------------------------------------------------
'* IsFolder �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIs the item a Folder?
'*-----------------------------------------------------------------------------
Property Get IsFolder() As Boolean
    IsFolder = mOrigin.IsFolder
End Property

'*-----------------------------------------------------------------------------
'* IsLink �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIs the item a link?
'*-----------------------------------------------------------------------------
Property Get IsLink() As Boolean
    IsLink = mOrigin.IsLink
End Property
    
'*-----------------------------------------------------------------------------
'* ModifyDate �v���p�e�B
'*
'* [��  ��]
'* �EModification Date?
'*-----------------------------------------------------------------------------
Property Get ModifyDate() As Date
    ModifyDate = mOrigin.ModifyDate
End Property
Property Let ModifyDate(arg As Date)
    mOrigin.ModifyDate = arg
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B�i���胁���o�[�j
'*
'* [��  ��]
'* �EGet display name for item
'*-----------------------------------------------------------------------------
Property Get Name() As String
Attribute Name.VB_UserMemId = 0
    Name = mOrigin.Name
End Property
Property Let Name(arg As String)
    mOrigin.Name = arg
End Property

'*-----------------------------------------------------------------------------
'* Parent �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet Parent object
'*-----------------------------------------------------------------------------
Property Get Parent() As Object
    Set Parent = mOrigin.Parent
End Property

'*-----------------------------------------------------------------------------
'* Path �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet the pathname to the item
'*-----------------------------------------------------------------------------
Property Get Path() As String
    Path = mOrigin.Path
End Property

'*-----------------------------------------------------------------------------
'* Size �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �ESize
'*-----------------------------------------------------------------------------
Property Get Size() As Long
    Size = mOrigin.Size
End Property

'*-----------------------------------------------------------------------------
'* Type_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EType
'*-----------------------------------------------------------------------------
Property Get Type_() As String
    Type_ = mOrigin.Type
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Shell32.FolderItem")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] InvokeVerb ���\�b�h
'* [��  ��] InvokeVerb �̃��b�p�[���\�b�h�B
'*          Execute a command on the item.
'*
'* @param vVerb
'*
'******************************************************************************
Sub InvokeVerb(Optional vVerb)
    If IsMissing(vVerb) Then
       Call mOrigin.InvokeVerb
    Else
       Call mOrigin.InvokeVerb(vVerb)
    End If
End Sub

'******************************************************************************
'* [�T  �v] Verbs ���\�b�h
'* [��  ��] Verbs �̃��b�p�[���\�b�h�B
'*          Get the list of verbs for the object.
'*
'* @param vItem
'* @param iColumn
'* @return String
'******************************************************************************
Function Verbs() As ShellExFolderItemVerbs
    Dim wrap As ShellExFolderItemVerbs: Set wrap = New ShellExFolderItemVerbs
    Set wrap.Origin = mOrigin.Verbs()
    Set Verbs = wrap
End Function