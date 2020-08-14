VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsFilterReconstructure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'clsFilterReconstructure
'init �œn�������[�N�V�[�g�ɂ���I�[�g�t�B���^�̃t�B���^������
'�L�����āA�����������Đݒ肷��B
'http://yamav102.cocolog-nifty.com/blog/2018/02/post-82ac.html

Private mws As Worksheet

'// ���ꂼ��̗�̃I�[�g�t�B���^�������L������ϐ�
Private mCriterias() As Collection

'���������\�b�h
Friend Sub Init(newWs As Worksheet)
    Set mws = newWs
End Sub

'�I�[�g�t�B���^�̏������L�����܂��B
Public Sub StoreCriterias()

    '// �I�[�g�t�B���^�̖����V�[�g�Ȃ牽�����Ȃ�
    If mws.AutoFilter Is Nothing Then Exit Sub
    
    Dim fltr As AutoFilter
    Dim Clms As Filters
    Dim operator As XlAutoFilterOperator
    
    Set fltr = mws.AutoFilter
    Set Clms = fltr.Filters
    
    '//�@�t�B���^���|�����Ă�����
    If fltr.FilterMode Then
        Dim i As Long
        
        ReDim mCriterias(1 To Clms.count)
        
        '// �S�J�����̃t�B���^�����𒲍�
        For i = 1 To Clms.count
        
            Set mCriterias(i) = New Collection
            
            '// �t�B���^�������ݒ肳��Ă���
            If Clms.Item(i).On Then
            
                '// ���Z�q
                mCriterias(i).Add Clms.Item(i).operator, "operator"
                
                '// ��1����
                If Clms.Item(i).count > 0 Then
                    mCriterias(i).Add Clms.Item(i).Criteria1, "Criteria1"
                End If
                
                '//operator���AxlFilterValues(7) �ȊO�ŁA������2�ȏ�̏ꍇ�͑�2����������̂Ŏ擾
                If 7 <> Clms.Item(i).operator And Clms.Item(i).count > 1 Then
                    mCriterias(i).Add Clms.Item(i).Criteria2, "Criteria2"
                End If
            
            End If '// If Clms.Item(i).On Then
        
        Next '// For i = 1 To Clms.Count
    
    End If '// If fltr.FilterMode Then
    
End Sub
    
'�t�B���^���������đS�s�\�����܂�
Public Sub ShowAllData()
    '// �I�[�g�t�B���^�̖����V�[�g�Ȃ牽�����Ȃ�
    If mws.AutoFilter Is Nothing Then Exit Sub
    
    If mws.FilterMode Then
        mws.ShowAllData
    End If
End Sub
    
'�t�B���^�����̕���
Public Sub ReConstructFilter()
    
    '// �I�[�g�t�B���^�̖����V�[�g�Ȃ牽�����Ȃ�
    If mws.AutoFilter Is Nothing Then Exit Sub
    
    '// �t�B���^������������Ή������Ȃ�
    If IsEmptyArray(mCriterias) Then Exit Sub
    
    Dim i As Long
    Dim rng As Range
    
    Set rng = mws.AutoFilter.Range
    
    '// �t�B���^�̈�̑S�Ă̗�̏����𕜌�
    For i = 1 To mws.AutoFilter.Filters.count
        
        With mCriterias(i)
            ' ��2����������ꍇ
            If HasKey(mCriterias(i), "Criteria2") Then
                rng.AutoFilter Field:=i, _
                Criteria1:=.Item("Criteria1"), _
                Criteria2:=.Item("Criteria2"), _
                operator:=.Item("operator")
            ' ��1�����݂̂̏ꍇ
            ElseIf HasKey(mCriterias(i), "Criteria1") Then
                rng.AutoFilter Field:=i, _
                Criteria1:=.Item("Criteria1"), _
                operator:=.Item("operator")
            End If
        End With
    Next
End Sub

'// ��̔z���n���� True ��Ԃ�
Private Function IsEmptyArray(arr) As Boolean
    Dim errNum As Long
    Dim itemCnt As Long
    
    On Error Resume Next
    
    itemCnt = UBound(arr)
    errNum = err.Number
    
    On Error GoTo 0
    
    'collection �̋�̔z��� ubound �̓G���[�ɂȂ�Ȃ��B-1�@���Ԃ�B
    If errNum <> 0 Or itemCnt = -1 Then
        IsEmptyArray = True
    Else
        IsEmptyArray = False
    End If

End Function

'//�����ɃL�[�����邩�`�F�b�N
Private Function HasKey(Coll As Collection, strKey As String) As Boolean
    Dim var As Variant
    On Error Resume Next
    var = Coll(strKey)
    HasKey = (err.Number = 0)
    err.Clear
End Function
