VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ShellExDFConstraint"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Shell32.DFConstraint�N���X�̃��b�v�E�g���N���X
'* [��  ��] Shell32.DFConstraint�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Shell32.DFConstraint�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Shell32.DFConstraint�N���X�ɂ��āB
' Constraint used in search command.
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mOrigin As shell32.DFConstraint
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
'* Name �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet the constraint name
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property

'*-----------------------------------------------------------------------------
'* Value �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet the constraint Value
'*-----------------------------------------------------------------------------
Property Get Value() As Variant
    Value = mOrigin.Value
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Shell32.DFConstraint")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub