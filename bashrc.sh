# append to .bashrc

# User specific aliases and functions

## Exports for a colorful terminal and the pre-cursor text format
## \u - user name
## \h - short hostname
## \W - current working dir
## \? - exit status of the command

## \H: Display FQDN hostname.
## \@: Display current time in 12-hour am/pm format

## \e[ : Start color scheme.
## x;y : Color pair to use (x;y)
## $PS1 : Your shell prompt variable.
## \e[m : Stop color scheme.

## Black       0;30     Dark Gray     1;30
## Blue        0;34     Light Blue    1;34
## Green       0;32     Light Green   1;32
## Cyan        0;36     Light Cyan    1;36
## Red         0;31     Light Red     1;31
## Purple      0;35     Light Purple  1;35
## Brown       0;33     Yellow        1;33
## Light Gray  0;37     White         1;37
# export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' # ubuntu; e.g., wenching@wenching-VirtualBox:~$
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\\$\[\e[m\] "
# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad

# User specific aliases and functions

ncol()
{
    if [ $# -eq 0 ]; then
        echo "USAGE: ncol INFILE"
    else
        res=$(awk -F '\t' 'NR==1{print NF}' $1)
        echo "${res}"
    fi
}

export PATH="/home/wenching/.local/bin:${PATH}"

# FastQC

export PATH="/home/wenching/Tools/FastQC/CURRENT:${PATH}"

# WDL/Cromwell

export WDLTOOLS="/media/sf_shared/WDL"

export WDLEXE="java -jar $WDLTOOLS/wdltool.jar"
export WOMEXE="java -jar $WDLTOOLS/womtool.jar"
export CWEXE="java -jar $WDLTOOLS/cromwell.jar"

# Go Programming Language [Dependency of Signularity]

export GOPATH="${HOME}/go"
export PATH="/home/wenching/Tools/Go/CURRENT/bin:${GOPATH}/bin:${PATH}"

echo $WDLEXE
echo $CWEXE
echo $PATH

