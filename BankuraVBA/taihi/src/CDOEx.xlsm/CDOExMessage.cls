VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CDOExMessage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] CDO.Message�N���X�̃��b�v�E�g���N���X
'* [��  ��] CDO.Message�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          CDO.Message�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* [�Q  �l] <xx>
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' CDO.Message�N���X�ɂ��āB
' <xx>
' Defines an object used to manage a message.
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As CDO.Message
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
'* Attachments �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Object 's Attachments collection.
'*-----------------------------------------------------------------------------
Property Get Attachments() As CDOExIBodyParts
    Dim wrap As CDOExIBodyParts: Set wrap = New CDOExIBodyParts
    Set wrap.Origin = mOrigin.Attachments()
    Set Attachments = wrap
End Property

'*-----------------------------------------------------------------------------
'* AutoGenerateTextBody �v���p�e�B
'*
'* [��  ��]
'* �EIndicates whether a text/plain alternate representation should automatically be generated from the text/html part of the message body.
'*-----------------------------------------------------------------------------
Property Get AutoGenerateTextBody() As Boolean
    AutoGenerateTextBody = mOrigin.AutoGenerateTextBody
End Property
Property Let AutoGenerateTextBody(arg As Boolean)
    mOrigin.AutoGenerateTextBody = arg
End Property
    
'*-----------------------------------------------------------------------------
'* BCC �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's hidden carbon copy (BCC header) recipients.
'*-----------------------------------------------------------------------------
Property Get BCC() As String
    BCC = mOrigin.BCC
End Property
Property Let BCC(arg As String)
    mOrigin.BCC = arg
End Property

'*-----------------------------------------------------------------------------
'* BodyPart �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Object 's IBodyPart interface.
'*-----------------------------------------------------------------------------
Property Get BodyPart() As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.BodyPart()
    Set BodyPart = wrap
End Property

'*-----------------------------------------------------------------------------
'* CC �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's secondary (CC header) recipients.
'*-----------------------------------------------------------------------------
Property Get CC() As String
    CC = mOrigin.CC
End Property
Property Let CC(arg As String)
    mOrigin.CC = arg
End Property
    
'*-----------------------------------------------------------------------------
'* Configuration �v���p�e�B
'*
'* [��  ��]
'* �EThe Object 's Configuration object.
'*-----------------------------------------------------------------------------
Property Get Configuration() As CDOExConfiguration
    Dim wrap As CDOExConfiguration: Set wrap = New CDOExConfiguration
    Set wrap.Origin = mOrigin.Configuration()
    Set Configuration = wrap
End Property
Property Set Configuration(arg As CDOExConfiguration)
    Set mOrigin.Configuration = arg.Origin
End Property

'*-----------------------------------------------------------------------------
'* DataSource �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Object 's IDataSource interface.
'*-----------------------------------------------------------------------------
Property Get DataSource() As CDOExIDataSource
    Dim wrap As CDOExIDataSource: Set wrap = New CDOExIDataSource
    Set wrap.Origin = mOrigin.DataSource()
    Set DataSource = wrap
End Property

'*-----------------------------------------------------------------------------
'* DSNOptions �v���p�e�B
'*
'* [��  ��]
'* �EThe delivery status notification (DSN) options for the message.
'*-----------------------------------------------------------------------------
Property Get DSNOptions() As CdoDSNOptions
    DSNOptions = mOrigin.DSNOptions
End Property
Property Let DSNOptions(arg As CdoDSNOptions)
    mOrigin.DSNOptions = arg
End Property
   
'*-----------------------------------------------------------------------------
'* EnvelopeFields �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe transport envelope Fields collection for the message (transport event sinks only).
'*-----------------------------------------------------------------------------
Property Get EnvelopeFields() As ADODBExFields
    Dim wrap As ADODBExFields: Set wrap = New ADODBExFields
    Set wrap.Origin = mOrigin.EnvelopeFields()
    Set EnvelopeFields = wrap
End Property

'*-----------------------------------------------------------------------------
'* Fields �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Object 's Fields collection.
'*-----------------------------------------------------------------------------
Property Get Fields() As ADODBExFields
    Dim wrap As ADODBExFields: Set wrap = New ADODBExFields
    Set wrap.Origin = mOrigin.Fields()
    Set Fields = wrap
End Property

'*-----------------------------------------------------------------------------
'* FollowUpTo �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's follow-up recipients.
'*-----------------------------------------------------------------------------
Property Get FollowUpTo() As String
    FollowUpTo = mOrigin.FollowUpTo
End Property
Property Let FollowUpTo(arg As String)
    mOrigin.FollowUpTo = arg
End Property

'*-----------------------------------------------------------------------------
'* From �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's principle (From header) authors.
'*-----------------------------------------------------------------------------
Property Get From() As String
    From = mOrigin.From
End Property
Property Let From(arg As String)
    mOrigin.From = arg
End Property

'*-----------------------------------------------------------------------------
'* HTMLBody �v���p�e�B
'*
'* [��  ��]
'* �EThe text/html portion of the message body.
'*-----------------------------------------------------------------------------
Property Get HTMLBody() As String
    HTMLBody = mOrigin.HTMLBody
