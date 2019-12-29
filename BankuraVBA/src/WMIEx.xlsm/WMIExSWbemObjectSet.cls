VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemObjectSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemObjectSet�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemObjectSet�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemObjectSet�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemObjectSet�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393762(v=vs.80)>
' A collection of Classes or Instances
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemObjectSet
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
    Dim myItem As Object
    For Each myItem In mOrigin
        Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
        Set wrap.Origin = myItem
        mKeys.Add wrap, myItem.Name
    Next myItem
End Property

'*-----------------------------------------------------------------------------
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe number of items in this collection.
'*-----------------------------------------------------------------------------
Property Get Count() As Long
    Count = mOrigin.Count
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
    'Set mOrigin = CreateObject("WbemScripting.SWbemObjectSet")
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
'* [�T  �v] Item ���\�b�h�i���胁���o�[�j
'* [��  ��] Item �̃��b�p�[���\�b�h�B
'*          Get an Object with a specific path from this collection.
'*
'* @param strObjectPath xx
'* @param iFlags xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function Item(strObjectPath As String, Optional iFlags As Long) As WMIExSWbemObject
Attribute Item.VB_UserMemId = 0
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.Item(strObjectPath, iFlags)
    Set Item = wrap
End Function

'******************************************************************************
'* [�T  �v] ItemIndex ���\�b�h
'* [��  ��] ItemIndex �̃��b�p�[���\�b�h�B
'*          Get an Object with a specific index from this collection.
'*
'* @param lIndex xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function ItemIndex(lIndex As Long) As WMIExSWbemObject
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.ItemIndex(lIndex)
    Set ItemIndex = wrap
End Function

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