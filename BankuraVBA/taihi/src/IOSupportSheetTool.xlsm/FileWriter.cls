VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "FileWriter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] File�����N���X
'* [��  ��] File�����p�̃��[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


'******************************************************************************
'* Enum��`
'******************************************************************************
'*-----------------------------------------------------------------------------
'* �I�u�W�F�N�g���J���Ă��邩���Ă��邩�A�f�[�^ �\�[�X�ɐڑ������A�R�}���h��
'* ���s�����A�܂��̓f�[�^���擾������\���܂��B
'*-----------------------------------------------------------------------------
Private Enum ObjectStateEnum
    adStateClosed = 0     '�I�u�W�F�N�g�����Ă��邱�Ƃ������܂��B
    adStateOpen = 1       '�I�u�W�F�N�g���J���Ă��邱�Ƃ������܂��B
    adStateConnecting = 2 '�I�u�W�F�N�g���ڑ����ł��邱�Ƃ������܂��B
    adStateExecuting = 4  '�I�u�W�F�N�g���R�}���h�����s���ł��邱�Ƃ������܂��B
    adStateFetching = 8   '�I�u�W�F�N�g�̍s���擾���ł��邱�Ƃ������܂��B
End Enum

'*-----------------------------------------------------------------------------
'* Stream �I�u�W�F�N�g�ɕۑ�����f�[�^�̎�ނ�\���܂��B
'*
'*-----------------------------------------------------------------------------
Private Enum StreamTypeEnum
    adTypeBinary = 1 '�o�C�i�� �f�[�^�������܂��B
    adTypeText = 2   '����l�BCharset �Ŏw�肳�ꂽ�����Z�b�g�̃e�L�X�g �f�[�^�������܂��B
End Enum

'*-----------------------------------------------------------------------------
'* Stream �I�u�W�F�N�g����t�@�C���ɕۑ�����Ƃ��ɁA�t�@�C�����쐬���邩�A
'* �㏑�����邩��\���܂��B�����̒l�� AND ���Z�q�Ō����ł��܂��B
'*-----------------------------------------------------------------------------
Private Enum SaveOptionsEnum
    adSaveCreateNotExist = 1  '����l�BFileName �p�����[�^�[�Ŏw�肵���t�@�C�����Ȃ��ꍇ�͐V�����t�@�C�����쐬����܂��B
    adSaveCreateOverWrite = 2 'Filename �p�����[�^�[�Ŏw�肵���t�@�C��������ꍇ�́A���݊J����Ă��� Stream �I�u�W�F�N�g�̃f�[�^�Ńt�@�C�����㏑������܂��B
End Enum

'*-----------------------------------------------------------------------------
'* Stream �I�u�W�F�N�g�ɏ������ޕ�����ɁA�s��؂�L����ǉ����邩�ǂ�����\���܂��B
'*
'*-----------------------------------------------------------------------------
Private Enum StreamWriteEnum
    adWriteChar = 0 '����l�BStream �I�u�W�F�N�g�ɁAData �p�����[�^�[�Ŏw�肵���e�L�X�g��������������݂܂��B
    adWriteLine = 1 'Stream �I�u�W�F�N�g�ɁA�e�L�X�g������ƍs��؂�L�����������݂܂��BLineSeparator �v���p�e�B����`����Ă��Ȃ��ꍇ�́A���s���G���[��Ԃ��܂��B
End Enum

'*-----------------------------------------------------------------------------
'* Connection ���̃f�[�^�̕ҏW�ARecord �̃I�[�v���A�܂��� Record ����� Stream
'*  �I�u�W�F�N�g�� Mode �v���p�e�B�̒l�̎w��ɑ΂��錠����\���܂��B
'*-----------------------------------------------------------------------------
Private Enum ConnectModeEnum
    adModeRead = 1            '�ǂݎ���p�̌�����\���܂��B
    adModeReadWrite = 3       '�ǂݎ��/�������ݗ����̌�����\���܂��B
    adModeRecursive = 4194304 '���̋��L���ےl (adModeShareDenyNone�A adModeShareDenyWrite�A�܂���adModeShareDenyRead) �Ƌ��Ɏg�p���āA���݂̃��R�[�h�̂��ׂẴT�u���R�[�h�ɋ��L������`�B���܂��B Record �Ɏq���Ȃ��ꍇ�͋@�\���܂���BadModeShareDenyNone �݂̂Ƒg�ݍ��킹�Ďg�p����ƁA���s���G���[���������܂��B �������A���̑��̒l�Ƒg�ݍ��킹���ꍇ�� adModeShareDenyNone �Ƒg�ݍ��킹�Ďg�p�ł��܂��B
    adModeShareDenyNone = 16  '�����̎�ނɊ֌W�Ȃ��A���̃��[�U�[���ڑ����J����悤�ɂ��܂��B���̃��[�U�[�ɑ΂��āA�ǂݎ��Ə������݂̗����̃A�N�Z�X�������܂��B
    adModeShareDenyRead = 4   '���̃��[�U�[���ǂݎ�茠���Őڑ����J���̂��֎~���܂��B
    adModeShareDenyWrite = 8  '���̃��[�U�[���������݌����Őڑ����J���̂��֎~���܂��B
    adModeShareExclusive = 12 '���̃��[�U�[���ڑ����J���̂��֎~���܂��B
    adModeUnknown = 0         '����l�B�������ݒ肳��Ă��Ȃ����A�����𔻒�ł��Ȃ����Ƃ������܂��B
    adModeWrite = 2           '�������ݐ�p�̌����������܂��B
