VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WScriptExWshNetwork"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WScript.WshNetwork�N���X�̃��b�v�E�g���N���X
'* [��  ��] WScript.WshNetwork�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          WScript.WshNetwork�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' WScript.WshNetwork�N���X�ɂ��āB
' �R���s���[�^���ڑ�����Ă���l�b�g���[�N��̋��L���\�[�X�ւ̃A�N�Z�X��񋟂��܂��B
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364454(v=msdn.10)>
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As IWshRuntimeLibrary.WshNetwork
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
'* ComputerName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�R���s���[�^���̕�����\����񋟂��܂��B
'*-----------------------------------------------------------------------------
Property Get ComputerName() As String
    ComputerName = mOrigin.ComputerName
End Property

'*-----------------------------------------------------------------------------
'* UserDomain �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E���[�U�[ �h���C�����̕�����\����񋟂��܂��B
'*-----------------------------------------------------------------------------
Property Get UserDomain() As String
    UserDomain = mOrigin.UserDomain
End Property

'*-----------------------------------------------------------------------------
'* UserName �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E���[�U�[���̕�����\����񋟂��܂��B
'*-----------------------------------------------------------------------------
Property Get UserName() As String
    UserName = mOrigin.UserName
End Property

'*-----------------------------------------------------------------------------
'* Organization �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�B�����ځB
'*-----------------------------------------------------------------------------
'Property Get Organization() As String
'    Organization = mOrigin.Organization
'End Property

'*-----------------------------------------------------------------------------
'* Site �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�B�����ځB
'*-----------------------------------------------------------------------------
'Property Get Site() As String
'    Site = mOrigin.Site
'End Property

'*-----------------------------------------------------------------------------
'* UserProfile �v���p�e�B�i�ǂݎ���p�j
'*
'* [��  ��]
'* �E�B�����ځB
'*-----------------------------------------------------------------------------
'Property Get UserProfile() As String
'    UserProfile = mOrigin.UserProfile
'End Property
    
'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("WScript.Network")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] AddPrinterConnection ���\�b�h
'* [��  ��] AddPrinterConnection �̃��b�p�[���\�b�h�B
'*          �����[�g�� MS-DOS �x�[�X�̃v�����^�ڑ����R���s���[�^ �V�X�e����
'*          �ǉ����܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364413%28v%3dmsdn.10%29>
'*
'* @param LocalName �ڑ��v�����^�Ɋ��蓖�Ă郍�[�J����������������l
'* @param RemoteName �����[�g�v�����^��������������l
'* @param UpdateProfile �ȗ��\�B�v�����^�̃}�b�s���O�������݂̃��[�U�[
'*                      �v���t�@�C���Ɋi�[���邩�ǂ����������u�[���l�B
'*                      TRUE ���w�肷��ƁA���̊��蓖�Ă����[�U�[�v���t�@�C��
'*                      �ɕۑ�����܂��B����l�� FALSE �ł��B
'* @param UserName �ȗ��\�B���[�U�[��������������l�B
'* @param Password �ȗ��\�B���[�U�[�̃p�X���[�h������������l�B
'*                 UserName ����� Password �́A���݂̃��[�U�[�ȊO�̃A�J�E���g
'*                 �����g���ă����[�g �v�����^�����蓖�Ă�ꍇ�Ɏg�p���܂��B
'*
'******************************************************************************
Sub AddPrinterConnection(LocalName As String, RemoteName As String, Optional UpdateProfile, Optional UserName, Optional Password)
    If IsMissing(UpdateProfile) Then
        If IsMissing(UserName) Then
             If IsMissing(Password) Then
                Call mOrigin.AddPrinterConnection(LocalName, RemoteName)
            Else
                Call mOrigin.AddPrinterConnection(LocalName, RemoteName, , , Password)
            End If
        ElseIf IsMissing(Password) Then
            Call mOrigin.AddPrinterConnection(LocalName, RemoteName, , UserName)
        Else
            Call mOrigin.AddPrinterConnection(LocalName, RemoteName, , UserName, Password)
        End If
    Else
        If IsMissing(UserName) Then
             If IsMissing(Password) Then
                Call mOrigin.AddPrinterConnection(LocalName, RemoteName, UpdateProfile)
            Else
                Call mOrigin.AddPrinterConnection(LocalName, RemoteName, UpdateProfile, , Password)
            End If
        ElseIf IsMissing(Password) Then
            Call mOrigin.AddPrinterConnection(LocalName, RemoteName, UpdateProfile, UserName)
        Else
            Call mOrigin.AddPrinterConnection(LocalName, RemoteName, UpdateProfile, UserName, Password)
        End If
    End If
