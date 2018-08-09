VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmProject 
   Caption         =   "New Project"
   ClientHeight    =   2640
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6960
   Icon            =   "frmProject.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2640
   ScaleWidth      =   6960
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtClientCopy 
      Height          =   315
      Left            =   1920
      TabIndex        =   2
      Top             =   1200
      Width           =   1275
   End
   Begin VB.TextBox txtPrefixCopy 
      Height          =   315
      Left            =   1920
      TabIndex        =   4
      Top             =   1680
      Width           =   1275
   End
   Begin VB.TextBox txtFileName 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   4635
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "&Select Project to Copy"
      Height          =   375
      Left            =   4980
      TabIndex        =   1
      Top             =   720
      Width           =   1815
   End
   Begin VB.TextBox txtRoot 
      Height          =   315
      Left            =   1920
      TabIndex        =   6
      Text            =   "D:\@Source"
      Top             =   2160
      Width           =   2835
   End
   Begin VB.CommandButton cmdProject 
      Caption         =   "&Create New Project"
      Default         =   -1  'True
      Height          =   375
      Left            =   4980
      TabIndex        =   7
      Top             =   1260
      Width           =   1815
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   4980
      TabIndex        =   9
      Top             =   1800
      Width           =   1815
   End
   Begin VB.TextBox txtPrefix 
      Height          =   315
      Left            =   3510
      TabIndex        =   5
      Top             =   1680
      Width           =   1275
   End
   Begin VB.TextBox txtClient 
      Height          =   315
      Left            =   3510
      TabIndex        =   3
      Top             =   1200
      Width           =   1275
   End
   Begin MSComDlg.CommonDialog dlgOpen 
      Left            =   0
      Top             =   2160
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin VB.Label Label6 
      Caption         =   $"frmProject.frx":0442
      ForeColor       =   &H00800000&
      Height          =   495
      Left            =   180
      TabIndex        =   14
      Top             =   120
      Width           =   6315
   End
   Begin VB.Label Label2 
      Caption         =   "Source Directory"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   600
      TabIndex        =   13
      Top             =   2220
      Width           =   1335
   End
   Begin VB.Label Label5 
      Caption         =   "To"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   3240
      TabIndex        =   12
      Top             =   1260
      Width           =   315
   End
   Begin VB.Label Label4 
      Caption         =   "To"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   0
      Left            =   3240
      TabIndex        =   11
      Top             =   1740
      Width           =   315
   End
   Begin VB.Label Label3 
      Caption         =   "Copy Client From"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   660
      TabIndex        =   10
      Top             =   1260
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Copy Prefix From"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   660
      TabIndex        =   8
      Top             =   1740
      Width           =   1335
   End
End
Attribute VB_Name = "frmProject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const cModName As String = "frmProject"
Public mClient As String
Public mPrefix As String
Public mRoot As String
Public mPath As String

Public mUClient As String
Public mLClient As String
Public mUPrefix As String
Public mLPrefix As String

Public mTotalFolders As Long
Public mTotalFiles As Long
Public mStartTime As Date


Private Sub cmdCancel_Click()
   Unload Me
End Sub

Private Sub cmdProject_Click()
   '--------------------------------------------------------------------------------
   '  Generate New Project
   '--------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "cmdProject_Click"
   '--------------------------------------------------------------------------------
   Dim sPath As String
   Dim sMsg As String
   Dim tmp As Long
   Dim sTotalTime As String
   
   On Error GoTo ErrorHandler
      
   If Len(txtClientCopy.Text) = 0 Then
      MsgBox "Please enter a Client Name to copy from.", vbExclamation
      txtClientCopy.SetFocus
      Exit Sub
   End If
   If Len(txtClient.Text) = 0 Then
      MsgBox "Please enter a Client Name to copy to.", vbExclamation
      txtClient.SetFocus
      Exit Sub
   End If
   If Len(txtRoot.Text) = 0 Then
      MsgBox "Please enter a Source Directory.", vbExclamation
      txtRoot.SetFocus
      Exit Sub
   End If
   If Len(txtPrefix.Text) = 0 Then
      MsgBox "Please enter a Project Prefix to copy to.", vbExclamation
      txtPrefix.SetFocus
      Exit Sub
   End If
   If Len(txtPrefixCopy.Text) = 0 Then
      MsgBox "Please enter a Project Prefix to copy from.", vbExclamation
      txtPrefixCopy.SetFocus
      Exit Sub
   End If
