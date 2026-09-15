import socket

HOST = 'localhost'
PORT = 5000

cliente = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
cliente.connect((HOST, PORT))
print("[+] Conectado ao servidor!")

mensagem = "Solicitando acesso ao sistema..."
cliente.send(mensagem.encode('utf-8'))

resposta = cliente.recv(1024).decode('utf-8')
print(f"[+] Resposta do Servidor: {resposta}")

cliente.close()