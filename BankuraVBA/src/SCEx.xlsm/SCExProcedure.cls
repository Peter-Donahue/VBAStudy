VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "SCExProcedure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] MSScriptControl.Procedure �N���X�̃��b�v�E�g���N���X
'* [��  ��] MSScriptControl.Procedure �N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          MSScriptControl.Procedure �N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' MSScriptControl.Procedure �N���X�ɂ��āB
' Describes a procedure.
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As MSScriptControl.Procedure
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
'* HasReturnValue �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �ETrue if procedure returns a value.
'*-----------------------------------------------------------------------------
Property Get HasReturnValue() As Boolean
    HasReturnValue = mOrigin.HasReturnValue
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �EName of the procedure.
'*-----------------------------------------------------------------------------
Property Get Name() As String
Attribute Name.VB_UserMemId = 0
    Name = mOrigin.Name
End Property
    
'*-----------------------------------------------------------------------------
'* NumArgs �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �ENumber of arguments that are expected.
'*-----------------------------------------------------------------------------
Property Get NumArgs() As Long
    NumArgs = mOrigin.NumArgs
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("MSScriptControl.Procedure")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************
'�Ȃ