End Enum

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mFso As Object
Private mFile As Object
Private mAdoStream As Object
Private mCharSet As String
Private mLineSeparator As LineSeparatorEnum
Private mHeaderExists As Boolean
Private mFilePath As String
Private mValidFormat As Boolean
Private mBOM As Boolean

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************

'*-----------------------------------------------------------------------------
'* FilePath �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get filePath() As String
    filePath = mFilePath
End Property
Property Let filePath(arg As String)
    mFilePath = arg
End Property

'*-----------------------------------------------------------------------------
'* Charset �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get CharSet() As String
    CharSet = mCharSet
End Property
Property Let CharSet(arg As String)
    mCharSet = arg
End Property

'*-----------------------------------------------------------------------------
'* LineSeparator �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get LineSeparator() As LineSeparatorEnum
    LineSeparator = mLineSeparator
End Property
Property Let LineSeparator(arg As LineSeparatorEnum)
    mLineSeparator = arg
End Property

'*-----------------------------------------------------------------------------
'* HeaderExists �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get HeaderExists() As Boolean
    HeaderExists = mHeaderExists
End Property
Property Let HeaderExists(arg As Boolean)
    mHeaderExists = arg
End Property

'*-----------------------------------------------------------------------------
'* BOM �v���p�e�B
'*-----------------------------------------------------------------------------
Property Get BOM() As Boolean
    BOM = mBOM
End Property
Property Let BOM(arg As Boolean)
    mBOM = arg
End Property

'*-----------------------------------------------------------------------------
'* ValidFormat �v���p�e�B�i�ǂݎ���p�j
'*-----------------------------------------------------------------------------
Property Get ValidFormat() As Boolean
    ValidFormat = mValidFormat
End Property

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mFso = CreateObject("Scripting.FileSystemObject")
    Set mAdoStream = CreateObject("ADODB.Stream")
    mCharSet = "UTF-8"
    mLineSeparator = adLF
    mHeaderExists = False
    mValidFormat = True
    mBOM = False
End Sub
Private Sub Class_Terminate()
    If Not mAdoStream Is Nothing Then
        If mAdoStream.State <> adStateClosed Then
            Call mAdoStream.Close
        End If
    End If
    Set mAdoStream = Nothing
    Set mFso = Nothing
    Set mFile = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] FileExists ���\�b�h
'* [��  ��] �t�@�C�������݂��邩�ǂ������肷��
'*
'* @param targetFilePath �t�@�C���p�X�B�ȗ��\�B
'* @return ���茋��
'*
'******************************************************************************
Public Function FileExists(Optional ByVal targetFilePath As String) As Boolean
    Dim tempPath As String: tempPath = mFilePath
    If targetFilePath <> "" Then
        tempPath = targetFilePath
    End If
    FileExists = mFso.FileExists(tempPath)
End Function

'******************************************************************************
'* [�T  �v] ShowCsvSaveFileDialog ���\�b�h
'* [��  ��] CSV�t�@�C����ۑ�����_�C�A���O��\������
'*
'* @param initialFile �����\���p�t�@�C���p�X�B�ȗ��\�B
'* @return �ۑ��t�@�C���̃p�X
'*
'******************************************************************************
Public Function ShowCsvSaveFileDialog(Optional ByVal initialFile As String) As String
    Dim fileName As Variant
    fileName = Application.GetSaveAsFilename(initialFile, "CSV�t�@�C��,*.csv")
    If fileName = False Then
        Exit Function
    End If
    mFilePath = CStr(fileName)
    ShowCsvSaveFileDialog = CStr(fileName)
End Function

