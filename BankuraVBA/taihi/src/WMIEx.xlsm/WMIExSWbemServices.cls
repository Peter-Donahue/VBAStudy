VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemServices"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemServices�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemServices�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemServices�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemServices�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393854(v=vs.80)>
' A connection to a Namespace
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WbemScripting.SWbemServices
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
    'Set mOrigin = CreateObject("WbemScripting.SWbemServices")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] AssociatorsOf ���\�b�h
'* [��  ��] AssociatorsOf �̃��b�p�[���\�b�h�B
'*          Get the Associators of a class or instance.
'*
'* @param strObjectPath xx
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
Function AssociatorsOf(strObjectPath As String, _
                       Optional strAssocClass As String, _
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
    Set wrap.Origin = mOrigin.AssociatorsOf(strObjectPath, strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet)
    Set AssociatorsOf = wrap
End Function

'******************************************************************************
'* [�T  �v] AssociatorsOfAsync ���\�b�h
'* [��  ��] AssociatorsOfAsync �̃��b�p�[���\�b�h�B
'*          Get the Associators of a class or instance asynchronously.
'*
'* @param objWbemSink xx
'* @param strObjectPath xx
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
Sub AssociatorsOfAsync(objWbemSink As Object, _
                       strObjectPath As String, _
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
    Call mOrigin.AssociatorsOfAsync(objWbemSink, strObjectPath, strAssocClass, strResultClass, strResultRole, strRole, bClassesOnly, bSchemaOnly, strRequiredAssocQualifier, strRequiredQualifier, iFlags, objWbemNamedValueSet)
End Sub

'******************************************************************************
'* [�T  �v] Delete ���\�b�h
'* [��  ��] Delete �̃��b�p�[���\�b�h�B
'*          Delete a Class or Instance.
'*
'* @param strObjectPath xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'*
'******************************************************************************
Sub Delete(strObjectPath As String, Optional iFlags As Long, Optional objWbemNamedValueSet As Object)
    Call mOrigin.Delete(strObjectPath, iFlags, objWbemNamedValueSet)
End Sub

'******************************************************************************
'* [�T  �v] DeleteAsync ���\�b�h
'* [��  ��] DeleteAsync �̃��b�p�[���\�b�h�B
'*          Delete a Class or Instance asynchronously.
'*
'* @param objWbemSink xx
'* @param strObjectPath xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub DeleteAsync(objWbemSink As Object, strObjectPath As String, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.DeleteAsync(objWbemSink, strObjectPath, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] ExecMethod ���\�b�h
'* [��  ��] ExecMethod �̃��b�p�[���\�b�h�B
'*          Execute a Method.
'*
'* @param strObjectPath xx
'* @param strMethodName xx
'* @param objWbemInParameters xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function ExecMethod(strObjectPath As String, strMethodName As String, Optional objWbemInParameters As Object, Optional iFlags As Long, Optional objWbemNamedValueSet As Object) As WMIExSWbemObject
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.ExecMethod(strObjectPath, strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet)
    Set ExecMethod = wrap
End Function

'******************************************************************************
'* [�T  �v] ExecMethodAsync ���\�b�h
'* [��  ��] ExecMethodAsync �̃��b�p�[���\�b�h�B
'*          Execute a Method asynchronously.
'*
'* @param objWbemSink xx
'* @param strObjectPath xx
'* @param strMethodName xx
'* @param objWbemInParameters xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub ExecMethodAsync(objWbemSink As Object, _
                    strObjectPath As String, _
                    strMethodName As String, _
                    Optional objWbemInParameters As Object, _
                    Optional iFlags As Long, _
                    Optional objWbemNamedValueSet As Object, _
                    Optional objWbemAsyncContext As Object)
    Call mOrigin.ExecMethodAsync(objWbemSink, strObjectPath, strMethodName, objWbemInParameters, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] ExecNotificationQuery ���\�b�h
'* [��  ��] ExecNotificationQuery �̃��b�p�[���\�b�h�B
'*          Execute a Query to receive Notifications.
'*
'* @param strQuery xx
'* @param strQueryLanguage xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemEventSource
'*
'******************************************************************************
Function ExecNotificationQuery(strQuery As String, _
                               Optional strQueryLanguage As String = "WQL", _
                               Optional iFlags As Long = 48, _
                               Optional objWbemNamedValueSet As Object) As WMIExSWbemEventSource
    Dim wrap As WMIExSWbemEventSource: Set wrap = New WMIExSWbemEventSource
    Set wrap.Origin = mOrigin.ExecNotificationQuery(strQuery, strQueryLanguage, iFlags, objWbemNamedValueSet)
    Set ExecNotificationQuery = wrap
End Function

'******************************************************************************
'* [�T  �v] ExecNotificationQueryAsync ���\�b�h
'* [��  ��] ExecNotificationQueryAsync �̃��b�p�[���\�b�h�B
'*          Execute an asynchronous Query to receive Notifications.
'*
'* @param objWbemSink xx
'* @param strQuery xx
'* @param strQueryLanguage xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub ExecNotificationQueryAsync(objWbemSink As Object, _
                               strQuery As String, _
                               Optional strQueryLanguage As String = "WQL", _
                               Optional iFlags As Long, _
                               Optional objWbemNamedValueSet As Object, _
                               Optional objWbemAsyncContext As Object)
    Call mOrigin.ExecNotificationQueryAsync(objWbemSink, strQuery, strQueryLanguage, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] ExecQuery ���\�b�h
