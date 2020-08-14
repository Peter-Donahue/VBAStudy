VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WinHttpExWinHttpRequest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WinHttp.WinHttpRequest�N���X�̃��b�v�E�g���N���X
'* [��  ��] WinHttp.WinHttpRequest�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WinHttp.WinHttpRequest�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WinHttp.WinHttpRequest�N���X�ɂ��āB
' <https://docs.microsoft.com/en-us/windows/win32/winhttp/winhttprequest>
' HTTP�v���g�R������đ���HTTP�T�[�o�[�ɗv���𑗐M����@�\��񋟂��܂��B
'
' [�C�x���g]
' Event OnError(ErrorNumber As Long, ErrorDescription As String)
' Event OnResponseDataAvailable(Data() As Byte)
' Event OnResponseFinished()
' Event OnResponseStart(Status As Long, ContentType As String)
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As WinHttpRequest
Private mOrigin As Object
Private mCharset As String

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
'* Option_ �v���p�e�B
'*
'* [��  ��]
'* �EOption�v���p�e�B�̑�ցB
'* �ESets or retrieves a WinHTTP option value.
'*-----------------------------------------------------------------------------
Property Get Option_(whrOption As WinHttpRequestOption)
    Option_ = mOrigin.Option
End Property
Property Let Option_(whrOption As WinHttpRequestOption, arg)
    mOrigin.Option(whrOption) = arg
End Property

'*-----------------------------------------------------------------------------
'* ResponseBody �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet response body as a safearray of UI1
'*-----------------------------------------------------------------------------
Property Get ResponseBody() As Variant
    If IsObject(mOrigin.ResponseBody) Then
        Set ResponseBody = mOrigin.ResponseBody
    Else
        ResponseBody = mOrigin.ResponseBody
    End If
End Property

'*-----------------------------------------------------------------------------
'* ResponseStream �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet response body as a stream
'*-----------------------------------------------------------------------------
Property Get ResponseStream() As Variant
    If IsObject(mOrigin.ResponseStream) Then
        Set ResponseStream = mOrigin.ResponseStream
    Else
        ResponseStream = mOrigin.ResponseStream
    End If
End Property

'*-----------------------------------------------------------------------------
'* ResponseText �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet response body as a string
'*-----------------------------------------------------------------------------
Property Get ResponseText() As String
    ResponseText = mOrigin.ResponseText
End Property

'*-----------------------------------------------------------------------------
'* Status �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet HTTP status code
'*-----------------------------------------------------------------------------
Property Get Status() As Long
    Status = mOrigin.Status
End Property

'*-----------------------------------------------------------------------------
'* StatusText �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EGet HTTP status text
'*-----------------------------------------------------------------------------
Property Get StatusText() As String
    StatusText = mOrigin.StatusText
End Property

'*-----------------------------------------------------------------------------
'* <�g��>CharSet �v���p�e�B
'*
'* [��  ��]
'* �ERequest/Response�̕����R�[�h���w�肷��B
'*-----------------------------------------------------------------------------
Property Get CharSet() As String
    CharSet = mCharset
End Property
Property Let CharSet(arg As String)
    mCharset = arg
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("WinHttp.WinHttpRequest.5.1")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Abort ���\�b�h
'* [��  ��] Abort �̃��b�p�[���\�b�h�B
'*          Abort an asynchronous operation in progress
'*
'******************************************************************************
Public Sub Abort()
    Call mOrigin.Abort
End Sub
    
'******************************************************************************
'* [�T  �v] GetAllResponseHeaders ���\�b�h
'* [��  ��] GetAllResponseHeaders �̃��b�p�[���\�b�h�B
'*          Get all HTTP response headers
'*
'* @return ResponseHeaders
'*         Receives the resulting header information.
'******************************************************************************
Public Function GetAllResponseHeaders() As String
    GetAllResponseHeaders = mOrigin.GetAllResponseHeaders
End Function
    
'******************************************************************************
'* [�T  �v] GetResponseHeader ���\�b�h
'* [��  ��] GetResponseHeader �̃��b�p�[���\�b�h�B
'*          Get HTTP response header
'*
'* @param Header ResponseHeader��
'*               Specifies the case-insensitive header name.
'* @return HTTPResponseHeader
'*         Receives the resulting header information.
'******************************************************************************
Public Function GetResponseHeader(Header As String) As String
    GetResponseHeader = mOrigin.GetResponseHeader(Header)
