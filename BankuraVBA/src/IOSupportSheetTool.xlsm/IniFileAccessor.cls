VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IniFileAccessor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] INI�t�@�C���A�N�Z�X�N���X
'* [��  ��] INI�t�@�C���ɃA�N�Z�X���鏈����񋟂���B
'*
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'******************************************************************************
'* WindowsAPI��`
'******************************************************************************
Private Declare PtrSafe Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

'******************************************************************************
'* Enum��`
'******************************************************************************

'******************************************************************************
'* �萔��`
'******************************************************************************

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
Private mIniFilePath As String
Private mIniStringMaxSize As Long

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    mIniStringMaxSize = 4096
End Sub
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] Init ���\�b�h
'* [��  ��] �������p���\�b�h�
'*
'* @param iniFilePath INI�t�@�C���p�X
'* @param iniStringMaxSize �������ڍő�T�C�Y
'* @return IniFileAccessor�I�u�W�F�N�g
'*
'******************************************************************************
Public Function Init(iniFilePath As String, Optional iniStringMaxSize As Long = 4096) As IniFileAccessor
    mIniFilePath = iniFilePath
    mIniStringMaxSize = iniStringMaxSize
    Set Init = Me
End Function

'******************************************************************************
'* [�T  �v] INI�t�@�C�����ڐݒ�l�擾����
'* [��  ��] �w�肳�ꂽINI�t�@�C���p�X/�Z�N�V����/���ڂ̒l���擾����B
'*          WindowsAPI��GetPrivateProfileString���g�p�B
'*
'* @param sectionName �Z�N�V������
'* @param itmName ���ږ�
'* @return String INI�t�@�C�����ڐݒ�l�iNG���͋󕶎���ԋp�j
'******************************************************************************
Public Function GetStringValue(sectionName As String, itmName As String) As String
                                 
    Dim retString As String: retString = Space$(mIniStringMaxSize)
    On Error Resume Next
    Dim ret As Long
    ret = GetPrivateProfileString(sectionName, itmName, vbNullString, _
                                  retString, Len(retString), mIniFilePath)
    On Error GoTo 0
    If ret = 0 Then
        GetStringValue = ""
        Exit Function
    End If

    GetStringValue = Left$(retString, InStr(retString, Chr$(0)) - 1)
End Function
