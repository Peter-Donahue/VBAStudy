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
'* [�Q  �l] http://kojama.la.coocan.jp/works/rdbms/conn/connstr.html
'*          https://excel-ubara.com/excelvba4/EXCEL273.html
'*
'* [��  ��] ODBC�h���C�o
'*          <Oracle ODBC Driver (Oracle Instant Client����)>
'*            https://www.oracle.com/database/technologies/instant-client/downloads.html
'*          <Microsoft ODBC for Oracle (32bit�̂�:Oracle 8 �܂ŁBOracle�ł𐄏�)>
'*            Windows�����B�ȉ��ɂ��ƁA����̃o�[�W������ Windows �ł͍폜�����\��̂��ߎg�p���Ȃ��B
'*            https://docs.microsoft.com/ja-jp/sql/odbc/microsoft/odbc-driver-for-oracle?view=sql-server-ver15
'*          <ODBC Driver for SQL Server>
'*            https://docs.microsoft.com/ja-jp/sql/connect/odbc/download-odbc-driver-for-sql-server
'*          <psqlODBC (PostgreSQL ODBC Driver)>
'*            https://www.postgresql.org/ftp/odbc/versions/msi/
'*          <MySQL Connector/ODBC>
'*            https://dev.mysql.com/downloads/connector/odbc/
'*          <SQLite ODBC Driver>
'*            http://www.ch-werner.de/sqliteodbc/
'*          <Microsoft Access �f�[�^�x�[�X �G���W�� 2016 �ĔЕz�\�R���|�[�l���g(ODBC/OLEDB����)>
'*            https://www.microsoft.com/en-us/download/details.aspx?id=54920
'*
'*          OLEDB�v���o�C�_
'*          <Oracle OLEDB (Oracle Instant Client����)>
'*            https://www.oracle.com/database/technologies/instant-client/downloads.html
'*          <Microsoft OLE DB Driver for SQL Server>
'*            https://docs.microsoft.com/ja-jp/sql/connect/oledb/download-oledb-driver-for-sql-server
'*          <PgOleDB (PostgreSQL OLEDB Provider) 32bit�̂�: ODBC�g�p�𐄏�>
'*            https://www.postgresql.org/ftp/projects/pgFoundry/stackbuilder/PgOleDB/PgOleDB1.0.0.20/
'*          <Microsoft Access �f�[�^�x�[�X �G���W�� 2016 �ĔЕz�\�R���|�[�l���g(ODBC/OLEDB����)>
'*            https://www.microsoft.com/en-us/download/details.aspx?id=54920
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
'*-----------------------------------------------------------------------------
'* �J�[�\�� �T�[�r�X�̏ꏊ��\���B
'*
'*-----------------------------------------------------------------------------
Public Enum CursorLocationEnum
    adUseClient = 3
    adUseServer = 2
    adUseNone = 1
End Enum

'*-----------------------------------------------------------------------------
'* Recordset �I�u�W�F�N�g���g�p����J�[�\���̎�ށB
'*
'*-----------------------------------------------------------------------------
Public Enum CursorTypeEnum
    adOpenDynamic = 2
    adOpenForwardOnly = 0
    adOpenKeyset = 1
    adOpenStatic = 3
    adOpenUnspecified = -1
End Enum
'*-----------------------------------------------------------------------------
'* Connection �I�u�W�F�N�g�̃g�����U�N�V�����������x����\���B
'*
'*-----------------------------------------------------------------------------
Public Enum IsolationLevelEnum
    adXactUnspecified = -1
    adXactChaos = 16
    adXactBrowse = 256
    adXactReadUncommitted = 256
    adXactCursorStability = 4096
    adXactReadCommitted = 4096
    adXactRepeatableRead = 65536
    adXactIsolated = 1048576
    adXactSerializable = 1048576
End Enum

'*-----------------------------------------------------------------------------
'* �ҏW���Ƀ��R�[�h�ɓK�p����郍�b�N�̎�ނ�\���B
'*
'*-----------------------------------------------------------------------------
Public Enum LockTypeEnum
    adLockBatchOptimistic = 4
    adLockOptimistic = 3
    adLockPessimistic = 2
    adLockReadOnly = 1
    adLockUnspecified = -1
