VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ScriptingExEncoder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] Scripting.Encoder�N���X�̃��b�v�E�g���N���X
'* [��  ��] Scripting.Encoder�N���X��Wrapper�Ƃ��Ă̋@�\��񋟂��鑼�A
'*          Scripting.Encoder�N���X���g�p�������[�e�B���e�B��񋟂���B
'*
'* @author Bankura
'* Copyright (c) 2019 Bankura
'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

'------------------------------------------------------------------------------
' [��  ��]
' Scripting.Encoder�N���X�ɂ��āB
' VBScript���Í���������@��񋟂���I�u�W�F�N�g�B
' <https://docs.microsoft.com/ja-jp/previous-versions/windows/scripting/cc392170(v%3dmsdn.10)>
' <https://gallery.technet.microsoft.com/scriptcenter/16439c02-3296-4ec8-9134-6eb6fb599880>
' <http://sammaya.jugem.jp/?eid=13>
'
'------------------------------------------------------------------------------

'******************************************************************************
'* �����ϐ���`
'******************************************************************************
'Private mOrigin As Scripting.Encoder
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

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mOrigin = CreateObject("Scripting.Encoder")
End Sub
Private Sub Class_Terminate()
    Set mOrigin = Nothing
End Sub
 
'******************************************************************************
'* ���\�b�h��`
'******************************************************************************

'******************************************************************************
'* [�T  �v] EncodeScriptFile ���\�b�h(���胁���o�[)
'* [��  ��] EncodeScriptFile �̃��b�p�[���\�b�h�B
'*          szExt �ɂ���Č��肳�ꂽ�G���R�[�_���Ăяo���AbstrStreamIn
'*          ����уI�v�V����������n���B
'*
'* @param szExt �G���R�[�h�Ώۊg���q�ie.g. ".vbs", ".js", ".htm", ".html"�j
'* @param bstrStreamIn �\�[�XScript�e�L�X�g
'* @param cFlags �t���O�i0�j
'* @param bstrDefaultLang �f�t�H���g��Language
'*                        �ie.g. "VBScript", "JScript". Can be a null string, ""�j
'* @return Encode���ꂽScript������
'******************************************************************************
Function EncodeScriptFile(szExt As String, bstrStreamIn As String, cFlags As Long, bstrDefaultLang As String) As String
Attribute EncodeScriptFile.VB_UserMemId = 0
    EncodeScriptFile = mOrigin.EncodeScriptFile(szExt, bstrStreamIn, cFlags, bstrDefaultLang)
End Function