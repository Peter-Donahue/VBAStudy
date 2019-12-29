VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CDOExIBodyPart"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] CDO.IBodyPart�N���X�̃��b�v�E�g���N���X
'* [��  ��] CDO.IBodyPart�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          CDO.IBodyPart�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* [�Q  �l] <xx>
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' CDO.IBodyPart�N���X�ɂ��āB
' <xx>
' Defines methods, properties, and collections used to manage a message body part.
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As CDO.IBodyPart
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
'* Count �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �EThe Object 's BodyParts collection.
'*-----------------------------------------------------------------------------
Property Get BodyParts() As CDOExIBodyParts
    Dim wrap As CDOExIBodyParts: Set wrap = New CDOExIBodyParts
    Set wrap.Origin = mOrigin.BodyParts()
    Set BodyParts = wrap
End Property

'*-----------------------------------------------------------------------------
'* Charset �v���p�e�B
'*
'* [��  ��]
'* The character set of the body part's text content (not applicable for non-text content types).
'*-----------------------------------------------------------------------------
Property Get CharSet() As String
    CharSet = mOrigin.CharSet
End Property
Property Let CharSet(arg As String)
    mOrigin.CharSet = arg
End Property

'*-----------------------------------------------------------------------------
'* ContentClass �v���p�e�B
'*
'* [��  ��]
'* The body part's content class.
'*-----------------------------------------------------------------------------
Property Get ContentClass() As String
    ContentClass = mOrigin.ContentClass
End Property
Property Let ContentClass(arg As String)
    mOrigin.ContentClass = arg
End Property

'*-----------------------------------------------------------------------------
'* ContentClassName �v���p�e�B
'*
'* [��  ��]
'* Deprecated. Do not use.
'*-----------------------------------------------------------------------------
Property Get ContentClassName() As String
    ContentClassName = mOrigin.ContentClassName
End Property
Property Let ContentClassName(arg As String)
    mOrigin.ContentClassName = arg
End Property

'*-----------------------------------------------------------------------------
'* ContentMediaType �v���p�e�B
'*
'* [��  ��]
'* The content media type portion of the body part's content type.
'*-----------------------------------------------------------------------------
Property Get ContentMediaType() As String
    ContentMediaType = mOrigin.ContentMediaType
End Property
Property Let ContentMediaType(arg As String)
    mOrigin.ContentMediaType = arg
End Property

'*-----------------------------------------------------------------------------
'* ContentTransferEncoding �v���p�e�B
'*
'* [��  ��]
'* The method used to encode the body part content. For example, quoted-printable or base64.
'*-----------------------------------------------------------------------------
Property Get ContentTransferEncoding() As String
    ContentTransferEncoding = mOrigin.ContentTransferEncoding
End Property
Property Let ContentTransferEncoding(arg As String)
    mOrigin.ContentTransferEncoding = arg
End Property

'*-----------------------------------------------------------------------------
'* DataSource �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* The Object 's IDataSource interface.
'*-----------------------------------------------------------------------------
Property Get DataSource() As CDOExIDataSource
    Dim wrap As CDOExIDataSource: Set wrap = New CDOExIDataSource
    Set wrap.Origin = mOrigin.DataSource()
    Set DataSource = wrap
End Property

'*-----------------------------------------------------------------------------
'* Fields �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* The Object 's Fields collection.
'*-----------------------------------------------------------------------------
Property Get Fields() As ADODBExFields
    Dim wrap As ADODBExFields: Set wrap = New ADODBExFields
    Set wrap.Origin = mOrigin.Fields()
    Set Fields = wrap
End Property
    
'*-----------------------------------------------------------------------------
'* FileName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* The value of the filename parameter for the content-disposition MIME header.
'*-----------------------------------------------------------------------------
Property Get FileName() As String
    FileName = mOrigin.FileName
End Property

'*-----------------------------------------------------------------------------
'* Parent �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* The Object 's parent object in the body part hierarchy.
'*-----------------------------------------------------------------------------
Property Get Parent() As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.Parent()
    Set Parent = wrap
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    'Set mOrigin = CreateObject("CDO.IBodyPart")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] AddBodyPart ���\�b�h
'* [��  ��] AddBodyPart �̃��b�p�[���\�b�h�B
'*          Adds a body part to the object's BodyParts collection.
'*
'* @param Index xx
'* @return IBodyPart
'******************************************************************************
Function AddBodyPart(Optional Index As Long = -1) As CDOExIBodyPart
    Dim wrap As CDOExIBodyPart: Set wrap = New CDOExIBodyPart
    Set wrap.Origin = mOrigin.AddBodyPart(Index)
    Set AddBodyPart = wrap
End Function

'******************************************************************************
'* [�T  �v] GetDecodedContentStream ���\�b�h
'* [��  ��] GetDecodedContentStream �̃��b�p�[���\�b�h�B
'*          Returns a Stream object containing the body part content in decoded format.
'*
'* @return stream
'******************************************************************************
Function GetDecodedContentStream() As ADODBExStream
    Dim wrap As ADODBExStream: Set wrap = New ADODBExStream
    Set wrap.Origin = mOrigin.GetDecodedContentStream()
    Set GetDecodedContentStream = wrap
End Function

'******************************************************************************
'* [�T  �v] GetEncodedContentStream ���\�b�h
'* [��  ��] GetEncodedContentStream �̃��b�p�[���\�b�h�B
'*          Returns a Stream object containing the body part content in encoded format. The encoding method is specified in the ContentTransferEncoding property.
'*
'* @return stream
'******************************************************************************
Function GetEncodedContentStream() As ADODBExStream
    Dim wrap As ADODBExStream: Set wrap = New ADODBExStream
    Set wrap.Origin = mOrigin.GetEncodedContentStream()
    Set GetEncodedContentStream = wrap
End Function

    
'******************************************************************************
'* [�T  �v] GetFieldParameter ���\�b�h
'* [��  ��] GetFieldParameter �̃��b�p�[���\�b�h�B
'*          Returns the specified parameter from the body part's specified header field.
'*
'* @param FieldName xx
'* @param Parameter xx
'* @return String
'******************************************************************************
Function GetFieldParameter(FieldName As String, Parameter As String) As String
    GetFieldParameter = mOrigin.GetFieldParameter(FieldName, Parameter)
End Function

'******************************************************************************
'* [�T  �v] GetInterface ���\�b�h
'* [��  ��] GetInterface �̃��b�p�[���\�b�h�B
'*          Returns a specified interface on this object; provided for script languages.
'*
'* @param Interface xx
'* @return Object
'******************************************************************************
Function GetInterface(Interface As String) As Object
    Set GetInterface = mOrigin.GetInterface(Interface)
End Function

    
'******************************************************************************
'* [�T  �v] GetStream ���\�b�h
'* [��  ��] GetStream �̃��b�p�[���\�b�h�B
'*          Returns an ADO Stream object containing the body part in serialized, MIME encoded format.
'*
'* @return stream
'******************************************************************************
Function GetStream() As ADODBExStream
    Dim wrap As ADODBExStream: Set wrap = New ADODBExStream
    Set wrap.Origin = mOrigin.GetStream()
    Set GetStream = wrap
End Function

'******************************************************************************
'* [�T  �v] SaveToFile ���\�b�h
'* [��  ��] SaveToFile �̃��b�p�[���\�b�h�B
'*          Saves the body part content to the specified file.
'*
'* @param FileName xx
'******************************************************************************
Sub SaveToFile(FileName As String)
    Call mOrigin.SaveToFile(FileName)
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------
