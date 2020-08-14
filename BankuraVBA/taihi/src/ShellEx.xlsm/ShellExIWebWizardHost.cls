VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ShellExIWebWizardHost"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Shell32.IWebWizardHost�N���X�̃��b�v�E�g���N���X
'* [��  ��] Shell32.IWebWizardHost�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Shell32.IWebWizardHost�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Shell32.IWebWizardHost�N���X�ɂ��āB
' <xxxxxxxxxxxxxx>
'
' IWebWizardHost interface
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As shell32.IWebWizardHost
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
'* Caption �v���p�e�B
'*
'* [��  ��]
'* �E
'*-----------------------------------------------------------------------------
Property Get Caption() As String
    Caption = mOrigin.Caption
End Property
Property Let Caption(arg As String)
    mOrigin.Caption = arg
End Property

'*-----------------------------------------------------------------------------
'* Property �v���p�e�B
'*
'* [��  ��]
'* �E
'*-----------------------------------------------------------------------------
Property Get Property(bstrPropertyName As String) As Variant
    If IsObject(mOrigin.Property(bstrPropertyName)) Then
        Set Property = mOrigin.Property(bstrPropertyName)
    Else
        Property = mOrigin.Property(bstrPropertyName)
    End If
End Property
Property Set Property(bstrPropertyName As String, arg As Variant)
    If IsObject(arg) Then
        Set mOrigin.Property(bstrPropertyName) = arg
    Else
        mOrigin.Property(bstrPropertyName) = arg
    End If
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Shell32.IWebWizardHost")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Cancel ���\�b�h
'* [��  ��] Cancel �̃��b�p�[���\�b�h�B
'*
'******************************************************************************
Sub Cancel()
    Call mOrigin.Cancel
End Sub

'******************************************************************************
'* [�T  �v] FinalBack ���\�b�h�i���胁���o�[�j
'* [��  ��] FinalBack �̃��b�p�[���\�b�h�B
'*
'******************************************************************************
Sub FinalBack()
Attribute FinalBack.VB_UserMemId = 0
    Call mOrigin.FinalBack
End Sub

'******************************************************************************
'* [�T  �v] FinalNext ���\�b�h
'* [��  ��] FinalNext �̃��b�p�[���\�b�h�B
'*
'******************************************************************************
Sub FinalNext()
    Call mOrigin.FinalNext
End Sub

'******************************************************************************
'* [�T  �v] SetHeaderText ���\�b�h
'* [��  ��] SetHeaderText �̃��b�p�[���\�b�h�B
'*
'* @param bstrHeaderTitle
'* @param bstrHeaderSubtitle
'******************************************************************************
Sub SetHeaderText(bstrHeaderTitle As String, bstrHeaderSubtitle As String)
    Call mOrigin.SetHeaderText(bstrHeaderTitle, bstrHeaderSubtitle)
End Sub

'******************************************************************************
'* [�T  �v] SetWizardButtons ���\�b�h
'* [��  ��] SetWizardButtons �̃��b�p�[���\�b�h�B
'*
'* @param vfEnableBack
'* @param vfEnableNext
'* @param vfLastPage
'******************************************************************************
Sub SetWizardButtons(vfEnableBack As Boolean, vfEnableNext As Boolean, vfLastPage As Boolean)
    Call mOrigin.SetWizardButtons(vfEnableBack, vfEnableNext, vfLastPage)
End Sub