End Property
Property Let HTMLBody(arg As String)
    mOrigin.HTMLBody = arg
End Property

'*-----------------------------------------------------------------------------
'* HTMLBodyPart �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EReturns the BodyPart object (IBodyPart interface) containing the text/html portion of the message body.
'*-----------------------------------------------------------------------------
Property Get HTMLBodyPart() As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.HTMLBodyPart()
    Set HTMLBodyPart = wrap
End Property

'*-----------------------------------------------------------------------------
'* Keywords �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's keywords.
'*-----------------------------------------------------------------------------
Property Get Keywords() As String
    Keywords = mOrigin.Keywords
End Property
Property Let Keywords(arg As String)
    mOrigin.Keywords = arg
End Property

'*-----------------------------------------------------------------------------
'* MDNRequested �v���p�e�B
'*
'* [��  ��]
'* �EIndicates whether a mail delivery notification (MDN) should be sent when the message is received.
'*-----------------------------------------------------------------------------
Property Get MDNRequested() As Boolean
    MDNRequested = mOrigin.MDNRequested
End Property
Property Let MDNRequested(arg As Boolean)
    mOrigin.MDNRequested = arg
End Property

'*-----------------------------------------------------------------------------
'* MimeFormatted �v���p�e�B
'*
'* [��  ��]
'* �EIndicates whether the message is to be serialized using the MIME (True) or UUENCODE (False) format.
'*-----------------------------------------------------------------------------
Property Get MimeFormatted() As Boolean
    MimeFormatted = mOrigin.MimeFormatted
End Property
Property Let MimeFormatted(arg As Boolean)
    mOrigin.MimeFormatted = arg
End Property

'*-----------------------------------------------------------------------------
'* Newsgroups �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's newsgroup (Newsgroups header) recipients.
'*-----------------------------------------------------------------------------
Property Get Newsgroups() As String
    Newsgroups = mOrigin.Newsgroups
End Property
Property Let Newsgroups(arg As String)
    mOrigin.Newsgroups = arg
End Property

'*-----------------------------------------------------------------------------
'* Organization �v���p�e�B
'*
'* [��  ��]
'* �EThe Sender 's organization name.
'*-----------------------------------------------------------------------------
Property Get Organization() As String
    Organization = mOrigin.Organization
End Property
Property Let Organization(arg As String)
    mOrigin.Organization = arg
End Property

'*-----------------------------------------------------------------------------
'* ReceivedTime �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe date and time the message was received.
'*-----------------------------------------------------------------------------
Property Get ReceivedTime() As Date
    ReceivedTime = mOrigin.ReceivedTime
End Property

'*-----------------------------------------------------------------------------
'* ReplyTo �v���p�e�B
'*
'* [��  ��]
'* �EThe email addresses (Reply-To header) to which to reply.
'*-----------------------------------------------------------------------------
Property Get ReplyTo() As String
    ReplyTo = mOrigin.ReplyTo
End Property
Property Let ReplyTo(arg As String)
    mOrigin.ReplyTo = arg
End Property

'*-----------------------------------------------------------------------------
'* Sender �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's actual sender.
'*-----------------------------------------------------------------------------
Property Get Sender() As String
    Sender = mOrigin.Sender
End Property
Property Let Sender(arg As String)
    mOrigin.Sender = arg
End Property

'*-----------------------------------------------------------------------------
'* SentOn �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe date and time the message was sent.
'*-----------------------------------------------------------------------------
Property Get SentOn() As Date
    SentOn = mOrigin.SentOn
End Property

'*-----------------------------------------------------------------------------
'* Subject �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's subject (Subject header).
'*-----------------------------------------------------------------------------
Property Get Subject() As String
    Subject = mOrigin.Subject
End Property
Property Let Subject(arg As String)
    mOrigin.Subject = arg
End Property
    
'*-----------------------------------------------------------------------------
'* TextBody �v���p�e�B
'*
'* [��  ��]
'* �EThe text/plain portion of the message body.
'*-----------------------------------------------------------------------------
Property Get TextBody() As String
    TextBody = mOrigin.TextBody
End Property
Property Let TextBody(arg As String)
    mOrigin.TextBody = arg
End Property

'*-----------------------------------------------------------------------------
'* TextBodyPart �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EReturns the BodyPart object (IBodyPart interface) containing the text/plain part of the message body.
'*-----------------------------------------------------------------------------
Property Get TextBodyPart() As IBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.TextBodyPart()
    Set TextBodyPart = wrap
End Property

'*-----------------------------------------------------------------------------
'* To_ �v���p�e�B
'*
'* [��  ��]
'* �EThe Message 's principle (To header) recipients.
'*-----------------------------------------------------------------------------
Property Get To_() As String
    To_ = mOrigin.To
End Property
Property Let To_(arg As String)
    mOrigin.To = arg
End Property

    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("CDO.Message")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] AddAttachment ���\�b�h