End Function
    
    
'******************************************************************************
'* [�T  �v] OpenConn ���\�b�h
'* [��  ��] Open �̃��b�p�[���\�b�h�B
'*          Open HTTP connection
'*
'* @param Method ���\�b�h
'*               Specifies the HTTP verb used for the Open method, such as
'*               "GET" or "PUT". Always use uppercase as some servers ignore
'*               lowercase HTTP verbs.
'* @param Url    URL
'*               Specifies the name of the resource. This must be an absolute URL.
'* @param Async  �ȗ��\�B�����E�񓯊��̎w��B�ȗ����͓����B
'*               Indicates whether to open in asynchronous mode.
'*                 False - Opens the HTTP connection in synchronous mode.
'*                         A call to Send does not return until WinHTTP has
'*                         completely received the response.
'*                 True  - Opens the HTTP connection in asynchronous mode.
'******************************************************************************
Public Sub OpenConn(method As String, Url As String, Optional Async As Variant = False)
    Call mOrigin.Open(method, Url, Async)
End Sub

'******************************************************************************
'* [�T  �v] Send ���\�b�h
'* [��  ��] Send �̃��b�p�[���\�b�h�B
'*          Send HTTP request
'*
'* @param Body  �ȗ��\�BData to be sent to the server.
'******************************************************************************
Public Sub Send(Optional Body)
    If IsMissing(Body) Then
       Call mOrigin.Send
    Else
       Call mOrigin.Send(Body)
    End If
End Sub

'******************************************************************************
'* [�T  �v] SetAutoLogonPolicy ���\�b�h
'* [��  ��] SetAutoLogonPolicy �̃��b�p�[���\�b�h�B
'*          Specify if credentials should be sent automatically
'*
'* @param AutoLogonPolicy Specifies the current automatic logon policy.
'******************************************************************************
Public Sub SetAutoLogonPolicy(AutoLogonPolicy As WinHttpRequestAutoLogonPolicy)
    Call mOrigin.SetAutoLogonPolicy(AutoLogonPolicy)
End Sub
    
'******************************************************************************
'* [�T  �v] SetClientCertificate ���\�b�h
'* [��  ��] SetClientCertificate �̃��b�p�[���\�b�h�B
'*          Specify a client certificate
'*
'* @param ClientCertificate Specifies the location, certificate store, and s
'*                          ubject of a client certificate.
'******************************************************************************
Public Sub SetClientCertificate(ClientCertificate As String)
    Call mOrigin.SetClientCertificate(ClientCertificate)
End Sub

'******************************************************************************
'* [�T  �v] SetCredentials ���\�b�h
'* [��  ��] SetCredentials �̃��b�p�[���\�b�h�B
'*          Specify authentication credentials
'*
'* @param UserName ���[�U��
'*                 Specifies the user name for authentication.
'* @param Password �p�X���[�h
'*                 Specifies the password for authentication.
'*                 This parameter is ignored if UserName is NULL or missing.
'* @param Flags    �t���O
'*                 Specifies when IWinHttpRequest uses credentials.
'*
'******************************************************************************
Public Sub SetCredentials(UserName As String, Password As String, Flags As HTTPREQUEST_SETCREDENTIALS_FLAGS)
    Call mOrigin.SetCredentials(UserName, Password, Flags)
End Sub
    
'******************************************************************************
'* [�T  �v] SetProxy ���\�b�h
'* [��  ��] SetProxy �̃��b�p�[���\�b�h�B
'*          Specify proxy configuration
'*
'* @param ProxySetting The flags that control this method.
'* @param ProxyServer  Set to a proxy server string when ProxySetting equals
'*                     HTTPREQUEST_PROXYSETTING_PROXY.
'* @param BypassList   Set to a domain bypass list string when ProxySetting
'*                     equals HTTPREQUEST_PROXYSETTING_PROXY.
'******************************************************************************
Public Sub SetProxy(ProxySetting As HTTPREQUEST_PROXY_SETTING, Optional ProxyServer, Optional BypassList)
    If IsMissing(ProxyServer) Then
        If IsMissing(BypassList) Then
            Call mOrigin.SetProxy(ProxySetting)
        Else
            Call mOrigin.SetProxy(ProxySetting, , BypassList)
        End If
    ElseIf IsMissing(BypassList) Then
        Call mOrigin.SetProxy(ProxySetting, ProxyServer)
    Else
        Call mOrigin.SetProxy(ProxySetting, ProxyServer, BypassList)
    End If
