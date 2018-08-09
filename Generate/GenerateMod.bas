Attribute VB_Name = "GenerateMod"
Option Explicit
Private Const cModName As String = "GenerateMod"
Public Const cEncodeXML = "<?xml version='1.0' encoding='windows-1252'?>"
Public Const cRegKey As String = "HKEY_LOCAL_MACHINE\SOFTWARE\WinTech\ILingual\Generate"
Public Const cRegApp As String = "application"
Public Const cRegEntity As String = "entity"

Public mEntity As String
Public mProject As String
Public mPrefix As String
Public mSystem As String
Public mCommonLabels As Boolean

Public Type tGenerateInfoRec
   oDAT As MSXML2.DOMDocument
   oXML As MSXML2.DOMDocument
   EntityName As String
   ProjectSystem As String
   ProjectPrefix As String
   ProjectName As String
   Language As String
   
   FolderRoot As String
   FolderSystem As String
   FolderApp As String
   FolderProject As String
   FolderBusn As String
   FolderUser As String
   FolderData As String
   FolderDataTables As String
   FolderDataKeys As String
   FolderDataProcs As String
   FolderDataFunctions As String
   FolderDataScripts As String
   FolderWeb As String
   FolderStylesheet As String
   FileCnt As Long
   FileText As String
   ErrorCnt As Long
End Type

Public Function ReplacePrefix( _
   ByVal bvText As String, _
   ByVal bvFind As String, _
   ByVal bvReplace As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  replaces text
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReplacePrefix"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim pos As Long
   Dim LastPos As Long
   Dim c As Long
   Dim str As String
   Dim newstr As String
   
   On Error GoTo ErrorHandler

   str = bvText
   
   pos = 1
   LastPos = 1
   Do
      pos = InStr(pos, str, bvFind)
      ' if we found the string and it's not at the beginning
      If pos = 1 Then
         newstr = bvReplace
         LastPos = Len(bvFind) + 1
      End If
      If pos > 1 Then
         'get the character preceeding the find string
         c = Asc(Mid(str, pos - 1, 1))
         'test if it is a character
         If c < 65 Or (c > 90 And c < 97) Or c > 122 Then
            newstr = newstr + Mid(str, LastPos, (pos - LastPos)) + bvReplace
            LastPos = pos + Len(bvFind)
         End If
      End If
      ' Define a new starting position.
      If pos > 0 Then
         pos = pos + Len(bvFind)
      End If
      
   ' Loop until last occurrence has been found.
   Loop Until pos = 0
   
   newstr = newstr + Mid(str, LastPos)
   
   ReplacePrefix = newstr
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub m_SplitFilePath( _
   ByVal bvFilePath As String, _
   ByRef brFileName As String, _
   ByRef brFolder As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Splits the FilePath specified into the FileName and Path.
   '
   '  Input:
   '  bvFileName - fully-qualified path and file [Required]
   '
   '  Output:
   '  brFileName - file portion of the specified filepath (including extension)
   '  brFolder - folder portion of the specified filepath
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "m_SplitFilePath"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim iPos As Integer
   Dim WorkPath As String
   
   On Error GoTo ErrorHandler

   iPos = InStrRev(bvFilePath, "\")
   
   If iPos > 0 Then
      brFolder = Left$(bvFilePath, iPos)
      brFileName = Mid$(bvFilePath, iPos + 1)
   Else
      '-----no file separator, so whole string is the file name
      brFolder = ""
      brFileName = bvFilePath
   End If
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
End Sub

Public Sub MsgWindow( _
   ByVal bvMsg As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  post message to message window
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "MsgWindow"
   '---------------------------------------------------------------------------------------------------------------------------------
   
   On Error GoTo ErrorHandler

   frmMsg.txtMsg.Text = frmMsg.txtMsg.Text + bvMsg
   frmMsg.txtMsg.SelStart = Len(frmMsg.txtMsg.Text)
   frmMsg.txtMsg.Refresh
   DoEvents

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

