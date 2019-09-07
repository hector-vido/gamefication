#!/bin/bash

cat <<EOF
###############################
#     Bem vindo ao Gamefy!    #
###############################
EOF

if [ ! -f /home/vagrant/.gamefy ]; then
	read -p 'Digite o nome do seu usuário: ' NOME
	echo -e "nome=$NOME\nhost=$HOSTNAME" > /home/vagrant/.gamefy
fi

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
4 - O usuário "suporte" que possuía a senha "Abc123!" desapareceu.
5 - Um pequeno serviço chamado "rotina.sh" em /usr/local/bin parou de executar a toda meia-noite.

Acompanharemos sua resolução, basta executar este script cada vez que desejar validar os passos.
EOF

cat <<EOF

Validando...

EOF
sleep 2

cat <<EOF
###############################
#    Você encontrou o vim?    #
###############################
EOF
if [ -z "$(which vim)" ]; then
	echo 'Ops... parece que não, o vim ainda não está disponível.'
	exit 1
fi

cat <<EOF

Oba! Com o vim instalado ficará bem mais fácil seguir adiante!

EOF

cat <<EOF
###############################
#   O apache está rodando?    #
###############################
EOF
wget --quiet --spider localhost
if [ "$?" != 0 ]; then
	echo 'Eita... testamos daqui e não parece que o apache está funcionando.'
	exit 1
fi

cat <<EOF

Funcionou! O apache está respondendo!

EOF

cat <<EOF
#######################################
#   O acesso do root foi bloqueado?   #
#######################################

Estamos testando o acesso do root... pode ser que apareça alguma coisa na sua tela.
EOF
sshpass -p '123' ssh -o stricthostkeychecking=no root@localhost exit 0
if [ "$?" == 0 ]; then
	echo 'Olha, nossa equipe relatou que o acesso do root continua liberado!'
	exit 1
fi

cat <<EOF

Perfeito, finalmente eliminamos essa grande vulnerabilidade!

EOF
