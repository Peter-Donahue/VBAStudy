VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "RegExpExMatchCollection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] VBScript.MatchCollection�N���X�̃��b�v�E�g���N���X
'* [��  ��] VBScript.MatchCollection�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          VBScript.MatchCollection�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' VBScript.MatchCollection�N���X�ɂ��āB
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc392214(v=msdn.10)>
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As VBScript_RegExp_55.MatchCollection
Private mOrigin As Object
Private mKeys As Collection

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
    Set mKeys = New Collection
    Dim myObj As Object
    For Each myObj In mOrigin
        Dim wrap As RegExpExMatch: Set wrap = New RegExpExMatch
        Set wrap.Origin = myObj
        mKeys.Add wrap
    Next myObj
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�B
'*-----------------------------------------------------------------------------
Property Get Item(index As Long) As RegExpExMatch
Attribute Item.VB_UserMemId = 0
    Dim wrap As RegExpExMatch: Set wrap = New RegExpExMatch
    Set wrap.Origin = mOrigin.Item(index)
    Set Item = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("VBScript.MatchCollection")
    'Set mKeys = New Collection
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
    Set mKeys = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] NewEnum ���\�b�h
'* [��  ��] For Each �\���ŃC�e���[�^�[��Ԃ����߂̃��\�b�h�B
'*
'* @return �C�e���[�^�[
'******************************************************************************
Public Function NewEnum() As stdole.IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    'Set NewEnum = mOrigin.[_NewEnum]
    Set NewEnum = mKeys.[_NewEnum]
End Function