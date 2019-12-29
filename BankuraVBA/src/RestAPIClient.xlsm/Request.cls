VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Request"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Request�N���X
'* [��  ��] Request���̃f�[�^�N���X�B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mMethod As String
Private mUrl As String
Private mBody As String
Private mHeaders() As Header

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
' Method
Public Property Get method() As String
    method = mMethod
End Property
Public Property Set method(arg As String)
    mMethod = arg
End Property

' URL
Public Property Get url() As String
    url = mUrl
End Property
Public Property Set url(arg As String)
    mUrl = arg
End Property

' Body
Public Property Get Body() As String
    Body = mBody
End Property
Public Property Set Body(arg As String)
    mBody = arg
End Property

' Headers
Public Property Get Headers() As Variant
    Headers = mHeaders
End Property
Public Property Set Headers(arg() As Header)
    mHeaders = arg()
End Property