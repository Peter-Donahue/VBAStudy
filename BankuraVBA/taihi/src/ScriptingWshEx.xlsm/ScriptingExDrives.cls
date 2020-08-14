VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ScriptingExDrives"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Scripting.Drives�N���X�̃��b�v�E�g���N���X
'* [��  ��] Scripting.Drives�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Scripting.Drives�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Scripting.Drives�N���X�ɂ��āB
' �h���C�u�����Ɋ֘A�t����ꂽ�A�h���C�u�̃R���N�V�����B
' ���p�\�Ȃ��ׂẴh���C�u�̓ǂݎ���p�̃R���N�V�����ł��B
' <https://docs.microsoft.com/ja-jp/office/vba/language/reference/user-interface-help/drives-collection>
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As Scripting.Drives
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
    Dim myDrive As Object
    For Each myDrive In mOrigin
        Dim wrap As ScriptingExDrive: Set wrap = New ScriptingExDrive
        Set wrap.Origin = myDrive
        mKeys.Add wrap, myDrive.DriveLetter
    Next myDrive
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�h���C�u�̐��B
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
End Property

'*-----------------------------------------------------------------------------
'* Item �v���p�e�B�i�ǂݎ���p:���胁���o�[�j
'*
'* [��  ��]
'* �E�h���C�u���擾����B
'* �ESet wrap.Origin = mOrigin.Item(Key) �Ƃ���ƈȉ��̃G���[�������B
'*   ���s���G���[ '5': �v���V�[�W���̌Ăяo���A�܂��͈������s���ł��B
'*
'*   Drives�I�u�W�F�N�g��Item���\�b�h�́A�Q�Ɛݒ肹���Ɏg�p����ꍇ�A
'*   ��L�̂悤�Ɉ����ɕϐ����g�p����ƃG���[����������͗l�B
'*   ���R�͕s���B�Œ�l�ł���Γ��삷�邽�߁A�Œ�l��n���悤�ɑΏ������B
'*-----------------------------------------------------------------------------
Property Get Item(Key) As ScriptingExDrive
Attribute Item.VB_UserMemId = 0
    Dim wrap As ScriptingExDrive: Set wrap = New ScriptingExDrive
    'Set wrap.Origin = mOrigin.Item(Key)
    Select Case Key
        Case "A", "a", "A:", "a:"
            Set wrap.Origin = mOrigin.Item("A:")
        Case "B", "b", "A:", "a:"
            Set wrap.Origin = mOrigin.Item("B:")
        Case "C", "c", "C:", "c:"
            Set wrap.Origin = mOrigin.Item("C:")
        Case "D", "d", "D:", "d:"
            Set wrap.Origin = mOrigin.Item("D:")
        Case "E", "e", "E:", "e:"
            Set wrap.Origin = mOrigin.Item("E:")
        Case "F", "f", "F:", "f:"
            Set wrap.Origin = mOrigin.Item("F:")
        Case "G", "g", "G:", "g:"
            Set wrap.Origin = mOrigin.Item("G:")
        Case "H", "h", "H:", "h:"
            Set wrap.Origin = mOrigin.Item("H:")
        Case "I", "i", "I:", "i:"
            Set wrap.Origin = mOrigin.Item("I:")
        Case "J", "j", "J:", "j:"
            Set wrap.Origin = mOrigin.Item("J:")
        Case "K", "k", "K:", "k:"
            Set wrap.Origin = mOrigin.Item("K:")
        Case "L", "l", "L:", "l:"
            Set wrap.Origin = mOrigin.Item("L:")
        Case "M", "m", "M:", "m:"
            Set wrap.Origin = mOrigin.Item("M:")
        Case "N", "n", "N:", "n:"
            Set wrap.Origin = mOrigin.Item("N:")
        Case "O", "o", "O:", "o:"
            Set wrap.Origin = mOrigin.Item("O:")
        Case "P", "p", "P:", "p:"
            Set wrap.Origin = mOrigin.Item("P:")
        Case "Q", "q", "Q:", "q:"
            Set wrap.Origin = mOrigin.Item("Q:")
        Case "R", "r", "R:", "r:"
            Set wrap.Origin = mOrigin.Item("R:")
        Case "S", "s", "S:", "s:"
            Set wrap.Origin = mOrigin.Item("S:")
        Case "T", "t", "T:", "t:"
            Set wrap.Origin = mOrigin.Item("T:")
        Case "U", "u", "U:", "u:"
            Set wrap.Origin = mOrigin.Item("U:")
        Case "V", "v", "V:", "V:"
            Set wrap.Origin = mOrigin.Item("V:")
        Case "W", "w", "W:", "w:"
            Set wrap.Origin = mOrigin.Item("W:")
        Case "X", "x", "X:", "x:"
            Set wrap.Origin = mOrigin.Item("X:")
        Case "Y", "y", "Y:", "y:"
            Set wrap.Origin = mOrigin.Item("Y:")
        Case "Z", "z", "Z:", "z:"
            Set wrap.Origin = mOrigin.Item("Z:")
    End Select
    Set Item = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("Scripting.Drives")
    'Set mKeys = New Collection
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
    Set mKeys = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************
'�Ȃ�

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] NewEnum ���\�b�h
'* [��  ��] For Each �\���ŃC�e���[�^�[��Ԃ����߂̃��\�b�h�B
'*
'* @return �C�e���[�^�[
'******************************************************************************
Public Function NewEnum() As stdole.IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    Set NewEnum = mKeys.[_NewEnum]
End Function