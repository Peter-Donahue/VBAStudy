VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemObject�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemObject�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemObject�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemObject�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393741(v=vs.80)>
' A Class or Instance
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemObject
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
'* Derivation_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EAn array of strings describing the class derivation heirarchy,
'*   in most-derived-from order (the first element in the array defines
'*   the superclass and the last element defines the dynasty class).
'*-----------------------------------------------------------------------------
Property Get Derivation_() As Variant
    If IsObject(mOrigin.Derivation_) Then
        Set Derivation_ = mOrigin.Derivation_
    Else
        Derivation_ = mOrigin.Derivation_
    End If
End Property

'*-----------------------------------------------------------------------------
'* Methods_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe collection of Methods of this Object.
'*-----------------------------------------------------------------------------
Property Get Methods_() As WMIExSWbemMethodSet
    Dim wrap As WMIExSWbemMethodSet: Set wrap = New WMIExSWbemMethodSet
    Set wrap.Origin = mOrigin.Methods_()
    Set Methods_ = wrap
End Property

'*-----------------------------------------------------------------------------
'* Path_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe path of this Object.
'*-----------------------------------------------------------------------------
Property Get Path_() As WMIExSWbemObjectPath
    Dim wrap As WMIExSWbemObjectPath: Set wrap = New WMIExSWbemObjectPath
    Set wrap.Origin = mOrigin.Path_()
    Set Path_ = wrap
End Property

'*-----------------------------------------------------------------------------
'* Properties_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe collection of Properties of this Object.
'*-----------------------------------------------------------------------------
Property Get Properties_() As WMIExSWbemPropertySet
    Dim wrap As WMIExSWbemPropertySet: Set wrap = New WMIExSWbemPropertySet
    Set wrap.Origin = mOrigin.Properties_()
    Set Properties_ = wrap
End Property

'*-----------------------------------------------------------------------------
'* Qualifiers_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe collection of Qualifiers of this Object.
'*-----------------------------------------------------------------------------
Property Get Qualifiers_() As WMIExSWbemQualifierSet
    Dim wrap As WMIExSWbemQualifierSet: Set wrap = New WMIExSWbemQualifierSet
    Set wrap.Origin = mOrigin.Qualifiers_()
    Set Qualifiers_ = wrap
End Property

'*-----------------------------------------------------------------------------
'* Security_ �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Security Configurator for this Object.
'*-----------------------------------------------------------------------------
Property Get Security_() As WMIExSWbemSecurity
    Dim wrap As WMIExSWbemSecurity: Set wrap = New WMIExSWbemSecurity
    Set wrap.Origin = mOrigin.Security_()
    Set Security_ = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WbemScripting.SWbemObject")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Associators_ ���\�b�h
'* [��  ��] Associators_ �̃��b�p�[���\�b�h�B
'*          Get the Associators of this Object.
'*
'* @param strAssocClass xx
'* @param strResultClass xx
'* @param strResultRole xx
'* @param strRole xx
'* @param bClassesOnly xx
'* @param bSchemaOnly xx
'* @param strRequiredAssocQualifier xx
'* @param strRequiredQualifier xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function Associators_(Optional strAssocClass As String, _
                      Optional strResultClass As String, _
                      Optional strResultRole As String, _
                      Optional strRole As String, _
                      Optional bClassesOnly As Boolean = False, _
                      Optional bSchemaOnly As Boolean = False, _
                      Optional strRequiredAssocQualifier As String, _
                      Optional strRequiredQualifier As String, _
                      Optional iFlags As Long = 16, _
                      Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.Associators_(strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet)
    Set Associators_ = wrap
End Function

'******************************************************************************
'* [�T  �v] AssociatorsAsync_ ���\�b�h
'* [��  ��] AssociatorsAsync_ �̃��b�p�[���\�b�h�B
'*          Get the Associators of this Object asynchronously.
'*
'* @param objWbemSink xx
'* @param strAssocClass xx
'* @param strResultClass xx
'* @param strResultRole xx
'* @param strRole xx
'* @param bClassesOnly xx
'* @param bSchemaOnly xx
'* @param strRequiredAssocQualifier xx
'* @param strRequiredQualifier xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'*
'******************************************************************************
Sub AssociatorsAsync_(objWbemSink As Object, _
                      Optional strAssocClass As String, _
                      Optional strResultClass As String, _
                      Optional strResultRole As String, _
                      Optional strRole As String, _
                      Optional bClassesOnly As Boolean = False, _
                      Optional bSchemaOnly As Boolean = False, _
                      Optional strRequiredAssocQualifier As String, _
                      Optional strRequiredQualifier As String, _
                      Optional iFlags As Long, _
                      Optional objWbemNamedValueSet As Object, _
                      Optional objWbemAsyncContext As Object)
    Call mOrigin.AssociatorsAsync_(objWbemSink, strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet)
