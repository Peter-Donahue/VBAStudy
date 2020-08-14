VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "NetworkDriveUtils"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] �l�b�g���[�N�h���C�u���[�e�B���e�B�N���X
'* [��  ��] �l�b�g���[�N�h���C�u�Ɋւ��郆�[�e�B���e�B��񋟂���B
'*          Static�N���X�iAttribute VB_PredeclaredId = True�j�Ƃ���B
'* [�Q  �l]
'*
'* @author Bankura
'* Copyright (c) 2019-2020 Bankura
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

'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************


'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
End Sub

'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] ConnectNetworkDrive
'* [��  ��] �l�b�g���[�N�h���C�u�ɐڑ�����B
'*
'* @param strNdName �l�b�g���[�N�h���C�u��
'* @param strUncPath �ڑ���p�X
'* @param strUserId  ���[�UID
'* @param strPass    �p�X���[�h
'* @return Boolean �������ʁiTrue:���� False�F�ُ�j
'******************************************************************************
Public Function ConnectNetworkDrive(strNdName As String, strUncPath As String, _
                                    strUserId As String, strPass As String) As Boolean
    On Error GoTo ErrorHandler
    Base.GetWshNetwork.MapNetworkDrive strNdName, strUncPath, False, strUserId, strPass
    
    ConnectNetworkDrive = True
    Exit Function
ErrorHandler:
    ConnectNetworkDrive = False
    
End Function

'******************************************************************************
'* [�T  �v] DisconnectNetworkDrive
'* [��  ��] �l�b�g���[�N�h���C�u����ؒf����B
'*
'* @param strNdName �l�b�g���[�N�h���C�u��
'* @return Boolean �������ʁiTrue:���� False�F�ُ�j
'******************************************************************************
Public Function DisconnectNetworkDrive(strNdName As String) As Boolean
    On Error GoTo ErrorHandler
    Base.GetWshNetwork.RemoveNetworkDrive strNdName, True, True
    DisconnectNetworkDrive = True
    Exit Function
ErrorHandler:
    DisconnectNetworkDrive = False
    
End Function

'******************************************************************************
'* [�T  �v] GetUnusedNetworkDriveName
'* [��  ��] �g�p����Ă��Ȃ��l�b�g���[�N�h���C�u�����擾����B
'*
'* @return String �l�b�g���[�N�h���C�u��
'******************************************************************************
Public Function GetUnusedNetworkDriveName() As String
    Dim i As Long
    Dim objNetWork As Object
    Dim colDrives As Object
    Set objNetWork = Base.GetWshNetwork
    
    Dim vNdArr() As Variant
    Dim strTmpNd As Variant
    Dim flg As Boolean
    flg = True
    vNdArr = Array("E:", "F:", "G:", "H:", "I:", "J:", "K:", "L:", "M:", "N:", "O:", "P:", "Q:", "R:", "S:", "T:", "U:", "V:", "W:", "X:", "Y:", "Z:")
    
    Set colDrives = objNetWork.EnumNetworkDrives
    For Each strTmpNd In vNdArr
        flg = True
        For i = 0 To colDrives.count - 1 Step 2
            If colDrives.Item(i) = strTmpNd Then
                flg = False
                Exit For
            End If
        Next i
        If flg Then
            Exit For
        End If
    Next
  
    If Not flg Then
        strTmpNd = ""
    End If
    Set colDrives = Nothing
    Set objNetWork = Nothing
    GetUnusedNetworkDriveName = strTmpNd
End Function