End Enum

'******************************************************************************
'* �萔��`
'******************************************************************************
' Oracle ODBC�ڑ�(Oracle��Driver)
Private Const CONN_STR_ODBC_ORACLE_ORA As String = "Driver={{0}};DBQ=" & _
    "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={1})(PORT={2}))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME={3})))"
' Microsoft SQL Server ODBC�ڑ�
Private Const CONN_STR_ODBC_SQLSERVER As String = "Driver={SQL Server};Server={0};Database={1}"
' Microsoft SQL Server LocalDB ODBC�ڑ�
Private Const CONN_STR_ODBC_SQLSERVER_LOCALDB As String = "Driver={SQL Server Native Client 11.0};Server=(LocalDB)\{0};AttachDBFileName={1};Database={2};Trusted_Connection=Yes"
' PostgreSQL ODBC�ڑ�
Private Const CONN_STR_ODBC_POSTGRESQL As String = "Driver={{0}};Server={1};Port={2};Database={3}"
' MySQL ODBC�ڑ�
Private Const CONN_STR_ODBC_MYSQL As String = "Driver={{0}};Server={1};Port={2};Database={3}"
' Access/Excel/CSV/TXT ODBC�ڑ�
Private Const CONN_STR_ODBC_ACCESS As String = "Driver={{0}};DBQ={1}"
Private Const CONN_STR_ODBC_ACCESS_PASS As String = "Driver={{0}};DBQ={1};Uid=Admin;Pwd={2}"
' SQLite ODBC�ڑ�
Private Const CONN_STR_ODBC_SQLITE As String = "Driver={{0}};Database={1}"

' Oracle OLE�ڑ�(Oracle��Provider)
Private Const CONN_STR_OLE_ORACLE_ORA As String = "Provider= OraOLEDB.Oracle;Data Source=" & _
    "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={0})(PORT={1}))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME={2})))"
' Microsoft SQL Server OLE�ڑ�
Private Const CONN_STR_OLE_SQLSERVER As String = "Provider=SQLOLEDB;Data Source={0};Initial Catalog={1}"
' PostgreSQL OLE�ڑ�
Private Const CONN_STR_OLE_POSTGRESQL As String = "Provider=PostgreSQL OLE DB Provider;Data Source={1};Location={2}"
' Access OLE�ڑ�
Private Const CONN_STR_OLE_ACCESS As String = "Provider={0};Data Source={1}"
Private Const CONN_STR_OLE_ACCESS_PASS As String = "Provider={0};Data Source={1};User ID=Admin;Jet OLEDB:Database Password={2}"
' Excel/CSV/TXT/HTML OLE�ڑ�
Private Const CONN_STR_OLE_FILEDATA As String = "Provider={0};Data Source={1};Extended Properties=""{2}"""

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mConn As Object

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************
Public Property Get IsReady() As Boolean
    IsReady = False
    If Not mConn Is Nothing Then
        If mConn.State = adStateOpen Then
            IsReady = True
        End If
    End If
End Property

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
'* [�T  �v] OpenOracle ���\�b�h
'* [��  ��] Oracle�f�[�^�x�[�X�ւ̐ڑ����J���
'*          Oracle�ڑ���������쐬���AConnection.Open ���\�b�h�����s����B
'*
'* @param serverName   �ڑ���T�[�o��
'* @param portNo       �ڑ���|�[�g�ԍ�
'* @param serviceName  �ڑ���T�[�r�X���i�O���[�o���f�[�^�x�[�X���j
'* @param userId       �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p���郆�[�U�[���B
'* @param password     �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p����p�X���[�h�B
'* @param connectType  �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'******************************************************************************
Public Sub OpenOracle(ByVal serverName As String, _
                          ByVal portNo As Integer, _
                          ByVal serviceName As String, _
                          Optional ByVal userId As String, _
                          Optional ByVal Password As String, _
                          Optional ByVal connectType As String = "oledb")
    Dim cnnStr As String
    If LCase(connectType) = "odbc" Then
        cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_ORACLE_ORA, GetOracleODBCDriverName(), serverName, portNo, serviceName)
    Else
        cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_ORACLE_ORA, serverName, portNo, serviceName)
    End If
    Call mConn.Open(cnnStr, userId, Password)
