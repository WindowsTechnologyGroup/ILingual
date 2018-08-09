Attribute VB_Name = "wtiErrorMod"
Option Explicit
Private Const cModName As String = "wtiErrorMod"

Private Const cErrSystem As Integer = 1000
'----system error codes
Public Const ErrSQLUniqueIndexViolation As Long = 2601
'-----native error codes from VB Runtime
'-----used to trap specific VB runtime errors
Public Const cErrVBPermissionDenied As Long = 70
'----application error codes
Public Const cErrXMLParseFailed As Long = vbObjectError + cErrSystem + 1
Public Const cErrXMLCantFindNode As Long = vbObjectError + cErrSystem + 2
Public Const cErrXMLCantFindAttribute As Long = vbObjectError + cErrSystem + 3
Public Const cErrXMLElementHasNoValue As Long = vbObjectError + cErrSystem + 4
Public Const cErrInvalidParameter As Long = vbObjectError + cErrSystem + 5
Public Const ErrEditFieldError As Long = vbObjectError + cErrSystem + 6
Public Const ErrCheckDataArray As Long = vbObjectError + cErrSystem + 7
Public Const cErrCantOpenFile As Long = vbObjectError + cErrSystem + 8
Public Const cErrFileNotFound As Long = vbObjectError + cErrSystem + 9
Public Const cErrInvalidParent As Long = vbObjectError + cErrSystem + 10

'-----constants for event log type
Public Const cEventLogSuccess As Long = 0
Public Const cEventLogErrorType As Long = 1
Public Const cEventLogWarningType As Long = 2
Public Const cEventLogInformationType As Long = 4
Public Const cEventLogAuditSuccess As Long = 8
Public Const cEventLogAuditFailure As Long = 10

'-----event log function declarations
Private Declare Function RegisterEventSource Lib "advapi32.dll" Alias "RegisterEventSourceA" (ByVal bvUNCServerName As String, ByVal bvSourceName As String) As Long
Private Declare Function DeregisterEventSource Lib "advapi32.dll" (ByVal bvEventLog As Long) As Long
Private Declare Function ReportEvent Lib "advapi32.dll" Alias "ReportEventA" (ByVal bvEventLog As Long, ByVal bvType As Integer, _
   ByVal bvCategory As Integer, ByVal bvEventID As Long, ByVal bvUserSid As Any, ByVal bvNumStrings As Integer, _
   ByVal bvDataSize As Long, bvStrings As Long, bvRawData As Any) As Boolean
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByVal bvDest As Any, ByVal bvSource As Any, ByVal bvCopy As Long)
Private Declare Function GlobalAlloc Lib "kernel32" (ByVal bvFlags As Long, ByVal bvBytes As Long) As Long
Private Declare Function GlobalFree Lib "kernel32" (ByVal bvMem As Long) As Long

Public Sub CatchError( _
   ByRef brError As Long, _
   ByRef brSource As String, _
   ByRef brDesc As String, _
   Optional ByVal bvModName As String, _
   Optional ByVal bvProcName As String, _
   Optional ByVal bvWriteLog As Boolean = True, _
   Optional ByRef brSQLErrors As Object)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Records the current error information to the NT event log
   '
   '  Input:
   '  brError - error number [Required]
   '  brSource - error source [Required]
   '  brDesc - error description [Required]
   '  bvModName - name of module that trapped the error [Optional]
   '  bvProcName - name of procedure that trapped the error [Optional]
   '  bvWrtieLog - Flag indicating if error should be written to the NT Event log [Optional]
   '
   '  Output:
   '  None
   '---------------------------------------------------------------------------------------------------------------------------------
   Const cProcName As String = "CatchError"
   '---------------------------------------------------------------------------------------------------------------------------------
   
   '-----save the current error information
   brError = Err.Number
   brSource = Err.Source
   brDesc = Err.Description
      
   '-----clean up the module and proc references
   If Len(Trim$(bvModName)) = 0 Then bvModName = "Unspecified"
   If Len(Trim$(bvProcName)) = 0 Then bvProcName = "Unspecified"
            
   '-----if the error is a user error then switch the error and don't write to the log
   If IsUserError(brError, brDesc, brSQLErrors) Then
      bvWriteLog = False
   End If
   
   '-----write the log
   If bvWriteLog Then
