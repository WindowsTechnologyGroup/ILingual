Attribute VB_Name = "NewMacros"
Option Explicit
Public mAttributeID As Long
Public q As String

Sub ConvertAttribute()
'
' Macro1 Macro
' Macro recorded 2/5/2002 by Bob Wood
'
    Dim nam As String
    Dim typ As String
    Dim opt As String
    Dim optu As String
    Dim txt As String
    Dim t As String
    Dim req As String
    Dim min As String
    Dim max As String
    Dim title As String
    Dim lookup As String
    Dim parent As String
    Dim format As String
    Dim join As String
    Dim joinEntity As String
    Dim joinAttribute As String
    Dim protected As String
    Dim hidden As String
    Dim sysid As Boolean
    Dim enumerate As Boolean
    Dim compute As Boolean
    Dim buf As String
    Dim buf1 As String
    Dim numtype As String
    Dim Source As String
    Dim Default As String
    Dim DateType As String
    
    Dim arr As Variant
    Dim idx As Long
    Dim x As Long
    Dim length As Long
    Dim mEntityID As Long

    q = Chr$(34)    'quote character
    t = Chr$(9)     'tab character
    mAttributeID = mAttributeID + 1
    
    If Selection.Information(wdWithInTable) = False Then
        MsgBox "Convert Attribute Macro Only Available in a Table!"
        Exit Sub
    End If
    If Selection.Information(wdMaximumNumberOfColumns) < 3 Then
        MsgBox "Table must have at least 3 columns!"
        Exit Sub
    End If
    
    Application.ScreenUpdating = False
    
    mEntityID = GetEntityID()
    
    Selection.HomeKey Unit:=wdRow
    Selection.MoveRight Unit:=wdCell
    Selection.MoveLeft Unit:=wdCell
    nam = Selection.text
    Selection.MoveRight Unit:=wdCell
    typ = Selection.text
    Selection.MoveRight Unit:=wdCell
    opt = Selection.text
    Selection.HomeKey Unit:=wdRow
    Selection.MoveDown Unit:=wdLine, Count:=1
    
    idx = InStr(typ, " ")
    If idx > 0 Then
        If IsNumeric(Mid(typ, idx + 1)) Then
            length = Mid(typ, idx + 1)
        End If
    End If
    
    optu = UCase(opt)
    If InStr(optu, "REQUIRE") > 0 Then req = " required=" + q + "true" + q
    If InStr(optu, "TITLE") > 0 Then title = " title=" + q + "true" + q
    format = GetText(optu, "FORMAT", opt)
        
    If InStr(optu, "PROTECTED") > 0 Then
        protected = " protected=" + q + GetText(optu, "PROTECTED", opt) + q
    End If
    If InStr(optu, "HIDDEN") > 0 Then
        hidden = " hidden=" + q + GetText(optu, "HIDDEN", opt) + q
    End If
    If InStr(optu, "DEFAULT") > 0 Then
        Default = GetText(optu, "DEFAULT", opt)
    End If
    If InStr(optu, "JOIN") > 0 Then
        joinEntity = GetText(optu, "FROM", opt)
        joinAttribute = GetText(opt, joinEntity, opt)
        Source = "join"
    Else
        Source = "entity"
    End If
        
    Select Case UCase(Left(typ, 4))
        Case "IDEN"
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "number" + q + " identity=" + q + "true" + q + " min=" + q + "1" + q + " required=" + q + "true" + q + " source=" + q + "entity" + q + "/>" + vbCr
            
        Case "PARE"
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "number" + q + " min=" + q + "1" + q + " source=" + q + Source + q + req + protected + hidden
            If Len(joinEntity) > 0 Then
                txt = txt + ">" + vbCr
                txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
                txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If
            
        Case "FORE"
            lookup = GetText(optu, "LOOKUP", opt)
            parent = GetText(optu, "PARENT", opt)
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "number" + q + " min=" + q + "1" + q + " source=" + q + "entity" + q + req + protected + hidden
            If Len(lookup) > 0 Then
                txt = txt + ">" + vbCr
                txt = txt + t + "<WTLOOKUP entity=" + q + lookup + q + " class=" + q + lookup + "s" + q + " method=" + q + "Enumerate" + q + ">" + vbCr
                If Len(parent) > 0 Then
                    txt = txt + t + t + "<WTPARAM name=" + q + parent + q + " direction=" + q + "input" + q + " type=" + q + "attribute" + q + " value=" + q + parent + q + "/>" + vbCr
                End If
                txt = txt + t + t + "<WTPARAM name=" + q + "UserID" + q + " direction=" + q + "input" + q + " type=" + q + "system" + q + " value=" + q + "sysuser" + q + "/>" + vbCr
                txt = txt + t + "</WTLOOKUP>" + vbCr
                txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If
            
        Case "TEXT"
            If InStr(optu, "COMPUTED") > 0 Then compute = True
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "text" + q + " length=" + q & length & q + " min=" + q + "1" + q + " max=" + q & length & q + " source=" + q + Source + q + req + title + protected + hidden
            If Len(joinEntity) > 0 Or Len(Default) > 0 Or compute Then
                txt = txt + ">" + vbCr
                If compute Then
                    Dim creq As String
                    idx = InStr(optu, "COMPUTED")
                    arr = Split(LTrim(Mid(opt, idx + 9)), " ")
                    For idx = LBound(arr) To UBound(arr)
                        buf = arr(idx)
                        If Right(buf, 1) = "®" Then
                            creq = " required=" + q + "true" + q
                            buf = Left(buf, Len(buf) - 1)
                        Else
                            creq = ""
                        End If
                        If Len(buf) <= 2 Or InStr(buf, "_") > 0 Then
                            buf1 = Replace(buf, "_", " ")
                            txt = txt + t + "<WTCOMPUTE text=" + q + buf1 + q + "/>" + vbCr
                        Else
                            txt = txt + t + "<WTCOMPUTE name=" + q + buf + q + " width=" + q + GetComputeWidth(buf, Len(creq)) + q + creq + "/>" + vbCr
                        End If
                    Next
                End If
                If Len(joinEntity) > 0 Then
                    txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
                End If
                If Len(Default) > 0 Then
                    txt = txt + t + "<WTDEFAULT type=" + q + "constant" + q + " value=" + q + Default + q + "/>" + vbCr
                End If
                txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If
            
        Case "CHAR"
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "text" + q + " length=" + q & length & q + " min=" + q + "1" + q + "  max=" + q & length & q + " source=" + q + Source + q + req + title + protected + hidden
            If Len(joinEntity) > 0 Or Len(Default) > 0 Then
                txt = txt + ">" + vbCr
                If Len(joinEntity) > 0 Then
                    txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
                End If
                If Len(Default) > 0 Then
                    txt = txt + t + "<WTDEFAULT type=" + q + "constant" + q + " value=" + q + Default + q + "/>" + vbCr
                End If
                txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If
            
        Case "NUMB", "SMAL", "DECI"
            If InStr(optu, "SYSIDENTITY") > 0 Then sysid = True
            If InStr(optu, "ENUM") > 0 Then enumerate = True
            x = GetNumber(optu, "MIN")
            If x <> 0 Then min = " min=" + q & x & q
            x = GetNumber(optu, "MAX")
            If x <> 0 Then max = " max=" + q & x & q
            Select Case UCase(Left(typ, 4))
                Case "NUMB": numtype = "number"
                Case "SMAL" : numtype = "small number"
                Case "BIGN" : numtype = "big number"
                Case "DECI" : numtype = "decimal"
            End Select
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + numtype + q + " source=" + q + Source + q + req + min + max + title + protected + hidden
            If Len(joinEntity) > 0 Or sysid Or enumerate Or Len(Default) > 0 Then
                txt = txt + ">" + vbCr
                If sysid Then
                txt = txt + t + "<WTINIT type=" + q + "system" + q + " value=" + q + "sysidentity" + q + "/>" + vbCr
                End If
                If Len(joinEntity) > 0 Then
                    txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
                End If
                If enumerate Then
                    idx = InStr(optu, "ENUM")
                    arr = Split(LTrim(Mid(opt, idx + 5)), " ")
                    For idx = LBound(arr) To UBound(arr)
                        buf = arr(idx)
                        txt = txt + t + "<WTENUM id=" + q & idx + 1 & q + " name=" + q + buf + q + "/>" + vbCr
                    Next
                End If
                If Len(Default) > 0 Then
                    txt = txt + t + "<WTDEFAULT type=" + q + "constant" + q + " value=" + q + Default + q + "/>" + vbCr
                End If
                txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If

        Case "DATE"
            x = Getdate(optu, "MIN")
            If x <> 0 Then min = " min=" + q & x & q
            x = Getdate(optu, "MAX")
            If x <> 0 Then max = " max=" + q & x & q
            If UCase(Left(typ, 5)) = "DATET" Then DateType = "datetime" Else DateType = "date"
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + DateType + q + " source=" + q + Source + q + req + title + protected + hidden 
            If Len(joinEntity) > 0 Or InStr(optu, "SYSDATE") > 0 Then
                txt = txt + ">" + vbCr
				If InStr(optu, "SYSDATE") > 0 Then
				    If InStr(optu, "INIT") > 0 Then
				        txt = txt + t + "<WTINIT type=" + q + "system" + q + " value=" + q + "sysdate" + q + "/>" + vbCr
				    End If
				    If InStr(optu, "DEFAULT") > 0 Then
				        If Default = "sysdate" Then
				            txt = txt + t + "<WTDEFAULT type=" + q + "system" + q + " value=" + q + Default + q + "/>" + vbCr
				        Else
				            txt = txt + t + "<WTDEFAULT type=" + q + "constant" + q + " value=" + q + Default + q + "/>" + vbCr
				        End If
				    End If
				End If
				If Len(joinEntity) > 0 Then
				    txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
				End If
				txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If
        
        Case "CURR"
            x = GetNumber(optu, "MIN")
            If x <> 0 Then min = " min=" + q & x & q
            x = GetNumber(optu, "MAX")
            If x <> 0 Then max = " max=" + q & x & q
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "currency" + q + " source=" + q + Source + q + req + min + max + title + protected + hidden
            If Len(joinEntity) > 0 Or Len(Default) > 0 Then
                txt = txt + ">" + vbCr
                If Len(joinEntity) > 0 Then
                    txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
                End If
                If Len(Default) > 0 Then
                    txt = txt + t + "<WTDEFAULT type=" + q + "constant" + q + " value=" + q + Default + q + "/>" + vbCr
                End If
                txt = txt + "</WTATTRIBUTE>" + vbCr
            Else
                txt = txt + "/>" + vbCr
            End If
            
        Case "YESN"
            txt = "<WTATTRIBUTE id=" + q & (mEntityID * 100) + mAttributeID & q + " name=" + q + nam + q + " type=" + q + "yesno" + q + " source=" + q + Source + q + req + title + protected + hidden + ">" + vbCr
            txt = txt + t + "<WTTRUE name=" + q + nam + "Yes" + q + "/>" + vbCr
            txt = txt + t + "<WTFALSE name=" + q + nam + "No" + q + "/>" + vbCr
            If Len(joinEntity) > 0 Or Len(Default) > 0 Then
                If Len(joinEntity) > 0 Then
                    txt = txt + t + "<WTJOIN entity=" + q + joinEntity + q + " name=" + q + joinAttribute + q + "/>" + vbCr
                End If
                If Len(Default) > 0 Then
                    txt = txt + t + "<WTDEFAULT type=" + q + "constant" + q + " value=" + q + Default + q + "/>" + vbCr
                End If
            End If
            txt = txt + "</WTATTRIBUTE>" + vbCr
            
        Case Else
            Beep
            MsgBox "********** Unknown Attibute ********** " + vbCr + nam + ": " + typ + ": " + opt + vbCr
    End Select
    
    If Len(txt) > 0 Then
        txt = Replace(txt, Chr$(150), Chr$(45))
        AppendClipboard (txt)
    End If
    Application.ScreenUpdating = True
    