End Sub

'******************************************************************************
'* [�T  �v] GetOracleODBCDriverName ���\�b�h
'* [��  ��] Oracle�pODBC�h���C�o�[�����擾����
'*
'* @param use32bit 32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'*
'******************************************************************************
Private Function GetOracleODBCDriverName(Optional use32bit As Boolean = False) As String
    GetOracleODBCDriverName = GetODBCDriverName("Oracle in Ora", , use32bit)
End Function

'******************************************************************************
'* [�T  �v] OpenPostgreSql ���\�b�h
'* [��  ��] PostgreSql�f�[�^�x�[�X�ւ̐ڑ����J���
'*          PostgreSql�ڑ���������쐬���AConnection.Open ���\�b�h�����s����B
'*
'* @param serverName   �ڑ���T�[�o��
'* @param portNo       �ڑ���|�[�g�ԍ�
'* @param databaseName �ڑ���f�[�^�x�[�X��
'* @param userId       �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p���郆�[�U�[���B
'* @param password     �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p����p�X���[�h�B
'* @param connectType  �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'******************************************************************************
Public Sub OpenPostgreSql(ByVal serverName As String, _
                          ByVal portNo As Integer, _
                          ByVal databaseName As String, _
                          Optional ByVal userId As String, _
                          Optional ByVal Password As String, _
                          Optional ByVal connectType As String = "odbc")
    Dim cnnStr As String
    If LCase(connectType) = "odbc" Then
        cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_POSTGRESQL, GetPostgreSqlODBCDriverName(), serverName, portNo, databaseName)
    Else
        ' OLEDB�ڑ��i�|�[�g�w��s�j
        cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_POSTGRESQL, serverName, databaseName)
    End If
    Call mConn.Open(cnnStr, userId, Password)
End Sub

'******************************************************************************
'* [�T  �v] GetPostgreSqlODBCDriverName ���\�b�h
'* [��  ��] PostgreSQL�pODBC�h���C�o�[�����擾����
'*
'* @param tryDefaultUse �擾�ł��Ȃ��ꍇ�Ƀf�t�H���g�l��ԋp���邩�ǂ����w��
'* @param use32bit 32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'*
'******************************************************************************
Private Function GetPostgreSqlODBCDriverName(Optional ByVal tryDefaultUse As Boolean = True, Optional use32bit As Boolean = False) As String
    If tryDefaultUse Then
        GetPostgreSqlODBCDriverName = GetODBCDriverName("PostgreSQL", "PostgreSQL Unicode", use32bit)
    Else
        GetPostgreSqlODBCDriverName = GetODBCDriverName("PostgreSQL", , use32bit)
    End If
End Function

'******************************************************************************
'* [�T  �v] OpenSqlServer ���\�b�h
'* [��  ��] SqlServer�f�[�^�x�[�X�ւ̐ڑ����J���
'*          SqlServer�ڑ���������쐬���AConnection.Open ���\�b�h�����s����B
'*
'* @param serverName   �ڑ���T�[�o��
'* @param databaseName �ڑ���f�[�^�x�[�X��
'* @param portNo       �ȗ��\�B�ڑ���|�[�g�ԍ�
'* @param userId       �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p���郆�[�U�[���B
'* @param password     �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p����p�X���[�h�B
'* @param connectType  �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'******************************************************************************
Public Sub OpenSqlServer(ByVal serverName As String, _
                         ByVal databaseName As String, _
                         Optional ByVal portNo, _
                         Optional ByVal userId As String, _
                         Optional ByVal Password As String, _
                         Optional ByVal connectType As String = "odbc")
    Dim cnnStr As String
    If Not IsMissing(portNo) Then
        serverName = serverName & "," & portNo
    End If
    If LCase(connectType) = "odbc" Then
        cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_SQLSERVER, serverName, databaseName)
    Else
        cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_SQLSERVER, serverName, databaseName)
    End If
    Call mConn.Open(cnnStr, userId, Password)
End Sub

