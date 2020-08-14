VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WMIExSWbemSink"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
#Const USE_REFERENCE = False    '�Q�Ɛݒ�g�p�L��

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WbemScripting.SWbemSink�N���X�̃��b�v�E�g���N���X
'* [��  ��] WbemScripting.SWbemSink�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WbemScripting.SWbemSink�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WbemScripting.SWbemSink�N���X�ɂ��āB
' <https://msdn.microsoft.com/ja-jp/windows/aa393877(v=vs.80)>
' A sink for events arising from asynchronous operations
'
' [�C�x���g���]
'Event OnCompleted(iHResult As WbemErrorEnum, objWbemErrorObject As SWbemObject, objWbemAsyncContext As SWbemNamedValueSet)
'    Event triggered when an asynchronous operation is completed
'Event OnObjectPut(objWbemObjectPath As SWbemObjectPath, objWbemAsyncContext As SWbemNamedValueSet)
'    Event triggered when an object path is available following a Put operation
'Event OnObjectReady(objWbemObject As SWbemObject, objWbemAsyncContext As SWbemNamedValueSet)
'    Event triggered when an Object is available
'Event OnProgress(iUpperBound As Long, iCurrent As Long, strMessage As String, objWbemAsyncContext As SWbemNamedValueSet
'    Event triggered to report the progress of an asynchronous operation
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
#If USE_REFERENCE Then
    Private WithEvents mOrigin As WbemScripting.SWbemSink
Attribute mOrigin.VB_VarHelpID = -1
#Else
    Private mOrigin As Object
#End If
    
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

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("WbemScripting.SWbemSink")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Cancel ���\�b�h
'* [��  ��] Cancel �̃��b�p�[���\�b�h�B
'*          Cancel an asynchronous operation.
'*
'******************************************************************************
Sub Cancel()
    Call mOrigin.Cancel
End Sub
    
'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] CreateInstance ���\�b�h
'* [��  ��] �^�C�v�����w�肵��SWbemSink�I�u�W�F�N�g���쐬����B
'*
'* @return WMIExSWbemSink SWbemSink���b�v�I�u�W�F�N�g�B
'*
'******************************************************************************
Function CreateInstance() As WMIExSWbemSink
#If USE_REFERENCE Then
    Set mOrigin = New WbemScripting.SWbemSink
#Else
    Set mOrigin = CreateObject("WbemScripting.SWbemSink")
#End If
    Set CreateInstance = Me
End Function

'******************************************************************************
'* [�T  �v] ExecNTLogEvent ���\�b�h
'* [��  ��] Win32_NTLogEvent��񓯊����s���ăC�x���g�𔭐�������B
'* [��  �l] �����p�B�Q�Ɛݒ肪�K�v�B
'*
'******************************************************************************
#If USE_REFERENCE Then
Sub ExecNTLogEvent()
    Dim objWMIService As New WMIExSWbemServicesEx
    Set objWMIService = objWMIService.CreateInstance()
    objWMIService.InstancesOfAsync mOrigin, "Win32_NTLogEvent"
    Dim i As Long
    For i = 0 To 10000
        DoEvents
    Next i
End Sub
#End If

'------------------------------------------------------------------------------
' [NOTE]
' �E�C�x���g�������s���ꍇ�A�Q�Ɛݒ肪�K�v
' �EmOrigin�̒�`���uPrivate WithEvents mOrigin As WbemScripting.SWbemSink�v�Ƃ���
' �E�I�u�W�F�N�g�́uSet mOrigin = New WbemScripting.SWbemSink�v�̂悤��New����
'   �K�v����iCreateObject�ł̓_���j
'------------------------------------------------------------------------------
#If USE_REFERENCE Then
' Event triggered when an asynchronous operation is completed
Sub mOrigin_OnCompleted(ByVal iHResult As WbemScripting.WbemErrorEnum, ByVal objWbemErrorObject As WbemScripting.SWbemObject, ByVal objWbemAsyncContext As WbemScripting.SWbemNamedValueSet)
    Debug.Print "Asynchronous operation is done."
End Sub

 
' Event triggered when an object path is available following a Put operation
Sub mOrigin_OnObjectPut(ByVal objWbemObjectPath As SWbemObjectPath, ByVal objWbemAsyncContext As SWbemNamedValueSet)
    Debug.Print "An object path is available following a Put operation."
End Sub

' Event triggered when an Object is available
Sub mOrigin_OnObjectReady(ByVal objEvent As SWbemObject, ByVal objAsyncContext As SWbemNamedValueSet)
    Debug.Print "Category: " & objEvent.Category
    Debug.Print "Computer Name: " & objEvent.ComputerName
    Debug.Print "Event Code: " & objEvent.EventCode
    Debug.Print "Message: " & objEvent.message
    Debug.Print "Record Number: " & objEvent.RecordNumber
    Debug.Print "Source Name: " & objEvent.SourceName
    Debug.Print "Time Written: " & objEvent.TimeWritten
    Debug.Print "Event Type: " & objEvent.Type
    Debug.Print "User: " & objEvent.User
End Sub

' Event triggered to report the progress of an asynchronous operation
Sub mOrigin_OnProgress(ByVal iUpperBound As Long, ByVal iCurrent As Long, ByVal strMessage As String, ByVal objWbemAsyncContext As SWbemNamedValueSet)
    Debug.Print "report the progress of an asynchronous operation."
End Sub
#End If