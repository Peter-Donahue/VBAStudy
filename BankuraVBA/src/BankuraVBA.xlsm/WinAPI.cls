VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WinAPI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'*/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
'*
'* [�@�\��] WindowAPI�N���X
'* [��  ��] WindowAPI�̋@�\��񋟂���B
'*
'* [�Q  �l] Win32API_PtrSafe.TXT
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
'* �����ϐ���`
'******************************************************************************

Private mWinApiAdvapi As WinApiAdvapi
Private mWinApiComdlg As WinApiComdlg
Private mWinApiGdi As WinApiGdi
Private mWinApiImm As WinApiImm
Private mWinApiKernel As WinApiKernel
Private mWinApiKernelWinBase As WinApiKernelWinbase
Private mWinApiLz As WinApiLz
Private mWinApiMpr As WinApiMpr
Private mWinApiNetapi As WinApiNetapi
Private mWinApiOle As WinApiOle
Private mWinApiOleacc As WinApiOleacc
Private mWinApiOleaut As WinApiOleaut
Private mWinApiShell As WinApiShell
Private mWinApiUrlmon As WinApiUrlmon
Private mWinApiUser As WinApiUser
Private mWinApiVersion As WinApiVersion
Private mWinApiWininet As WinApiWininet
Private mWinApiWinmm As WinApiWinmm
Private mWinApiWinspool As WinApiWinspool


'******************************************************************************
'* �v���p�e�B��`
'******************************************************************************

'******************************************************************************
'* �R���X�g���N�^�E�f�X�g���N�^
'******************************************************************************
Private Sub Class_Initialize()
    Set mWinApiAdvapi = New WinApiAdvapi
    Set mWinApiComdlg = New WinApiComdlg
    Set mWinApiGdi = New WinApiGdi
    Set mWinApiImm = New WinApiImm
    Set mWinApiKernel = New WinApiKernel
    Set mWinApiKernelWinBase = New WinApiKernelWinbase
    Set mWinApiLz = New WinApiLz
    Set mWinApiMpr = New WinApiMpr
    Set mWinApiNetapi = New WinApiNetapi
    Set mWinApiOle = New WinApiOle
    Set mWinApiOleacc = New WinApiOleacc
    Set mWinApiOleaut = New WinApiOleaut
    Set mWinApiShell = New WinApiShell
    Set mWinApiUrlmon = New WinApiUrlmon
    Set mWinApiUser = New WinApiUser
    Set mWinApiVersion = New WinApiVersion
    Set mWinApiWininet = New WinApiWininet
    Set mWinApiWinmm = New WinApiWinmm
    Set mWinApiWinspool = New WinApiWinspool
End Sub
Private Sub Class_Terminate()
    Set mWinApiAdvapi = Nothing
    Set mWinApiComdlg = Nothing
    Set mWinApiGdi = Nothing
    Set mWinApiImm = Nothing
    Set mWinApiKernel = Nothing
    Set mWinApiKernelWinBase = Nothing
    Set mWinApiLz = Nothing
    Set mWinApiMpr = Nothing
    Set mWinApiNetapi = Nothing
    Set mWinApiOle = Nothing
    Set mWinApiOleacc = Nothing
    Set mWinApiOleaut = Nothing
    Set mWinApiShell = Nothing
    Set mWinApiUrlmon = Nothing
    Set mWinApiUser = Nothing
    Set mWinApiVersion = Nothing
    Set mWinApiWininet = Nothing
    Set mWinApiWinmm = Nothing
    Set mWinApiWinspool = Nothing
End Sub

'*=============================================================================
'* ole32
'*=============================================================================

'******************************************************************************
'* [�T  �v] IIDFromString
'* [��  ��] WindowsAPI�u IIDFromString �v���b�p�[���\�b�h�B
'*          Lib "ole32"
'*
'******************************************************************************
Friend Function IIDFromString(lpsz As Byte, lpiid As LongPtr) As Long
    IIDFromString = mWinApiOle.WinApi_IIDFromString(lpsz, lpiid)
End Function


'*=============================================================================
'* oleacc
'*=============================================================================
'******************************************************************************
'* [�T  �v] ObjectFromLresult
'* [��  ��] WindowsAPI�u ObjectFromLresult �v���b�p�[���\�b�h�B
'*          Lib "oleacc"
'*
'******************************************************************************
Friend Function ObjectFromLresult(ByVal lResult As LongPtr, riid As LongPtr, ByVal wParam As LongPtr, ppvObject As Object) As LongPtr
    ObjectFromLresult = mWinApiOleacc.WinApi_ObjectFromLresult(lResult, riid, wParam, ppvObject)
End Function

'*=============================================================================
'* oleaut
'*=============================================================================

