#!/bin/bash

cat <<EOF
###############################
#     Bem vindo ao Gamefy!    #
###############################
EOF

if [ ! -f /root/.gamefy ]; then
	read -p 'Digite o nome do seu usuário: ' NOME
	echo -e "NOME='$NOME'" > /root/.gamefy
fi

source /root/.gamefy

clear

cat <<EOF
###############################
#           Tarefas           #
###############################

Um dos nossos clientes está fazendo várias reclamações sobre esta máquina na cloud.
Por favor, você é a nossa única esperança. A lista de tarefas a serem verificadas é a seguinte:

1 - O editor "vim" sumiu.
2 - O "apache" não está iniciando.
3 - O login do usuário root via ssh está funcionando com a senha "123"! Isso deveria estar bloqueado.
4 - O usuário "suporte" que possuía a senha "Abc123!" desapareceu, precisamos dele para os acessos ssh.
5 - Um pequeno serviço chamado "rotina.sh" em /usr/local/bin parou de executar a toda meia-noite.

Acompanharemos sua resolução, basta executar este script cada vez que desejar validar os passos.
EOF

cat <<EOF

Validando...

EOF
sleep 2

cat <<EOF
###################################
#    1 - Você encontrou o vim?    #
###################################
EOF
if [ -z "$(which vim)" ]; then
	echo -e '\nOps... parece que não, o vim ainda não está disponível.'
	exit 1
fi

cat <<EOF

Oba! Com o vim instalado ficará bem mais fácil seguir adiante!

EOF
curl -s -X POST -H 'Content-Type: application/json' https://hectorvido.dev -d "{\"name\" : \"$NOME\", \"hostname\" : \"$HOSTNAME\", \"task\" : 0}"

cat <<EOF
###################################
#   2 - O apache está rodando?    #
###################################
EOF
wget --quiet --spider localhost
if [ "$?" != 0 ]; then
	echo -e '\nEita... testamos daqui e não parece que o apache está funcionando.'
	exit 1
fi

cat <<EOF

Funcionou! O apache está respondendo!

EOF
curl -s -X POST -H 'Content-Type: application/json' https://hectorvido.dev -d "{\"name\" : \"$NOME\", \"hostname\" : \"$HOSTNAME\", \"task\" : 1}"

cat <<EOF
###########################################
#   3 - O acesso do root foi bloqueado?   #
###########################################

Estamos testando o acesso do root... pode ser que apareça alguma coisa na sua tela.
EOF
sshpass -p '123' ssh -o stricthostkeychecking=no root@localhost exit 0
if [ "$?" == 0 ]; then
	echo -e '\nOlha, nossa equipe relatou que o acesso do root continua liberado!'
	exit 1
fi

cat <<EOF

Perfeito, finalmente eliminamos essa grande vulnerabilidade!

EOF
curl -s -X POST -H 'Content-Type: application/json' https://hectorvido.dev -d "{\"name\" : \"$NOME\", \"hostname\" : \"$HOSTNAME\", \"task\" : 2}"

cat <<EOF
###########################################
#   4 - O usuário suporte foi recriado?   #
###########################################

Estamos testando o acesso do usuário suporte... não desligue a máquina.
EOF
sshpass -p 'Abc123!' ssh -o stricthostkeychecking=no suporte@localhost exit 0
if [ "$?" != 0 ]; then
	echo -e '\nNossas rotinas automatizadas não conseguiram se conectar com "suporte".'
	exit 1
fi

cat <<EOF

Valeu! Agora nosso scripts automatizados poderão reverter boa parte da situação!

EOF
curl -s -X POST -H 'Content-Type: application/json' https://hectorvido.dev -d "{\"name\" : \"$NOME\", \"hostname\" : \"$HOSTNAME\", \"task\" : 3}"

cat <<EOF
################################################################
#   5 - Você sabe porque o serviço não está rodando à 00:00?   #
################################################################
EOF
grep -Eo '^\s*00\s*00\s*\*\s*\*\s*\*\s*\w*\s*(bash)?\s*/usr/local/bin/rotina.sh.*' /etc/crontab > /dev/null
if [ "$?" != 0 ]; then
	if [ -f /var/spool/cron/crontabs/root ]; then
		grep -Eo '^\s*00\s*00\s*\*\s*\*\s*\*\s*(bash)?\s*/usr/local/bin/rotina.sh.*' /var/spool/cron/crontabs/root > /dev/null
		if [ "$?" != 0 ]; then
			echo -e '\nVamos avançar no tempo... já passou da meia noite e a rotina ainda não rodou.'
			exit 1
		fi
	fi
fi

cat <<EOF

Muito bom! Agora o sistema será atualizado automaticamente toda meia-noite!

EOF
curl -s -X POST -H 'Content-Type: application/json' https://hectorvido.dev -d "{\"name\" : \"$NOME\", \"hostname\" : \"$HOSTNAME\", \"task\" : 4}"

cat <<EOF
##################################################
#   Parabéns, você concluiu todas as 5 tarefas   #
#   Agora podemos lhe dar o título de SysAdmin!  #
##################################################

EOF
