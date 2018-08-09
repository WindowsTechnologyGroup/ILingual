@echo off

CALL CompilePgm.bat C WinTech  WinTech  wtOldSystem
CALL CompilePgm.bat C WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiCommon  WinTech/ILingual/wtiCommon  wtiCommon_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiTable  WinTech/ILingual/wtiTable  wtiTable_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiUser  WinTech/ILingual/wtiUser  wtiUser_logUser
CALL CompilePgm.bat C WinTech\ILingual\wtiOldApplication  WinTech/ILingual/wtiOldApplication  wtiOldAppl_logBusn
CALL CompilePgm.bat C WinTech\ILingual\wtiOldApplication  WinTech/ILingual/wtiOldApplication  wtiOldAppl_logUser
CALL CompilePgm.bat A WinTech\ILingual  WinTech/ILingual  wtiOldLingual