'******************************************************************************
'* [�T  �v] DispCallFunc
'* [��  ��] WindowsAPI�u DispCallFunc �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function DispCallFunc(ByVal pvInstance As LongPtr, ByVal oVft As LongPtr, ByVal cc_ As Long, ByVal vtReturn As Integer, ByVal cActuals As Long, ByRef prgvt As Integer, ByRef prgpvarg As LongPtr, ByRef pvargResult As Variant) As Long
    DispCallFunc = mWinApiOleaut.WinApi_DispCallFunc(pvInstance, oVft, cc_, vtReturn, cActuals, prgvt, prgpvarg, pvargResult)
End Function

'******************************************************************************
'* [�T  �v] SafeArrayAllocDescriptor
'* [��  ��] WindowsAPI�u SafeArrayAllocDescriptor �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function SafeArrayAllocDescriptor(ByVal cDims As Long, ByRef ppsaOut() As Long) As Long
    SafeArrayAllocDescriptor = mWinApiOleaut.WinApi_SafeArrayAllocDescriptor(cDims, ppsaOut)
End Function

'*=============================================================================
'* urlmon
'*=============================================================================
'******************************************************************************
'* [�T  �v] URLDownloadToFile
'* [��  ��] WindowsAPI�u URLDownloadToFile �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function URLDownloadToFile(ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
    URLDownloadToFile = mWinApiUrlmon.WinApi_URLDownloadToFile(pCaller, szURL, szFileName, dwReserved, lpfnCB)
End Function


'*=============================================================================
'* wininet
'*=============================================================================
'******************************************************************************
'* [�T  �v] DeleteUrlCacheEntry
'* [��  ��] WindowsAPI�u DeleteUrlCacheEntry �v���b�p�[���\�b�h�B
'*
'******************************************************************************
Friend Function DeleteUrlCacheEntry(ByVal lpszUrlName As String) As Long
    DeleteUrlCacheEntry = mWinApiWininet.WinApi_DeleteUrlCacheEntry(lpszUrlName)
End Function


'*=============================================================================
'* shell32
'*=============================================================================

'******************************************************************************
'* [�T  �v] SHCreateDirectoryEx
'* [��  ��] WindowsAPI�u SHCreateDirectoryEx �v���b�p�[���\�b�h�B
'*          Lib "shell32"
'*
'******************************************************************************
Friend Function SHCreateDirectoryEx(ByVal hWnd As LongPtr, ByVal pszPath As String, ByVal psa As Long) As LongPtr
    SHCreateDirectoryEx = mWinApiShell.WinApi_SHCreateDirectoryEx(hWnd, pszPath, psa)
End Function

'*=============================================================================
'* kernel32
'*=============================================================================

'******************************************************************************
'* [�T  �v] Sleep
'* [��  ��] WindowsAPI�u Sleep �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'* @param ms �ҋ@���ԁi�~���b�j
'*
'******************************************************************************
Friend Sub Sleep(ByVal ms As Long)
    Call mWinApiKernel.WinApi_Sleep(ms)
End Sub

'******************************************************************************
'* [�T  �v] CopyMemory
'* [��  ��] WindowsAPI�u CopyMemory �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Sub CopyMemory(Destination As LongPtr, Source As LongPtr, ByVal Length As LongPtr)
    Call mWinApiKernel.WinApi_CopyMemory(Destination, Source, Length)
End Sub

'******************************************************************************
'* [�T  �v] CopyMemoryByRef
'* [��  ��] WindowsAPI�u CopyMemory �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Sub CopyMemoryByRef(ByRef Destination As LongPtr, ByRef Source As LongPtr, ByVal Length As LongPtr, _
                           Optional destByVal As Boolean = False, Optional sourceByVal As Boolean = False)
    Call mWinApiKernel.WinApi_CopyMemoryByRef(Destination, Source, Length, destByVal, sourceByVal)
End Sub

'******************************************************************************
'* [�T  �v] GetPrivateProfileString
'* [��  ��] WindowsAPI�u GetPrivateProfileString �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function GetPrivateProfileString(ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
    GetPrivateProfileString = mWinApiKernel.WinApi_GetPrivateProfileString(lpApplicationName, lpKeyName, lpDefault, lpReturnedString, nSize, lpFileName)
End Function

'******************************************************************************
'* [�T  �v] CreateFile
'* [��  ��] WindowsAPI�u CreateFile �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function CreateFile(ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, lpSecurityAttributes As Long, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As LongPtr) As LongPtr
    CreateFile = mWinApiKernel.WinApi_CreateFile(lpFileName, dwDesiredAccess, dwShareMode, lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile)
End Function

'******************************************************************************
'* [�T  �v] CloseHandle
'* [��  ��] WindowsAPI�u CloseHandle �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function CloseHandle(ByVal hObject As LongPtr) As Long
    CloseHandle = mWinApiKernel.WinApi_CloseHandle(hObject)