End Sub

'******************************************************************************
'* [�T  �v] SetRequestHeader ���\�b�h
'* [��  ��] SetRequestHeader �̃��b�p�[���\�b�h�B
'*          Add HTTP request header
'*
'* @param Header Header��
'*               Specifies the name of the header to be set, for example,
'*               "depth". This parameter should not contain a colon and must be
'*               the actual text of the HTTP header.
'* @param Value  ���ڒl
'*               Specifies the value of the header, for example, "infinity".
'*
'******************************************************************************
Public Sub SetRequestHeader(Header As String, Value As String)
    Call mOrigin.SetRequestHeader(Header, Value)
End Sub
    
'******************************************************************************
'* [�T  �v] SetTimeouts ���\�b�h
'* [��  ��] SetTimeouts �̃��b�p�[���\�b�h�B
'*          Specify timeout settings (in milliseconds)
'*
'* @param ResolveTimeout ���]�����^�C���A�E�g�l
'*                       Time-out value applied when resolving a host name
'*                       (such as www.microsoft.com) to an IP address (such
'*                       as 192.168.131.199), in milliseconds.
'*                       The default value is zero, meaning no time-out (infinite).
'*                       If DNS timeout is specified using NAME_RESOLUTION_TIMEOUT,
'*                       there is an overhead of one thread per request.
'* @param ConnectTimeout �ڑ��^�C���A�E�g�l
'*                       Time-out value applied when establishing a communication
'*                       socket with the target server, in milliseconds.
'*                       The default value is 60,000 (60 seconds).
'* @param SendTimeout    ���M�^�C���A�E�g�l
'*                       Time-out value applied when sending an individual packet
'*                       of request data on the communication socket to the target
'*                       server, in milliseconds. A large request sent to an HTTP
'*                       server are normally be broken up into multiple packets;
'*                       the send time-out applies to sending each packet
'*                       individually. The default value is 30,000 (30 seconds).
'* @param ReceiveTimeout ��M�^�C���A�E�g�l
'*                       Time-out value applied when receiving a packet of
'*                       response data from the target server, in milliseconds.
'*                       Large responses are be broken up into multiple packets;
'*                       the receive time-out applies to fetching each packet of
'*                       data off the socket.
'*                       The default value is 30,000 (30 seconds).
'******************************************************************************
Public Sub SetTimeouts(ResolveTimeout As Long, ConnectTimeout As Long, SendTimeout As Long, ReceiveTimeout As Long)
    Call mOrigin.SetTimeouts(ResolveTimeout, ConnectTimeout, SendTimeout, ReceiveTimeout)
End Sub

'******************************************************************************
'* [�T  �v] WaitForResponse ���\�b�h
'* [��  ��] WaitForResponse �̃��b�p�[���\�b�h�B
'*          Wait for asynchronous send to complete, with optional timeout (in seconds)
'*
'* @param Timeout �ȗ��\�B�^�C���A�E�g�l�B
'*                Time-out value, in seconds. Default time-out is infinite.
'*                To explicitly set time-out to infinite, use the value -1.
'* @return Receives one of the following values.
'*          True  - A response has been received.
'*          False - The specified time-out period was exceeded.
'******************************************************************************
Public Function WaitForResponse(Optional Timeout) As Boolean
    If IsMissing(Timeout) Then
       WaitForResponse = mOrigin.WaitForResponse()
    Else
       WaitForResponse = mOrigin.WaitForResponse(Timeout)
    End If
End Function


'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] ReNew ���\�b�h
'* [��  ��] WinHttpRequest�I�u�W�F�N�g���Đ�������B
'*
'******************************************************************************
Public Sub ReNew()
    Set mOrigin = Nothing
    Set mOrigin = CreateObject("WinHttp.WinHttpRequest.5.1")