End Sub

'******************************************************************************
'* [�T  �v] Clone_ ���\�b�h
'* [��  ��] Clone_ �̃��b�p�[���\�b�h�B
'*          Clone this Object.
'*
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function Clone_() As WMIExSWbemObject
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.Clone_()
    Set Clone_ = wrap
End Function

'******************************************************************************
'* [�T  �v] CompareTo_ ���\�b�h
'* [��  ��] CompareTo_ �̃��b�p�[���\�b�h�B
'*          Compare this Object with another.
'*
'* @param objWbemObject xx
'* @param iFlags xx
'* @return Boolean
'*
'******************************************************************************
Function CompareTo_(objWbemObject As Object, Optional iFlags As Long) As Boolean
    CompareTo_ = mOrigin.CompareTo_(objWbemObject, iFlags)
End Function

'******************************************************************************
'* [�T  �v] Delete_ ���\�b�h
'* [��  ��] Delete_ �̃��b�p�[���\�b�h�B
'*          Delete this Object.
'*
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'*
'******************************************************************************
Sub Delete_(Optional iFlags As Long, Optional objWbemNamedValueSet As Object)
    Call mOrigin.Delete_(iFlags, objWbemNamedValueSet)
End Sub

'******************************************************************************
'* [�T  �v] DeleteAsync_ ���\�b�h
'* [��  ��] DeleteAsync_ �̃��b�p�[���\�b�h�B
'*          Delete this Object asynchronously.
'*
'* @param objWbemSink xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub DeleteAsync_(objWbemSink As Object, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.DeleteAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] ExecMethod_ ���\�b�h
'* [��  ��] ExecMethod_ �̃��b�p�[���\�b�h�B
'*          Execute a Method of this Object.
'*
'* @param strMethodName xx
'* @param objWbemInParameters xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function ExecMethod_(strMethodName As String, Optional objWbemInParameters As Object, Optional iFlags As Long, Optional objWbemNamedValueSet As Object) As WMIExSWbemObject
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.ExecMethod_(strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet)
    Set ExecMethod_ = wrap
End Function

'******************************************************************************
'* [�T  �v] ExecMethodAsync_ ���\�b�h
'* [��  ��] ExecMethodAsync_ �̃��b�p�[���\�b�h�B
'*          Execute a Method of this Object asynchronously.
'*
'* @param objWbemSink xx
'* @param strMethodName xx
'* @param objWbemInParameters xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub ExecMethodAsync_(objWbemSink As Object, _
                     strMethodName As String, _
                     Optional objWbemInParameters As Object, _
                     Optional iFlags As Long, _
                     Optional objWbemNamedValueSet As Object, _
                     Optional objWbemAsyncContext As Object)
    Call mOrigin.ExecMethodAsync_(objWbemSink, strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] GetObjectText_ ���\�b�h
'* [��  ��] GetObjectText_ �̃��b�p�[���\�b�h�B
'*          Get the MOF text of this Object.
'*
'* @param iFlags xx
'* @return String
'*
'******************************************************************************
Function GetObjectText_(Optional iFlags As Long) As String
    GetObjectText_ = mOrigin.GetObjectText_(iFlags)
End Function

