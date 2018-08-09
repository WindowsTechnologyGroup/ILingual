VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmMain 
   Caption         =   "Generate"
   ClientHeight    =   5835
   ClientLeft      =   2055
   ClientTop       =   2340
   ClientWidth     =   5985
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5815.152
   ScaleMode       =   0  'User
   ScaleWidth      =   5985
   Begin VB.CommandButton cmdEntity 
      Caption         =   "&New Entity"
      Height          =   375
      Left            =   4920
      TabIndex        =   36
      Top             =   5338
      Width           =   975
   End
   Begin VB.CommandButton cmdProject 
      Caption         =   "&New Project"
      Height          =   375
      Left            =   3720
      TabIndex        =   34
      Top             =   5338
      Width           =   1095
   End
   Begin VB.ComboBox cmbApp 
      Height          =   315
      Left            =   690
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   540
      Width           =   5175
   End
   Begin VB.Frame fraWeb 
      Caption         =   "Web Services (...Web)"
      ForeColor       =   &H00000000&
      Height          =   1335
      Left            =   3120
      TabIndex        =   27
      Top             =   2160
      Width           =   2715
      Begin VB.CheckBox chkTemplate 
         Caption         =   "Templates"
         Height          =   195
         Left            =   240
         TabIndex        =   33
         Top             =   960
         Width           =   1515
      End
      Begin VB.CheckBox chkLanguage 
         Caption         =   "Language File"
         Height          =   315
         Left            =   240
         TabIndex        =   29
         Top             =   600
         Value           =   1  'Checked
         Width           =   1755
      End
      Begin VB.CheckBox chkWebPages 
         Caption         =   "Web Pages *"
         Height          =   315
         Left            =   240
         TabIndex        =   28
         Top             =   300
         Value           =   1  'Checked
         Width           =   1395
      End
   End
   Begin VB.TextBox txtRootPath 
      Height          =   315
      Left            =   2610
      TabIndex        =   1
      Top             =   120
      Width           =   3195
   End
   Begin VB.CommandButton cmdCheck 
      Caption         =   "Uncheck All"
      Height          =   375
      Left            =   1440
      TabIndex        =   31
      Top             =   5338
      Width           =   1095
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "&Close"
      Height          =   375
      Left            =   2640
      TabIndex        =   32
      Top             =   5338
      Width           =   975
   End
   Begin VB.Frame fraOptions 
      Caption         =   "Generate Options"
      Height          =   1035
      Left            =   120
      TabIndex        =   10
      Top             =   960
      Width           =   5775
      Begin VB.TextBox txtName 
         Height          =   315
         Left            =   4320
         TabIndex        =   4
         Top             =   240
         Width           =   1275
      End
      Begin VB.TextBox txtSystem 
         Height          =   315
         Left            =   900
         TabIndex        =   5
         Top             =   600
         Width           =   1275
      End
      Begin VB.TextBox txtPrefix 
         Height          =   315
         Left            =   3180
         TabIndex        =   6
         Top             =   600
         Width           =   735
      End
      Begin VB.TextBox txtdbo 
         Height          =   315
         Left            =   4800
         TabIndex        =   7
         Text            =   "dbo"
         Top             =   600
         Width           =   765
      End
      Begin VB.TextBox txtProject 
         Height          =   315
         Left            =   900
         TabIndex        =   3
         Top             =   240
         Width           =   2655
      End
      Begin VB.Label lblName 
         Caption         =   "&Name *"
         Height          =   255
         Left            =   3720
         TabIndex        =   35
         Top             =   300
         Width           =   615
      End
      Begin VB.Label lblSystem 
         Caption         =   "&Client:"
         Height          =   255
         Left            =   360
         TabIndex        =   12
         Top             =   660
         Width           =   675
      End
      Begin VB.Label lblPrefix 
         Caption         =   "&Project:"
         Height          =   255
         Left            =   2520
         TabIndex        =   13
         Top             =   660
         Width           =   675
      End
      Begin VB.Label lbldbo 
         Caption         =   "&Owner:"
         Height          =   255
         Left            =   4200
         TabIndex        =   14
         Top             =   660
         Width           =   735
      End
      Begin VB.Label lblProject 
         Caption         =   "&Entity:"
         Height          =   255
         Left            =   360
         TabIndex        =   11
         Top             =   300
         Width           =   555
      End
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "Open Application"
      Height          =   315
      Left            =   180
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
   Begin VB.CommandButton cmdGenerate 
      Caption         =   "&Generate [ctrl]"
      Default         =   -1  'True
      Height          =   375
      Left            =   120
      TabIndex        =   30
      Top             =   5338
      Width           =   1215
   End
   Begin VB.Frame fraUser 
      Caption         =   "User Services (...User)"
      ForeColor       =   &H00000000&
      Height          =   1575
      Left            =   3120
      TabIndex        =   23
      Top             =   3600
      Width           =   2715
      Begin VB.CheckBox chkUserBusn 
         Caption         =   "Integrate Business Services"
         Height          =   315
         Left            =   240
         TabIndex        =   37
         Top             =   1200
         Value           =   1  'Checked
         Width           =   2415
      End
      Begin VB.CheckBox chkUserProject 
         Caption         =   "VB Project"
         Height          =   315
         Left            =   240
         TabIndex        =   24
         Top             =   300
         Width           =   1155
      End
      Begin VB.CheckBox chkCollection 
         Caption         =   "VB Collection Class"
         Height          =   315
         Left            =   240
         TabIndex        =   26
         Top             =   900
         Value           =   1  'Checked
         Width           =   1815
      End
      Begin VB.CheckBox chkItem 
         Caption         =   "VB Item Class"
         Height          =   315
         Left            =   240
         TabIndex        =   25
         Top             =   600
         Value           =   1  'Checked
         Width           =   1395
      End
   End
   Begin VB.Frame fraBusn 
      Caption         =   "Business Services (...Busn)"
      ForeColor       =   &H00000000&
      Height          =   1335
      Left            =   120
      TabIndex        =   19
      Top             =   3840
      Visible         =   0   'False
      Width           =   2800
      Begin VB.CheckBox chkBusnMod 
         Caption         =   "VB Class Constants"
         Height          =   315
         Left            =   300
         TabIndex        =   22
         Top             =   900
         Value           =   1  'Checked
         Width           =   1815
      End
      Begin VB.CheckBox chkBusnProject 
         Caption         =   "VB Project"
         Height          =   315
         Left            =   300
         TabIndex        =   20
         Top             =   300
         Width           =   1215
      End
      Begin VB.CheckBox chkClass 
         Caption         =   "VB Class "
         Height          =   315
         Left            =   300
         TabIndex        =   21
         Top             =   600
         Value           =   1  'Checked
         Width           =   1335
      End
   End
   Begin VB.Frame fraData 
      Caption         =   "Data Services (...Data)"
      ForeColor       =   &H00000000&
      Height          =   1575
      Left            =   120
      TabIndex        =   15
      Top             =   2160
      Width           =   2800
      Begin VB.CheckBox chkTableRebuild 
         Caption         =   "Table Rebuild"
         Height          =   315
         Left            =   240
         TabIndex        =   38
         Top             =   600
         Value           =   1  'Checked
         Width           =   1335
      End
      Begin VB.CheckBox chkProcs 
         Caption         =   "Stored Procedures *"
         Height          =   315
         Left            =   240
         TabIndex        =   18
         Top             =   1200
         Value           =   1  'Checked
         Width           =   2055
      End
      Begin VB.CheckBox chkKeys 
         Caption         =   "Foreign Keys"
         Height          =   315
         Left            =   240
         TabIndex        =   17
         Top             =   900
         Value           =   1  'Checked
         Width           =   1815
      End
      Begin VB.CheckBox chkTable 
         Caption         =   "Table Script"
         Height          =   315
         Left            =   240
         TabIndex        =   16
         Top             =   300
         Value           =   1  'Checked
         Width           =   1335
      End
   End
   Begin MSComDlg.CommonDialog dlgOpen 
      Left            =   3000
      Top             =   4680
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin VB.Label lblApp 
      Caption         =   "&Entity:"
      Height          =   255
      Left            =   180
      TabIndex        =   8
      Top             =   600
      Width           =   855
   End
   Begin VB.Label Label4 
      Caption         =   "&Root"
      Height          =   255
      Left            =   2100
      TabIndex        =   9
      Top             =   180
      Width           =   375
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const cModName As String = "frmMain"
Public mApplication As String
Public mEntity As String
Public mCtrlKey As Boolean
Public mShiftKey As Boolean
Public mCancel As Boolean

Public mTotalFiles As Long
Public mTotalErrors As Long
Public mTotalWebFiles As Long
Public mTotalLangFiles As Long
Public mTotalVBFiles As Long
Public mTotalSQLFiles As Long
Public mStartTime As Date

Private Sub chkUserBusn_Click()
   If chkUserBusn Then fraBusn.Visible = False Else fraBusn.Visible = True
End Sub

Private Sub cmbApp_Click()
   Dim sFile As String
   Dim sPath As String
   Dim sRoot As String
   Dim sProject As String
   Dim x As Integer

   If cmbApp.ListIndex >= 0 Then
   
      txtName.Text = ""
      sFile = cmbApp.Text
      mEntity = sFile
      
      '-----split file name and path out
      m_SplitFilePath sFile, sFile, sPath
      If Right$(sPath, 1) <> "\" Then sPath = sPath + "\"
      
      sRoot = sPath
      If Right$(sRoot, 1) = "\" Then sRoot = Left$(sRoot, Len(sRoot) - 1)
      
      m_SplitFilePath sRoot, sProject, sRoot
      x = InStr(UCase(sRoot), UCase(txtSystem.Text))
      txtRootPath.Text = Left(sRoot, x - 1)
      
      If Left(sFile, 1) = "_" Then sFile = Mid(sFile, 2)
      txtProject.Text = Left(sFile, Len(sFile) - 4)
   End If
   
End Sub

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
      .DefaultExt = "@Application.xml"
      .DialogTitle = "Open Application"
      .Filter = "Application XML Files|@Application.xml"
      .ShowOpen
      sFile = .FileName
   End With
   
   LoadAppFile sFile

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