End Sub

'******************************************************************************
'* [�T  �v] AddWindowsPrinterConnection ���\�b�h
'* [��  ��] AddWindowsPrinterConnection �̃��b�p�[���\�b�h�B
'*          Windows �x�[�X�̃v�����^�ڑ����R���s���[�^ �V�X�e���ɒǉ����܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364395%28v%3dmsdn.10%29>
'*
'* @param PrinterName �v�����^�ڑ��ւ̃p�X������������l
'* @param DriverName �h���C�u��������������l�B
'*                    (Windows NT/Windows 2000 �ł͖�������܂�)�B
'* @param Port �ȗ��\�B�v�����^�ڑ��̃v�����^ �|�[�g���w�肷�镶����l�B
'*             (Windows NT/Windows 2000 �ł͖�������܂�)�B
'*
'******************************************************************************
Sub AddWindowsPrinterConnection(PrinterName As String, Optional DriverName As String, Optional Port As String = "LPT1")
    Call mOrigin.AddWindowsPrinterConnection(PrinterName, DriverName, Port)
End Sub

'******************************************************************************
'* [�T  �v] EnumNetworkDrives ���\�b�h
'* [��  ��] EnumNetworkDrives �̃��b�p�[���\�b�h�B
'*          �l�b�g���[�N �h���C�u�̌��݂̊��蓖�Ă�Ԃ��܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364403%28v%3dmsdn.10%29>
'*
'* @return WScriptExWshCollection �l�b�g���[�N�h���C�u�̃}�b�s���O���
'*         �l�b�g���[�N �h���C�u�̃��[�J�����ƑΉ����� UNC ���Ƃ��� 2 ��
'*         �A�C�e�����y�A�ɂ����z��B
'*         �����Ԗڂ̃A�C�e���͘_���h���C�u�̃��[�J�����B
'*         ��Ԗڂ̃A�C�e���͑Ή����� UNC ���L���B
'*         �R���N�V�����̃A�C�e���̓C���f�b�N�X �[�� (0) ����n�܂�܂��B
'******************************************************************************
Function EnumNetworkDrives() As WScriptExWshCollection
    Dim wrap As WScriptExWshCollection: Set wrap = New WScriptExWshCollection
    Set wrap.Origin = mOrigin.EnumNetworkDrives()
    Set EnumNetworkDrives = wrap
End Function

'******************************************************************************
'* [�T  �v] EnumPrinterConnections ���\�b�h
'* [��  ��] EnumPrinterConnections �̃��b�p�[���\�b�h�B
'*          �l�b�g���[�N �v�����^�̌��݂̊��蓖�Ă�Ԃ��܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364404%28v%3dmsdn.10%29>
'*
'* @return WScriptExWshCollection �v�����^�̃R���N�V�����ւ̕ϐ��Q��
'*         �l�b�g���[�N �v�����^�̃��[�J�����ƑΉ����� UNC ���Ƃ��� 2 ��
'*         �A�C�e�����y�A�ɂ����z��B
'*         �����Ԗڂ̃A�C�e���̓v�����^ �|�[�g�B
'*         ��Ԗڂ̃A�C�e���͑Ή�����l�b�g���[�N �v�����^�B
'*         �R���N�V�����̃A�C�e���̓C���f�b�N�X �[�� (0) ����n�܂�܂��B
'******************************************************************************
Function EnumPrinterConnections() As WScriptExWshCollection
    Dim wrap As WScriptExWshCollection: Set wrap = New WScriptExWshCollection
    Set wrap.Origin = mOrigin.EnumPrinterConnections()
    Set EnumPrinterConnections = wrap