End Function

'******************************************************************************
'* [�T  �v] LocalFileTimeToFileTime
'* [��  ��] WindowsAPI�u LocalFileTimeToFileTime �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function LocalFileTimeToFileTime(lpLocalFileTime As FILETIME, lpFileTime As FILETIME) As Long
    LocalFileTimeToFileTime = mWinApiKernel.WinApi_LocalFileTimeToFileTime(lpLocalFileTime, lpFileTime)
End Function

'******************************************************************************
'* [�T  �v] SystemTimeToFileTime
'* [��  ��] WindowsAPI�u SystemTimeToFileTime �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function SystemTimeToFileTime(lpSystemTime As SystemTime, lpFileTime As FILETIME) As Long
    SystemTimeToFileTime = mWinApiKernel.WinApi_SystemTimeToFileTime(lpSystemTime, lpFileTime)
End Function

'******************************************************************************
'* [�T  �v] SetFileTime
'* [��  ��] WindowsAPI�u SetFileTime �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function SetFileTime(ByVal hFile As LongPtr, ByRef lpCreationTime As FILETIME, ByRef lpLastAccessTime As FILETIME, ByRef lpLastWriteTime As FILETIME) As Long
    SetFileTime = mWinApiKernel.WinApi_SetFileTime(hFile, lpCreationTime, lpLastAccessTime, lpLastWriteTime)
End Function

'******************************************************************************
'* [�T  �v] GetFileTime
'* [��  ��] WindowsAPI�u GetFileTime �v���b�p�[���\�b�h�B
'*          Lib "kernel32"
'*
'******************************************************************************
Friend Function GetFileTime(ByVal hFile As LongPtr, ByRef lpCreationTime As FILETIME, ByRef lpLastAccessTime As FILETIME, ByRef lpLastWriteTime As FILETIME) As Long
    GetFileTime = mWinApiKernel.WinApi_GetFileTime(hFile, lpCreationTime, lpLastAccessTime, lpLastWriteTime)
End Function


'*=============================================================================
'* user32
'*=============================================================================

'******************************************************************************
'* [�T  �v] GetInputState
'* [��  ��] WindowsAPI�u GetInputState �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetInputState() As Long
    GetInputState = mWinApiUser.WinApi_GetInputState()
End Function

'******************************************************************************
'* [�T  �v] SetForegroundWindow
'* [��  ��] WindowsAPI�u SetForegroundWindow �v���b�p�[���\�b�h�B
'*          �E�B���h�E�������I�ɍőO�ʂɕ\��������API�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function SetForegroundWindow(ByVal hWnd As LongPtr) As Long
    SetForegroundWindow = mWinApiUser.WinApi_SetForegroundWindow(hWnd)
End Function

'******************************************************************************
'* [�T  �v] IsIconic
'* [��  ��] WindowsAPI�u IsIconic �v���b�p�[���\�b�h�B
'*          �E�B���h�E���ŏ�������Ă��邩���ׂ�API�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function IsIconic(ByVal hWnd As LongPtr) As Long
    IsIconic = mWinApiUser.WinApi_IsIconic(hWnd)
End Function
    
'******************************************************************************
'* [�T  �v] ShowWindowAsync
'* [��  ��] WindowsAPI�u ShowWindowAsync �v���b�p�[���\�b�h�B
'*          �E�B���h�E�����̑傫���ɖ߂�API�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function ShowWindowAsync(ByVal hWnd As LongPtr, ByVal nCmdShow As Long) As Long
    ShowWindowAsync = mWinApiUser.WinApi_ShowWindowAsync(hWnd, nCmdShow)
End Function

'******************************************************************************
'* [�T  �v] PeekMessage
'* [��  ��] WindowsAPI�u PeekMessage �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function PeekMessage(lpMsg As msg, ByVal hWnd As LongPtr, ByVal wMsgFilterMin As Long, ByVal wMsgFilterMax As Long, ByVal wRemoveMsg As Long) As Long
    PeekMessage = mWinApiUser.WinApi_PeekMessage(lpMsg, hWnd, wMsgFilterMin, wMsgFilterMax, wRemoveMsg)
End Function

'******************************************************************************
'* [�T  �v] TranslateMessage
'* [��  ��] WindowsAPI�u TranslateMessage �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function TranslateMessage(lpMsg As msg) As Long
    TranslateMessage = mWinApiUser.WinApi_TranslateMessage(lpMsg)
End Function

'******************************************************************************
'* [�T  �v] DispatchMessage
'* [��  ��] WindowsAPI�u DispatchMessage �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function DispatchMessage(lpMsg As msg) As LongPtr
    DispatchMessage = mWinApiUser.WinApi_DispatchMessage(lpMsg)
End Function