End Sub

Function GetNumber(str As String, tag As String) As Long
    Dim idx As Long
    Dim number As Long
    Dim buf As String
    
    idx = InStr(str, tag)
    If idx > 0 Then
        buf = LTrim(Mid(str, idx + Len(tag) + 1))
        idx = InStr(buf, " ")
        If idx > 0 Then
            If IsNumeric(Left(buf, idx - 1)) Then number = Left(buf, idx - 1)
        Else
            If IsNumeric(buf) Then number = buf
        End If
    Else
        number = 0
    End If

    GetNumber = number
    
End Function

Function GetComputeWidth(fld As String, req As Boolean) As String
    Dim width As String
    
    Select Case fld
        Case "NameLast": width = "140"
        Case "NameFirst": width = "300"
        Case "City": If req Then width = "231" Else width = "206"
        Case "State": If req Then width = "63" Else width = "38"
        Case "Zip": 
			if req Then width = "146" Else width = "196"
			width = width + q + " convert=" + q + "nvarchar(5)"
        Case Else
            If InStr(fld, "Area") Then If req Then width = "75" Else width = "50"
            If InStr(fld, "Number") Then If req Then width = "110" Else width = "85"
            If InStr(fld, "Ext") Then width = "255"
    End Select
    
    If Len(width) = 0 Then width = "100"
    
    GetComputeWidth = width
    
