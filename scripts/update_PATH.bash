#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou


#updating PATH in shell configuration

shell_f=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${shell_f}rc"

line=$(grep -E ".*export.*PATH=.*/goinfre/\.brew/bin.*" < "$shell_f")

if [[ "$line" != *export*'PATH='*'/goinfre/.brew/bin'* || "$line" =~ .*\#.*export.*'PATH='.*'/goinfre/.brew/bin'.* ]]; then
	echo "export PATH=$HOME/goinfre/.brew/bin:$PATH" >> "$shell_f"
fi