'******************************************************************************
'* [�T  �v] Instances_ ���\�b�h
'* [��  ��] Instances_ �̃��b�p�[���\�b�h�B
'*          Return all instances of this Class.
'*
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function Instances_(Optional iFlags As Long = 16, Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.Instances_(iFlags, objWbemNamedValueSet)
    Set Instances_ = wrap
End Function

'******************************************************************************
'* [�T  �v] InstancesAsync_ ���\�b�h
'* [��  ��] InstancesAsync_ �̃��b�p�[���\�b�h�B
'*          Return all instances of this Class asynchronously.
'*
'* @param objWbemSink xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub InstancesAsync_(objWbemSink As Object, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.InstancesAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] Put_ ���\�b�h
'* [��  ��] Put_ �̃��b�p�[���\�b�h�B
'*          Save this Object.
'*
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectPath
'*
'******************************************************************************
Function Put_(Optional iFlags As Long, Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectPath
    Dim wrap As WMIExSWbemObjectPath: Set wrap = New WMIExSWbemObjectPath
    Set wrap.Origin = mOrigin.Put_(iFlags, objWbemNamedValueSet)
    Set Put_ = wrap
End Function

'******************************************************************************
'* [�T  �v] PutAsync_ ���\�b�h
'* [��  ��] PutAsync_ �̃��b�p�[���\�b�h�B
'*          Save this Object asynchronously.
'*
'* @param objWbemSink xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub PutAsync_(objWbemSink As Object, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.PutAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] References_ ���\�b�h
'* [��  ��] References_ �̃��b�p�[���\�b�h�B
'*          Get the References to this Object.
'*
'* @param strResultClass xx
'* @param strRole xx
'* @param bClassesOnly xx
'* @param bSchemaOnly xx
'* @param strRequiredQualifier xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function References_(Optional strResultClass As String, _
                     Optional strRole As String, _
                     Optional bClassesOnly As Boolean = False, _
                     Optional bSchemaOnly As Boolean = False, _
                     Optional strRequiredQualifier As String, _
                     Optional iFlags As Long = 16, _
                     Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.References_(strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet)
    Set References_ = wrap
End Function

'******************************************************************************
'* [�T  �v] ReferencesAsync_ ���\�b�h
'* [��  ��] ReferencesAsync_ �̃��b�p�[���\�b�h�B
'*          Get the References to this Object asynchronously.
'*
'* @param objWbemSink xx
'* @param strResultClass xx
'* @param strRole xx
'* @param bClassesOnly xx
'* @param bSchemaOnly xx
'* @param strRequiredQualifier xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub ReferencesAsync_(objWbemSink As Object, _
                     Optional strResultClass As String, _
                     Optional strRole As String, _
                     Optional bClassesOnly As Boolean = False, _
                     Optional bSchemaOnly As Boolean = False, _
                     Optional strRequiredQualifier As String, _
                     Optional iFlags As Long, _
                     Optional objWbemNamedValueSet As Object, _
                     Optional objWbemAsyncContext As Object)
    Call mOrigin.ReferencesAsync_(objWbemSink, strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] SpawnDerivedClass_ ���\�b�h
'* [��  ��] SpawnDerivedClass_ �̃��b�p�[���\�b�h�B
'*          Create a subclass of this Object.
'*
'* @param iFlags xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function SpawnDerivedClass_(Optional iFlags As Long) As WMIExSWbemObject
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.SpawnDerivedClass_(iFlags)
    Set SpawnDerivedClass_ = wrap
End Function

'******************************************************************************
'* [�T  �v] SpawnInstance_ ���\�b�h
'* [��  ��] SpawnInstance_ �̃��b�p�[���\�b�h�B
'*          Create an Instance of this Object.
'*
'* @param iFlags xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function SpawnInstance_(Optional iFlags As Long) As WMIExSWbemObject
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.SpawnInstance_(iFlags)
    Set SpawnInstance_ = wrap
End Function

'******************************************************************************
'* [�T  �v] Subclasses_ ���\�b�h
'* [��  ��] Subclasses_ �̃��b�p�[���\�b�h�B
'*          Enumerate subclasses of this Class.
'*
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function Subclasses_(Optional iFlags As Long = 16, Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.Subclasses_(iFlags, objWbemNamedValueSet)
    Set Subclasses_ = wrap
End Function

'******************************************************************************
'* [�T  �v] SubclassesAsync_ ���\�b�h
'* [��  ��] SubclassesAsync_ �̃��b�p�[���\�b�h�B
'*          Enumerate subclasses of this Class asynchronously.
'*
'* @param objWbemSink xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub SubclassesAsync_(objWbemSink As Object, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.SubclassesAsync_(objWbemSink, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------