'******************************************************************************
'* [�T  �v] OpenSqlServerLocalDB ���\�b�h
'* [��  ��] SqlServer�iLocalDB�j�f�[�^�x�[�X�ւ̐ڑ����J���
'*          SqlServer�iLocalDB�j�ڑ���������쐬���AConnection.Open ���\�b�h
'*          �����s����B
'*
'* @param dbFileName   �f�[�^�x�[�X�t�@�C����
'* @param databaseName �ڑ���f�[�^�x�[�X��
'* @param serverName  �ȗ��\�B�T�[�o���B�ȗ����́usqllocaldb info�v�R�}���h
'*                    �̎��s���ʂ���T�[�o�����擾����B
'******************************************************************************
Public Sub OpenSqlServerLocalDB(ByVal dbFileName As String, _
                                ByVal databaseName As String, _
                                Optional ByVal serverName As String)
    Dim cnnStr As String
    If serverName = "" Then
        Dim cmdr As DosCommander: Set cmdr = New DosCommander
        serverName = StringUtils.RemoveEach(cmdr.GetCommandResult("sqllocaldb info"), Array(vbCrLf, vbCr, vbLf))
    End If
    cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_SQLSERVER_LOCALDB, serverName, dbFileName, databaseName)
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] OpenMySql ���\�b�h
'* [��  ��] MySql�f�[�^�x�[�X�ւ̐ڑ����J���
'*          MySql�ڑ���������쐬���AConnection.Open ���\�b�h�����s����B
'*          ODBC�ڑ��̂݁B
'*
'* @param serverName   �ڑ���T�[�o��
'* @param portNo       �ڑ���|�[�g�ԍ�
'* @param databaseName �ڑ���f�[�^�x�[�X��
'* @param userId       �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p���郆�[�U�[���B
'* @param password     �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p����p�X���[�h�B
'******************************************************************************
Public Sub OpenMySql(ByVal serverName As String, _
                     ByVal portNo As Integer, _
                     ByVal databaseName As String, _
                     Optional ByVal userId As String, _
                     Optional ByVal Password As String)
    Dim cnnStr As String
    cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_MYSQL, GetODBCDriverName(Array("MySQL ODBC", "Unicode")), serverName, portNo, databaseName)
    Call mConn.Open(cnnStr, userId, Password)
End Sub