'******************************************************************************
'* [�T  �v] keybd_event
'* [��  ��] WindowsAPI�u keybd_event �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Sub keybd_event(ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As LongPtr)
    Call mWinApiUser.WinApi_keybd_event(bVk, bScan, dwFlags, dwExtraInfo)
End Sub

'******************************************************************************
'* [�T  �v] GetKeyboardState
'* [��  ��] WindowsAPI �uGetKeyboardState �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetKeyboardState(pbKeyState As Byte) As Long
    GetKeyboardState = mWinApiUser.WinApi_GetKeyboardState(pbKeyState)
End Function

'******************************************************************************
'* [�T  �v] SetCursorPos
'* [��  ��] WindowsAPI�u SetCursorPos �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function SetCursorPos(ByVal x As Long, ByVal y As Long) As Long
    SetCursorPos = mWinApiUser.WinApi_SetCursorPos(x, y)
End Function

'******************************************************************************
'* [�T  �v] GetCursorPos
'* [��  ��] WindowsAPI�u GetCursorPos �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetCursorPos(lpPoint As POINTAPI) As Long
    GetCursorPos = mWinApiUser.WinApi_GetCursorPos(lpPoint)
End Function

'******************************************************************************
'* [�T  �v] EnumChildWindows
'* [��  ��] WindowsAPI�u EnumChildWindows �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function EnumChildWindows(ByVal hwndParent As LongPtr, ByVal lpEnumFunc As LongPtr, ByVal lParam As LongPtr) As Long
    EnumChildWindows = mWinApiUser.WinApi_EnumChildWindows(hwndParent, lpEnumFunc, lParam)
End Function

'******************************************************************************
'* [�T  �v] EnumWindows
'* [��  ��] WindowsAPI�u EnumWindows �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function EnumWindows(ByVal lpEnumFunc As LongPtr, ByVal lParam As LongPtr) As Long
    EnumWindows = mWinApiUser.WinApi_EnumWindows(lpEnumFunc, lParam)
End Function

'******************************************************************************
'* [�T  �v] GetClassName
'* [��  ��] WindowsAPI�u GetClassName �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetClassName(ByVal hWnd As LongPtr, ByRef lpClassName As String, ByVal nMaxCount As Long) As Long
    GetClassName = mWinApiUser.WinApi_GetClassName(hWnd, lpClassName, nMaxCount)
End Function

'******************************************************************************
'* [�T  �v] GetDesktopWindow
'* [��  ��] WindowsAPI�u GetDesktopWindow �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetDesktopWindow() As LongPtr
    GetDesktopWindow = mWinApiUser.WinApi_GetDesktopWindow()
End Function

'******************************************************************************
'* [�T  �v] GetWindow
'* [��  ��] WindowsAPI�u GetWindow �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetWindow(ByVal hWnd As LongPtr, ByVal wCmd As Long) As LongPtr
    GetWindow = mWinApiUser.WinApi_GetWindow(hWnd, wCmd)
End Function

'******************************************************************************
'* [�T  �v] GetWindowText
'* [��  ��] WindowsAPI�u GetWindowText �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetWindowText(ByVal hWnd As LongPtr, ByRef lpString As String, ByVal cch As Long) As Long
    GetWindowText = mWinApiUser.WinApi_GetWindowText(hWnd, lpString, cch)
End Function

'******************************************************************************
'* [�T  �v] GetWindowThreadProcessId
'* [��  ��] WindowsAPI�u GetWindowThreadProcessId �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function GetWindowThreadProcessId(ByVal hWnd As LongPtr, lpdwProcessId As Long) As Long
    GetWindowThreadProcessId = mWinApiUser.WinApi_GetWindowThreadProcessId(hWnd, lpdwProcessId)
End Function

'******************************************************************************
'* [�T  �v] IsWindow
'* [��  ��] WindowsAPI�u IsWindow �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function IsWindow(ByVal hWnd As LongPtr) As LongPtr
    IsWindow = mWinApiUser.WinApi_IsWindow(hWnd)
End Function

'******************************************************************************
'* [�T  �v] SendMessage
'* [��  ��] WindowsAPI�u SendMessage �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function SendMessage(ByVal hWnd As LongPtr, ByVal wMsg As Long, ByVal wParam As LongPtr, lParam As LongPtr) As LongPtr
    SendMessage = mWinApiUser.WinApi_SendMessage(hWnd, wMsg, wParam, lParam)
End Function

'******************************************************************************
'* [�T  �v] IsWindowVisible
'* [��  ��] WindowsAPI�u IsWindowVisible �v���b�p�[���\�b�h�B
'*          Lib "user32"
'*
'******************************************************************************
Friend Function IsWindowVisible(ByVal hWnd As LongPtr) As Long
    IsWindowVisible = mWinApiUser.WinApi_IsWindowVisible(hWnd)
End Function
