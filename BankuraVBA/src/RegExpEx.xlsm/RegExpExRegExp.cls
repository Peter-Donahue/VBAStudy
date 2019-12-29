VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "RegExpExRegExp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] VBScript.RegExp�N���X�̃��b�v�E�g���N���X
'* [��  ��] VBScript.RegExp�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          VBScript.RegExp�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' VBScript.RegExp�N���X�ɂ��āB
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc392403(v=msdn.10)?redirectedfrom=MSDN>
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As VBScript_RegExp_55.RegExp
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
'* Global_ �v���p�e�B
'*
'* [��  ��]
'* �E�
'*-----------------------------------------------------------------------------
Property Get Global_() As Boolean
    Global_ = mOrigin.Global
End Property
Property Let Global_(arg As Boolean)
    mOrigin.Global = arg
End Property

'*-----------------------------------------------------------------------------
'* IgnoreCase �v���p�e�B
'*
'* [��  ��]
'* �E�
'*-----------------------------------------------------------------------------
Property Get IgnoreCase() As Boolean
    IgnoreCase = mOrigin.IgnoreCase
End Property
Property Let IgnoreCase(arg As Boolean)
    mOrigin.IgnoreCase = arg
End Property

'*-----------------------------------------------------------------------------
'* Multiline �v���p�e�B
'*
'* [��  ��]
'* �E�
'*-----------------------------------------------------------------------------
Property Get Multiline() As Boolean
    Multiline = mOrigin.Multiline
End Property
Property Let Multiline(arg As Boolean)
    mOrigin.Multiline = arg
End Property

'*-----------------------------------------------------------------------------
'* Pattern �v���p�e�B
'*
'* [��  ��]
'* �E�
'*-----------------------------------------------------------------------------
Property Get Pattern() As String
    Pattern = mOrigin.Pattern
End Property
Property Let Pattern(arg As String)
    mOrigin.Pattern = arg
End Property
    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("VBScript.RegExp")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Execute ���\�b�h
'* [��  ��] Execute �̃��b�p�[���\�b�h�B
'*
'*
'* @param sourceString xx
'* @return Object
'*
'******************************************************************************
Function Execute(sourceString As String) As RegExpExMatchCollection
    Dim wrap As RegExpExMatchCollection: Set wrap = New RegExpExMatchCollection
    Set wrap.Origin = mOrigin.Execute(sourceString)
    Set Execute = wrap
End Function

'******************************************************************************
'* [�T  �v] Replace ���\�b�h
'* [��  ��] Replace �̃��b�p�[���\�b�h�B
'*
'*
'* @param sourceString xx
'* @param replaceVar xx
'* @return Object
'*
'******************************************************************************
Function Replace(sourceString As String, replaceVar) As String
    Replace = mOrigin.Replace(sourceString, replaceVar)
End Function

'******************************************************************************
'* [�T  �v] Test ���\�b�h
'* [��  ��] Test �̃��b�p�[���\�b�h�B
'*
'*
'* @param sourceString xx
'* @return Boolean
'*
'******************************************************************************
Function Test(sourceString As String) As Boolean
    Test = mOrigin.Test(sourceString)
End Function
    
'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------