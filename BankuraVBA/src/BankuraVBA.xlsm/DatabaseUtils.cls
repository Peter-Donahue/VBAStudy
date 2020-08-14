VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DatabaseUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Database���[�e�B���e�B�N���X
'* [��  ��] Database�Ɋւ��郆�[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* WindowsAPI��`
'******************************************************************************

'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mConn As Object

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mConn = CreateObject("ADODB.Connection")
End Sub
Private Sub Class_Terminate()
    If Not mConn Is Nothing Then
        If mConn.State <> adStateClosed Then
            Call mConn.Close
        End If
    End If
    Set mConn = Nothing
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] OpenPostgreSql ���\�b�h
'* [��  ��] PostgreSql�f�[�^�x�[�X�ւ̐ڑ����J���
'*          PostgreSql�ڑ���������쐬���AConnection.Open ���\�b�h�����s����B
'*
'* @param Server   �ڑ���T�[�o��
'* @param Port     �ڑ���|�[�g�ԍ�
'* @param Database �ڑ���f�[�^�x�[�X��
'* @param UserID   �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p���郆�[�U�[���B
'* @param Password �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p����p�X���[�h�B
'* @param Options  �ȗ��\�B�ڑ����m�����ꂽ�� (����) �܂��͐ڑ���
'*                 �m�������O (�񓯊�) �̂ǂ���ł��̃��\�b�h���Ԃ�
'*                 �����w�肷�� ConnectOptionEnum �l�B
'******************************************************************************
Sub OpenPostgreSql(Server As String, _
                   Port As Integer, _
                   Database As String, _
                   Optional UserID As String, _
                   Optional Password As String, _
                   Optional Options As Long = -1)
    Dim cnnStr As String
    cnnStr = "Driver={PostgreSQL};" & _
             "Server=" & Server & ";" & _
             "Port=" & Port & ";" & _
             "Database=" & Database
    Call mConn.Open(cnnStr, UserID, Password, Options)
End Sub


'******************************************************************************
'* [�T  �v] SQL�\�������B
'* [��  ��] SQL�̖����p�����[�^���u?�v����u��������B
'* [�Q  �l] <http://kagen88.blogspot.com/2012/12/adodbcommand.html>
'*
'* @return SQL������
'******************************************************************************
' adArray
' adBigInt
' adBinary
' adBoolean
' adBSTR
' adChapter
' adChar
' adCurrency
' adDate
' adDBDate
' adDBTime
' adDBTimeStamp
' adDecimal
' adDouble
' adEmpty
' adError
' adFileTime
' adGUID
' adIDispatch
' adInteger
' adIUnknown
' adLongVarBinary
' adLongVarChar
' adLongVarWChar
' adNumeric
' adPropVariant
' adSingle
' adSmallInt
' adTinyInt
' adUnsignedBigInt
' adUnsignedInt
' adUnsignedSmallInt
' adUnsignedTinyInt
' adUserDefined
' adVarBinary
' adVarChar
' adVariant
' adVarNumeric
' adVarWChar
' adWChar
'Public Function PrintSql() As String
'    Dim p As Variant
'    Dim v As Variant
'    Dim i As Integer
'    Dim s As String
'    i = 1
'    ReDim v(Me.Parameters.Count)
'    For Each p In mOrigin.Parameters '��
'        Select Case p.Type
'            '�����̓j�[�Y�ɉ����ă^�C�v��ǉ�
'            Case adInteger
'                v(i) = p.Value
'            Case Else
'                v(i) = "'" & p.Value & "'"
'        End Select
'        i = i + 1
'    Next
'    s = mOrigin.CommandText '��
'    For i = 1 To UBound(v)
'        s = Replace(s, "?", v(i), 1, 1)
'    Next
'    PrintSql = s
'End Function

