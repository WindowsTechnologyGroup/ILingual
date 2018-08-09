VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmEntity 
   Caption         =   "New Entity"
   ClientHeight    =   3240
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6915
   Icon            =   "frmEntity.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3240
   ScaleWidth      =   6915
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtEntity 
      Height          =   315
      Left            =   3510
      TabIndex        =   3
      Top             =   1320
      Width           =   1275
   End
   Begin VB.TextBox txtEntityCopy 
      Height          =   315
      Left            =   1860
      TabIndex        =   2
      Top             =   1320
      Width           =   1275
   End
   Begin VB.TextBox txtClient 
      Height          =   315
      Left            =   3510
      TabIndex        =   5
      Top             =   1800
      Width           =   1275
   End
   Begin VB.TextBox txtPrefix 
      Height          =   315
      Left            =   3510
      TabIndex        =   7
      Top             =   2280
      Width           =   1275
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   4980
      TabIndex        =   10
      Top             =   1920
      Width           =   1815
   End
   Begin VB.CommandButton cmdProject 
      Caption         =   "&Create New Entity"
      Default         =   -1  'True
      Height          =   375
      Left            =   4980
      TabIndex        =   9
      Top             =   1380
      Width           =   1815
   End
   Begin VB.TextBox txtRoot 
      Height          =   315
      Left            =   1920
      TabIndex        =   8
      Text            =   "C:\@Source"
      Top             =   2760
      Width           =   2835
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "&Select Entity to Copy"
      Height          =   375
      Left            =   4980
      TabIndex        =   1
      Top             =   840
      Width           =   1815
   End
   Begin VB.TextBox txtFileName 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   4635
   End
   Begin VB.TextBox txtPrefixCopy 
      Height          =   315
      Left            =   1860
      TabIndex        =   6
      Top             =   2280
      Width           =   1275
   End
   Begin VB.TextBox txtClientCopy 
      Height          =   315
      Left            =   1860
      TabIndex        =   4
      Top             =   1800
      Width           =   1275
   End
   Begin MSComDlg.CommonDialog dlgOpen 
      Left            =   60
      Top             =   2040
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin VB.Label Label4 
      Caption         =   "*Required"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   1
      Left            =   4980
      TabIndex        =   19
      Top             =   2820
      Width           =   855
   End
   Begin VB.Label Label8 
      Caption         =   "Copy Entity From"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   600
      TabIndex        =   18
      Top             =   1380
      Width           =   1335
   End
   Begin VB.Label Label7 
      Caption         =   "To"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   3240
      TabIndex        =   17
      Top             =   1380
      Width           =   315
   End
   Begin VB.Label Label1 
      Caption         =   "Copy Prefix From"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   600
      TabIndex        =   16
      Top             =   2340
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "Copy Client From"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   600
      TabIndex        =   15
      Top             =   1860
      Width           =   1335
   End
   Begin VB.Label Label4 
      Caption         =   "To*"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   0
      Left            =   3180
      TabIndex        =   14
      Top             =   2340
      Width           =   315
   End
   Begin VB.Label Label5 
      Caption         =   "To*"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   3180
      TabIndex        =   13
      Top             =   1860
      Width           =   315
   End
   Begin VB.Label Label2 
      Caption         =   "Source Directory*"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   300
      TabIndex        =   12
      Top             =   2820
      Width           =   1635
   End
   Begin VB.Label Label6 
      Caption         =   $"frmEntity.frx":0442
      ForeColor       =   &H00800000&
      Height          =   615
      Left            =   180
      TabIndex        =   11
      Top             =   120
      Width           =   6315
   End
End
Attribute VB_Name = "frmEntity"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const cModName As String = "frmEntity"
Public mClient As String
Public mPrefix As String
Public mEntity As String
Public mRoot As String
Public mPath As String
Public mFolder As String
Public mFile As String

Public mUClient As String
Public mLClient As String
Public mUPrefix As String
Public mLPrefix As String
Public mFEntity As String  'From Entity Name
Public mUEntity As String  'Uppaercase From Entity Name
Public mLEntity As String  'Lowercase From Entity Name
Public mPEntity As String  'Propercase From Entity Name

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
      
   If Len(txtClient.Text) = 0 Then
      MsgBox "Please enter a Client Name to copy to.", vbExclamation
      txtClient.SetFocus
      Exit Sub
   End If
   If Len(txtPrefix.Text) = 0 Then
      MsgBox "Please enter a Project Prefix to copy to.", vbExclamation
      txtPrefix.SetFocus
      Exit Sub
   End If
   If Len(txtRoot.Text) = 0 Then
      MsgBox "Please enter a Source Directory.", vbExclamation
      txtRoot.SetFocus
      Exit Sub
   End If
   
   mEntity = txtEntity.Text
   mClient = txtClient.Text
   mPrefix = txtPrefix.Text
   mRoot = txtRoot.Text
   
   mFEntity = txtEntityCopy.Text
   mLEntity = LCase(mFEntity)
   mUEntity = UCase(mFEntity)
   mPEntity = UCase(Left(mFEntity, 1)) + LCase(Mid(mFEntity, 2))
   mLPrefix = LCase(txtPrefixCopy.Text)
   mUPrefix = UCase(txtPrefixCopy.Text)
   mLClient = LCase(txtClientCopy.Text)
   mUClient = UCase(txtClientCopy.Text)
   
   frmMsg.Caption = "New Entity"
   frmMsg.txtMsg.Text = ""
   If Not frmMsg.Visible Then
      frmMsg.Left = frmMain.Left + frmMain.Width
      frmMsg.Top = frmMain.Top
      frmMsg.Height = frmMain.Height
      frmMsg.Show , frmMain
   End If
   
   MsgWindow "New Entity" + vbCrLf + vbCrLf
   
   sPath = CreateEntityFolder
   
   If Len(sPath) <> 0 Then
      sMsg = ""
      sMsg = sMsg + "New Entity Created" & vbCr & vbCr & sPath
      MsgBox sMsg, vbInformation + vbOKOnly, "New Entity Complete"
   End If

   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Public Function CreateEntityFolder() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Creates the client / project folders.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CreateEntityFolder"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim oFolderDst As Scripting.Folder
   Dim sPath As String
   Dim fnam As String
   
   On Error GoTo ErrorHandler
   
   sPath = mRoot
  
   If Right(sPath, 1) <> "\" Then
      sPath = sPath + "\"
   End If
   
   Set oFileSys = New Scripting.FileSystemObject
   With oFileSys
      'Create Client Folder if it doesn't exist
      sPath = sPath + mClient
      If Not .FolderExists(sPath) Then
         .CreateFolder sPath
      End If
      'Create Prefix Folder if it doesn't exist
      sPath = sPath + "\" + mPrefix
      If Not .FolderExists(sPath) Then
         .CreateFolder sPath
      End If
      'Create Entity Folder if it doesn't exist
