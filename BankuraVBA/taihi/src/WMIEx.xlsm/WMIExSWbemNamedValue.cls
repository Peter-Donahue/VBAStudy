VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemNamedValue"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemNamedValue�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemNamedValue�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemNamedValue�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemNamedValue�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393731(v=vs.80)>
' A named value
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemNamedValue
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
'* Name �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Name of this Value.
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property

'*-----------------------------------------------------------------------------
'* Value �v���p�e�B�i���胁���o�[�j
'*
'* [��  ��]
'* �EThe Value of this Named element.
'*-----------------------------------------------------------------------------
Property Get Value() As Variant
Attribute Value.VB_UserMemId = 0
    If IsObject(mOrigin.Value) Then
        Set Value = mOrigin.Value
    Else
        Value = mOrigin.Value
    End If
End Property
Property Set Value(arg As Variant)
    If IsObject(arg) Then
        Set mOrigin.Value = arg
    Else
        mOrigin.Value = arg
    End If
End Property


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WbemScripting.SWbemNamedValue")
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