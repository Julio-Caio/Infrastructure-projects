# OpenVPN Lab - Static Key

**Requisitos**:

- Vagrant 2.3.x
- VMware ou VirtualBox
- Docker & Docker-compose 2.39.x

```bash
    vagrant up
```
ou 

```bash
   vagrant up --provider=vmware_desktop ## VMWare
```

## 1. Configurando o setup

### 1.1. Instalando as dependências

```bash
dnf install -y tcpdump openvpn
```

### 1.2. Gerar chave simétrica

```bash
openvpn --genkey --secret static.key
```

### 1.3. Criar arquivos de configuração

**/etc/openvpn/server/server.conf**
```bash
dev tun
ifconfig 10.8.0.1 10.8.0.2
secret static.key
cipher AES-128-CBC
user nobody
group nobody
```

**/etc/openvpn/client/client.conf**
```bash
remote <IP do Servidor>
dev tun
ifconfig 10.8.0.2 10.8.0.1
secret static.key
cipher AES-128-CBC
user nobody
group nobody
```
<hr>

## 2. Iniciar e Verificar conexão

### 2.1 Inicie o serviço:
**No servidor**:
```bash
    sudo openvpn --config /etc/openvpn/server/server.conf
```
<hr>

**No cliente**:
```bash
    sudo openvpn --config /etc/openvpn/client/client.conf
```

### 2.2 Configuração do firewall

```bash
sudo firewall-cmd --add-port=1194/udp --permanent
sudo firewall-cmd --reload
```

### 2.3 Verifique se o serviço está rodando:

```bash
sudo netstat -tulnp | grep openvpn
udp        0      0 0.0.0.0:1194            0.0.0.0:*                           5083/openvpn
```
<hr>

### 2.4 Iniciar Conexão com o server

**No servidor**:

```bash
sudo openvpn --config /etc/openvpn/server/server.conf
```

**No cliente**:

```bash
sudo openvpn --config /etc/openvpn/client/client.conf
```
<hr>

### Testar conexão

No **servidor e cliente**, verifique se a interface tun0 foi criado corretamente e possuem os IPs definidos:

```bash
ifconfig | grep tun
...

tun0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1500

```

<hr>

No **cliente**, faça um ping para o IP do servidor:

```bash
    ping 10.8.0.1
```

Verifique se o teste foi bem sucedido.