End Function

'******************************************************************************
'* [�T  �v] MapNetworkDrive ���\�b�h
'* [��  ��] MapNetworkDrive �̃��b�p�[���\�b�h�B
'*          ���L�l�b�g���[�N �h���C�u���R���s���[�^ �V�X�e���ɒǉ����܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364409%28v%3dmsdn.10%29>
'*
'* @param LocalName ���蓖�Ă�h���C�u�̃��[�J����������������l
'* @param RemoteName ���L�h���C�u�� UNC �� (\\xxx\yyy) ������������l
'* @param UpdateProfile �ȗ��\�B�}�b�s���O�������݂̃��[�U�[ �v���t�@�C��
'*                      �Ɋi�[���邩�ǂ����������u�[���l�B
'*                      TRUE ���w�肷��ƁA���[�U�[ �v���t�@�C���Ɋ��蓖�Ă�
'*                      �ۑ�����܂��B����l�� FALSE �ł��B
'* @param UserName �ȗ��\�B���[�U�[��������������l�B
'* @param Password �ȗ��\�B���[�U�[ �p�X���[�h������������l�B
'*                 UserName��Password�́A�l�b�g���[�N �h���C�u�̊��蓖�Ď���
'*                 ���݂̃��[�U�[�ȊO�̃��[�U�[�̃A�J�E���g�����g�p����ꍇ�A
'*                 �w�肷��K�v������܂��B
'*
'******************************************************************************
Sub MapNetworkDrive(LocalName As String, RemoteName As String, Optional UpdateProfile, Optional UserName, Optional Password)
    If IsMissing(UpdateProfile) Then
        If IsMissing(UserName) Then
             If IsMissing(Password) Then
                Call mOrigin.MapNetworkDrive(LocalName, RemoteName)
            Else
                Call mOrigin.MapNetworkDrive(LocalName, RemoteName, , , Password)
            End If
        ElseIf IsMissing(Password) Then
            Call mOrigin.MapNetworkDrive(LocalName, RemoteName, , UserName)
        Else
            Call mOrigin.MapNetworkDrive(LocalName, RemoteName, , UserName, Password)
        End If
    Else
        If IsMissing(UserName) Then
             If IsMissing(Password) Then
                Call mOrigin.MapNetworkDrive(LocalName, RemoteName, UpdateProfile)
            Else
                Call mOrigin.MapNetworkDrive(LocalName, RemoteName, UpdateProfile, , Password)
            End If
        ElseIf IsMissing(Password) Then
            Call mOrigin.MapNetworkDrive(LocalName, RemoteName, UpdateProfile, UserName)
        Else
            Call mOrigin.MapNetworkDrive(LocalName, RemoteName, UpdateProfile, UserName, Password)
        End If
    End If
End Sub

'******************************************************************************
'* [�T  �v] RemoveNetworkDrive ���\�b�h
'* [��  ��] RemoveNetworkDrive �̃��b�p�[���\�b�h�B
'*          �R���s���[�^ �V�X�e���̋��L�l�b�g���[�N �h���C�u�ڑ����������܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364419%28v%3dmsdn.10%29>
'*
'* @param Name �ڑ����������銄�蓖�ăh���C�u������������l�B
'*             �h���C�u�̊��蓖�ĕ��@�ɂ���āA���[�J�����������[�g����
'*             �w�肵�܂��B
'* @param Force �ȗ��\�B�h���C�u�̊��蓖�Ă������I�ɉ������邩�ǂ���������
'*              �u�[���l�BTRUE ���w�肷��ƁA���\�[�X���g�p����Ă��邩�ǂ���
'*              �Ɋ֌W�Ȃ��A�ڑ�����������܂��B
'* @param UpdateProfile �ȗ��\�B���[�U�[ �v���t�@�C�����犄�蓖�Ă��폜����
'*                      ���ǂ���������������l�BTRUE ���w�肷��ƁA���[�U�[
'*                      �v���t�@�C�����犄�蓖�Ă��폜����܂��B
'*                      ����l�� FALSE �ł��B
'*
'******************************************************************************
Sub RemoveNetworkDrive(Name As String, Optional Force, Optional UpdateProfile)
    If IsMissing(Force) Then
        If IsMissing(UpdateProfile) Then
            Call mOrigin.RemoveNetworkDrive(Name)
        Else
            Call mOrigin.RemoveNetworkDrive(Name, , UpdateProfile)
        End If
    ElseIf IsMissing(UpdateProfile) Then
        Call mOrigin.RemoveNetworkDrive(Name, Force)
    Else
        Call mOrigin.RemoveNetworkDrive(Name, Force, UpdateProfile)
    End If