End Sub

'******************************************************************************
'* [�T  �v] Post ���\�b�h
'* [��  ��] Post���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function Post(req As RequestDto) As ResponseDto
    req.method = "POST"
    Set Post = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] PutReq ���\�b�h
'* [��  ��] Put���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function PutReq(req As RequestDto) As ResponseDto
    req.method = "PUT"
    Set PutReq = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] Patch ���\�b�h
'* [��  ��] Patch���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function Patch(req As RequestDto) As ResponseDto
    req.method = "PATCH"
    Set Patch = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] GetReq ���\�b�h
'* [��  ��] Get���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function GetReq(req As RequestDto) As ResponseDto
    req.method = "GET"
    Set GetReq = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] Delete ���\�b�h
'* [��  ��] Delete���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function Delete(req As RequestDto) As ResponseDto
    req.method = "DELETE"
    Set Delete = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] Head ���\�b�h
'* [��  ��] Head���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function Head(req As RequestDto) As ResponseDto
    req.method = "HEAD"
    Set Head = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] OptionsReq ���\�b�h
'* [��  ��] Options���M���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function OptionsReq(req As RequestDto) As ResponseDto
    req.method = "OPTIONS"
    Set OptionsReq = Transmit(req)
End Function

'******************************************************************************
'* [�T  �v] Transmit ���\�b�h
'* [��  ��] �ȒP��Http�ʐM���s���B
'*
'* @param ResponseDto Request���
'* @return Response���
'*
'******************************************************************************
Public Function Transmit(req As RequestDto, Optional saveOriginalBody As Boolean = False) As ResponseDto
    Me.OpenConn req.method, req.Url, False
    SetRequestHeaders req
    If req.method = "GET" Or req.method = "DELETE" Or req.method = "HEAD" Or req.method = "OPTIONS" Then
        Me.Send
    Else
        Me.Send req.Body
    End If
    Set Transmit = SetResponseDto(saveOriginalBody)
End Function

'******************************************************************************
'* [�T  �v] SetRequestHeaders ���\�b�h
'* [��  ��] RequestDto��Header����ݒ肷��B
'*
'* @param Request���
'*
'******************************************************************************
Public Sub SetRequestHeaders(req As RequestDto)
    Dim v
    For Each v In req.Headers.keys
        Me.SetRequestHeader CStr(v), req.Headers(v)
    Next
End Sub

'******************************************************************************
'* [�T  �v] SetResponseDto ���\�b�h
'* [��  ��] Request���M���ʂ� ResponseDto �ɐݒ肷��B
'*
'* @param  saveOriginalBody �ȗ��\�BBody��Text���������̂܂ܕێ����邩�w��B
'* @return Response���
'*
'******************************************************************************
Public Function SetResponseDto(Optional saveOriginalBody As Boolean = False) As ResponseDto
    Dim Status As String:     Status = Me.Status
    Dim statusTxt As String:  statusTxt = Me.StatusText
    Dim resHeaders As String: resHeaders = Me.GetAllResponseHeaders
    Dim encode As String: encode = IIf(mCharset <> "", mCharset, "utf-8")
    
    Dim resBody As Variant
    Const adTypeBinary = 1
    Const adTypeText = 2
    Const adReadAll = -1
    
    If saveOriginalBody Then
        resBody = Me.ResponseBody
    Else
        With CreateObject("ADODB.Stream")
            .Type = adTypeBinary
            .Open
            .Write Me.ResponseBody
            .Position = 0
            .Type = adTypeText
            .CharSet = encode
            resBody = .ReadText(adReadAll)
            .Close
        End With
    End If
  
    ' ���X�|���X�ݒ�
    Dim res As ResponseDto: Set res = New ResponseDto
    res.StatusCd = Status
    res.StatusText = statusTxt
    res.Body = resBody
    res.Headers = resHeaders
    
    Set SetResponseDto = res
End Function