Private Sub LoadAppFile( _
   ByVal bvFileName As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the common project values from the XML
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadAppFile"
   '---------------------------------------------------------------------------------------------------------------------------------
   
   On Error GoTo ErrorHandler
   
   If Right(UCase(bvFileName), 16) = "@APPLICATION.XML" Then
      mApplication = bvFileName
      Me.Caption = "Generate " + bvFileName
      LoadProjectInfo bvFileName
      LoadApplication
   End If
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then
      Resume Next
   Else
      ShowError Err.Number, Err.Source, Err.Description
   End If
End Sub

Private Sub LoadProjectInfo( _
   ByVal bvFileName As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Set the common project values from the XML
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadApplication"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XML As New MSXML2.DOMDocument
   Dim oList As MSXML2.IXMLDOMNodeList
   Dim oListItem As MSXML2.IXMLDOMElement
   
   On Error GoTo ErrorHandler
   
   XML.Load bvFileName
   
   If Len(XML.XML) = 0 Then
      Beep
      MsgBox "Invalid XML File." + vbCr + vbCr + mApplication, vbCritical, "Error"
   Else
      Set oList = XML.selectNodes("/WTROOT")
      Set oListItem = oList.Item(0)
      With oListItem
         If Not IsNull(.getAttribute("system")) Then
            txtSystem.Text = .getAttribute("system")
         End If
         If Not IsNull(.getAttribute("prefix")) Then
            txtPrefix.Text = .getAttribute("prefix")
         End If
         If Not IsNull(.getAttribute("dbo")) Then
            txtdbo.Text = .getAttribute("dbo")
         End If
      End With
      Set oListItem = Nothing
      Set oList = Nothing
   End If
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then
      Resume Next
   Else
      ShowError Err.Number, Err.Source, Err.Description
   End If
End Sub

Private Sub LoadApplication()
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Open Application XML File
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadApplication"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XML As New MSXML2.DOMDocument
   Dim oList As MSXML2.IXMLDOMNodeList
   Dim oListItem As MSXML2.IXMLDOMElement
   Dim idxList As Integer
   Dim sPath As String
   Dim sValidate As String
   
   On Error GoTo ErrorHandler
   
   cmbApp.Clear
   
   XML.Load mApplication
   If Len(XML.XML) > 0 Then
      sValidate = ValidateApp(XML)
   End If
   
   If Len(XML.XML) = 0 Then
      Beep
      MsgBox "Invalid XML File." + vbCr + vbCr + mApplication, vbCritical, "Error"
   ElseIf Len(sValidate) > 0 Then
      Beep
      MsgBox "Invalid Application Definition" + vbCrLf + vbCrLf + mApplication + vbCrLf + vbCrLf + sValidate, vbCritical, "Error"
   Else
   
      sPath = Replace(mApplication, "@Application.xml", "")
   
      '-----get entity files
      Set oList = XML.selectNodes("/WTROOT/WTENTITIES/WTENTITY[@file]")
      For idxList = 0 To oList.length - 1
         Set oListItem = oList.Item(idxList)
         cmbApp.AddItem sPath + oListItem.getAttribute("file")
         Set oListItem = Nothing
      Next idxList
      cmbApp.ListIndex = 0
      Set oList = Nothing
      
   End If
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then
      Resume Next
   Else
      ShowError Err.Number, Err.Source, Err.Description
   End If
End Sub

Private Sub cmdCheck_Click()
   Dim chk As Integer
   
   txtName.Text = ""
   If cmdCheck.Caption = "Check All" Then
      chk = 1
      cmdCheck.Caption = "Uncheck All"
   Else
      chk = 0
      cmdCheck.Caption = "Check All"
   End If
   
   chkTable.Value = chk
   chkTableRebuild.Value = chk
   chkKeys.Value = chk
   chkProcs.Value = chk
   chkClass.Value = chk
'   chkBusnProject.Value = chk
   chkBusnMod.Value = chk
   chkItem.Value = chk
   chkCollection.Value = chk
   chkUserBusn.Value = chk
'   chkUserProject.Value = chk
   chkWebPages.Value = chk
   chkLanguage.Value = chk
'   chkTemplate.Value = chk

   If chkUserBusn Then fraBusn.Visible = False Else fraBusn.Visible = True

End Sub

Private Sub cmdClose_Click()
   If cmdClose.Caption = "Cancel" Then
      cmdClose.Caption = "Close"
      DoEvents
   Else
      SetRegistryValue cRegKey, cRegApp, cRegSz, mApplication
      SetRegistryValue cRegKey, cRegEntity, cRegSz, cmbApp.ListIndex
      End
   End If
End Sub

Private Function GenerateRelationshipXML(ByVal bvEntity As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate Relationship info for entity
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GenerateRelationshipXML"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XML As New MSXML2.DOMDocument
   Dim DAT As New MSXML2.DOMDocument
   Dim XSL As New MSXML2.DOMDocument
   Dim OUT As New MSXML2.DOMDocument
   Dim REL As New MSXML2.DOMDocument
   Dim oNode As MSXML2.IXMLDOMElement
   Dim outFile As String
   Dim str As String
   Dim bError As Boolean
   
   On Error GoTo ErrorHandler
   
   XML.Load bvEntity
   If Len(XML.XML) = 0 Then
      Beep
      MsgBox "Invalid XML File." + vbCr + vbCr + bvEntity, vbCritical, "Error"
      bError = True
   End If
   REL.Load mApplication
   If Len(REL.XML) = 0 Then
      Beep
      MsgBox "Invalid Relationship XML File." + vbCr + vbCr + mApplication, vbCritical, "Error"
      bError = True
   End If
   
   If Not bError Then
      Set oNode = DAT.createElement("Data")
      DAT.appendChild oNode
      With oNode
         .appendChild XML.selectSingleNode("/WTROOT/WTENTITY").cloneNode(True)
         .appendChild REL.selectSingleNode("/WTROOT/WTENTITIES").cloneNode(True)
         .appendChild REL.selectSingleNode("/WTROOT/WTRELATIONSHIPS").cloneNode(True)
      End With
      Set oNode = Nothing
   
      '--------------------------------------------------
      ' GENERATE RELATIONSHIPS
      '--------------------------------------------------
      '-----generate file with specified stylesheet
      XSL.Load App.Path + "\Stylesheet\GenerateRelationships.xsl"
      DAT.transformNodeToObject XSL, OUT
      '-----replace the line feeds with carriage return/line feed
      str = Replace(OUT.Text, Chr(10), vbCrLf)
      '-----update response and save file
      outFile = App.Path + "\Relationships.tmp"
      SaveFile outFile, str
   
      GenerateRelationshipXML = outFile
   Else
      GenerateRelationshipXML = ""
   End If
   
   Set XML = Nothing
   Set DAT = Nothing
   Set XSL = Nothing
   Set OUT = Nothing
   Set REL = Nothing
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set XML = Nothing
   Set DAT = Nothing
   Set XSL = Nothing
   Set OUT = Nothing
   Set REL = Nothing
   Set oNode = Nothing
   ShowError Err.Number, Err.Source, Err.Description
   Exit Function
End Function

Private Sub LoadRelationships(ByRef DAT As MSXML2.DOMDocument)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Load Relationship info into DAT Document
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "LoadRelationships"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim REL As New MSXML2.DOMDocument
   Dim oNode As MSXML2.IXMLDOMElement
   Dim oNode2 As MSXML2.IXMLDOMElement
   Dim oList As MSXML2.IXMLDOMNodeList
   Dim oList2 As MSXML2.IXMLDOMNodeList
   Dim oParentNode As MSXML2.IXMLDOMElement
   Dim sName As String
   Dim bFound As Boolean
   Dim iPos As Integer
   Dim iPos2 As Integer
   Dim sRelFile As String
   
   On Error GoTo ErrorHandler
      
   If Len(mApplication) > 0 Then
      sRelFile = GenerateRelationshipXML(mEntity)
      If Len(sRelFile) > 0 Then
         REL.Load sRelFile
         If Len(REL.XML) = 0 Then
            Beep
            MsgBox "Invalid Relationship File." + vbCr + vbCr + sRelFile, vbCritical, "Error"
            sRelFile = ""
         End If
      End If
   End If
   
   If Len(sRelFile) > 0 Then
      'if WTRELATIONSHIPS doesn't exist, create it
      If DAT.selectNodes("/Data/WTENTITY/WTRELATIONSHIPS").length = 0 Then
         DAT.createElement ("/Data/WTENTITY/WTRELATIONSHIPS")
      End If
      '-----append each generated WTRELATIONSHIP if it doesn't already exist
      Set oList = REL.selectNodes("/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP")
      Set oList2 = DAT.selectNodes("/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP")
      Set oParentNode = DAT.selectSingleNode("/Data/WTENTITY/WTRELATIONSHIPS")
      For iPos = 0 To oList.length - 1
         Set oNode = oList.Item(iPos)
         sName = oNode.getAttribute("entity")
         'check if this node already exists
         bFound = False
         For iPos2 = 0 To oList2.length - 1
            Set oNode2 = oList2.Item(iPos2)
            If sName = oNode2.getAttribute("entity") Then
               bFound = True
               Set oNode2 = Nothing
               Exit For
            End If
            Set oNode2 = Nothing
         Next
         Set oNode = Nothing
         If Not bFound Then
            oParentNode.appendChild oList.Item(iPos).cloneNode(True)
         End If
      Next
      Set oList2 = Nothing
      Set oParentNode = Nothing
      
      ' append the WTPARENTS
      Set oParentNode = DAT.selectSingleNode("/Data/WTENTITY")
      If DAT.selectNodes("/Data/WTENTITY/WTPARENTS").length = 0 Then
         If REL.selectNodes("/WTROOT/WTPARENTS").length > 0 Then
            oParentNode.appendChild REL.selectSingleNode("/WTROOT/WTPARENTS").cloneNode(True)
         End If
      End If
      Set oParentNode = Nothing
   End If
   
   Set REL = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set REL = Nothing
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Private Function SaveSource( _
   ByRef brGenInfo As tGenerateInfoRec, _
   ByVal bvSource As String, _
   ByVal bvFileName As String, _
   Optional ByVal bvReplace As Boolean = True) As Boolean
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Common save code routine.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SaveSource"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim sSource As String
   Dim sError As String
   Dim lError As Long
   
   On Error GoTo ErrorHandler
      
   '-----replace tabs and carriage returns
   If bvReplace Then
      sSource = Replace(bvSource, Chr(10), vbCrLf)
      sSource = Replace(sSource, Chr(9), Space(3))
   Else
      sSource = bvSource
   End If
   
   lError = CheckError(sSource, sError)
   
   '-----update file generation statistics
   With brGenInfo
      .FileCnt = .FileCnt + 1
      .FileText = .FileText + bvFileName + vbCrLf
      If lError > 0 Then
         .ErrorCnt = .ErrorCnt + lError
         .FileText = .FileText + sError + vbCrLf
      End If
   End With

   '-----save the file
   SaveSource = SaveFile(bvFileName, sSource)
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function CheckError( _
   ByVal bvSource As String, _
   ByRef brError As String) As Long
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Common save code routine.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "CheckError"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrorCnt As Long
   Dim sError As String
   Dim pos As Long
   Dim pos1 As Long
   
   On Error GoTo ErrorHandler
      
   ErrorCnt = 0
   pos = InStr(bvSource, "***ERROR")
   While pos > 0
      pos1 = InStr(pos + 1, bvSource, "***")
      If pos1 > 0 Then
         sError = sError + Mid(bvSource, pos, pos1 - pos) + vbCrLf
         ErrorCnt = ErrorCnt + 1
      End If
      pos = InStr(pos1, bvSource, "***ERROR")
   Wend
   
   brError = sError
   CheckError = ErrorCnt
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Function Generate() As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate Source Code for selected items
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "Generate"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XML As New MSXML2.DOMDocument
   Dim DAT As New MSXML2.DOMDocument
   Dim XSL As New MSXML2.DOMDocument
   Dim OUT As New MSXML2.DOMDocument
   Dim xmlApplication As MSXML2.DOMDocument
   
   Dim bGenerateVB As Boolean
   Dim bGenerateName As Boolean
   Dim iPos As Integer
   Dim iEnum As Integer
   Dim sEntity As String
   Dim sPath As String
   Dim sProcName As String
   Dim tGenInfo As tGenerateInfoRec
   Dim sLanguage As String
   Dim sValidate As String
   
   '-----variables for processing node lists
   Dim oNodeItem As MSXML2.IXMLDOMNode
   Dim oNode As MSXML2.IXMLDOMElement
   Dim oListItem As MSXML2.IXMLDOMElement
   Dim oEnumItem As MSXML2.IXMLDOMElement
   Dim oChildItem As MSXML2.IXMLDOMElement
   Dim oProcItem As MSXML2.IXMLDOMElement
   Dim oItem As MSXML2.IXMLDOMElement
   Dim oEntity As MSXML2.IXMLDOMElement
   Dim oEntityList As MSXML2.IXMLDOMElement
   
   On Error GoTo ErrorHandler
      
   '-----get entity name----------
   sEntity = mEntity
   m_SplitFilePath sEntity, sEntity, sPath
   If Right$(sPath, 1) <> "\" Then sPath = sPath + "\"
   iPos = InStr(1, sEntity, ".")
   If iPos > 0 Then sEntity = Left(sEntity, iPos - 1)
   If Left(sEntity, 1) = "_" Then sEntity = Mid(sEntity, 2)
      
   XML.Load mEntity
   If Len(XML.XML) > 0 Then
      sValidate = ValidateEntity(XML)
   End If
   
   If Len(XML.XML) = 0 Then
      Beep
      MsgBox "Invalid XML File." + vbCrLf + vbCrLf + mEntity, vbCritical, "Error"
   ElseIf Len(sValidate) > 0 Then
      sValidate = Replace(sValidate, Chr(10), vbCrLf) + vbCrLf
      tGenInfo.ErrorCnt = 1
      tGenInfo.FileText = "***INVALID ENTITY DEFINITION --- " + mEntity + vbCrLf + sValidate
   Else
      '-----load Application XML
      Set xmlApplication = New MSXML2.DOMDocument
'      xmlApplication.Load tGenInfo.FolderApp + "@Application.xml"
      xmlApplication.Load mApplication
      
      Set oListItem = XML.selectSingleNode("/WTROOT")
      Set oNode = DAT.createElement("Data")
      DAT.appendChild oNode
      With oNode
         .setAttribute "project", txtProject.Text
         .setAttribute "system", txtSystem.Text
         .setAttribute "prefix", txtPrefix.Text
         .setAttribute "dbo", txtdbo.Text
         
         '*** Get the List of Entity Numbers ***************************************
         .appendChild DAT.createElement("ENTITIES")
         Set oEntityList = oNode.selectSingleNode("/Data/ENTITIES")
         For Each oItem In xmlApplication.selectNodes("/WTROOT/WTENTITIES/WTENTITY")
            Set oEntity = oEntityList.appendChild(DAT.createElement("ENTITY"))
            oEntity.setAttribute "number", oItem.getAttribute("number")
            oEntity.setAttribute "name", oItem.getAttribute("name")
            Set oEntity = Nothing
         Next oItem
         Set oEntityList = Nothing
         
         If chkUserBusn.Value Then .setAttribute "userbusn", "1"
         .appendChild XML.selectSingleNode("/WTROOT/WTENTITY").cloneNode(True)
         If Not (xmlApplication.selectSingleNode("/WTROOT/WTPAGE") Is Nothing) Then
            .appendChild xmlApplication.selectSingleNode("/WTROOT/WTPAGE").cloneNode(True)
         End If
         If Not (xmlApplication.selectSingleNode("/WTROOT/WTSYSCONS") Is Nothing) Then
            .appendChild xmlApplication.selectSingleNode("/WTROOT/WTSYSCONS").cloneNode(True)
         End If
         
         .appendChild xmlApplication.selectSingleNode("/WTROOT/WTCOLORS").cloneNode(True)
         .appendChild xmlApplication.selectSingleNode("/WTROOT/WTCONDITIONS").cloneNode(True)
         .appendChild xmlApplication.selectSingleNode("/WTROOT/WTLANGUAGES/WTLABELS").cloneNode(True)
         
         If Not IsNull(oListItem.getAttribute("language")) Then
            sLanguage = oListItem.getAttribute("language")
         Else
            sLanguage = "true"
         End If
         .setAttribute "language", sLanguage
         
         Set oItem = xmlApplication.selectSingleNode("/WTROOT/WTLANGUAGES/WTLANGUAGE[@default]")
         If Not (oItem Is Nothing) Then
            .setAttribute "defaultlanguage", oItem.getAttribute("code")
         End If
         Set oItem = Nothing
         
      End With
      Set oNode = Nothing
      Set oListItem = Nothing
         
      '-----set flag to stop VB code generation
      bGenerateVB = True
      For Each oNodeItem In XML.selectSingleNode("/WTROOT/WTENTITY").Attributes
         If oNodeItem.nodeName = "VB" Then
            bGenerateVB = (oNodeItem.nodeValue <> "false")
            Exit For
         End If
      Next oNodeItem
      
      '-----set common generate variables
      With tGenInfo
         .EntityName = sEntity
         .ProjectSystem = txtSystem.Text
         .ProjectPrefix = txtPrefix.Text
         .ProjectName = txtProject.Text
         .Language = sLanguage
         
         .FolderRoot = txtRootPath.Text
         If Len(.FolderRoot) = 0 Then .FolderRoot = sPath
         If Right$(.FolderRoot, 1) <> "\" Then .FolderRoot = .FolderRoot + "\"
      
         .FolderSystem = .FolderRoot + .ProjectSystem + "\"
         .FolderApp = .FolderSystem + .ProjectPrefix + "\"
'         .FolderProject = .FolderApp + .ProjectPrefix + .ProjectName + "\"
         .FolderProject = .FolderApp + "GEN\" + .ProjectPrefix + .ProjectName + "\"

'         .FolderBusn = .FolderProject + .ProjectPrefix + .ProjectName + "Busn\"
'         .FolderUser = .FolderProject + .ProjectPrefix + .ProjectName + "User\"

'         .FolderData = .FolderApp + "@SQL\"
         .FolderData = .FolderApp + "SQL\"
         .FolderDataTables = .FolderData + "Foreign Keys\"
         .FolderDataKeys = .FolderData + "Functions\"
         .FolderDataProcs = .FolderData + "Procedures\"
         .FolderDataScripts = .FolderData + "Scripts\"
         .FolderDataTables = .FolderData + "Tables\"
         
'         .FolderWeb = .FolderApp + "@Web\"
         .FolderWeb = .FolderApp + "Web\"
         
         .FolderStylesheet = App.Path + "\Stylesheet\"
      End With
         
      With tGenInfo
         FolderCreate .FolderData
'         If bGenerateVB Then
'            If chkUserBusn.Value = 0 Then FolderCreate .FolderBusn
'            FolderCreate .FolderUser
'         End If
         FolderCreate .FolderWeb
         FolderCreate .FolderProject
      End With
      
      '--------------------------------------------------
      ' GENERATE TABLE
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If chkTable.Value Then
         '-----load the stylesheet
         XSL.Load tGenInfo.FolderStylesheet + "GenerateDataTable.xsl"
         '-----transform
         DAT.transformNodeToObject XSL, OUT
         '-----save the XML
         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataTables + sEntity + ".sql") Then GoTo AbortError
         mTotalSQLFiles = mTotalSQLFiles + 1
      End If
      
      '--------------------------------------------------
      ' GENERATE TABLE REBUILD
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If chkTableRebuild.Value Then
         '-----load the stylesheet
         XSL.Load tGenInfo.FolderStylesheet + "GenerateDataTableRebuild.xsl"
         '-----transform
         DAT.transformNodeToObject XSL, OUT
         '-----save the XML
         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataTables + sEntity + "Rebuild.sql") Then GoTo AbortError
         mTotalSQLFiles = mTotalSQLFiles + 1
      End If
      
      '--------------------------------------------------
      ' GENERATE FOREIGN KEYS
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If chkKeys.Value Then
         '-----generate one file for each relationship
         For Each oListItem In XML.selectNodes("/WTROOT/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@type != 'child']")
            DoEvents
            If cmdClose.Caption = "Close" Then GoTo AbortError
            With oListItem
               '-----load the style sheet
               XSL.Load tGenInfo.FolderStylesheet + "GenerateDataForeignKey.xsl"
               '-----append additional XML
               DAT.selectSingleNode("/Data/WTENTITY").appendChild oListItem.cloneNode(True)
               '-----transform
               DAT.transformNodeToObject XSL, OUT
               '-----remove appended XML
               DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTRELATIONSHIP")
               '-----save XML
               If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataKeys + "FK_" + sEntity + "_" + .getAttribute("name") + ".sql") Then GoTo AbortError
               mTotalSQLFiles = mTotalSQLFiles + 1
            End With
         Next oListItem
      End If
      
      '--------------------------------------------------
      ' GENERATE PROCEDURES
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If chkProcs.Value Then
         '-----generate one file for each relationship
         For Each oListItem In XML.selectNodes("/WTROOT/WTPROCEDURES/WTPROCEDURE[@type != 'Custom' and not(@nodata)]")
            DoEvents
            If cmdClose.Caption = "Close" Then GoTo AbortError
            With oListItem
               
               If Len(txtName.Text) = 0 Then
                  bGenerateName = True
               Else
                  bGenerateName = (txtName.Text = .getAttribute("name"))
               End If

               If bGenerateName Then
               
                  '-----load the style sheet
                  XSL.Load tGenInfo.FolderStylesheet + .getAttribute("style")
                  
                  Select Case .getAttribute("type")
                     Case "Find"
                        Dim sTmp As String
                        '-----save the original proc name
                        sProcName = .getAttribute("name")
                        If IsNull(.getAttribute("enum")) Then
                            iEnum = 1
                        Else
                            iEnum = .getAttribute("enum")
                        End If
                        '-----create a find procedure for each find type enum
                        For Each oEnumItem In XML.selectNodes("/WTROOT/WTENTITY/WTENUM[@type='find' and @id=" & iEnum & "]/WTATTRIBUTE")
                           
                           '-----modify the proc's name
                           oListItem.setAttribute "name", sProcName + oEnumItem.getAttribute("name")
                           
                           '-----modify the child bookmark element's name
                           For Each oChildItem In oListItem.selectNodes("WTBOOKMARK")
                              oChildItem.setAttribute "name", oEnumItem.getAttribute("name")
                              If Not IsNull(oChildItem.getAttribute("order")) Then oChildItem.setAttribute "order", ""
                              If Not IsNull(oChildItem.getAttribute("length")) Then oChildItem.setAttribute "length", ""
                              If Not IsNull(oEnumItem.getAttribute("order")) Then
                                 sTmp = oEnumItem.getAttribute("order")
                                 If Not IsNull(oChildItem.getAttribute("order")) Then
                                    oChildItem.setAttribute "order", sTmp
                                 End If
                              End If
                              If Not IsNull(oEnumItem.getAttribute("length")) Then
                                 sTmp = oEnumItem.getAttribute("length")
                                 If Not IsNull(oChildItem.getAttribute("length")) Then
                                    oChildItem.setAttribute "length", sTmp
                                 End If
                              End If
                           Next oChildItem
                           
                           '-----modify the child search element's name
                           For Each oChildItem In oListItem.selectNodes("WTSEARCH")
                              oChildItem.setAttribute "name", oEnumItem.getAttribute("name")
                              If Not IsNull(oChildItem.getAttribute("order")) Then oChildItem.setAttribute "order", ""
                              If Not IsNull(oChildItem.getAttribute("length")) Then oChildItem.setAttribute "length", ""
                              If Not IsNull(oEnumItem.getAttribute("order")) Then
                                 sTmp = oEnumItem.getAttribute("order")
                                 If Not IsNull(oChildItem.getAttribute("order")) Then
                                    oChildItem.setAttribute "order", sTmp
                                 End If
                              End If
                              If Not IsNull(oEnumItem.getAttribute("length")) Then
                                 sTmp = oEnumItem.getAttribute("length")
                                 If Not IsNull(oChildItem.getAttribute("length")) Then
                                    oChildItem.setAttribute "length", sTmp
                                 End If
                              End If
                           Next oChildItem
                           
                           '-----append additional XML
                           DAT.selectSingleNode("/Data/WTENTITY").appendChild oListItem.cloneNode(True)
                           DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
                           '-----transform
                           DAT.transformNodeToObject XSL, OUT
                           '-----remove appended XML
                           DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURE")
                           DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
                           '-----save the XML
                           If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataProcs + tGenInfo.ProjectPrefix + "_" + sEntity + "_" + .getAttribute("name") + ".sql") Then GoTo AbortError
                           mTotalSQLFiles = mTotalSQLFiles + 1
                           '-----modify the proc's name back
                           oListItem.setAttribute "name", sProcName
                        Next oEnumItem
                     
                     Case "List"
                        '-----create a find procedure for each list type enum
                        If (XML.selectNodes("/WTROOT/WTENTITY/WTENUM[@type = 'list']/WTATTRIBUTE").length > 0) And InStr(.getAttribute("name"), "#") > 0 Then
                           '-----generate one proc for each list attribute
                           For Each oEnumItem In XML.selectNodes("/WTROOT/WTENTITY/WTENUM[@type = 'list']/WTATTRIBUTE")
                              Set oProcItem = ReplaceProcXML(oListItem, oEnumItem.getAttribute("name"))
                              '-----append additional XML
                              DAT.selectSingleNode("/Data/WTENTITY").appendChild oProcItem.cloneNode(True)
                              DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
                              '-----transform
                              DAT.transformNodeToObject XSL, OUT
                              '-----remove appended XML
                              DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURE")
                              DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
                              '-----save the XML
                              If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataProcs + tGenInfo.ProjectPrefix + "_" + sEntity + "_" + oProcItem.getAttribute("name") + ".sql") Then GoTo AbortError
                              mTotalSQLFiles = mTotalSQLFiles + 1
                           Next oEnumItem
                        Else
                           '-----append additional XML
                           DAT.selectSingleNode("/Data/WTENTITY").appendChild oListItem.cloneNode(True)
                           DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
                           '-----transform
                           DAT.transformNodeToObject XSL, OUT
                           '-----remove appended XML
                           DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURE")
                           DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
                           '-----save the XML
                           If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataProcs + tGenInfo.ProjectPrefix + "_" + sEntity + "_" + oListItem.getAttribute("name") + ".sql") Then GoTo AbortError
                           mTotalSQLFiles = mTotalSQLFiles + 1
                        End If
                     Case Else
                        '-----append additional XML
                        DAT.selectSingleNode("/Data/WTENTITY").appendChild oListItem.cloneNode(True)
                        DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
                        '-----transform
                        DAT.transformNodeToObject XSL, OUT
                        '-----remove appended XML
                        DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURE")
                        DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
                        '-----save the XML
                        If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderDataProcs + tGenInfo.ProjectPrefix + "_" + sEntity + "_" + .getAttribute("name") + ".sql") Then GoTo AbortError
                        mTotalSQLFiles = mTotalSQLFiles + 1
                  End Select
               End If
            End With
         Next oListItem
      End If
      
      '--------------------------------------------------
      ' GENERATE BUSINESS CLASS OBJECT
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If ((chkClass.Value Or chkUserBusn.Value) And bGenerateVB) Then
         If (XML.selectNodes("/WTROOT/WTCOMPONENTS/WTCOMPONENT").length > 0) Then
            With tGenInfo
               Set .oXML = XML
               Set .oDAT = DAT
               With .oDAT.selectSingleNode("/Data/WTENTITY")
                  .appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
               End With
            End With
            GenerateVBClass tGenInfo
            With tGenInfo
               Set .oDAT = Nothing
               Set .oXML = Nothing
            End With
         Else
            '-----load the style sheet
            XSL.Load tGenInfo.FolderStylesheet + "GenerateBusnClass.xsl"
            '-----append additional XML
            DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
            '-----transform
            DAT.transformNodeToObject XSL, OUT
            '-----remove appended XML
            DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
            '-----save source
 '           If chkUserBusn.Value Then