'* [��  ��] ExecQuery �̃��b�p�[���\�b�h�B
'*          Execute a Query.
'*
'* @param strQuery xx
'* @param strQueryLanguage xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemEventSource
'*
'******************************************************************************
Function ExecQuery(strQuery As String, _
                   Optional strQueryLanguage As String = "WQL", _
                   Optional iFlags As Long = 16, _
                   Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.ExecQuery(strQuery, strQueryLanguage, iFlags, objWbemNamedValueSet)
    Set ExecQuery = wrap
End Function

'******************************************************************************
'* [�T  �v] ExecQueryAsync ���\�b�h
'* [��  ��] ExecQueryAsync �̃��b�p�[���\�b�h�B
'*          Execute an asynchronous Query.
'*
'* @param objWbemSink xx
'* @param strQuery xx
'* @param strQueryLanguage xx
'* @param lFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub ExecQueryAsync(objWbemSink As Object, _
                   strQuery As String, _
                   Optional strQueryLanguage As String = "WQL", _
                   Optional lFlags As Long, _
                   Optional objWbemNamedValueSet As Object, _
                   Optional objWbemAsyncContext As Object)
    Call mOrigin.ExecQueryAsync(objWbemSink, strQuery, strQueryLanguage, lFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub


'******************************************************************************
'* [�T  �v] Get_ ���\�b�h
'* [��  ��] Get �̃��b�p�[���\�b�h�B
'*          Get a single Class or Instance.
'*
'* @param strObjectPath xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObject
'*
'******************************************************************************
Function Get_(Optional strObjectPath As String, Optional iFlags As Long, Optional objWbemNamedValueSet As Object) As WMIExSWbemObject
    Dim wrap As WMIExSWbemObject: Set wrap = New WMIExSWbemObject
    Set wrap.Origin = mOrigin.Get(strObjectPath, iFlags, objWbemNamedValueSet)
    Set Get_ = wrap
End Function

'******************************************************************************
'* [�T  �v] GetAsync ���\�b�h
'* [��  ��] GetAsync �̃��b�p�[���\�b�h�B
'*          Get a single Class or Instance asynchronously.
'*
'* @param objWbemSink xx
'* @param strObjectPath xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub GetAsync(objWbemSink As Object, _
             Optional strObjectPath As String, _
             Optional iFlags As Long, _
             Optional objWbemNamedValueSet As Object, _
             Optional objWbemAsyncContext As Object)
    Call mOrigin.GetAsync(objWbemSink, strObjectPath, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] InstancesOf ���\�b�h
'* [��  ��] InstancesOf �̃��b�p�[���\�b�h�B
'*          Enumerate the Instances of a Class.
'*
'* @param strClass xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function InstancesOf(strClass As String, Optional iFlags As Long = 16, Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.InstancesOf(strClass, iFlags, objWbemNamedValueSet)
    Set InstancesOf = wrap