'      fnam = ReplaceText(mClient, mPrefix, mEntity, mFolder)
'      sPath = sPath + "\" + fnam
'      If Not .FolderExists(sPath) Then
'         .CreateFolder sPath
'      End If
      If Len(sPath) <> 0 Then sPath = sPath + "\"
      Set oFolderDst = .GetFolder(sPath)
   End With
   Set oFileSys = Nothing
   
   MsgWindow sPath + vbCrLf
   sPath = AddEntityFile(oFolderDst)
   
   Set oFolderDst = Nothing
   
   CreateEntityFolder = sPath
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set oFileSys = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function AddEntityFile( _
   ByRef oFolderDst As Scripting.Folder) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Creates the client / project folders.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "AddEntityFile"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim oTextStream As Scripting.TextStream
   Dim fnam As String
   Dim nam As String
   Dim txt As String
   
   On Error GoTo ErrorHandler
   
   Set oFileSys = New Scripting.FileSystemObject
   
   fnam = ReplaceText(mClient, mPrefix, mEntity, mFile)
   nam = oFolderDst.Path + "\" + fnam
   MsgWindow "File: " + fnam + vbCrLf
   Set oTextStream = oFileSys.OpenTextFile(mPath + mFile, ForReading, False, TristateUseDefault)
   With oTextStream
      txt = .ReadAll
      .Close
   End With
   Set oTextStream = Nothing
   
   txt = ReplaceText(mClient, mPrefix, mEntity, txt)
   
   Set oTextStream = oFileSys.OpenTextFile(nam, ForWriting, True)
   With oTextStream
      .Write txt
      .Close
   End With
   Set oTextStream = Nothing
      
   Set oFileSys = Nothing
      
   AddEntityFile = nam
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set oFileSys = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

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

Public Function ReplaceText( _
   ByVal bvClient As String, _
   ByVal bvPrefix As String, _
   ByVal bvEntity As String, _
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
   
   If mLEntity <> "" And mLEntity <> LCase(bvEntity) Then
      str = Replace(str, mFEntity, bvEntity)
      str = Replace(str, mLEntity, LCase(bvEntity))
      str = Replace(str, mUEntity, UCase(bvEntity))
      str = Replace(str, mPEntity, UCase(Left(bvEntity, 1)) + LCase(Mid(bvEntity, 2)))
   End If
   'Only replace Prefix and Client if they are not embedded in a string
   'The Prefix and Client tokens never follow another character (A-Z, a-z)
   'Don't replace if no copy from or the copy from  = copy to
   If mLPrefix <> "" And mLPrefix <> LCase(bvPrefix) Then
      str = ReplacePrefix(str, mLPrefix, LCase(bvPrefix))
      str = ReplacePrefix(str, mUPrefix, UCase(bvPrefix))
   End If
   If mLClient <> "" And mLClient <> LCase(bvClient) Then
      str = ReplacePrefix(str, mLClient, LCase(bvClient))
      str = ReplacePrefix(str, mUClient, UCase(bvClient))
   End If
   
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
   Dim pos As Integer
   
   On Error GoTo ErrorHandler
   
   With dlgOpen
      .CancelError = True
'      .DefaultExt = "Entity.xml"
      .DialogTitle = "Select Entity to Copy"
      .Filter = "Entity XML Files|*.xml"
      .ShowOpen
      sFile = .FileName
   End With
      
   If Right(UCase(sFile), 4) = ".XML" Then
      
      '-----split file name and path out
      m_SplitFilePath sFile, mFile, mPath
      If Right$(mPath, 1) <> "\" Then mPath = mPath + "\"
      txtFileName = sFile
      pos = InStrRev(mPath, "\", Len(mPath) - 1)
'      If pos > 0 Then
'         mFolder = Mid(mPath, pos + 1, (Len(mPath) - pos) - 1)
'      End If
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