'* [��  ��] AddAttachment �̃��b�p�[���\�b�h�B
'*          Adds an attachment (BodyPart) to the message.
'*
'* @param Msg
'* @return �R���N�V�����̗v�f��
'*
'******************************************************************************
Function AddAttachment(URL As String, Optional UserName As String, Optional Password As String) As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.AddAttachment(URL, UserName, Password)
    Set AddAttachment = wrap
End Function

'******************************************************************************
'* [�T  �v] AddRelatedBodyPart ���\�b�h
'* [��  ��] AddRelatedBodyPart �̃��b�p�[���\�b�h�B
'*          Adds a BodyPart object with content referenced within the text/html portion of the message body.
'*
'* @param URL
'* @param Reference
'* @param ReferenceType
'* @param UserName
'* @param Password
'* @return IBodyPart
'*
'******************************************************************************
Function AddRelatedBodyPart(URL As String, Reference As String, ReferenceType As CdoReferenceType, Optional UserName As String, Optional Password As String) As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.AddRelatedBodyPart(URL, Reference, ReferenceType, UserName, Password)
    Set AddRelatedBodyPart = wrap
End Function

'******************************************************************************
'* [�T  �v] CreateMHTMLBody ���\�b�h
'* [��  ��] CreateMHTMLBody �̃��b�p�[���\�b�h�B
'*          Creates an MHTML-formatted message body using the resource(s) at the specified URL.
'*
'* @param URL
'* @param Flags
'* @param UserName
'* @param Password
'*
'******************************************************************************
Sub CreateMHTMLBody(URL As String, Optional Flags As CdoMHTMLFlags = cdoSuppressNone, Optional UserName As String, Optional Password As String)
    Call mOrigin.CreateMHTMLBody(URL, Flags, UserName, Password)
End Sub

'******************************************************************************
'* [�T  �v] Forward ���\�b�h
'* [��  ��] Forward �̃��b�p�[���\�b�h�B
'*          Returns a Message object used to forward a message.
'*
'* @return Message
'*
'******************************************************************************
Function Forward() As CDOExMessage
    Dim wrap As CDOExMessage: Set wrap = New CDOExMessage
    Set wrap.Origin = mOrigin.Forward()
    Set Forward = wrap
End Function

'******************************************************************************
'* [�T  �v] GetInterface ���\�b�h
'* [��  ��] GetInterface �̃��b�p�[���\�b�h�B
'*          Returns a specified interface on this object; provided for script languages.
'*
'* @param Interface
'* @return Object
'*
'******************************************************************************
Function GetInterface(Interface As String) As Object
    Set GetInterface = mOrigin.GetInterface(Interface)
End Function

'******************************************************************************
'* [�T  �v] GetStream ���\�b�h
'* [��  ��] GetStream �̃��b�p�[���\�b�h�B
'*          Returns an ADO Stream object containing the message in serialized,
'*          RFC 822 format.
'*          The message body is encoded using either MIME or UUENCODE as
'*          specified by the MIMEFormatted property.
'*
'* @return stream
'*
'******************************************************************************
Function GetStream() As ADODBExStream
    Dim wrap As ADODBExStream: Set wrap = New ADODBExStream
    Set wrap.Origin = mOrigin.GetStream()
    Set GetStream = wrap
End Function

'******************************************************************************
'* [�T  �v] Post ���\�b�h
'* [��  ��] Post �̃��b�p�[���\�b�h�B
'*          Posts the message using the method specified in the associated Configuration object.
'*
'******************************************************************************
Sub Post()
    Call mOrigin.Post
End Sub


'******************************************************************************
'* [�T  �v] PostReply ���\�b�h
'* [��  ��] PostReply �̃��b�p�[���\�b�h�B
'*          Returns a Message object used to post a reply to the message.
'*
'* @return Message
'*
'******************************************************************************
Function PostReply() As CDOExMessage
    Dim wrap As CDOExMessage: Set wrap = New CDOExMessage
    Set wrap.Origin = mOrigin.PostReply()
    Set PostReply = wrap
End Function

'******************************************************************************
'* [�T  �v] Reply ���\�b�h
'* [��  ��] Reply �̃��b�p�[���\�b�h�B
'*          Returns a Message object used to reply to the message.
'*
'* @return Message
'*
'******************************************************************************
Function Reply() As CDOExMessage
    Dim wrap As CDOExMessage: Set wrap = New CDOExMessage
    Set wrap.Origin = mOrigin.Reply()
    Set Reply = wrap
End Function

'******************************************************************************
'* [�T  �v] ReplyAll ���\�b�h
'* [��  ��] ReplyAll �̃��b�p�[���\�b�h�B
'*          Returns a Message object used to post a reply to all recipients of the message.
'*
'* @return Message
'*
'******************************************************************************
Function ReplyAll() As Message
    Dim wrap As CDOExMessage: Set wrap = New CDOExMessage
    Set wrap.Origin = mOrigin.ReplyAll()
    Set ReplyAll = wrap
End Function

'******************************************************************************
'* [�T  �v] Send ���\�b�h
'* [��  ��] Send �̃��b�p�[���\�b�h�B
'*          Sends the message using the method specified in the associated Configuration object.
'*
'******************************************************************************
Sub Send()
    Call mOrigin.Send
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------