'   If Len(txtPrefix.Text) <> 3 Then
'      MsgBox "Project Prefix must be 3 characters.", vbExclamation
'      txtPrefix.SetFocus
'      Exit Sub
'   End If
'   If Len(txtPrefixCopy.Text) <> 3 Then
'      MsgBox "Copy From Project Prefix must be 3 characters.", vbExclamation
'      txtPrefixCopy.SetFocus
'      Exit Sub
'   End If
   
   mClient = txtClient.Text
   mPrefix = txtPrefix.Text
   mRoot = txtRoot.Text
   
   mLPrefix = LCase(txtPrefixCopy.Text)
   mUPrefix = UCase(txtPrefixCopy.Text)
   mLClient = LCase(txtClientCopy.Text)
   mUClient = UCase(txtClientCopy.Text)
   
   frmMsg.Caption = "New Project"
   frmMsg.txtMsg.Text = ""
   If Not frmMsg.Visible Then
      frmMsg.Left = frmMain.Left + frmMain.Width
      frmMsg.Top = frmMain.Top
      frmMsg.Height = frmMain.Height
      frmMsg.Show , frmMain
   End If
   
   mTotalFolders = 0
   mTotalFiles = 0
   mStartTime = Now
   
   MsgWindow "New Project" + vbCrLf + vbCrLf
   
   sPath = CreateProjectFolders
   
   If Len(sPath) <> 0 Then
      tmp = DateDiff("s", mStartTime, Now)
      sTotalTime = Format(Int(tmp / 60), "00") + ":" + Format(tmp Mod 60, "00")
      sMsg = ""
      sMsg = sMsg + "New Project " & vbTab & sPath & vbTab & vbCr & vbCr
      sMsg = sMsg + "Total Folders " & vbTab & mTotalFolders & vbTab & vbCr & vbCr
      sMsg = sMsg + "Total Files " & vbTab & mTotalFiles & vbTab & vbCr & vbCr
      sMsg = sMsg + "Total Time" & vbTab & sTotalTime + vbCr
      MsgBox sMsg, vbInformation + vbOKOnly, "New Project Complete"
   End If

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Public Function CreateProjectFolders() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Creates the client / project folders.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CreateProjectFolders"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim oFolderSrc As Scripting.Folder
   Dim oFolderDst As Scripting.Folder
   Dim ClientFolder As String
   Dim ProjectFolder As String
   Dim sPath As String
   
   On Error GoTo ErrorHandler
   
   sPath = mRoot
   
   If Right(sPath, 1) <> "\" Then
      sPath = sPath + "\"
   End If
   
   Set oFileSys = New Scripting.FileSystemObject
   
   With oFileSys
      sPath = sPath + mClient
      If Not .FolderExists(sPath) Then
         .CreateFolder sPath
      End If
      sPath = sPath + "\" + mPrefix
      If .FolderExists(sPath) Then
         MsgBox "Project Folder Already Exists", vbExclamation
         CreateProjectFolders = ""
         Exit Function
      Else
         Set oFolderDst = .CreateFolder(sPath)
      End If
      Set oFolderSrc = .GetFolder(mPath)
   End With

   Set oFileSys = Nothing
   If Len(sPath) <> 0 Then sPath = sPath + "\"
   
   MsgWindow sPath + vbCrLf
   AddFolders oFolderSrc, oFolderDst, 1
   
   Set oFolderSrc = Nothing
   Set oFolderDst = Nothing
   
   CreateProjectFolders = sPath
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set oFileSys = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function AddFolders( _
   ByRef oFolderSrc As Scripting.Folder, _
   ByRef oFolderDst As Scripting.Folder, _
   ByVal level As Long) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Creates the client / project folders.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AddFolders"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim oTextStream As Scripting.TextStream
   Dim Folders, Files
   Dim oSrc As Scripting.Folder
   Dim oDst As Scripting.Folder
   Dim File As Scripting.File
   Dim fnam As String
   Dim nam As String
   Dim str As String
   Dim ext As String
   Dim txt As String
   Dim cnt As Long
   
   On Error GoTo ErrorHandler
   
   Set oFileSys = New Scripting.FileSystemObject
   
   With oFolderSrc
   
      Set Folders = .SubFolders
      For Each oSrc In Folders
         mTotalFolders = mTotalFolders + 1
         nam = ReplaceText(mClient, mPrefix, oSrc.Name)
         MsgWindow Space(level * 3) + "Folder: " + nam + vbCrLf
         nam = oFolderDst.Path + "\" + nam
         Set oDst = oFileSys.CreateFolder(nam)
         str = AddFolders(oSrc, oDst, level + 1)
         Set oDst = Nothing
      Next
      Set Folders = Nothing
   
      Set Files = .Files
      For Each File In Files
         mTotalFiles = mTotalFiles + 1
         fnam = ReplaceText(mClient, mPrefix, File.Name)
         nam = oFolderDst.Path + "\" + fnam
         ext = LCase(Right(nam, 3))
         'Dont copy files with these extensions
         If InStr("dll vbp scc", ext) = 0 Then
            MsgWindow Space(level * 3) + "File: " + fnam + vbCrLf
            'replace text for the following file extensions
            If InStr("xml xsl asp sql bat reg", ext) > 0 Then
               Set oTextStream = oFileSys.OpenTextFile(File.Path, ForReading, False, TristateUseDefault)
               With oTextStream
                  txt = .ReadAll
                  .Close
               End With
               Set oTextStream = Nothing
               
               txt = ReplaceText(mClient, mPrefix, txt)
               
               Set oTextStream = oFileSys.OpenTextFile(nam, ForWriting, True)
               With oTextStream
                  .Write txt
                  .Close
               End With
               Set oTextStream = Nothing
            Else
               'Copy binary files
               oFileSys.CopyFile File.Path, nam
            End If
         End If
      Next
      Set Files = Nothing
      
   End With
      
   Set oFileSys = Nothing
      
   AddFolders = str
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set oFileSys = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function ReplaceText( _
   ByVal bvClient As String, _
   ByVal bvPrefix As String, _
   ByVal bvText As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  replaces text
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReplaceText"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim str As String
   
   On Error GoTo ErrorHandler

   str = bvText
   
'   str = Replace(str, mLPrefix, LCase(bvPrefix))
'   str = Replace(str, mUPrefix, UCase(bvPrefix))
'   str = Replace(str, mLClient, LCase(bvClient))
'   str = Replace(str, mUClient, UCase(bvClient))
   
   'Only replace Prefix and Client if they are not embedded in a string
   'The Prefix and Client tokens never follow another character (A-Z, a-z)
   str = ReplacePrefix(str, mLPrefix, LCase(bvPrefix))
   str = ReplacePrefix(str, mUPrefix, UCase(bvPrefix))
   str = ReplacePrefix(str, mLClient, LCase(bvClient))
   str = ReplacePrefix(str, mUClient, UCase(bvClient))
   
   ReplaceText = str
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Sub cmdBrowse_Click()
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Opem Entity XML File
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "cmdBrowse_Click"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim sFile As String
   Dim sPath As String
   Dim sRoot As String
   Dim sProject As String
   
   On Error GoTo ErrorHandler
   
   With dlgOpen
      .CancelError = True
      .DefaultExt = "_Application.xml"
      .DialogTitle = "Select Project to Copy"
      .Filter = "Application XML Files|_application.xml"
      .ShowOpen
      sFile = .FileName
   End With
      
   If Right(UCase(sFile), 16) = "_APPLICATION.XML" Then
      
      '-----split file name and path out
      m_SplitFilePath sFile, sFile, mPath
      If Right$(mPath, 1) <> "\" Then mPath = mPath + "\"
      txtFileName = mPath
   End If

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   MousePointer = 0 '---default
   If Err.Number = 0 Then
      Resume Next
   ElseIf Err.Number = 32755 Then
      '-----user cancelled, so do nothing
      Err.Clear
      Exit Sub
   Else
      ShowError Err.Number, Err.Source, Err.Description
   End If
End Sub


