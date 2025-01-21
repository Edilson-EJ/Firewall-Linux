# Configuração de Firewall com IPTables no Linux

Este projeto apresenta um script de configuração de firewall utilizando o `iptables` em um ambiente Linux. Ele foi desenvolvido para proteger servidores, restringindo e permitindo acessos de forma controlada com base em protocolos, portas e origens.

---

## 🎯 **Objetivo**

O objetivo deste projeto é criar um firewall funcional, que siga boas práticas de segurança e seja facilmente gerenciável. O script possibilita:

- Permitir acessos apenas às portas e protocolos necessários.
- Bloquear conexões indesejadas.
- Garantir que as regras sejam carregadas automaticamente ao iniciar o sistema.

---

## ⚙️ **Requisitos**

Antes de utilizar o script, certifique-se de que o sistema atende aos seguintes requisitos:

- Sistema operacional Linux (testado no Ubuntu Server).
- `iptables` instalado (geralmente pré-instalado em distribuições Linux).
- Permissão de administrador (`root`).

---

## 📝 **Como Usar**

## 1. Clone o repositório

     git clone https://github.com/seu-usuario/firewall-iptables.git

cd firewall-iptables

## 2. Edite o script, se necessário

Abra o script firewall.sh e ajuste as configurações conforme suas necessidades:

- Alterar as redes (192.168.0.0/24).
- Adicionar ou remover portas/protocolos.

## 3. Torne o script executável

        chmod +x firewall.sh

## 4. Execute o script

Para gerenciar o firewall, utilize os seguintes comandos:

- Iniciar o firewall:

        sudo ./firewall.sh start

- Parar o firewall:

        sudo ./firewall.sh stop

- Reiniciar o firewall:

        sudo ./firewall.sh restart

## 🔒 Portas e Protocolos Configurados

### Portas TCP/LAN

| Porta | Protocolo | Descrição                 |
| ----- | --------- | ------------------------- |
| 21    | FTP       | Transferência de Arquivos |
| 22    | SSH       | Acesso Remoto Seguro      |
| 80    | HTTP      | Navegação Web             |
| 443   | HTTPS     | Navegação Segura          |

### Portas UDP/LAN

| Porta | Protocolo | Descrição              |
| ----- | --------- | ---------------------- |
| 53    | DNS       | Resolução de Nomes     |
| 123   | NTP       | Sincronização de Tempo |

### 💡 Dicas

- Verifique as regras aplicadas com:

        sudo iptables -L -v -n

- Para salvar regras persistentes, instale o iptables-persistent:

        sudo apt install iptables-persistent
        sudo netfilter-persistent save

## 🛠️ Contribuição

Se você encontrar problemas ou quiser melhorar este projeto, fique à vontade para abrir um Pull Request ou enviar sugestões na aba Issues.

# 🖥️ Autor

Desenvolvido por Edilson de França.
Se tiver dúvidas, entre em contato comigo: edilson.franca.melo@gmail.com.
