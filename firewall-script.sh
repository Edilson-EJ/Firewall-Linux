#!/bin/bash

# Funções para iniciar e parar o firewall
iniciar() {
    echo "Iniciando execução do firewall"

    # Limpar regras existentes
    iptables -F
    iptables -X
    iptables -Z

    # Definir políticas padrão
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT

    # Permitir tráfego local (loopback)
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT

    # Permitir conexões já estabelecidas
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

    # TCP/LAN
    iptables -A INPUT -p tcp --dport 21 -s 192.168.0.0/24 -j ACCEPT  # FTP
    iptables -A INPUT -p tcp --dport 22 -s 192.168.0.0/24 -j ACCEPT  # SSH
    iptables -A INPUT -p tcp --dport 80 -s 192.168.0.0/24 -j ACCEPT  # HTTP
    iptables -A INPUT -p tcp --dport 443 -s 192.168.0.0/24 -j ACCEPT # HTTPS
    iptables -A INPUT -p tcp --dport 465 -s 192.168.0.0/24 -j ACCEPT # SMTPS
    iptables -A INPUT -p tcp --dport 1723 -s 192.168.0.0/24 -j ACCEPT # PPTP
    iptables -A INPUT -p tcp --dport 3389 -s 192.168.0.0/24 -j ACCEPT # RDP
    iptables -A INPUT -p tcp --dport 5222 -s 192.168.0.0/24 -j ACCEPT # XMPP
    iptables -A INPUT -p tcp --dport 8080 -s 192.168.0.0/24 -j ACCEPT # HTTP-ALT
    iptables -A INPUT -p tcp --dport 8999 -s 192.168.0.0/24 -j ACCEPT # HOD-SERPRO
    iptables -A INPUT -p tcp --dport 9000 -s 192.168.0.0/24 -j ACCEPT # SSH-ALT
    iptables -A INPUT -p tcp --dport 9001 -s 192.168.0.0/24 -j ACCEPT # HTTPS-ALT
    iptables -A INPUT -p tcp --dport 23000 -s 192.168.0.0/24 -j ACCEPT # SERPRO-TELNETS

    # UDP/LAN
    iptables -A INPUT -p udp --dport 53 -s 192.168.0.0/24 -j ACCEPT   # DNS
    iptables -A INPUT -p udp --dport 123 -s 192.168.0.0/24 -j ACCEPT  # NTP
    iptables -A INPUT -p udp --dport 161 -s 192.168.0.0/24 -j ACCEPT  # SNMP
    iptables -A INPUT -p udp --dport 162 -s 192.168.0.0/24 -j ACCEPT  # SNMP-TRAP
    iptables -A INPUT -p udp --dport 500 -s 192.168.0.0/24 -j ACCEPT  # ISAKMP
    iptables -A INPUT -p udp --dport 8999 -s 192.168.0.0/24 -j ACCEPT # SERPRO-HOD

    # TCP/WAN
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
    iptables -A INPUT -p tcp --dport 1723 -j ACCEPT # PPTP
    iptables -A INPUT -p tcp --dport 9000 -j ACCEPT # SSH-ALT
    iptables -A INPUT -p tcp --dport 9001 -j ACCEPT # HTTPS-ALT
    iptables -A INPUT -p tcp --dport 3389 -j ACCEPT # RDP

    # UDP/WAN
    iptables -A INPUT -p udp --dport 161 -j ACCEPT  # SNMP
    iptables -A INPUT -p udp --dport 162 -j ACCEPT  # SNMP-TRAP

    
    echo "Regras aplicadas com sucesso."
}

parar() {
    echo "Parando execução do firewall"

    # Limpar todas as regras e definir política padrão para ACCEPT
    iptables -F
    iptables -X
    iptables -Z
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT

    echo "Firewall desativado."
}

# Lógica para processar os parâmetros do script
case "$1" in 
    start)
        iniciar
        ;;
    stop)
        parar
        ;;
    restart)
        parar
        iniciar
        ;;
    *)
        echo "Uso: $0 {start|stop|restart}"
        exit 1
        ;;
esac