'               If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderUser + "C" + sEntity + "B.cls") Then GoTo AbortError
               If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderProject + "C" + sEntity + "B.cls") Then GoTo AbortError
'            Else
'               If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderBusn + "C" + sEntity + ".cls") Then GoTo AbortError
'            End If
            mTotalVBFiles = mTotalVBFiles + 1
         End If
      End If

      '--------------------------------------------------
      ' GENERATE CLASS CONSTANTS MODULE
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If ((chkBusnMod.Value Or chkUserBusn.Value) And bGenerateVB) Then
         '-----load the style sheet
         XSL.Load tGenInfo.FolderStylesheet + "GenerateBusnClassMod.xsl"
         '-----append additional XML
         DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
         '-----transform
         DAT.transformNodeToObject XSL, OUT
         '-----remove appended XML
         DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
         '-----save the XML
'         If chkUserBusn.Value = 0 Then
'            If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderBusn + "C" + sEntity + "Mod.bas") Then GoTo AbortError
'            mTotalVBFiles = mTotalVBFiles + 1
'         End If
         '-----save a copy to the user project as well
'         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderUser + "C" + sEntity + "Mod.bas") Then GoTo AbortError
         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderProject + "C" + sEntity + "Mod.bas") Then GoTo AbortError
         mTotalVBFiles = mTotalVBFiles + 1
      End If
      
      '--------------------------------------------------
      ' GENERATE BUSINESS PROJECT
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If (chkBusnProject.Value And chkUserBusn.Value = 0 And bGenerateVB) Then
         If (XML.selectNodes("/WTROOT/WTCOMPONENTS/WTCOMPONENT").length > 0) Then
            With tGenInfo
               Set .oXML = XML
               Set .oDAT = DAT
               With .oDAT.selectSingleNode("/Data/WTENTITY")
                  .appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
               End With
            End With
            GenerateVBProject tGenInfo
            With tGenInfo
               Set .oDAT = Nothing
               Set .oXML = Nothing
            End With
         Else
            '-----load the style sheet
            XSL.Load tGenInfo.FolderStylesheet + "GenerateBusnProject.xsl"
            '-----transform
            DAT.transformNodeToObject XSL, OUT
            '-----save the source
