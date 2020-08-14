VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemObjectPath"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemObjectPath�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemObjectPath�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemObjectPath�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemObjectPath�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393746(v=vs.80)>
' Object Path
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemObjectPath
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
'* Authority �v���p�e�B
'*
'* [��  ��]
'* �EDefines authentication authority component of this path.
'*-----------------------------------------------------------------------------
Property Get Authority() As String
    Authority = mOrigin.Authority
End Property
Property Let Authority(arg As String)
    mOrigin.Authority = arg
End Property

'*-----------------------------------------------------------------------------
'* Class �v���p�e�B
'*
'* [��  ��]
'* �EThe Class name.
'*-----------------------------------------------------------------------------
Property Get Class() As String
    Class = mOrigin.Class
End Property
Property Let Class(arg As String)
    mOrigin.Class = arg
End Property

'*-----------------------------------------------------------------------------
'* DisplayName �v���p�e�B
'*
'* [��  ��]
'* �EThe Display Name for this path.
'*-----------------------------------------------------------------------------
Property Get DisplayName() As String
    DisplayName = mOrigin.DisplayName
End Property
Property Let DisplayName(arg As String)
    mOrigin.DisplayName = arg
End Property

'*-----------------------------------------------------------------------------
'* IsClass �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIndicates whether this path addresses a Class.
'*-----------------------------------------------------------------------------
Property Get IsClass() As Boolean
    IsClass = mOrigin.IsClass
End Property

'*-----------------------------------------------------------------------------
'* IsSingleton �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIndicates whether this path addresses a Singleton Instance.
'*-----------------------------------------------------------------------------
Property Get IsSingleton() As Boolean
    IsSingleton = mOrigin.IsSingleton
End Property

'*-----------------------------------------------------------------------------
'* Keys �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* The collection of Key value bindings for this path.
'*-----------------------------------------------------------------------------
Property Get Keys() As WMIExSWbemNamedValueSet
    Dim wrap As WMIExSWbemNamedValueSet: Set wrap = New WMIExSWbemNamedValueSet
    Set wrap.Origin = mOrigin.Keys
    Set Keys = wrap
End Property

'*-----------------------------------------------------------------------------
'* Locale �v���p�e�B
'*
'* [��  ��]
'* �EDefines locale component of this path.
'*-----------------------------------------------------------------------------
Property Get Locale() As String
    Locale = mOrigin.Locale
End Property
Property Let Locale(arg As String)
    mOrigin.Locale = arg
End Property

'*-----------------------------------------------------------------------------
'* Namespace �v���p�e�B
'*
'* [��  ��]
'* �EThe Namespace path.
'*-----------------------------------------------------------------------------
Property Get Namespace() As String
    Namespace = mOrigin.Namespace
End Property
Property Let Namespace(arg As String)
    mOrigin.Namespace = arg
End Property

'*-----------------------------------------------------------------------------
'* ParentNamespace �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe parent Namespace path.
'*-----------------------------------------------------------------------------
Property Get ParentNamespace() As String
    ParentNamespace = mOrigin.ParentNamespace
End Property

'*-----------------------------------------------------------------------------
'* Path �v���p�e�B�i���胁���o�[�j
'*
'* [��  ��]
'* �EThe full path.
'*-----------------------------------------------------------------------------
Property Get Path() As String
Attribute Path.VB_UserMemId = 0
    Path = mOrigin.Path
End Property
Property Let Path(arg As String)
    mOrigin.Path = arg
End Property

'*-----------------------------------------------------------------------------
'* RelPath �v���p�e�B
'*
'* [��  ��]
'* �EThe relative path.
'*-----------------------------------------------------------------------------
Property Get RelPath() As String
    RelPath = mOrigin.RelPath
End Property
Property Let RelPath(arg As String)
    mOrigin.RelPath = arg
End Property

'*-----------------------------------------------------------------------------
'* Security_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EDefines the security components of this path.
'*-----------------------------------------------------------------------------
Property Get Security_() As WMIExSWbemSecurity
    Dim wrap As WMIExSWbemSecurity: Set wrap = New WMIExSWbemSecurity
    Set wrap.Origin = mOrigin.Security_
    Set Security_ = wrap
End Property

'*-----------------------------------------------------------------------------
'* Server �v���p�e�B
'*
'* [��  ��]
'* �EThe name of the Server.
'*-----------------------------------------------------------------------------
Property Get Server() As String
    Server = mOrigin.Server
End Property
Property Let Server(arg As String)
    mOrigin.Server = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WbemScripting.SWbemObjectPath")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] SetAsClass ���\�b�h
'* [��  ��] SetAsClass �̃��b�p�[���\�b�h�B
'*          Coerce this path to address a Class.
'*
'******************************************************************************
Sub SetAsClass()
    Call mOrigin.SetAsClass
End Sub

'******************************************************************************
'* [�T  �v] SetAsSingleton ���\�b�h
'* [��  ��] SetAsSingleton �̃��b�p�[���\�b�h�B
'*          Coerce this path to address a Singleton Instance.
'*
'******************************************************************************
Sub SetAsSingleton()
    Call mOrigin.SetAsSingleton
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------