Attribute VB_Name = "Download"
Sub Import_CSV_File_From_URL()
    
    Dim URL As String
    Dim destCell As Range
    Dim ws As Worksheet
    Dim SheetName As String
    Dim SKUShow As String
    Dim Conn As WorkbookConnection
    
    Service = Worksheets("Menu").Range("C2").Value
    Region = Worksheets("Menu").Range("C3").Value
    SKUShow = Worksheets("Menu").Range("C4").Value
    SheetName = Left(Service + "-" + Region, 31)
    
    URL = Worksheets("Tools").Range("G6").Value
    
    'Delete Sheet if already present
    For Each ws In ThisWorkbook.Worksheets
        If SheetName = ws.Name Then
          ws.Delete
        End If
    Next ws
    
    'Add a new Sheet
    Sheets.Add(After:=Sheets(Sheets.Count)).Name = SheetName
    Set destCell = Worksheets(SheetName).Range("A1")
    
    'Get data from AWS API
    With destCell.Parent.QueryTables.Add(Connection:="TEXT;" & URL, Destination:=destCell)
        .TextFileStartRow = 6
        .TextFileParseType = xlDelimited
        .TextFileCommaDelimiter = True
        .Refresh BackgroundQuery:=False
    End With
    destCell.Parent.QueryTables(1).Delete
    
    For Each Conn In ThisWorkbook.Connections
        Conn.Delete
    Next Conn
        
    If SKUShow = "No" Then
        'Delete SKU Columns
        Columns("A:C").Select
        Selection.Delete Shift:=xlToLeft
        If Service = "AmazonEC2" Then
            'Reorder Columns
            Columns("P:Q").Select
            Selection.Cut
            Columns("B:B").Select
            Selection.Insert Shift:=xlToRight
            Columns("H:J").Select
            Selection.Cut
            Columns("D:D").Select
            Selection.Insert Shift:=xlToRight
            Columns("AG:AG").Select
            Selection.Cut
            Columns("H:H").Select
            Selection.Insert Shift:=xlToRight
            Columns("AI:AJ").Select
            Selection.Cut
            Columns("I:I").Select
            Selection.Insert Shift:=xlToRight
            Columns("AU:AU").Select
            Selection.Cut
            Columns("K:K").Select
            Selection.Insert Shift:=xlToRight
            ActiveWindow.ScrollColumn = 1
            Range("A1").Select
        End If
    End If
        
    'Create a Table
    'Find Last Row
    LastRow = Cells(Rows.Count, "A").End(xlUp).Row
        
    'Find Last Column
    LastColumn = Cells(1, Columns.Count).End(xlToLeft).Column
        
    'Range to create table
    Set TblRng = Range("A1", Cells(LastRow, LastColumn))
    
    'Create a table
    ActiveSheet.ListObjects.Add(xlSrcRange, TblRng, , xlYes). _
        Name = SheetName
    Columns("A:AZ").EntireColumn.AutoFit
End Sub