'            If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderBusn + tGenInfo.ProjectPrefix + tGenInfo.ProjectName + "Busn.vbp") Then GoTo AbortError
            If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderProject + tGenInfo.ProjectPrefix + tGenInfo.ProjectName + "Busn.vbp") Then GoTo AbortError
            mTotalVBFiles = mTotalVBFiles + 1
         End If
      End If
      
      '--------------------------------------------------
      ' GENERATE USER ITEM CLASS OBJECT
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If (chkItem.Value And bGenerateVB) Then
         '-----load the style sheet
         XSL.Load tGenInfo.FolderStylesheet + "GenerateUserItem.xsl"
         '-----append additional XML
         DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
         '-----transform
         DAT.transformNodeToObject XSL, OUT
         '-----remove appended XML
         DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
         '-----save the source
'         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderUser + "C" + sEntity + ".cls") Then GoTo AbortError
         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderProject + "C" + sEntity + ".cls") Then GoTo AbortError
         mTotalVBFiles = mTotalVBFiles + 1
      End If
      
      '--------------------------------------------------
      ' GENERATE USER COLLECTION CLASS OBJECT
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If (chkCollection.Value And bGenerateVB) Then
         '-----load the style sheet
         XSL.Load tGenInfo.FolderStylesheet + "GenerateUserCollection.xsl"
         '-----append additional XML
         DAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
         '-----transform
         DAT.transformNodeToObject XSL, OUT
         '-----remove appended XML
         DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTPROCEDURES")
         '-----save the source file
'         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderUser + "C" + sEntity + "s.cls") Then GoTo AbortError
         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderProject + "C" + sEntity + "s.cls") Then GoTo AbortError
         mTotalVBFiles = mTotalVBFiles + 1
      End If
      
      '--------------------------------------------------
      ' GENERATE USER PROJECT
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If (chkUserProject.Value And bGenerateVB) Then
         '-----load the style sheet
         XSL.Load tGenInfo.FolderStylesheet + "GenerateUserProject.xsl"
         '-----transform
         DAT.transformNodeToObject XSL, OUT
         '-----save the XML
