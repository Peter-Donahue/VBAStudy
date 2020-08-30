VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "HttpRequest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] HttpRequest�N���X
'* [��  ��] Request���̃f�[�^�N���X�B
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mMethod As String
Private mUrl As String
Private mBody As String
'Private mHeaders As Dictionary
'Private mParams As Dictionary
Private mHeaders As Object
Private mParams As Object

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
' Method
Public Property Get method() As String
    method = mMethod
End Property
Public Property Let method(arg As String)
    mMethod = arg
End Property

' URL
Public Property Get Url() As String
    If mParams.Count > 0 Then
        Url = mUrl & "?" & GetRequestParamsString
    Else
        Url = mUrl
    End If
End Property
Public Property Let Url(arg As String)
    mUrl = arg
End Property

' Body
Public Property Get Body() As String
    Body = mBody
End Property
Public Property Let Body(arg As String)
    mBody = arg
End Property

' Headers
Public Property Get Headers() As Object
    Set Headers = mHeaders
End Property
Public Property Set Headers(arg As Object)
    Set mHeaders = arg
End Property

' Params
Public Property Get Params() As Object
    Set Headers = mParams
End Property
Public Property Set Params(arg As Object)
    Set mParams = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mHeaders = CreateObject("Scripting.Dictionary")
    Set mParams = CreateObject("Scripting.Dictionary")
End Sub
Private Sub Class_Terminate()
    Set mHeaders = Nothing
    Set mParams = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] SetRequestHeader ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_��ݒ肷��B
'*
'* @param headerName  Header��
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetRequestHeader(headerName As String, Optional headerValue As String = "")
    If headerValue = "" Then
        mHeaders.Remove headerName
    Else
        mHeaders.Add headerName, headerValue
    End If
End Sub

'******************************************************************************
'* [�T  �v] SetRequestParam ���\�b�h
'* [��  ��] �N�G���p�����[�^��ݒ肷��B
'*
'* @param paramName  �p�����[�^��
'* @param paramValue ���ڒl
'*
'******************************************************************************
Public Sub SetRequestParam(paramName As String, Optional paramValue As String = "")
    If paramValue = "" Then
        mParams.Remove paramName
    Else
        mParams.Add paramName, paramValue
    End If
End Sub

'******************************************************************************
'* [�T  �v] SetRequestParam ���\�b�h
'* [��  ��] �N�G���p�����[�^��ݒ肷��B
'*
'* @param paramName  �p�����[�^��
'* @param paramValue ���ڒl
'*
'******************************************************************************
Public Function GetRequestParamsString() As String
    Dim tmp As String, i As Long: i = 1
    Dim vKey
    Dim varKey: varKey = mParams.keys
    For Each vKey In varKey
        If i = 1 Then
            tmp = vKey & "=" & EncodeUrl(mParams(vKey))
        Else
            tmp = tmp & "&" & vKey & "=" & EncodeUrl(mParams(vKey))
        End If
        i = i + 1
    Next
    GetRequestParamsString = tmp
End Function

'******************************************************************************
'* [�T  �v] SetReqHeaderContentType ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Content-Type"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderContentType(headerValue As String)
    SetRequestHeader "Content-Type", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderConnection ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Connection"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderConnection(headerValue As String)
    SetRequestHeader "Connection", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderCookie ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Cookie"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderCookie(headerValue As String)
    SetRequestHeader "Cookie", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderAccept ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Accept"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderAccept(headerValue As String)
    SetRequestHeader "Accept", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderUserAgent ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"User-Agent"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderUserAgent(headerValue As String)
    SetRequestHeader "User-Agent", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderReferer ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Referer"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderReferer(headerValue As String)
    SetRequestHeader "Referer", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderAcceptLanguage ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Accept-Language"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderAcceptLanguage(headerValue As String)
    SetRequestHeader "Accept-Language", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderAcceptEncoding ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Accept-Encoding"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderAcceptEncoding(headerValue As String)
    SetRequestHeader "Accept-Encoding", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderHost ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Host"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderHost(headerValue As String)
    SetRequestHeader "Host", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderCacheControl ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Cache-Control"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderCacheControl(headerValue As String)
    SetRequestHeader "Cache-Control", headerValue
End Sub

'******************************************************************************
'* [�T  �v] SetReqHeaderAuthorization ���\�b�h
'* [��  ��] ���N�G�X�g�w�b�_"Authorization"��ݒ肷��B
'*
'* @param headerValue ���ڒl
'*
'******************************************************************************
Public Sub SetReqHeaderAuthorization(headerValue As String)
    SetRequestHeader "Authorization", headerValue
End Sub

'******************************************************************************
'* [�T  �v] URL�G���R�[�h�����B
'* [��  ��] URL�G���R�[�h���s���B
'*          ����ScriptControl���֐����g�p�����A���O�ŃG���R�[�h���Ă���̂�
'*          �ǂ�Excel�o�[�W�����E32bit/64bit�ł��g�p�\�B
'*
'* @param target �ΏۂƂȂ镶����
'* @return �G���R�[�h�㕶����
'******************************************************************************
Private Function EncodeUrl(Target As String) As String
    Dim buf() As Byte, s As String, i As Long
    
    With CreateObject("ADODB.Stream")
        .Mode = 3 'adModeReadWrite
        .Open
        .Type = 2 'adTypeText
        .charSet = "UTF-8"
        .WriteText Target
        
        .Position = 0
        .Type = 1 'adTypeBinary
        .Position = 3 'BOM��΂�
        buf = .Read
        .Close
    End With

    For i = 0 To UBound(buf)
        Dim flg As Boolean: flg = False
        Select Case buf(i)
            Case 45, 46, 95, 126 '-._~
                flg = True
            Case 48 To 57 '0-9
                flg = True
            Case 65 To 90 'A-Z
                flg = True
            Case 97 To 122 'a-z
                flg = True
        End Select
        If flg Then
            s = s & Chr(buf(i))
        Else
            s = s & "%" & Hex(buf(i))
        End If
    Next
    EncodeUrl = s
End Function