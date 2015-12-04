#!/bin/bash

clear
echo "Prepare for provisioning ..."

if [ ! -f /root/.ansible/INSTALLED ]; then
    sudo yum update -y ca-certificates > /dev/null 2>&1
    sudo yum -y install epel-release > /dev/null 2>&1
    sudo yum update > /dev/null 2>&1
    sudo yum install -y python-devel python-pip libselinux-python > /dev/null 2>&1
    sudo pip install --upgrade pip > /dev/null 2>&1
    sudo pip install ansible > /dev/null 2>&1

    sudo mkdir -p /etc/ansible
    printf '[vagrant]\nlocalhost\n' | sudo tee /etc/ansible/hosts > /dev/null

    sudo mkdir -p /root/.ansible
    touch /root/.ansible/INSTALLED
fi

clear
cat << "EOF"

                                    .----:--::--....--:/.:/-:-.
                               `-:::-```                    ` .:--:-
                           `--:.``                                `.::--
                        `-/-`                                         `.::-
                     `-+-`                                               `.:/`
                   `/+`                                                     `-/-
                 `::`                                                         `-+-
               `//`                                                             `:/`
              -/.                                ...                              `:/
             ::                                -hmNmy`                              -+`
           `+-                                `mMMMMMy                               `+.
          `/`                                `hMMMMMMMo                                /:
         `s`                                 sMMMMMMMMM:                                +:
        `+`                                 +MMMMMNMMMMN.                                o`
        +.                                 :MMMMMd-NMMMMm`                                s`
       -/                                 .NMMMMN. :MMMMMh                                .+
       s                                 `dMMMMM:   oMMMMMo                                o`
      .:                                 yMMMMMo     hMMMMM/                               `+
      +                                 oMMMMMh      `mMMMMM-                               o
      s                                :MMMMMm`       .NMMMMm`                              :.
      +                               .NMMMMM-         :MMMMMd                              `o
      :                              `mMMMMMMy:         oMMMMMy                              o
      :                              hMMMMMMMMMm+`       hMMMMM+                             +
      :                             sMMMMMmNMMMMMMy:     `mMMMMM:                            o
      +                            /MMMMMN.`+dMMMMMMm+`   -MMMMMN.                          .o
      s                           -MMMMMM:    -yMMMMMMNy:  /MMMMMd`                         /
      o`                         .NMMMMM+       `+mMMMMMMd+.oMMMMMh                         o
      `+                        `dMMMMMy          `:hMMMMMMNyNMMMMMo                       ./
       +`                       yMMMMMm`             .omMMMMMMMMMMMM/                      s
       `o                      oMMMMMN.                `/hMMMMMMMMMMN-                    :/
        /:                    :MMMMMM/                   `-sNMMMMMMMMm`                  .o
         /-                  .NMMMMMo                       .+dMMMMMMMs                 `+`
          /-                `mMMMMMh                          `:yNMMMN+                `o`
           /:               `------`                             ./+/.                .+`
            :/                                                                       -+`
             .+.                                                                   `/:
              `::`                                                                -+.
                -+-                                                             .:.
                  -/-`                                                        .:/`
                    -/:.                                                   `-/-
                      `-/-`                                             `./:.
                         --/-`                                       `.:::
                            `--:-``                             ``-//:-
                                `----:-` ``              ```.:::-:`
                                      .-.:-./::-----:::.----.

EOF

echo "Running provisioner: ansible"
ansible-galaxy install geerlingguy.repo-remi
PYTHONUNBUFFERED=1 ansible-playbook -c local /vagrant/ansible/site.yml