'         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderUser + tGenInfo.ProjectPrefix + tGenInfo.ProjectName + "User.vbp") Then GoTo AbortError
         If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderProject + tGenInfo.ProjectPrefix + tGenInfo.ProjectName + "User.vbp") Then GoTo AbortError
         mTotalVBFiles = mTotalVBFiles + 1
      End If
      
      '--------------------------------------------------
      ' GENERATE WEB PAGES
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If chkWebPages.Value Then
         For Each oListItem In XML.selectNodes("/WTROOT/WTWEBPAGES/WTWEBPAGE")
            DoEvents
            If cmdClose.Caption = "Close" Then GoTo AbortError
            With oListItem
            
               If Len(txtName.Text) = 0 Then
                  bGenerateName = True
               Else
                  bGenerateName = (txtName.Text = .getAttribute("name"))
               End If

               If bGenerateName Then
            
                  '--------------------------------------------------
                  ' GENERATE ASP PAGES
                  '--------------------------------------------------
                  If (.getAttribute("aspstyle") <> "Null") Then
                     '-----load the style sheet
                     XSL.Load tGenInfo.FolderStylesheet + .getAttribute("aspstyle")
                     '-----append additional XML
                     DAT.selectSingleNode("/Data/WTENTITY").appendChild oListItem.cloneNode(True)
                     DAT.selectSingleNode("/Data/WTENTITY").appendChild xmlApplication.selectSingleNode("/WTROOT/WTLANGUAGES").cloneNode(True)
                     '-----transform
                     DAT.transformNodeToObject XSL, OUT
                     '-----remove appended XML
                     DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTWEBPAGE")
                     DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTLANGUAGES")
                     '-----save the XML
                     If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderWeb + .getAttribute("name") + ".asp") Then GoTo AbortError
                     mTotalWebFiles = mTotalWebFiles + 1
                  End If
               
                  '--------------------------------------------------
                  ' GENERATE XSL PAGES
                  '--------------------------------------------------
                  If (.getAttribute("xslstyle") <> "Null") Then
                     '-----load the style sheet
                     XSL.Load tGenInfo.FolderStylesheet + .getAttribute("xslstyle")
                     '-----append additional XML
                     DAT.selectSingleNode("/Data/WTENTITY").appendChild oListItem.cloneNode(True)
                     '-----transform
                     DAT.transformNodeToObject XSL, OUT
                     '-----remove appended XML
                     DAT.selectSingleNode("/Data/WTENTITY").removeChild DAT.selectSingleNode("/Data/WTENTITY/WTWEBPAGE")
                     '-----save the XML
                     If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderWeb + .getAttribute("name") + ".xsl") Then GoTo AbortError
                     mTotalWebFiles = mTotalWebFiles + 1
                  End If
               End If
            End With
         Next oListItem
      End If
      
      '--------------------------------------------------
      ' GENERATE LANGUAGE FILES
      '--------------------------------------------------
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      If chkLanguage.Value Then
         '-----generate comon labels the first time
         If (mCommonLabels = True) Then
            With tGenInfo
               Set .oDAT = Nothing
            End With
            GenerateCommonLabels tGenInfo
            With tGenInfo
            End With
            mCommonLabels = False
         End If
         
         '-----generate entity labels
         With tGenInfo
            Set .oDAT = DAT
            Set .oXML = XML
            .oDAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTPROCEDURES").Item(0).cloneNode(True)
            .oDAT.selectSingleNode("/Data/WTENTITY").appendChild XML.selectNodes("/WTROOT/WTWEBPAGES").Item(0).cloneNode(True)
         End With
         GenerateLanguage tGenInfo
         GenerateLanguagePages tGenInfo
         With tGenInfo
            Set .oDAT = Nothing
            Set .oXML = Nothing
         End With
      End If
   End If
         
   '--------------------------------------------------
   ' GENERATE WEB TEMPLATES
   '--------------------------------------------------
   DoEvents
   If cmdClose.Caption = "Close" Then GoTo AbortError
   If chkTemplate.Value Then
      '-----load the application XML file
      XML.Load mApplication
      '-----generate one file for each template
      For Each oListItem In XML.selectNodes("WTROOT/WTTEMPLATE")
         DoEvents
         If cmdClose.Caption = "Close" Then GoTo AbortError
         Dim TemplateType As String
         With oListItem
            TemplateType = ""
            If Not IsNull(.getAttribute("type")) Then
               TemplateType = .getAttribute("type")
            End If
            '-----load the style sheet
            If TemplateType = "menu" Then
               XSL.Load tGenInfo.FolderStylesheet + "GenerateWebASPMenus.xsl"
            Else
               XSL.Load tGenInfo.FolderStylesheet + "GenerateWebXSLTemplate.xsl"
            End If
            Set DAT = Nothing
            Set DAT = New MSXML2.DOMDocument
            Set oNode = DAT.createElement("Data")
            DAT.appendChild oNode
            With oNode
               .setAttribute "project", txtProject.Text
               .setAttribute "system", txtSystem.Text
               .setAttribute "prefix", txtPrefix.Text
               .setAttribute "dbo", txtdbo.Text
               .appendChild DAT.createElement("WTENTITY")
               .appendChild xmlApplication.selectSingleNode("/WTROOT/WTCOLORS").cloneNode(True)
               .appendChild oListItem.cloneNode(True)
               If Not (xmlApplication.selectSingleNode("/WTROOT/WTPAGE") Is Nothing) Then
                  .appendChild xmlApplication.selectSingleNode("/WTROOT/WTPAGE").cloneNode(True)
               End If
               If Not (xmlApplication.selectSingleNode("/WTROOT/WTSYSCONS") Is Nothing) Then
                  .appendChild xmlApplication.selectSingleNode("/WTROOT/WTSYSCONS").cloneNode(True)
               End If
            End With
            Set oNode = Nothing
            DAT.selectSingleNode("/Data/WTENTITY").appendChild xmlApplication.selectSingleNode("/WTROOT/WTCONDITIONS").cloneNode(True)
            '-----transform
            DAT.transformNodeToObject XSL, OUT
            '-----save the XML
            If TemplateType = "menu" Then
               If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderWeb + .getAttribute("name") + ".asp") Then GoTo AbortError
            Else
               If Not SaveSource(tGenInfo, OUT.Text, tGenInfo.FolderWeb + .getAttribute("name") + ".xsl") Then GoTo AbortError
            End If
            mTotalWebFiles = mTotalWebFiles + 1
         End With
      Next oListItem
   End If
      
   Generate = tGenInfo.FileCnt & " File(s) Generated." + vbCrLf + tGenInfo.FileText
   mTotalFiles = mTotalFiles + tGenInfo.FileCnt
   mTotalErrors = mTotalErrors + tGenInfo.ErrorCnt
   
AbortError:
   
   Set XML = Nothing
   Set DAT = Nothing
   Set XSL = Nothing
   Set OUT = Nothing
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set XML = Nothing
   Set DAT = Nothing
   Set XSL = Nothing
   Set OUT = Nothing
   Set oNode = Nothing
   ShowError Err.Number, Err.Source, Err.Description
   Exit Function
End Function

Private Function ValidateApp( _
   ByRef XML As MSXML2.DOMDocument) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Validate Entity Definition
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ValidateEntity"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XSL As New MSXML2.DOMDocument
   Dim OUT As New MSXML2.DOMDocument
   
   On Error GoTo ErrorHandler
      
   XSL.Load App.Path + "\Stylesheet\GenerateValidateApp.xsl"
   '-----transform
   XML.transformNodeToObject XSL, OUT
   
   ValidateApp = OUT.Text
   
   Set OUT = Nothing
   Set XSL = Nothing
   
AbortError:
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Function
End Function

Private Function ValidateEntity( _
   ByRef XML As MSXML2.DOMDocument) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Validate Entity Definition
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ValidateEntity"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim XSL As New MSXML2.DOMDocument
   Dim OUT As New MSXML2.DOMDocument
   Dim DAT As New MSXML2.DOMDocument
   Dim XAP As New MSXML2.DOMDocument
   Dim oNode As MSXML2.IXMLDOMElement
   
   On Error GoTo ErrorHandler
      
   XSL.Load App.Path + "\Stylesheet\GenerateValidateEntity.xsl"
   XAP.Load mApplication
   
   Set oNode = DAT.createElement("Data")
   DAT.appendChild oNode
   With oNode
      .appendChild XML.selectSingleNode("/WTROOT/WTENTITY").cloneNode(True)
      .appendChild XAP.selectSingleNode("/WTROOT/WTENTITIES").cloneNode(True)
      .appendChild XAP.selectSingleNode("/WTROOT/WTLANGUAGES/WTLABELS").cloneNode(True)
   End With
   Set oNode = Nothing
   
   '-----transform
   DAT.transformNodeToObject XSL, OUT
   
   ValidateEntity = OUT.Text
   
   Set OUT = Nothing
   Set XSL = Nothing
   Set DAT = Nothing
   Set XAP = Nothing
   
AbortError:
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Function
End Function

Private Sub GenerateCommonLabels( _
   ByRef brGenInfo As tGenerateInfoRec)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate Common Language Files
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GenerateCommonLabels"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oXSL As New MSXML2.DOMDocument
   Dim oOUT As New MSXML2.DOMDocument
   Dim DAT As New MSXML2.DOMDocument
   Dim oNode As MSXML2.IXMLDOMElement
   '-----application definition file
   Dim xmlApplication As New MSXML2.DOMDocument
   
   '-----original common language file
   Dim oLanguages As MSXML2.IXMLDOMNodeList
   Dim oLanguage As MSXML2.IXMLDOMElement
   Dim oCommonLabels As MSXML2.IXMLDOMNodeList
   Dim oCommonLabel As MSXML2.IXMLDOMElement
   Dim xmlLangOld As New MSXML2.DOMDocument
   Dim oItemOld As MSXML2.IXMLDOMElement
   '-----new common language file
   Dim xmlLangNew As New MSXML2.DOMDocument
   Dim oLabelsNew As MSXML2.IXMLDOMNodeList
   Dim oLabelNew As MSXML2.IXMLDOMElement
   '-----miscellaneous
   Dim sLabelName As String
   Dim sTempXML As String
   Dim sOutputFile As String
   Dim sLanguageCode As String
   Dim sFileName As String
   
   On Error GoTo ErrorHandler
      
   xmlApplication.Load brGenInfo.FolderApp + "@Application.xml"
   '-----load the style sheet and transform the XML
   oXSL.Load brGenInfo.FolderStylesheet + "GenerateLanguage.xsl"
   
   Set oNode = DAT.createElement("WTROOT")
   DAT.appendChild oNode
   Set oNode = Nothing
   
   Set oLanguages = xmlApplication.selectNodes("WTROOT/WTLANGUAGES/WTLANGUAGE")
   Set oCommonLabels = xmlApplication.selectNodes("WTROOT/WTLANGUAGES/WTCOMMONLABELS")
   For Each oLanguage In oLanguages
      For Each oCommonLabel In oCommonLabels
         DoEvents
         If cmdClose.Caption = "Close" Then GoTo AbortError
      
         If Not IsNull(oCommonLabel.getAttribute("name")) Then
            sFileName = oCommonLabel.getAttribute("name")
         Else
            sFileName = "Common"
         End If
         
         sLanguageCode = oLanguage.Attributes.getNamedItem("code").Text
         
         xmlLangOld.Load brGenInfo.FolderWeb + "Language\" + sFileName + "[" + sLanguageCode + "].xml"
         
         DAT.selectSingleNode("/WTROOT").appendChild oCommonLabel.cloneNode(True)
         '-----transform
         DAT.transformNodeToObject oXSL, oOUT
         '-----remove appended XML
         DAT.selectSingleNode("/WTROOT").removeChild DAT.selectSingleNode("/WTROOT/WTCOMMONLABELS")
         
         '-----replace the line feeds with carriage return/line feed
         '-----replace tabs with 3 spaces
         sTempXML = Replace(oOUT.Text, Chr(10), vbCrLf)
         sTempXML = Replace(sTempXML, Chr(9), Space(3))
         
         '-----load the new (default) language file
         xmlLangNew.loadXML sTempXML
                  
         '-----loop through each label and set its value(s)
         Set oLabelsNew = xmlLangNew.selectNodes("LANGUAGE/LABEL")
         For Each oLabelNew In oLabelsNew
            With oLabelNew
               sLabelName = .getAttribute("name")
               Set oItemOld = xmlLangOld.selectSingleNode("LANGUAGE/LABEL[@name='" & sLabelName & "']")
               '-----if found, replace it
               If Not (oItemOld Is Nothing) Then
                  oLabelNew.Text = oItemOld.Text
               End If
               Set oItemOld = Nothing
            End With
         Next
         Set oLabelsNew = Nothing
               
         '-----save file and update the status
         sOutputFile = brGenInfo.FolderWeb + "Language\" + sFileName + "[" + sLanguageCode + "].xml"
         SaveSource brGenInfo, cEncodeXML + vbCrLf + xmlLangNew.XML, sOutputFile, False
         mTotalLangFiles = mTotalLangFiles + 1
   
         Set xmlLangOld = Nothing
         Set oOUT = Nothing
         Set xmlLangNew = Nothing
      Next
   Next
   