End Function

'******************************************************************************
'* [�T  �v] InstancesOfAsync ���\�b�h
'* [��  ��] InstancesOfAsync �̃��b�p�[���\�b�h�B
'*          Enumerate the Instances of a Class asynchronously.
'*
'* @param objWbemSink xx
'* @param strClass xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub InstancesOfAsync(objWbemSink As Object, strClass As String, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.InstancesOfAsync(objWbemSink, strClass, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] ReferencesTo ���\�b�h
'* [��  ��] ReferencesTo �̃��b�p�[���\�b�h�B
'*          Get the References to a class or instance.
'*
'* @param strObjectPath xx
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
Function ReferencesTo(strObjectPath As String, _
                      Optional strResultClass As String, _
                      Optional strRole As String, _
                      Optional bClassesOnly As Boolean = False, _
                      Optional bSchemaOnly As Boolean = False, _
                      Optional strRequiredQualifier As String, _
                      Optional iFlags As Long = 16, _
                      Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.ReferencesTo(strObjectPath, strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet)
    Set ReferencesTo = wrap
End Function
    

'******************************************************************************
'* [�T  �v] ReferencesToAsync ���\�b�h
'* [��  ��] ReferencesToAsync �̃��b�p�[���\�b�h�B
'*          Get the References to a class or instance asynchronously.
'*
'* @param objWbemSink xx
'* @param strObjectPath xx
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
Sub ReferencesToAsync(objWbemSink As Object, _
                      strObjectPath As String, _
                      Optional strResultClass As String, _
                      Optional strRole As String, _
                      Optional bClassesOnly As Boolean = False, _
                      Optional bSchemaOnly As Boolean = False, _
                      Optional strRequiredQualifier As String, _
                      Optional iFlags As Long, _
                      Optional objWbemNamedValueSet As Object, _
                      Optional objWbemAsyncContext As Object)
    Call mOrigin.ReferencesToAsync(objWbemSink, strObjectPath, strResultClass, strRole, bClassesOnly, bSchemaOnly, strRequiredQualifier, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'******************************************************************************
'* [�T  �v] SubclassesOf ���\�b�h
'* [��  ��] SubclassesOf �̃��b�p�[���\�b�h�B
'*          Enumerate subclasses of this Class.
'*
'* @param strSuperclass xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @return WMIExSWbemObjectSet
'*
'******************************************************************************
Function SubclassesOf(Optional strSuperclass As String, Optional iFlags As Long = 16, Optional objWbemNamedValueSet As Object) As WMIExSWbemObjectSet
    Dim wrap As WMIExSWbemObjectSet: Set wrap = New WMIExSWbemObjectSet
    Set wrap.Origin = mOrigin.SubclassesOf(strSuperclass, iFlags, objWbemNamedValueSet)
    Set SubclassesOf = wrap
End Function

'******************************************************************************
'* [�T  �v] SubclassesAsync_ ���\�b�h
'* [��  ��] SubclassesAsync_ �̃��b�p�[���\�b�h�B
'*          Enumerate the subclasses of a Class asynchronously.
'*
'* @param objWbemSink xx
'* @param strSuperclass xx
'* @param iFlags xx
'* @param objWbemNamedValueSet xx
'* @param objWbemAsyncContext xx
'*
'******************************************************************************
Sub SubclassesOfAsync(objWbemSink As Object, Optional strSuperclass As String, Optional iFlags As Long, Optional objWbemNamedValueSet As Object, Optional objWbemAsyncContext As Object)
    Call mOrigin.SubclassesOfAsync(objWbemSink, strSuperclass, iFlags, objWbemNamedValueSet, objWbemAsyncContext)
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] CreateInstance ���\�b�h
'* [��  ��] GetObject ���\�b�h���g�p����SWbemServices�I�u�W�F�N�g�𐶐�����B
'*
'* @param strComputer �ȗ��B�R���s���[�^���B
'* @return WMIExSWbemServices SWbemServices���b�v�I�u�W�F�N�g�B
'*
'******************************************************************************
Function CreateInstance(Optional strComputer As String = ".") As WMIExSWbemServices
    Set Me.Origin = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
    Set CreateInstance = Me
End Function