'******************************************************************************
'* [�T  �v] �e�L�X�g�t�@�C�����������B
'* [��  ��] �e�L�X�g�t�@�C���ɔz��f�[�^���s�P�ʂŏ������s���B
'*
'* @param vArray �����z��f�[�^�iVariant�j
'******************************************************************************
Public Sub WriteTextFileFromVArray(vArray As Variant)
    Dim tmp
    With mAdoStream
        .Mode = adModeReadWrite
        .Type = adTypeText
        .CharSet = mCharSet
        .LineSeparator = mLineSeparator
        .Open
        For Each tmp In vArray
            .WriteText CStr(tmp), adWriteLine
        Next
        If UCase(mCharSet) = "UTF-8" And Not mBOM Then
            Call ExcludeBom
        End If
        .SaveToFile mFilePath, adSaveCreateOverWrite '�t�@�C���㏑�w��
        .Close
    End With
End Sub

'******************************************************************************
'* [�T  �v] �e�L�X�g�t�@�C�����������B
'* [��  ��] �e�L�X�g�t�@�C����RecordSet�f�[�^���s�P�ʂŏ������s���B
'*
'* @param records �����f�[�^�iRecordFormat�j
'******************************************************************************
Public Sub WriteTextFileFromRecordSet(records As RecordFormat)
    With mAdoStream
        .Mode = adModeReadWrite
        .Type = adTypeText
        .CharSet = mCharSet
        .LineSeparator = mLineSeparator
        .Open
        Dim recText As String
        '�w�b�_�s�o��
        If mHeaderExists Then
            recText = EditHeader(records.RecordDefinition)
            .WriteText recText, adWriteLine
        End If
        '�f�[�^�s�o��
        Dim record As Collection
        For Each record In records.RecordSet
            recText = EditRecord(record)
            .WriteText recText, adWriteLine
        Next
        If UCase(mCharSet) = "UTF-8" And Not mBOM Then
            Call ExcludeBom
        End If
        .SaveToFile mFilePath, adSaveCreateOverWrite '�t�@�C���㏑�w��
        .Close
    End With
End Sub

'******************************************************************************
'* [�T  �v] �w�b�_�ҏW�����B
'* [��  ��] ���R�[�h����CSV������i�w�b�_�j�ɕҏW����B
'*
'* @param record ���R�[�h���iCollection�j
'* @return CSV������i�w�b�_�j
'******************************************************************************
Private Function EditHeader(record As Collection) As String
    Dim itm As Item, ret As String, first As Boolean
    first = True
    For Each itm In record
        If itm.OutputTarget Then
            If first Then
                ret = EditItem(itm.Name)
                first = False
            Else
                ret = ret & "," & EditItem(itm.Name)
            End If
        End If
    Next
    EditHeader = ret
End Function

'******************************************************************************
'* [�T  �v] ���R�[�h�ҏW�����B
'* [��  ��] ���R�[�h����CSV������ɕҏW����B
'*
'* @param record ���R�[�h���iCollection�j
'* @return CSV������
'******************************************************************************
Private Function EditRecord(record As Collection) As String
    Dim sInfo As SettingInfo: Set sInfo = GetSettingInfo()
           
    Dim itm As Item, ret As String, val As String, first As Boolean
    first = True
    For Each itm In record
        If itm.OutputTarget Then
            If itm.OutputEditKind = "�}�X�^�ϊ��iCode��Value�j" Then
                val = sInfo.GetMasterValueByCode(itm.OutputEditValue, itm.Value)
            ElseIf itm.OutputEditKind = "�}�X�^�ϊ��iValue��Code�j" Then
                val = sInfo.GetMasterCodeByValue(itm.OutputEditValue, itm.Value)
            Else
                val = itm.Value
            End If
        
            If first Then
                ret = EditItem(val)
                first = False
            Else
                ret = ret & "," & EditItem(val)
            End If
        End If
    Next
    EditRecord = ret
End Function

'******************************************************************************
'* [�T  �v] ���ڒl�ҏW�����B
'* [��  ��] ���ڒl������s�R�[�h�����O���A�_�u���N�H�[�g���G�X�P�[�v����B
'*
'* @param val ���ڒl
'* @return �ҏW�㍀�ڒl
'******************************************************************************
Private Function EditItem(val As String) As String
    Dim ret As String
    ret = Replace(val, vbLf, "")
    ret = Replace(ret, vbCr, "")
    ret = Replace(ret, """", """""")
    ret = """" & ret & """"
    EditItem = ret
End Function

'******************************************************************************
'* [�T  �v] BOM���O�����B
'* [��  ��] UTF-8�e�L�X�g��BOM�����O����B
'* [���@�l] �Ăяo���O��Stream��Open����Ă��邱�ƁB
'*
'* @return BOM���O�f�[�^
'******************************************************************************
Private Function ExcludeBom() As Byte()
    With mAdoStream
        .Position = 0
        .Type = adTypeBinary
        .Position = 3 'BOM��΂�
        ExcludeBom = .Read
        .Position = 0
        .Write ExcludeBom
        .SetEOS
    End With
End Function