'******************************************************************************
'* [�T  �v] OpenSQLite ���\�b�h
'* [��  ��] SQLite�f�[�^�x�[�X�ւ̐ڑ����J���
'*          SQLite�ڑ���������쐬���AConnection.Open ���\�b�h
'*          �����s����B
'*
'* @param databaseFileName   �f�[�^�x�[�X�t�@�C����
'*
'******************************************************************************
Public Sub OpenSQLite(ByVal databaseFileName As String)
    Dim cnnStr As String
    cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_SQLITE, GetODBCDriverName(Array("SQLite", "ODBC")), databaseFileName)
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] OpenAccess ���\�b�h
'* [��  ��] Access�f�[�^�x�[�X�ւ̐ڑ����J���
'*          Access�ڑ���������쐬���AConnection.Open ���\�b�h
'*          �����s����B
'*
'* @param databaseFileName �f�[�^�x�[�X�t�@�C����
'* @param password     �ȗ��\�B�ڑ����m������Ƃ��Ɏg�p����p�X���[�h�B
'* @param connectType  �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'*
'******************************************************************************
Public Sub OpenAccess(ByVal databaseFileName As String, _
                      Optional ByVal Password As String, _
                      Optional ByVal connectType As String = "oledb")
    Dim cnnStr As String
    If LCase(connectType) = "odbc" Then
        If Password = "" Then
            cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_ACCESS, GetAccessODBCDriverName(), databaseFileName)
        Else
            cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_ACCESS_PASS, GetAccessODBCDriverName(), databaseFileName, Password)
        End If
    Else
        If Password = "" Then
            cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_ACCESS, GetAccessOLEDBProviderName(), databaseFileName)
        Else
            cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_ACCESS_PASS, GetAccessOLEDBProviderName(), databaseFileName, Password)
        End If
    End If
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] OpenExcel ���\�b�h
'* [��  ��] Excel�t�@�C�����f�[�^�x�[�X�Ƃ݂Ȃ��Đڑ����s���
'*          Excel�ڑ���������쐬���AConnection.Open ���\�b�h
'*          �����s����B
'*
'* @param filePath      Excel�t�@�C���p�X
'* @param headerExists  �ȗ��\�B�w�b�_�B
'* @param readwriteMode �ȗ��\�B0:�������[�h�A1:�Ǎ����[�h�A2:�o�������[�h�B
'* @param connectType   �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'*
'******************************************************************************
Public Sub OpenExcel(ByVal FilePath As String, _
                     Optional ByVal HeaderExists As Boolean = True, _
                     Optional ByVal readwriteMode As Integer = 1, _
                     Optional ByVal connectType As String = "oledb")
    Dim cnnStr As String
    If LCase(connectType) = "odbc" Then
        cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_ACCESS, GetExcelODBCDriverName(), FilePath)
    Else
        Dim exProp As New ArrayEx
        exProp.Add GetXlIsamType(FilePath)
        If HeaderExists Then
            exProp.Add "HDR=Yes"
        Else
            exProp.Add "HDR=No"
        End If
        Select Case readwriteMode
            Case 0
                exProp.Add "IMEX=0"
            Case 1
                exProp.Add "IMEX=1"
            Case 2
                exProp.Add "IMEX=2"
        End Select
        cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_FILEDATA, GetAccessOLEDBProviderName(), FilePath, exProp.Join(";"))
    End If
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] OpenCsv ���\�b�h
'* [��  ��] Csv�t�@�C�����f�[�^�x�[�X�Ƃ݂Ȃ��Đڑ����s���
'*          �ڑ���������쐬���AConnection.Open ���\�b�h
'*          �����s����B
'*
'* @param dirPath      CSV�t�@�C���̊i�[����Ă���p�X
'* @param headerExists �ȗ��\�B�w�b�_�B
'* @param connectType  �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'*
'******************************************************************************
Public Sub OpenCsv(ByVal dirPath As String, _
                   Optional ByVal HeaderExists As Boolean = True, _
                   Optional ByVal connectType As String = "oledb")
    Dim cnnStr As String
    If LCase(connectType) = "odbc" Then
        cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_ACCESS, GetTextODBCDriverName(), dirPath)
    Else
        Dim exProp As New ArrayEx
        exProp.Add "TEXT"
        If HeaderExists Then
            exProp.Add "HDR=Yes"
        Else
            exProp.Add "HDR=No"
        End If
        exProp.Add "FMT=Delimited"
        
        cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_FILEDATA, GetAccessOLEDBProviderName(), dirPath, exProp.Join(";"))
    End If
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] OpenText ���\�b�h
'* [��  ��] Text�t�@�C�����f�[�^�x�[�X�Ƃ݂Ȃ��Đڑ����s���
'*          �ڑ���������쐬���AConnection.Open ���\�b�h
'*          �����s����B
'*
'* @param dirPath      CSV�t�@�C���̊i�[����Ă���p�X
'* @param headerExists �ȗ��\�B�w�b�_�B
'* @param connectType  �ȗ��\�B�ڑ��^�C�v�i���@�j�B�uodbc�v���uoledb�v���w��B
'*
'******************************************************************************
Public Sub OpenText(ByVal dirPath As String, _
                    Optional ByVal HeaderExists As Boolean = True, _
                    Optional ByVal connectType As String = "oledb")
    Dim cnnStr As String
    If LCase(connectType) = "odbc" Then
        cnnStr = StringUtils.PlaceHolder(CONN_STR_ODBC_ACCESS, GetTextODBCDriverName(), dirPath)
    Else
        Dim exProp As New ArrayEx
        exProp.Add "TEXT"
        If HeaderExists Then
            exProp.Add "HDR=Yes"
        Else
            exProp.Add "HDR=No"
        End If
        cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_FILEDATA, GetAccessOLEDBProviderName(), dirPath, exProp.Join(";"))
    End If
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] OpenHtml ���\�b�h
'* [��  ��] Html�t�@�C�����f�[�^�x�[�X�Ƃ݂Ȃ��Đڑ����s���
'*          �ڑ���������쐬���AConnection.Open ���\�b�h�����s����B
'*
'* @param filePath Html�t�@�C���p�X
'*
'******************************************************************************
Public Sub OpenHtml(ByVal FilePath As String)
    Dim cnnStr As String
    cnnStr = StringUtils.PlaceHolder(CONN_STR_OLE_FILEDATA, GetAccessOLEDBProviderName(), FilePath, "HTML Import;HDR=Yes")
    Call mConn.Open(cnnStr)
