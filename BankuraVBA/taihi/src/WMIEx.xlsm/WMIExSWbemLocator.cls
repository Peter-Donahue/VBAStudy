VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemLocator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemLocator�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemLocator�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemLocator�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemLocator�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393719(v=vs.80)>
' Used to obtain Namespace connections
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemLocator
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
'* Security_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Security Configurator for this Object.
'*-----------------------------------------------------------------------------
Property Get Security_() As WMIExSWbemSecurity
    Dim wrap As WMIExSWbemSecurity: Set wrap = New WMIExSWbemSecurity
    Set wrap.Origin = mOrigin.Security_
    Set Security_ = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("WbemScripting.SWbemLocator")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] ConnectServer ���\�b�h
'* [��  ��] ConnectServer �̃��b�p�[���\�b�h�B
'*          Connect to a Namespace.
'*
'* @param strServer xx
'* @param strNamespace xx
'* @param strUser xx
'* @param strPassword xx
'* @param strLocale xx
'* @param strAuthority xx
'* @param iSecurityFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemServicesEx
'*
'******************************************************************************
Function ConnectServer(Optional strServer As String = ".", _
                       Optional strNamespace As String, _
                       Optional strUser As String, _
                       Optional strPassword As String, _
                       Optional strLocale As String, _
                       Optional strAuthority As String, _
                       Optional iSecurityFlags As Long, _
                       Optional objWbemNamedValueSet As Object) As WMIExSWbemServicesEx
    Dim wrap As WMIExSWbemServicesEx: Set wrap = New WMIExSWbemServicesEx
    Set wrap.Origin = mOrigin.ConnectServer(strServer, strNamespace, strUser, strPassword, strLocale, strAuthority, iSecurityFlags, objWbemNamedValueSet)
    Set ConnectServer = wrap
End Function

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] ConnectServerNoEx ���\�b�h
'* [��  ��] ConnectServer �̃��b�p�[���\�b�h�B
'           �߂�l��WMIExSWbemServices�Ƃ��Ď擾����B
'*          Connect to a Namespace.
'*
'* @param strServer xx
'* @param strNamespace xx
'* @param strUser xx
'* @param strPassword xx
'* @param strLocale xx
'* @param strAuthority xx
'* @param iSecurityFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemServices
'*
'******************************************************************************
Function ConnectServerNoEx(Optional strServer As String = ".", _
                           Optional strNamespace As String, _
                           Optional strUser As String, _
                           Optional strPassword As String, _
                           Optional strLocale As String, _
                           Optional strAuthority As String, _
                           Optional iSecurityFlags As Long, _
                           Optional objWbemNamedValueSet As Object) As WMIExSWbemServices
    Dim wrap As WMIExSWbemServices: Set wrap = New WMIExSWbemServices
    Set wrap.Origin = mOrigin.ConnectServer(strServer, strNamespace, strUser, strPassword, strLocale, strAuthority, iSecurityFlags, objWbemNamedValueSet)
    Set ConnectServerNoEx = wrap
End Function
