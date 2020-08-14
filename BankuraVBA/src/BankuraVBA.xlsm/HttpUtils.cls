VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "HttpUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Http�ʐM���[�e�B���e�B�N���X
'* [��  ��] Http�ʐM�Ɋւ��郆�[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mWinApi As WinAPI

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mWinApi = Base.GetWinAPI()
End Sub
Private Sub Class_Terminate()
    Set mWinApi = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************


'******************************************************************************
' [�֐���] DownloadFileByUrl
' [���@��] �w�肵��URL����t�@�C�����_�E�����[�h���A�w�肵���ۑ���i�t�@�C���j
'          �ɕۑ�����B
' [���@��] strFileUrl �_�E�����[�h�Ώۂ�URL
'          strSavePath �ۑ���t�@�C�����i�t���p�X�j
' [�߂�l] Boolean �������ʁiTrue:���� False�F�ُ�j
'******************************************************************************
Public Function DownloadFileByUrl(strFileUrl As String, strSavePath As String) As Boolean

    Dim lngCacheDelRs As Long
    Dim lngDlRs As Long

    ' �L���b�V���N���A
    lngCacheDelRs = mWinApi.DeleteUrlCacheEntry(strFileUrl)
    
    ' URL����t�@�C�����_�E�����[�h���ĕۑ�
    lngDlRs = mWinApi.URLDownloadToFile(0, strFileUrl, strSavePath, 0, 0)

    If lngDlRs <> 0 Then
        DownloadFileByUrl = False
        Exit Function
    End If
    DownloadFileByUrl = True
End Function

'******************************************************************************
'* [�T  �v] Http���N�G�X�g�𑗐M���A���X�|���X���擾�E�ԋp����B
'* [��  ��] �uWinHttp.WinHttpRequest.5.1�v���g�p���āAHttp���N�G�X�g�𑗐M
'*          ����B
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
Public Function SendRequest(Method As String, Url As String, reqHdrParams() As String, reqBody As String, _
                            Optional lTimeout As Long = 0, _
                            Optional resEncode As String = "utf-8") As HttpResponse
    Dim winHttp As Variant
    Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")

    ' HTTP ���N�G�X�g
    winHttp.Open Method, Url, False
    
    ' ���N�G�X�g�w�b�_�ݒ�
    Dim i As Long
    If ArrayUtils.GetDimension(reqHdrParams) <> 0 Then
        For i = 0 To UBound(reqHdrParams, 1)
            winHttp.SetRequestHeader reqHdrParams(i, 0), reqHdrParams(i, 1)
        Next i
    End If

    ' �^�C���A�E�g�ݒ�
    If lTimeout > 0 Then
        winHttp.SetTimeouts lTimeout, lTimeout, lTimeout, lTimeout
    End If
    
    ' ���N�G�X�g���M
    If Method = "GET" Or Method = "DELETE" Or Method = "HEAD" Or Method = "OPTIONS" Then
        winHttp.Send
    Else
        winHttp.Send reqBody
    End If
    
    ' �X�e�[�^�X�ƃ��X�|���X�{�f�B�̎擾
    Dim status As String:     status = winHttp.status
    Dim statusTxt As String:  statusTxt = winHttp.StatusText
    Dim resHeaders As String: resHeaders = winHttp.GetAllResponseHeaders
    Dim resBody As String
    Const adTypeBinary = 1
    Const adTypeText = 2
    Const adReadAll = -1
    With CreateObject("ADODB.Stream")
        .Type = adTypeBinary
        .Open
        .Write winHttp.ResponseBody
        .Position = 0
        .Type = adTypeText
        .charset = resEncode
        resBody = .ReadText(adReadAll)
        .Close
    End With
  
    ' ���X�|���X�ݒ�
    Dim res As HttpResponse: Set res = New HttpResponse
    res.StatusCd = status
    res.StatusText = statusTxt
    res.Body = resBody
    res.Headers = resHeaders
    
    Set SendRequest = res

End Function