End Sub

'******************************************************************************
'* [�T  �v] GetXlIsamType ���\�b�h
'* [��  ��] Excel�t�@�C���̊g���q����Excel�t�@�C����ISAM�^�C�v�����擾����
'*
'* @param filePath Excel�t�@�C���p�X
'* @return String Excel�t�@�C����ISAM�^�C�v��
'******************************************************************************
Private Function GetXlIsamType(ByVal FilePath As String) As String
    Select Case IO.GetExtensionName(FilePath)
        Case "xls"
            GetXlIsamType = "Excel 8.0"
        Case "xlsb"
            GetXlIsamType = "Excel 12.0"
        Case "xlsm"
            GetXlIsamType = "Excel 12.0 Macro"
        Case "xlsx"
            GetXlIsamType = "Excel 12.0 Xml"
    End Select
End Function

'******************************************************************************
'* [�T  �v] GetAccessODBCDriverName ���\�b�h
'* [��  ��] Access�pODBC�h���C�o�[�����擾����
'*
'* @param tryDefaultUse �擾�ł��Ȃ��ꍇ�Ƀf�t�H���g�l��ԋp���邩�ǂ����w��
'* @param use32bit 32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'* @return String Access�pODBC�h���C�o�[��
'******************************************************************************
Private Function GetAccessODBCDriverName(Optional ByVal tryDefaultUse As Boolean = True, Optional use32bit As Boolean = False) As String
    If tryDefaultUse Then
        GetAccessODBCDriverName = GetODBCDriverName(".accdb)", "Microsoft Access Driver (*.mdb, *.accdb)", use32bit)
    Else
        GetAccessODBCDriverName = GetODBCDriverName(".accdb)", , use32bit)
    End If
End Function

'******************************************************************************
'* [�T  �v] GetExcelODBCDriverName ���\�b�h
'* [��  ��] Excel�t�@�C���ڑ��pODBC�h���C�o�[�����擾����
'*
'* @param tryDefaultUse �擾�ł��Ȃ��ꍇ�Ƀf�t�H���g�l��ԋp���邩�ǂ����w��
'* @param use32bit      32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'* @return String       Excel�t�@�C���ڑ��pODBC�h���C�o�[��
'******************************************************************************
Private Function GetExcelODBCDriverName(Optional ByVal tryDefaultUse As Boolean = True, Optional use32bit As Boolean = False) As String
    If tryDefaultUse Then
        GetExcelODBCDriverName = GetODBCDriverName(".xlsb)", "Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)", use32bit)
    Else
        GetExcelODBCDriverName = GetODBCDriverName(".xlsb)", , use32bit)
    End If
End Function

'******************************************************************************
'* [�T  �v] GetTextODBCDriverName ���\�b�h
'* [��  ��] Text�t�@�C���ڑ��pODBC�h���C�o�[�����擾����
'*
'* @param tryDefaultUse �擾�ł��Ȃ��ꍇ�Ƀf�t�H���g�l��ԋp���邩�ǂ����w��
'* @param use32bit      32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'* @return String       Text�t�@�C���ڑ��pODBC�h���C�o�[��
'******************************************************************************
Private Function GetTextODBCDriverName(Optional ByVal tryDefaultUse As Boolean = True, Optional use32bit As Boolean = False) As String
    If tryDefaultUse Then
        GetTextODBCDriverName = GetODBCDriverName("Text Driver (*.txt", "Microsoft Text Driver (*.txt; *.csv)", use32bit)
    Else
        GetTextODBCDriverName = GetODBCDriverName("Text Driver (*.txt", , use32bit)
    End If
End Function

'******************************************************************************
'* [�T  �v] GetAccessOLEDBProviderName ���\�b�h
'* [��  ��] Access�pOLEDB�v���o�C�_�[�����擾����
'*
'* @param tryDefaultUse �擾�ł��Ȃ��ꍇ�Ƀf�t�H���g�l��ԋp���邩�ǂ����w��
'* @param use32bit      32�r�b�g�p�v���o�C�_�[�����擾���邩�ǂ����w��
'* @return String       Access�pOLEDB�v���o�C�_�[��
'******************************************************************************
Private Function GetAccessOLEDBProviderName(Optional ByVal tryDefaultUse As Boolean = True, Optional use32bit As Boolean = False) As String
    Dim v, vArr, vArr2, vProviderArr
    Dim stdRegProv As Object: Set stdRegProv = CreateStdRegProv()

    stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Office\", vArr
    For Each v In ArrayUtils.RegexSearch(vArr, "\d\d\.\d")
        stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Office\" & v & "\ClickToRun\REGISTRY\MACHINE\Software\Classes", vArr2
        vProviderArr = ArrayUtils.Search(vArr2, "Microsoft.ACE.OLEDB.")
        If Not ArrayUtils.IsEmptyArray(vProviderArr) Then
            GetAccessOLEDBProviderName = vProviderArr(UBound(vProviderArr))
            Exit Function
        End If
    Next
    
    stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\", vArr2
    vProviderArr = ArrayUtils.Search(vArr2, "Microsoft.ACE.OLEDB.")
    If Not ArrayUtils.IsEmptyArray(vProviderArr) Then
        GetAccessOLEDBProviderName = vProviderArr(UBound(vProviderArr))
        Exit Function
    End If
    
    If tryDefaultUse Then
        GetAccessOLEDBProviderName = GetOleDbProviderName("Microsoft.ACE.OLEDB.", "Microsoft.ACE.OLEDB.12.0", use32bit)
    Else
        GetAccessOLEDBProviderName = GetOleDbProviderName("Microsoft.ACE.OLEDB.", , use32bit)
    End If
End Function

'******************************************************************************
'* [�T  �v] GetODBCDriverName ���\�b�h
'* [��  ��] ODBC�h���C�o�[�������W�X�g������擾����
'*
'* @param driverKeyword     �h���C�o�[������������L�[���[�h�i�z��ŕ����w��j
'* @param defaultDriverName ������Hit���Ȃ������ꍇ�̃f�t�H���g�h���C�o�[��
'* @param use32bit          32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'* @return String           ODBC�h���C�o�[��
'******************************************************************************
Private Function GetODBCDriverName(ByVal driverKeyword, Optional ByVal defaultDriverName As String, Optional use32bit As Boolean = False) As String
    Dim vArr, vDriverArr
    Dim stdRegProv As Object: Set stdRegProv = CreateStdRegProv()
    If use32bit Then
        stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\ODBC\ODBCINST.INI", vArr
    Else
        stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\ODBC\ODBCINST.INI", vArr
    End If
    
    vDriverArr = ArrayUtils.Search(vArr, driverKeyword)
    If Not ArrayUtils.IsEmptyArray(vDriverArr) Then
        GetODBCDriverName = vDriverArr(UBound(vDriverArr))
    Else
        If defaultDriverName <> "" Then
            GetODBCDriverName = defaultDriverName
        Else
            Err.Raise 9999, "GetODBCDriverName", "ODBC Driver Not Found"
        End If
    End If
End Function

'******************************************************************************
'* [�T  �v] GetOleDbProviderName ���\�b�h
'* [��  ��] OLEDB�v���o�C�_�[�������W�X�g������擾����
'*
'* @param provideKeyword      �v���o�C�_�[������������L�[���[�h�i�z��ŕ����w��j
'* @param defaultProviderName ������Hit���Ȃ������ꍇ�̃f�t�H���g�v���o�C�_�[��
'* @param use32bit            32�r�b�g�p�h���C�o�[�����擾���邩�ǂ����w��
'* @return String             OLEDB�v���o�C�_�[��
'******************************************************************************
Private Function GetOleDbProviderName(ByVal provideKeyword As String, Optional ByVal defaultProviderName As String, Optional use32bit As Boolean = False) As String
    Dim vArr, vProviderArr
    Dim stdRegProv As Object: Set stdRegProv = CreateStdRegProv()
    If use32bit Then
        stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\WOW6432Node\Classes", vArr
    Else
        stdRegProv.EnumKey HKEY_LOCAL_MACHINE, "SOFTWARE\Classes", vArr
    End If
    
    vProviderArr = ArrayUtils.Search(vArr, provideKeyword)
    If Not ArrayUtils.IsEmptyArray(vProviderArr) Then
        GetOleDbProviderName = vProviderArr(UBound(vProviderArr))
    Else
        If defaultProviderName <> "" Then
            GetOleDbProviderName = defaultProviderName
        Else
            Err.Raise 9999, "GetOleDbProviderName", "OLEDB Provider Not Found"
        End If
    End If
End Function

'******************************************************************************
'* [�T  �v] SelectList ���\�b�h
'* [��  ��] SQL�iSELECT�j�����s���A���s���ʂ�Variant�z��ŕԋp����
'*
'* @param sql             SQL�iSELECT�j
'* @param sqlParams       SQL�p�����[�^�iVariant1�����z��j
'* @param pCursorLocation �J�[�\���T�[�r�X�̏ꏊ
'* @param pCursorType     �J�[�\���^�C�v
'* @param pLockType       ���b�N�̎��
'* @return Variant        SQL���s����
'*
'******************************************************************************
Public Function SelectList(ByVal sql As String, _
                           Optional ByVal sqlParams As Variant, _
                           Optional ByVal pCursorLocation As CursorLocationEnum = adUseClient, _
                           Optional ByVal pCursorType As CursorTypeEnum = adOpenForwardOnly, _
                           Optional ByVal pLockType As LockTypeEnum = adLockReadOnly) As Variant

    SelectList = SelectRecordset(sql, sqlParams, pCursorLocation, pCursorType, pLockType).GetRows
End Function

'******************************************************************************
'* [�T  �v] SelectRecordset ���\�b�h
'* [��  ��] SQL�iSELECT�j�����s���A���s���ʂ�Recordset��ԋp����
'*
'* @param sql                   SQL�iSELECT�j
'* @param sqlParams             SQL�p�����[�^�iVariant1�����z��j
'* @param pCursorLocation       �J�[�\���T�[�r�X�̏ꏊ
'* @param pCursorType           �J�[�\���^�C�v
'* @param pLockType             ���b�N�̎��
'* @return Object(Of Recordset) SQL���s����
'*
'******************************************************************************
Public Function SelectRecordset(ByVal sql As String, _
                                Optional ByVal sqlParams As Variant, _
                                Optional ByVal pCursorLocation As CursorLocationEnum = adUseClient, _
                                Optional ByVal pCursorType As CursorTypeEnum = adOpenForwardOnly, _
                                Optional ByVal pLockType As LockTypeEnum = adLockReadOnly) As Object
                                
    Dim adoRs As Object: Set adoRs = CreateObject("ADODB.Recordset")
    adoRs.CursorLocation = pCursorLocation
  
    ' TODO:SQL�p�����[�^�̐ݒ�
  
    adoRs.Open sql, mConn, pCursorType, pLockType
    Set SelectRecordset = adoRs
End Function

'******************************************************************************
'* [�T  �v] Disconnect ���\�b�h
'* [��  ��] DB�ւ̃R�l�N�V�������J���Ă���ꍇ�A�N���[�Y����
'*
'******************************************************************************
Public Sub Disconnect()
    If Not mConn Is Nothing Then
        If mConn.State <> adStateClosed Then
            Call mConn.Close
        End If
    End If
End Sub

'******************************************************************************
'* [�T  �v] Begin ���\�b�h
'* [��  ��] �g�����U�N�V�������J�n����
'*
'******************************************************************************
Public Sub Begin()
     mConn.BeginTrans
End Sub

'******************************************************************************
'* [�T  �v] Commit ���\�b�h
'* [��  ��] �g�����U�N�V�������R�~�b�g����
'*
'******************************************************************************
Public Sub Commit()
    mConn.CommitTrans
End Sub

'******************************************************************************
'* [�T  �v] Rollback ���\�b�h
'* [��  ��] �g�����U�N�V���������[���o�b�N����
'*
'******************************************************************************
Public Sub Rollback()
    mConn.RollbackTrans
End Sub

'******************************************************************************
'* [�T  �v] SQL�\�������B
'* [��  ��] SQL�̖����p�����[�^���u?�v����u��������B
'* [�Q  �l] http://kagen88.blogspot.com/2012/12/adodbcommand.html
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