'******************************************************************************
'* [�T  �v] SendRequest ���\�b�h
'* [��  ��] Http���N�G�X�g�𑗐M����B
'*
'* @param method         ���\�b�h�iGET,POST,PUT,DELETE,HEAD,OPTIONS,PATCH�j
'* @param url            �A�N�Z�X����URL�i��Fhttp://localhost:8080/api/v2/test�j
'* @param reqHdrParams() Header�p�����[�^(2�����z��)
'*                       ��2�C���f�b�N�X �c 0:name, 1:value
'* @param reqBody        Body
'* @param lTimeout       �^�C���A�E�g���ԁi�~���b�j�@���C��
'* @param resEncode      ���X�|���X�G���R�[�h�@���C��
'* @return Response���
'*
'******************************************************************************
Public Function SendRequest(method As String, Url As String, reqHdrParams() As String, reqBody As String, _
                            Optional lTimeout As Long = 0, _
                            Optional resEncode As String = "utf-8") As ResponseDto
    ' HTTP ���N�G�X�g
    Me.OpenConn method, Url, False

    ' ���N�G�X�g�w�b�_�ݒ�
    Dim i As Long
    If GetDimension(reqHdrParams) <> 0 Then
        For i = 0 To UBound(reqHdrParams, 1)
            Me.SetRequestHeader reqHdrParams(i, 0), reqHdrParams(i, 1)
        Next i
    End If

    ' �^�C���A�E�g�ݒ�
    If lTimeout > 0 Then
        Me.SetTimeouts lTimeout, lTimeout, lTimeout, lTimeout
    End If
    
    ' ���N�G�X�g���M
    If method = "GET" Or method = "DELETE" Or method = "HEAD" Or method = "OPTIONS" Then
        Me.Send
    Else
        Me.Send reqBody
    End If

    Set SendRequest = SetResponseDto
End Function

'******************************************************************************
'* [�T  �v] DownloadFile ���\�b�h
'* [��  ��] �t�@�C�����_�E�����[�h����B
'*
'* @param  req Request���
'* @param  saveFilePath �_�E�����[�h�t�@�C���ۑ���t���p�X
'* @return Response���
'*
'******************************************************************************
Public Function DownloadFile(req As RequestDto, saveFilePath As String) As ResponseDto
    Const adTypeBinary = 1
    Const adSaveCreateOverWrite = 2

    Set DownloadFile = Transmit(req, True)
    
    If Me.Status >= 200 And Me.Status < 400 Then
        With CreateObject("ADODB.Stream")
            .Type = adTypeBinary
            .Open
            .Write Me.ResponseBody
            .SaveToFile saveFilePath, adSaveCreateOverWrite
            .Close
        End With
    End If
End Function

'******************************************************************************
'* [�T  �v] SetEnableRedirects ���\�b�h
'* [��  ��] ���_�C���N�g�L��/������ݒ肷��B
'*
'* @param enable ���_�C���N�g�L��/�����iTrue:�L��, False:�����j
'*
'******************************************************************************
Public Sub SetEnableRedirects(enable As Boolean)
    Me.Option_(WinHttpRequestOption_EnableRedirects) = enable
End Sub


'******************************************************************************
'* [�T  �v] �����擾�����B
'* [��  ��] �w�肵���z�񂪉������̔z�񂩔��肷��B
'*
'* @param targetArray �ΏۂƂȂ�z��
'* @return ������
'******************************************************************************
Private Function GetDimension(targetArray As Variant) As Long
    Dim dimention As Long
    Dim tmp As Long
    
    dimention = 1
    On Error Resume Next
    While Err.Number = 0
        tmp = UBound(targetArray, dimention)
        dimention = dimention + 1
    Wend
    GetDimension = dimention - 2
End Function

'******************************************************************************
'* [�T  �v] URL�G���R�[�h�����B
'* [��  ��] URL�G���R�[�h���s���B
'*          ����ScriptControl���֐����g�p�����A���O�ŃG���R�[�h���Ă���̂�
'*          �ǂ�Excel�o�[�W�����E32bit/64bit�ł��g�p�\�B
'*
'* @param target �ΏۂƂȂ镶����
'* @return �G���R�[�h�㕶����
'******************************************************************************
Private Function EncodeUrl(target As String) As String
    Dim buf() As Byte, s As String, i As Long
    
    With CreateObject("ADODB.Stream")
        .Mode = 3 'adModeReadWrite
        .Open
        .Type = 2 'adTypeText
        .CharSet = "UTF-8"
        .WriteText target
        
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