'      WriteLogInternal "-----" + Space(1) & Now & Space(1) + "-----" + vbCrLf + _
'      "Error:" + Space(1) + CStr(brError) + " -- " + brDesc & vbCrLf + _
'      "Source: " + Space(1) + brSource + " -- " + bvModName + "::" + bvProcName & vbCrLf
   End If
End Sub

Public Function IsUserError( _
   ByRef brError As Long, _
   ByRef brDesc As String, _
   Optional ByRef brSQLErrors As Object) As Boolean
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Checks if an error is a user error. If so, it changes the err number and description to be more
   '  user-friendly.
   '
   '  Input:
   '  brError - error number [Required]
   '  brDesc - error description [Required]
   '  brSQLErrors - collection of SQL Server errors generated from a SQL Server exception [Optional]
   '
   '  Output:
   '  Boolean - True is the error is a user error, otherwise false
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTIsUserError"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oErrorObj As Object
      
   If brSQLErrors Is Nothing Then
      Set oErrorObj = Nothing
   ElseIf brSQLErrors.ActiveConnection Is Nothing Then
      Set oErrorObj = Nothing
   ElseIf brSQLErrors.ActiveConnection.Errors Is Nothing Then
      Set oErrorObj = Nothing
   ElseIf brSQLErrors.ActiveConnection.Errors.Count = 0 Then
      Set oErrorObj = Nothing
   Else
      Set oErrorObj = brSQLErrors.ActiveConnection.Errors.Item(0)
   End If

   '-----default the return Value
   IsUserError = False
   
   If oErrorObj Is Nothing Then
      '-----check for VB runtime errors to override
      If brError = cErrVBPermissionDenied Then
         IsUserError = True
      Else
         Select Case (brError - vbObjectError)
            Case (ErrEditFieldError - vbObjectError)  '-----edit field function errors
               IsUserError = True
            Case (cErrXMLParseFailed - vbObjectError) '-----can't open XML file
               IsUserError = True
         End Select
      End If
   Else
      '-----check to see what sql errors were raised
'      Select Case brSQLErrors.ActiveConnection.Errors.Item(0).NativeError
'         Case ErrSQLUniqueIndexViolation
'            If InStr(1, UCase$(brDesc), "IXU_OPERATOR_LOGON") Then
'               IsUserError = True
'               brDesc = "Oops, Logon is not unique, please choose another logon."
'            End If
'      End Select
   End If
   
   Set oErrorObj = Nothing
   
   Exit Function
End Function

Public Sub ShowError( _
   ByVal bvError As Long, _
   ByVal bvSource As String, _
   ByVal bvDesc As String)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Displays a message box dialog to the user if an error is encountered
   '
   '  Input:
   '  brError - error number [Required]
   '  brSource - error source [Required]
   '  brDesc - error description [Required]
   '
   '  Output:
   '  None
   '---------------------------------------------------------------------------------------------------------------------------------
   Const cProcName As String = "ShowError"
   '---------------------------------------------------------------------------------------------------------------------------------
   MsgBox bvDesc, vbCritical + vbOKOnly, "Error"
   Err.Clear
End Sub

Public Sub WriteLogInternal( _
   ByVal bvMsg As String, _
   Optional ByVal bvLogType As Long = cEventLogInformationType)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Writes the specified text to the NT Event Log.
   '
   '  Input:
   '  brMsg - Text to be written [Required]
   '
   '  Output:
   '  None
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WriteLogInternal"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim RC As Boolean
   Dim NumStrings As Integer
   Dim EventLog As Long
   Dim Msgs As Long
   Dim StringSize As Long
     
   On Error GoTo ErrorHandler
   
   EventLog = RegisterEventSource("", App.Title)
   StringSize = Len(bvMsg) + 1
   Msgs = GlobalAlloc(&H40, StringSize)
   CopyMemory ByVal Msgs, ByVal bvMsg, StringSize
   NumStrings = 1
   If ReportEvent(EventLog, _
      bvLogType, 0, _
      1001, 0&, _
      NumStrings, StringSize, _
      Msgs, Msgs) = 0 Then
   End If
   Call GlobalFree(Msgs)
   DeregisterEventSource (EventLog)
    
   Exit Sub

ErrorHandler:
   Err.Clear
   Resume Next
End Sub