End Sub

'******************************************************************************
'* [�T  �v] RemovePrinterConnection ���\�b�h
'* [��  ��] RemovePrinterConnection �̃��b�p�[���\�b�h�B
'*          �R���s���[�^ �V�X�e���̋��L�l�b�g���[�N �v�����^�ڑ����������܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364420%28v%3dmsdn.10%29>
'*
'* @param Name �v�����^���ʖ�������������l�B
'*             UNC �� (\\xxx\yyy �̌`��) �܂��̓��[�J���� (���Ƃ��� LPT1)
'*             ���w��ł��܂��B
'* @param Force �ȗ��\�B�v�����^�̊��蓖�Ă������I�ɉ������邩�ǂ���������
'*              �u�[���l�BTRUE ���w�肷��� (����l�� FALSE)�A���[�U�[���ڑ�
'*              ����Ă��邩�ǂ����Ɋ֌W�Ȃ��A�ڑ�����������܂��B
'* @param UpdateProfile �ȗ��\�B�u�[���l�ł��BTRUE ���w�肷��� (����l��
'*                      FALSE)�A���[�U�[ �v���t�@�C���ɕύX���e���ۑ�����܂��B
'*
'******************************************************************************
Sub RemovePrinterConnection(Name As String, Optional Force, Optional UpdateProfile)
    If IsMissing(Force) Then
        If IsMissing(UpdateProfile) Then
            Call mOrigin.RemovePrinterConnection(Name)
        Else
            Call mOrigin.RemovePrinterConnection(Name, , UpdateProfile)
        End If
    ElseIf IsMissing(UpdateProfile) Then
        Call mOrigin.RemovePrinterConnection(Name, Force)
    Else
        Call mOrigin.RemovePrinterConnection(Name, Force, UpdateProfile)
    End If
End Sub

'******************************************************************************
'* [�T  �v] SetDefaultPrinter ���\�b�h
'* [��  ��] SetDefaultPrinter �̃��b�p�[���\�b�h�B
'*          �w�肳�ꂽ�����[�g �v�����^������̃v�����^�Ƃ��Đݒ肵�܂��B
'* [�Q  �l] <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc364424%28v%3dmsdn.10%29>
'*
'* @param Name �����[�g �v�����^�� UNC ��������������l
'*
'******************************************************************************
Sub SetDefaultPrinter(Name As String)
    Call mOrigin.SetDefaultPrinter(Name)
End Sub

'*-----------------------------------------------------------------------------
'* �g�����\�b�h
'*-----------------------------------------------------------------------------

'******************************************************************************
'* [�T  �v] GetUnusedNetworkDriveName ���\�b�h
'* [��  ��] �g�p����Ă��Ȃ��l�b�g���[�N�h���C�u�����擾����B
'*
'* @return �l�b�g���[�N�h���C�u��
'*
'******************************************************************************
Public Function GetUnusedNetworkDriveName() As String
    Dim i As Long
    Dim colDrives As WScriptExWshCollection
  
    Dim vNdArr() As Variant
    Dim strTmpNd As Variant
    Dim flg As Boolean
    flg = True
    vNdArr = Array("E:", "F:", "G:", "H:", "I:", "J:", "K:", "L:", "M:", "N:", "O:", "P:", "Q:", "R:", "S:", "T:", "U:", "V:", "W:", "X:", "Y:", "Z:")
    
    Set colDrives = Me.EnumNetworkDrives
    For Each strTmpNd In vNdArr
        flg = True
        For i = 0 To colDrives.Count - 1 Step 2
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
    GetUnusedNetworkDriveName = strTmpNd
End Function
