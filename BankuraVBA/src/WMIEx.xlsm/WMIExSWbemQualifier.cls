VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemQualifier"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemQualifier�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemQualifier�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemQualifier�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemQualifier�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393817(v=vs.80)>
' A Qualifier
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemQualifier
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
'* IsAmended �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EDetermines whether the value of this Qualifier has been amended.
'*-----------------------------------------------------------------------------
Property Get IsAmended() As Boolean
    IsAmended = mOrigin.IsAmended
End Property

'*-----------------------------------------------------------------------------
'* IsLocal �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EIndicates whether this Qualifier is local or propagated.
'*-----------------------------------------------------------------------------
Property Get IsLocal() As Boolean
    IsLocal = mOrigin.IsLocal
End Property

'*-----------------------------------------------------------------------------
'* IsOverridable �v���p�e�B
'*
'* [��  ��]
'* �EDetermines whether this Qualifier can be overridden where propagated.
'*-----------------------------------------------------------------------------
Property Get IsOverridable() As Boolean
    IsOverridable = mOrigin.IsOverridable
End Property
Property Let IsOverridable(arg As Boolean)
    mOrigin.IsOverridable = arg
End Property

'*-----------------------------------------------------------------------------
'* Name �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe name of this Qualifier.
'*-----------------------------------------------------------------------------
Property Get Name() As String
    Name = mOrigin.Name
End Property
    
'*-----------------------------------------------------------------------------
'* PropagatesToInstance �v���p�e�B
'*
'* [��  ��]
'* �EDetermines whether this Qualifier can propagate to instances.
'*-----------------------------------------------------------------------------
Property Get PropagatesToInstance() As Boolean
    PropagatesToInstance = mOrigin.PropagatesToInstance
End Property
Property Let PropagatesToInstance(arg As Boolean)
    mOrigin.PropagatesToInstance = arg
End Property
    
'*-----------------------------------------------------------------------------
'* PropagatesToSubclass �v���p�e�B
'*
'* [��  ��]
'* �EDetermines whether this Qualifier can propagate to subclasses.
'*-----------------------------------------------------------------------------
Property Get PropagatesToSubclass() As Boolean
    PropagatesToSubclass = mOrigin.PropagatesToSubclass
End Property
Property Let PropagatesToSubclass(arg As Boolean)
    mOrigin.PropagatesToSubclass = arg
End Property

'*-----------------------------------------------------------------------------
'* Value �v���p�e�B�i���胁���o�[�j
'*
'* [��  ��]
'* �EThe value of this Qualifier.
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
    'Set mOrigin = CreateObject("WbemScripting.SWbemQualifier")
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

