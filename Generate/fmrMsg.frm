VERSION 5.00
Begin VB.Form frmMsg 
   Caption         =   "Message"
   ClientHeight    =   5520
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6930
   Icon            =   "fmrMsg.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5520
   ScaleWidth      =   6930
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtMsg 
      Height          =   5475
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Text            =   "fmrMsg.frx":0442
      Top             =   0
      Width           =   6885
   End
End
Attribute VB_Name = "frmMsg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Resize()
   
   If Me.ScaleHeight > 0 Then
      txtMsg.Move 0, 0, Me.ScaleWidth, Me.ScaleHeight
   End If

End Sub
