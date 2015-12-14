#!/bin/bash

sudo mkdir -p /etc/ansible
printf '[vagrant]\nlocalhost\n' | sudo tee /etc/ansible/hosts > /dev/null

if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    export PATH=$PATH:/usr/local/bin
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