End Function

Function Getdate(str As String, tag As String) As Date
    Dim idx As Long
    Dim dt As Date
    Dim buf As String
    
    idx = InStr(str, tag)
    If idx > 0 Then
        buf = LTrim(Mid(str, idx + Len(tag) + 1))
        idx = InStr(buf, " ")
        If idx > 0 Then
            If IsDate(Left(buf, idx - 1)) Then dt = Left(buf, idx - 1)
        Else
            If IsDate(buf) Then dt = buf
        End If
    Else
        dt = 0
    End If

    Getdate = dt
    
End Function

Function GetText(str As String, tag As String, str1 As String) As String
    Dim idx As Long
    Dim text As String
    Dim buf As String
    
    idx = InStr(str, tag)
    If idx > 0 Then
        buf = LTrim(Mid(str1, idx + Len(tag) + 1))
        idx = InStr(buf, " ")
        If idx > 0 Then
            text = Left(buf, idx - 1)
        Else
            text = buf
        End If
    Else
        text = ""
    End If

    GetText = text
    
End Function


Sub ClearClipboard()
'
' ClearClipboard Macro
' Macro recorded 2/5/2002 by Bob Wood
'
    Application.ScreenUpdating = False
    Selection.Collapse direction:=wdCollapseStart
    Selection.InsertAfter vbCrLf
    Selection.Cut
    mAttributeID = 0
    Application.ScreenUpdating = True
    
End Sub

Sub AppendClipboard(str As String)
'
' ClearClipboard Macro
' Macro recorded 2/5/2002 by Bob Wood
'
    Dim start As Long
    
    Application.ScreenUpdating = False
    start = Selection.start
    Selection.Collapse direction:=wdCollapseStart
    Selection.Paste
    Selection.SetRange start, Selection.End
    Selection.InsertAfter str
    Selection.Cut
    Application.ScreenUpdating = True
End Sub

Function GetEntityID() As Long
'
' ClearClipboard Macro
' Macro recorded 2/5/2002 by Bob Wood
'
    Dim start As Long
    Dim str As String
    Dim num As String
    
    start = Selection.start
    Selection.Tables(1).Select
    Selection.Tables(1).Rows(1).Cells(1).Select
    str = Selection.text
    Selection.SetRange start, start
    
    If IsNumeric(Left(str, 1)) Then num = Left(str, 1)
    If IsNumeric(Left(str, 2)) Then num = Left(str, 2)
    
    GetEntityID = num

End Function