AbortError:
   
   Set oCommonLabels = Nothing
   Set oLanguages = Nothing
   Set xmlApplication = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Private Sub GenerateLanguage( _
   ByRef brGenInfo As tGenerateInfoRec)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate Language Files
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GenerateLanguage"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oXSL As New MSXML2.DOMDocument
   Dim oOUT As New MSXML2.DOMDocument
   '-----application definition file
   Dim xmlApplication As New MSXML2.DOMDocument
   '-----common language file
   Dim xmlCommon As New MSXML2.DOMDocument
   '-----original language file
   Dim oLanguages As MSXML2.IXMLDOMNodeList
   Dim oLanguage As MSXML2.IXMLDOMElement
   Dim xmlLangOld As New MSXML2.DOMDocument
   Dim oItemOld As MSXML2.IXMLDOMElement
   
   '-----new language file
   Dim xmlLangNew As New MSXML2.DOMDocument
   Dim oLabelsNew As MSXML2.IXMLDOMNodeList
   Dim oLabelNew As MSXML2.IXMLDOMElement
   Dim oLabelsOld As MSXML2.IXMLDOMNodeList
   Dim oLabelOld As MSXML2.IXMLDOMElement
   Dim oAttribute As MSXML2.IXMLDOMAttribute
   Dim oDupLabels As MSXML2.IXMLDOMNodeList
   
   Dim xmlFinal As New MSXML2.DOMDocument
   
   '-----miscellaneous
   Dim sLabelName As String
   Dim sItemName As String
   Dim sTempXML As String
   Dim sOutputFile As String
   Dim sLanguageCode As String
   Dim sDefaultLanguage As String
   
   On Error GoTo ErrorHandler
      
   xmlApplication.Load brGenInfo.FolderApp + "@Application.xml"
   '-----load the style sheet and transform the XML
   oXSL.Load brGenInfo.FolderStylesheet + "GenerateLanguage.xsl"
   
   Set oLanguages = xmlApplication.selectNodes("WTROOT/WTLANGUAGES/WTLANGUAGE")
   For Each oLanguage In oLanguages
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
   
      sDefaultLanguage = Not (oLanguage.Attributes.getNamedItem("default") Is Nothing)
      
      If (brGenInfo.Language <> "false") Or (sDefaultLanguage = "True") Then
      
         sLanguageCode = oLanguage.Attributes.getNamedItem("code").Text
         
         If (brGenInfo.Language <> "false") Then
            xmlLangOld.Load brGenInfo.FolderWeb + "Language\" + brGenInfo.ProjectName + "[" + sLanguageCode + "].xml"
         Else
            xmlLangOld.Load brGenInfo.FolderWeb + "Language\" + brGenInfo.ProjectName + ".xml"
         End If
         xmlCommon.Load brGenInfo.FolderWeb + "Language\" + "Common[" + sLanguageCode + "].xml"
      
         '-----append additional XML
         With brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY")
            '-----append common labels to the XML
'            .appendChild xmlCommon.childNodes(1).cloneNode(True)
            '-----append application language parameters to the XML
            .appendChild xmlApplication.selectSingleNode("/WTROOT/WTLANGUAGES").cloneNode(True)
         End With
         
         brGenInfo.oDAT.transformNodeToObject oXSL, oOUT
         
         '-----remove additional XML
         With brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY")
            .removeChild brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY/WTLANGUAGES")
'            .removeChild brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY/LANGUAGE")
         End With
         
         '-----replace the line feeds with carriage return/line feed
         '-----replace tabs with 3 spaces
         sTempXML = Replace(oOUT.Text, Chr(10), vbCrLf)
         sTempXML = Replace(sTempXML, Chr(9), Space(3))
         
         '-----load the new (default) language file
         xmlLangNew.loadXML sTempXML
                  
         '-----loop through each label and set its value(s)
         Set oLabelsNew = xmlLangNew.selectNodes("LANGUAGE/LABEL")
         For Each oLabelNew In oLabelsNew
            With oLabelNew
               sLabelName = .getAttribute("name")
               Set oItemOld = xmlLangOld.selectSingleNode("LANGUAGE/LABEL[@name='" & sLabelName & "']")
               '-----if found, replace it
               If Not (oItemOld Is Nothing) Then
                  oLabelNew.Text = oItemOld.Text
               End If
               Set oItemOld = Nothing
            End With
         Next
         Set oLabelsNew = Nothing
               
         '-----append all the common labels
'         Set oAttribute = xmlLangNew.createAttribute("common")
'         With oAttribute
'            .Value = "true"
'         End With
'
'         Set oLabelsOld = xmlCommon.selectNodes("LANGUAGE/LABEL")
'         For Each oLabelOld In oLabelsOld
'            Set oLabelNew = xmlLangNew.selectSingleNode("LANGUAGE").appendChild(oLabelOld.cloneNode(True))
'            '-----tag the label as a common label
'            With oLabelNew
'               .setAttributeNode oAttribute.cloneNode(True)
'            End With
'            Set oLabelNew = Nothing
'         Next
'         Set oLabelsOld = Nothing
'         Set oAttribute = Nothing

         xmlFinal.loadXML "<LANGUAGE></LANGUAGE>"

         '-----rewrite labels without duplicates
         Set oLabelsNew = xmlLangNew.selectNodes("LANGUAGE/LABEL")
         For Each oLabelNew In oLabelsNew
            sLabelName = oLabelNew.getAttribute("name")
            '---check if this label is in Common labels
            Set oItemOld = xmlCommon.selectSingleNode("LANGUAGE/LABEL[@name='" & sLabelName & "']")
            If (oItemOld Is Nothing) Then
               '---check for duplicate
               Set oItemOld = xmlFinal.selectSingleNode("LANGUAGE/LABEL[@name='" & sLabelName & "']")
               '-----if not a duplicate, add it
               If (oItemOld Is Nothing) Then
                  Set oLabelOld = xmlFinal.selectSingleNode("LANGUAGE").appendChild(oLabelNew.cloneNode(True))
                  Set oLabelOld = Nothing
               End If
            End If
            Set oItemOld = Nothing
         Next
         Set oLabelsNew = Nothing
         
         '-----save file and update the status
         If (brGenInfo.Language <> "false") Then
            sOutputFile = brGenInfo.FolderWeb + "Language\" + brGenInfo.ProjectName + "[" + sLanguageCode + "].xml"
         Else
            sOutputFile = brGenInfo.FolderWeb + "Language\" + brGenInfo.ProjectName + ".xml"
         End If
         SaveSource brGenInfo, cEncodeXML + vbCrLf + xmlFinal.XML, sOutputFile, False
         mTotalLangFiles = mTotalLangFiles + 1
         
         Set xmlLangNew = Nothing
         Set xmlLangOld = Nothing
         Set xmlCommon = Nothing
         
      End If
   Next
   
AbortError:
   
   Set oLanguages = Nothing
   Set xmlApplication = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Private Sub GenerateLanguagePages( _
   ByRef brGenInfo As tGenerateInfoRec)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate Language Files for each page with its own @langfile
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GenerateLanguagePages"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oXSL As New MSXML2.DOMDocument
   Dim oOUT As New MSXML2.DOMDocument
   '-----application definition file
   Dim xmlApplication As New MSXML2.DOMDocument
   '-----common language file
