VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemSecurity"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemSecurity�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemSecurity�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemSecurity�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemSecurity�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393850(v=vs.80)>
' A Security Configurator
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemSecurity
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
'* AuthenticationLevel �v���p�e�B
'*
'* [��  ��]
'* �EThe security authentication level.
'*-----------------------------------------------------------------------------
Property Get AuthenticationLevel() As WbemAuthenticationLevelEnum
    AuthenticationLevel = mOrigin.AuthenticationLevel
End Property
Property Let AuthenticationLevel(arg As WbemAuthenticationLevelEnum)
    mOrigin.AuthenticationLevel = arg
End Property

'*-----------------------------------------------------------------------------
'* ImpersonationLevel �v���p�e�B
'*
'* [��  ��]
'* �EThe security impersonation level.
'*-----------------------------------------------------------------------------
Property Get ImpersonationLevel() As WbemImpersonationLevelEnum
    ImpersonationLevel = mOrigin.ImpersonationLevel
End Property
Property Let ImpersonationLevel(arg As WbemImpersonationLevelEnum)
    mOrigin.ImpersonationLevel = arg
End Property

'*-----------------------------------------------------------------------------
'* Privileges �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe collection of privileges for this object.
'*-----------------------------------------------------------------------------
Property Get Privileges() As WMIExSWbemPrivilegeSet
    Dim wrap As WMIExSWbemPrivilegeSet: Set wrap = New WMIExSWbemPrivilegeSet
    Set wrap.Origin = mOrigin.Privileges
    Set Privileges = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WbemScripting.SWbemSecurity")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************
'�Ȃ�

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------


