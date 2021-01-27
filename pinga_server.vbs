on error resume next

Public Sub Grava(comp)
 Const ForAppending = 8


'Colocar o local onde irá salvar o log 
arq_ext = "C:\ProgramData\resultado.log"
 Set fso = CreateObject("Scripting.FileSystemObject")
 Set arq_int = fso.OpenTextFile(arq_ext , ForAppending, true)
 arq_int.write (comp & vbcrlf)
 arq_int.close
End Sub

Public Sub Ping()

data = now()

'Colocar o IP que deseja realizar o PING
aMachines = ("192.168.120.141")

Set objPing = GetObject("winmgmts:{impersonationLevel=impersonate}")._
        ExecQuery("select * from Win32_PingStatus where address = '"& amachines & "'")
    
    For Each objStatus in objPing
     
      If IsNull(objStatus.StatusCode) or objStatus.StatusCode<>0 Then 
   
   result = ("Conexao falhou - " & data)

   grava(result)
  
 else
 
   result = ("OK - " &  data)

   'grava(result)
  
    
 
 end if 
 
 next
 
End Sub

Do
 While Counter < 2
  Ping()
  Counter = Counter + 1
'Definir de quanto em quanto tempo será executado, para cinco minutos alterar o valor abaixo para 300000
  wscript.sleep (1000)
 Wend
 Counter = 0
Loop Until Counter = 2