'   Dim xmlCommon As New MSXML2.DOMDocument
   '-----original language file
   Dim oLanguages As MSXML2.IXMLDOMNodeList
   Dim oLanguage As MSXML2.IXMLDOMElement
   Dim xmlLangOld As New MSXML2.DOMDocument
   Dim oItemOld As MSXML2.IXMLDOMElement
   
   '-----new language file
   Dim xmlLangNew As New MSXML2.DOMDocument
   Dim oLabelsNew As MSXML2.IXMLDOMNodeList
   Dim oLabelNew As MSXML2.IXMLDOMElement
   Dim oLabelsOld As MSXML2.IXMLDOMNodeList
   Dim oLabelOld As MSXML2.IXMLDOMElement
   Dim oAttribute As MSXML2.IXMLDOMAttribute
   Dim oDupLabels As MSXML2.IXMLDOMNodeList
   
   Dim xmlFinal As New MSXML2.DOMDocument
   
   Dim oLangPages As MSXML2.IXMLDOMNodeList
   Dim oLangPage As MSXML2.IXMLDOMElement
   
   '-----miscellaneous
   Dim sLabelName As String
   Dim sItemName As String
   Dim sTempXML As String
   Dim sOutputFile As String
   Dim sLanguageCode As String
   Dim sDefaultLanguage As String
   Dim sPageName As String
   Dim sLangFile As String
   Dim sLanguage As String
   
   On Error GoTo ErrorHandler
      
   xmlApplication.Load brGenInfo.FolderApp + "@Application.xml"
   '-----load the style sheet and transform the XML
   oXSL.Load brGenInfo.FolderStylesheet + "GenerateLanguagePage.xsl"
   
   Set oLangPages = brGenInfo.oXML.selectNodes("/WTROOT/WTWEBPAGES/WTWEBPAGE[@langfile]")
   For Each oLangPage In oLangPages
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
   
      brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY").appendChild oLangPage.cloneNode(True)
      
      sPageName = oLangPage.Attributes.getNamedItem("name").Text
      sLangFile = oLangPage.Attributes.getNamedItem("langfile").Text
      If Not (oLangPage.Attributes.getNamedItem("language") Is Nothing) Then
         sLanguage = oLangPage.Attributes.getNamedItem("language").Text
      Else
         sLanguage = ""
      End If
   
      Set oLanguages = xmlApplication.selectNodes("WTROOT/WTLANGUAGES/WTLANGUAGE")
      For Each oLanguage In oLanguages
         DoEvents
         If cmdClose.Caption = "Close" Then GoTo AbortError
      
         sDefaultLanguage = Not (oLanguage.Attributes.getNamedItem("default") Is Nothing)
         
         If (brGenInfo.Language <> "false" And sLanguage <> "false") Or (sDefaultLanguage = "True") Then
         
            sLanguageCode = oLanguage.Attributes.getNamedItem("code").Text
            
            If (brGenInfo.Language <> "false" And sLanguage <> "false") Then
               xmlLangOld.Load brGenInfo.FolderWeb + "Language\" + sLangFile + "[" + sLanguageCode + "].xml"
            Else
               xmlLangOld.Load brGenInfo.FolderWeb + "Language\" + sLangFile + ".xml"
            End If
            
            brGenInfo.oDAT.transformNodeToObject oXSL, oOUT
            
            '-----replace the line feeds with carriage return/line feed
            '-----replace tabs with 3 spaces
            sTempXML = Replace(oOUT.Text, Chr(10), vbCrLf)
            sTempXML = Replace(sTempXML, Chr(9), Space(3))
            
            '-----load the new (default) language file
            xmlLangNew.loadXML sTempXML
                     
            '-----loop through each label and set its value(s)
            Set oLabelsNew = xmlLangNew.selectNodes("LANGUAGE/LABEL")
            For Each oLabelNew In oLabelsNew
               With oLabelNew
                  sLabelName = .getAttribute("name")
                  Set oItemOld = xmlLangOld.selectSingleNode("LANGUAGE/LABEL[@name='" & sLabelName & "']")
                  '-----if found, replace it
                  If Not (oItemOld Is Nothing) Then
                     oLabelNew.Text = oItemOld.Text
                  End If
                  Set oItemOld = Nothing
               End With
            Next
            Set oLabelsNew = Nothing
                  
            xmlFinal.loadXML "<LANGUAGE/>"
            
            '-----rewrite labels without duplicates
            Set oLabelsNew = xmlLangNew.selectNodes("LANGUAGE/LABEL")
            For Each oLabelNew In oLabelsNew
               sLabelName = oLabelNew.getAttribute("name")
               '---check for duplicate
               Set oItemOld = xmlFinal.selectSingleNode("LANGUAGE/LABEL[@name='" & sLabelName & "']")
               '-----if not a duplicate, add it
               If (oItemOld Is Nothing) Then
                  Set oLabelOld = xmlFinal.selectSingleNode("LANGUAGE").appendChild(oLabelNew.cloneNode(True))
                  Set oLabelOld = Nothing
               End If
               Set oItemOld = Nothing
            Next
            Set oLabelsNew = Nothing
            
            '-----save file and update the status
            If (brGenInfo.Language <> "false" And sLanguage <> "false") Then
               sOutputFile = brGenInfo.FolderWeb + "Language\" + sLangFile + "[" + sLanguageCode + "].xml"
            Else
               sOutputFile = brGenInfo.FolderWeb + "Language\" + sLangFile + ".xml"
            End If
            SaveSource brGenInfo, cEncodeXML + vbCrLf + xmlFinal.XML, sOutputFile, False
            mTotalLangFiles = mTotalLangFiles + 1
      
            Set xmlLangNew = Nothing
            Set xmlLangOld = Nothing
            
         End If
      Next
      
      brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY").removeChild brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY/WTWEBPAGE")
      
   Next
   
AbortError:
   
   Set oLangPages = Nothing
   Set oLanguages = Nothing
   Set xmlApplication = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Private Sub GenerateVBClass( _
   ByRef brGenInfo As tGenerateInfoRec)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate VB Class
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GenerateVBClass"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oXSL As New MSXML2.DOMDocument
   Dim oOUT As New MSXML2.DOMDocument
   Dim oClasses As MSXML2.IXMLDOMNodeList
   Dim oClass As MSXML2.IXMLDOMElement
   Dim idxClass As Integer
   Dim sTempXML As String
   Dim sOutputFile As String
   
   On Error GoTo ErrorHandler
      
   '-----get the list of all the projects
   Set oClasses = brGenInfo.oXML.selectNodes("/WTROOT/WTCOMPONENTS/WTCOMPONENT/WTCLASS")
   
   '-----loop through each project
   For idxClass = 0 To oClasses.length - 1
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      
      Set oClass = oClasses.Item(idxClass)
      With oClass
         '-----load the style sheet and transform the XML
         oXSL.Load brGenInfo.FolderStylesheet + .getAttribute("stylesheet")
      
         '-----append additional XML
         With brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY")
            '-----append common labels to the XML
            .appendChild oClass.cloneNode(True)
         End With
         
         brGenInfo.oDAT.transformNodeToObject oXSL, oOUT
         
         '-----remove additional XML
         With brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY")
            .removeChild brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY/WTCLASS")
         End With
         
         '-----replace the line feeds with carriage return/line feed
         '-----replace tabs with 3 spaces
         sTempXML = Replace(oOUT.Text, Chr(10), vbCrLf)
         sTempXML = Replace(sTempXML, Chr(9), Space(3))
         
         '-----save file and update the status
'         sOutputFile = brGenInfo.FolderUser + .getAttribute("name") + ".cls"
         sOutputFile = brGenInfo.FolderProject + .getAttribute("name") + ".cls"
         If Not SaveSource(brGenInfo, sTempXML, sOutputFile) Then GoTo AbortError
         mTotalVBFiles = mTotalVBFiles + 1
      End With
      Set oClass = Nothing
   Next idxClass
         
AbortError:
   Set oClasses = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Private Sub GenerateVBProject( _
   ByRef brGenInfo As tGenerateInfoRec)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate VB Projects
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GenerateVBProject"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oXSL As New MSXML2.DOMDocument
   Dim oOUT As New MSXML2.DOMDocument
   Dim oComps As MSXML2.IXMLDOMNodeList
   Dim oComp As MSXML2.IXMLDOMElement
   Dim idxComp As Integer
   Dim sTempXML As String
   Dim sOutputFile As String
   
   On Error GoTo ErrorHandler
      
   '-----get the list of all the projects
   Set oComps = brGenInfo.oXML.selectNodes("/WTROOT/WTCOMPONENTS/WTCOMPONENT")
   
   '-----loop through each project
   For idxComp = 0 To oComps.length - 1
      DoEvents
      If cmdClose.Caption = "Close" Then GoTo AbortError
      
      Set oComp = oComps.Item(idxComp)
      With oComp
         '-----load the style sheet and transform the XML
         oXSL.Load brGenInfo.FolderStylesheet + .getAttribute("stylesheet")
      
         '-----append additional XML
         With brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY")
            '-----append common labels to the XML
            .appendChild oComp.cloneNode(True)
         End With
         
         brGenInfo.oDAT.transformNodeToObject oXSL, oOUT
         
         '-----remove additional XML
         With brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY")
            .removeChild brGenInfo.oDAT.selectSingleNode("/Data/WTENTITY/WTCOMPONENT")
         End With
         
         '-----replace the line feeds with carriage return/line feed
         '-----replace tabs with 3 spaces
         sTempXML = Replace(oOUT.Text, Chr(10), vbCrLf)
         sTempXML = Replace(sTempXML, Chr(9), Space(3))
         
         '-----save file and update the status
'         sOutputFile = brGenInfo.FolderUser + brGenInfo.ProjectPrefix + .getAttribute("name") + ".vbp"
         sOutputFile = brGenInfo.FolderProject + brGenInfo.ProjectPrefix + .getAttribute("name") + ".vbp"
         If Not SaveSource(brGenInfo, sTempXML, sOutputFile) Then GoTo AbortError
      End With
      Set oComp = Nothing
   Next idxComp
         