'******************************************************************************
'* [�T  �v] URL�G���R�[�h�����iUTF-8�j�B
'* [��  ��] URL�G���R�[�h���s���B
'*
'* @param target �ΏۂƂȂ镶����
'* @return �G���R�[�h�㕶����
'******************************************************************************
Public Function EncodeUrl(Target As String) As String
    Dim xlBit As String
    xlBit = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%")
    '32Bit��Excel�̏ꍇ��ScriptControl�Ŏg�p
    If xlBit = "x86" Then
        EncodeUrl = EncodeUrlFor32(Target)
    Else
        ' 64Bit�ł�Excel2010�ȑO�̏ꍇ���O�����ł��g�p
        Dim ver As Integer: ver = CInt(Application.Version)
        If ver <= 14 Then
            EncodeUrl = EncodeUrlMyP(Target)
            'PowerShell�ł͎g�p���Ȃ�
            'EncodeURL = EncodeURLByPs(target)
        ' 64Bit�ł�Excel2013�ȍ~�̏ꍇ��Excel�֐��g�p
        Else
            EncodeUrl = EncodeUrlForXl2013OrLater(Target)
        End If
    End If

End Function

'******************************************************************************
'* [�T  �v] URL�G���R�[�h�����B
'* [��  ��] URL�G���R�[�h���s���BExcel2010�ȑO��64bit�p�BPowerShell���g�p����B
'*
'* @param target �ΏۂƂȂ镶����
'* @param pEncode encode�w��ishift-jis���j
'* @return �G���R�[�h�㕶����
'******************************************************************************
Private Function EncodeURLByPs(Target As String, Optional pEncode As String = "utf-8") As String
    Dim cmd
    Dim i As Long, c As Long
    Dim tmp As String, flg As Boolean
    flg = False
    
    For i = 1 To Len(Target)
        tmp = Mid(Target, i, 1)
        c = Asc(tmp)
        Select Case tmp
            ' �\�񕶎��̏ꍇ
            Case ":", "/", "?", "#", "[", "]", "@", "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
                flg = True
                Exit For
        End Select
        If c < 33 Or c > 127 Then
                flg = True
                Exit For
        End If
    Next
    ' TODO�F�����������Ɠr���Ő؂��
    If flg Then
        Target = Replace(Target, "`", "``")
        Target = Replace(Target, """", "`""""""")
        cmd = "PowerShell -Command ""[void]([Reflection.Assembly]::LoadWithPartialName(""""""System.Web""""""));[Web.HttpUtility]::UrlEncode(""""""" & Target & """"""", [Text.Encoding]::GetEncoding(""""""" & pEncode & """""""))"""
        With CreateObject("WScript.Shell").Exec(cmd)
            Do While (.status = 0)
                DoEvents
            Loop
            EncodeURLByPs = .stdOut.ReadLine
        End With
        Exit Function
    End If
    EncodeURLByPs = Target
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
Private Function EncodeUrlMyP(Target As String) As String
    Dim buf() As Byte, s As String, i As Long
    
    With CreateObject("ADODB.Stream")
        .Mode = 3 'adModeReadWrite
        .Open
        .Type = 2 'adTypeText
        .charset = "UTF-8"
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
    EncodeUrlMyP = s
End Function

'******************************************************************************
'* [�T  �v] URL�G���R�[�h�����B
'* [��  ��] URL�G���R�[�h���s���BExcel2013�ȍ~�Ŏg�p�\�B
'*
'* @param target �ΏۂƂȂ镶����
'* @return �G���R�[�h�㕶����
'******************************************************************************
Private Function EncodeUrlForXl2013OrLater(Target As String) As String
    EncodeUrlForXl2013OrLater = Application.WorksheetFunction.EncodeUrl(Target)
End Function

'******************************************************************************
'* [�T  �v] URL�G���R�[�h�����B
'* [��  ��] URL�G���R�[�h���s���B64bit�ł͎g���Ȃ��B
'*
'* @param target �ΏۂƂȂ镶����
'* @return �G���R�[�h�㕶����
'******************************************************************************
Private Function EncodeUrlFor32(Target As String) As String
    Dim sc As Object

    Set sc = CreateObject("ScriptControl")
    sc.Language = "Jscript"
    EncodeUrlFor32 = sc.CodeObject.encodeURIComponent(Target)
    Set sc = Nothing

End Function