AbortError:
   Set oComps = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Private Function ReplaceProcXML( _
   ByRef oSrcElement As MSXML2.IXMLDOMElement, _
   ByVal bvReplaceText As String) As MSXML2.IXMLDOMElement
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Replaces the reserved character (#) in the oSrcElement XML with the specified replacement text and returns the new DOM ELement.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReplaceProcXML"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oNewElement As MSXML2.IXMLDOMElement
   Dim oNode As IXMLDOMNode
   
   On Error GoTo ErrorHandler
      
   Set oNewElement = oSrcElement.cloneNode(True)
   
   For Each oNode In oNewElement.Attributes
      ReplaceProcNode oNode, bvReplaceText
   Next oNode
   
   If oNewElement.hasChildNodes Then
      For Each oNode In oNewElement.childNodes
         ReplaceProcNode oNode, bvReplaceText
      Next oNode
   End If
   
   Set ReplaceProcXML = oNewElement
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Private Sub ReplaceProcNode( _
   ByRef oNode As MSXML2.IXMLDOMNode, _
   ByVal bvReplaceText As String)
      '---------------------------------------------------------------------------------------------------------------------------------
   '  Replaces the reserved character (#) in oNode with the specified replacement text and returns the new DOM ELement.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "ReplaceProcNode"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oChildNode As IXMLDOMNode
   
   On Error GoTo ErrorHandler
      
   '-----replace all the attributes
   With oNode
      If (InStr(1, .nodeValue, "#", vbTextCompare) <> 0) Then
         .nodeValue = Replace(.nodeValue, "#", bvReplaceText, , , vbTextCompare)
      End If
   End With

   '-----call this proc RECURSIVE to handle all the child nodes
   If Not (oNode.Attributes Is Nothing) Then
      For Each oNode In oNode.Attributes
         ReplaceProcNode oNode, bvReplaceText
      Next oNode
   End If

   '-----call this proc RECURSIVE to handle all the child nodes
   If Not (oNode Is Nothing) Then
      If oNode.hasChildNodes Then
         For Each oChildNode In oNode.childNodes
            ReplaceProcNode oChildNode, bvReplaceText
         Next oChildNode
      End If
   End If
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Private Sub cmdEntity_Click()
   frmEntity.Show , Me
End Sub

Private Sub cmdGenerate_Click()
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Generate Source Code for selected items
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "cmdGenerate_Click"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim sMsg As String
   Dim sErrorMsg As String
   Dim pos As Long
   Dim idx As Long
   Dim tmp As Long
   Dim sTotalTime As String
   
   On Error GoTo ErrorHandler
      
   If Len(mEntity) = 0 Then
      MsgBox "Please select an Entity Filename.", vbExclamation
      cmbApp.SetFocus
      Exit Sub
   End If
   If Len(txtProject.Text) = 0 Then
      MsgBox "Please enter a Project Name.", vbExclamation
      txtProject.SetFocus
      Exit Sub
   End If
   If Len(txtSystem.Text) = 0 Then
      MsgBox "Please enter a System Name.", vbExclamation
      txtSystem.SetFocus
      Exit Sub
   End If
   If Len(txtPrefix.Text) = 0 Then
      MsgBox "Please enter an Application Prefix.", vbExclamation
      txtPrefix.SetFocus
      Exit Sub
   End If
   
   frmMsg.Caption = "Generation Results"
   frmMsg.txtMsg.Text = ""
   If Not frmMsg.Visible Then
      frmMsg.Left = Me.Left + Me.Width
      frmMsg.Top = Me.Top
      frmMsg.Height = Me.Height
      frmMsg.Show , Me
   End If
   
   '-----initialize Common Labels Flag
   mCommonLabels = True
   
   mTotalFiles = 0
   mTotalErrors = 0
   mTotalWebFiles = 0
   mTotalLangFiles = 0
   mTotalVBFiles = 0
   mTotalSQLFiles = 0
   mStartTime = Now
   
   cmdClose.Caption = "Cancel"
   
   If mCtrlKey Then
      mCtrlKey = False
      With cmbApp
         pos = .ListIndex
         For idx = 0 To .ListCount - 1
            .ListIndex = idx
            sMsg = vbCrLf + "----------" + txtProject.Text + "----------" + vbCrLf
            sMsg = sMsg + Generate() + "----------Done----------" + vbCrLf
            frmMsg.txtMsg.Text = frmMsg.txtMsg.Text + sMsg
            frmMsg.txtMsg.SelStart = Len(frmMsg.txtMsg.Text)
            frmMsg.txtMsg.Refresh
            DoEvents
            If cmdClose.Caption = "Close" Then idx = .ListCount
         Next
         .ListIndex = pos
      End With
   Else
      sMsg = vbCrLf + "----------" + txtProject.Text + "----------" + vbCrLf
      sMsg = sMsg + Generate()
      frmMsg.txtMsg.Text = sMsg + "----------Done----------"
      If mShiftKey Then
         mShiftKey = False
         'select next application file
         With cmbApp
            If .ListIndex >= 0 Then
               If .ListIndex < .ListCount - 1 Then
                  .ListIndex = .ListIndex + 1
               Else
                  Beep
                  MsgBox "End of List", vbInformation, "Generate"
                  .ListIndex = 0
               End If
            End If
         End With
      End If
   End If
   
   chkBusnProject.Value = 0
   chkUserProject.Value = 0
   tmp = DateDiff("s", mStartTime, Now)
   sTotalTime = Format(Int(tmp / 60), "00") + ":" + Format(tmp Mod 60, "00")
   
   cmdClose.Caption = "Close"
   
   sMsg = ""
   sMsg = sMsg + "Total Files " & vbTab & mTotalFiles & vbTab & vbCr & vbCr
   If mTotalErrors > 0 Then
      sMsg = sMsg + "Total Errors " & vbTab & mTotalErrors & vbTab & vbCr & vbCr
   End If
   sMsg = sMsg + "Web Files" & vbTab & vbTab & mTotalWebFiles & vbCr
   sMsg = sMsg + "VB Files" & vbTab & vbTab & mTotalVBFiles & vbCr
   sMsg = sMsg + "SQL Files" & vbTab & vbTab & mTotalSQLFiles & vbCr
   sMsg = sMsg + "Language Files" & vbTab & mTotalLangFiles & vbCr & vbCr
   sMsg = sMsg + "Total Time" & vbTab & sTotalTime + vbCr
   
   If mTotalErrors > 0 Then
      sErrorMsg = "Total Errors " & vbTab & mTotalErrors & vbTab
      MsgBox sErrorMsg, vbCritical + vbOKOnly, "Generation Errors"
   End If
   
   MsgBox sMsg, vbInformation + vbOKOnly, "Generation Complete"
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   ShowError Err.Number, Err.Source, Err.Description
   Exit Sub
End Sub

Public Function FileConfirmWrite( _
   ByVal bvFileName As String) As Boolean
   '---------------------------------------------------------------------------------------------------------------------------------
   '  check if a file exists
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FileConfirmWrite"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim ret As Long
   
   On Error GoTo ErrorHandler

   Set oFileSys = New Scripting.FileSystemObject
   
   If oFileSys.FileExists(bvFileName) Then
      ret = MsgBox("Overwrite " + bvFileName + "?", vbExclamation + vbYesNoCancel, bvFileName)
      
      Select Case ret
         Case vbYes: FileConfirmWrite = True
         Case vbNo: FileConfirmWrite = False
         Case vbCancel
            FileConfirmWrite = False
            mCancel = True
      End Select
   Else
      FileConfirmWrite = True
   End If
   
   Set oFileSys = Nothing
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set oFileSys = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function SaveFile( _
   ByVal bvFileName As String, _
   ByVal bvText As String) As Boolean
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Saves the specified text file
   '
   '  Input:
   '  bvFileName - fully-qualified name of the file to save [Required]
   '  bvText - contents of the file [Required]
   '
   '  Output:
   '  None
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "SaveFile"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim oTextStream As Scripting.TextStream
   
   On Error GoTo ErrorHandler

   Set oFileSys = New Scripting.FileSystemObject
   '-----create an empty text file
   With oFileSys
      Set oTextStream = .OpenTextFile(bvFileName, ForWriting, True)
      With oTextStream
         '-----this will overwrite the file if it already exists
         .Write bvText
         .Close
      End With
   End With
   
ErrorIgnore:
   Set oTextStream = Nothing
   Set oFileSys = Nothing
   SaveFile = True
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   If ErrNo = cErrVBPermissionDenied Then
      Select Case MsgBox(bvFileName + vbCrLf + "Can't open file (The file is probably marked read-only).", vbAbortRetryIgnore + vbExclamation, "Error - Permission Denied")
         Case vbRetry
            Err.Clear
            Resume
         Case vbIgnore
            Err.Clear
            GoTo ErrorIgnore
         Case vbAbort
            Err.Clear
            SaveFile = False
            Exit Function
      End Select
   Else
      Err.Raise ErrNo, ErrSrc, ErrDesc
   End If
End Function

Public Sub FolderCreate( _
   ByVal bvFolder As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Creates the specified folder.
   '
   '  Input:
   '  bvFolder - fully-qualified name of the folder directory [Required]
   '
   '  Output:
   '  None
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FolderCreate"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oFileSys As Scripting.FileSystemObject
   Dim oFolder As Scripting.Folder
   Dim strFolders() As String
   Dim sPath As String
   Dim idxFolder As Integer

   On Error GoTo ErrorHandler
      
   '-----split the path into an array of sub folders
   strFolders = Split(bvFolder, "\")
   
   Set oFileSys = New Scripting.FileSystemObject
   
   With oFileSys
      '-----the first element (element 0) is the drive, make sure it is valid
      If UBound(strFolders) >= 0 Then
         If Not (.DriveExists(strFolders(0))) Then
            '-----can't create a drive
            Exit Sub
         End If
      End If
      
      '-----the remaining elements (elements 1 and on) are subfolders of the root folder
      '-----loop through each item in the array, adding the subfolder if necessary
      sPath = strFolders(0)   '-----set the beginning path to the drive
      For idxFolder = LBound(strFolders) + 1 To UBound(strFolders) - 1
         sPath = sPath + "\" + strFolders(idxFolder)
         If .FolderExists(sPath) Then
            Set oFolder = .GetFolder(sPath)
         Else
            Set oFolder = .CreateFolder(sPath)
         End If
      Next
   End With

   Set oFolder = Nothing
   Set oFileSys = Nothing
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Set oFolder = Nothing
   Set oFileSys = Nothing
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Private Sub cmdGenerate_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   If Shift = 2 Then mCtrlKey = True
   If Shift = 1 Then mShiftKey = True
End Sub

Private Sub cmdProject_Click()
   frmProject.Show , Me
End Sub

Public Function FormatXML( _
   ByVal bvXML As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns th specified XML formatted with carriage returns and indentation
   '
   '  Input:
   '  bvXML - XML to format
   '
   '  Output:
   '  String - formatted XML
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FormatXML"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim char1 As String
   Dim char2 As String
   Dim idxchar As Long
   Dim WorkStr As String
   Dim Result As String
   Dim mTabs As Integer
   Dim TotalLen As Long
   Dim StartMode As Boolean
   Dim StartTag As String
   Dim NoIndent As Boolean
   Dim Strip As Boolean
   
   On Error GoTo ErrorHandler

   mTabs = 0
   
   WorkStr = Replace(bvXML, vbCrLf, "")
   WorkStr = Replace(WorkStr, vbTab, "")
   WorkStr = Trim$(WorkStr)
   
   TotalLen = Len(WorkStr)
   For idxchar = 1 To TotalLen
      char1 = Mid$(WorkStr, idxchar, 1)
      char2 = Mid$(WorkStr, idxchar, 2)
      '-----if closing a tag
      If char2 = "</" Then
         'start indenting again if end tag for script
         If Mid$(WorkStr, idxchar + 2, 12) = "msxsl:script" Then
            NoIndent = False
         End If
         If Not NoIndent Then
            mTabs = mTabs - 1
            StartMode = False
            '--if the StartTag matches this closing tag, leave the closing tag on the same line
            If StartTag = Mid$(WorkStr, idxchar + 2, Len(StartTag)) Then
               Result = Result + "<"
            Else
               Result = Result + vbCrLf + String(mTabs, vbTab) + "<"
            End If
         Else
            Result = Result + "<"
         End If
      '-----if closing a tag
      ElseIf char2 = "/>" Then
         Result = Result + "/"
         If Not NoIndent Then
            mTabs = mTabs - 1
            StartMode = False
         End If
      '-----if starting a new tag
      ElseIf char1 = "<" Then
         'ignore less than sign (not a start tag)
         If char2 = "< " Or char2 = "<=" Then
            Result = Result + "<"
         Else
            If NoIndent Then
               Result = Result + "<"
            Else
               Result = Result + vbCrLf + String(mTabs, vbTab) + "<"
               If char2 <> "<?" And char2 <> "<!" Then mTabs = mTabs + 1
               StartMode = True
               StartTag = ""
            End If
            'don't indent script
            If Mid$(WorkStr, idxchar + 1, 12) = "msxsl:script" Then
               NoIndent = True
            End If
         End If
      '-----else nothing
      Else
         Result = Result + char1
         'remember the most recent start tag
         If StartMode Then
            If char1 = " " Or char1 = ">" Or char1 = "/" Then
               StartMode = False
            Else
               StartTag = StartTag + char1
            End If
         End If
      End If
   Next idxchar
   
   FormatXML = Result
      
   Exit Function

ErrorHandler:
   Err.Raise Err.Number, Err.Source, Err.Description
End Function

Private Sub Form_Load()
   Dim sFile As String
   Dim sEntity As String
   Me.Height = cmdGenerate.Top + cmdGenerate.Height + 600
   sFile = GetRegistryValue(cRegKey, cRegApp)
   sEntity = GetRegistryValue(cRegKey, cRegEntity)
   LoadAppFile sFile
   If IsNumeric(sEntity) And cmbApp.ListCount > 0 Then cmbApp.ListIndex = sEntity
End Sub

Private Sub Form_Unload(Cancel As Integer)
   End
End Sub

