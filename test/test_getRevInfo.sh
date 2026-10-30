#!/bin/bash
# Checks that getRevInfo.sh writes well-formed ST string literals for hostile values.
# Usage: bash test/test_getRevInfo.sh

SRC="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)/src/Ar/RevInfo/getRevInfo.sh"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
cd "$WORK" || exit 1

git init -q
git -c user.name="O'Brien \$x Åsa" -c user.email=a@b commit -q --allow-empty -m init
git checkout -q -b "feat/it's\$money"
tr -d '\r' < "$SRC" > getRevInfo.sh

fail=0
long=$(printf 'a%.0s' {1..100})
dollars=$(printf '$%.0s' {1..100})

# Undo ST escapes so we can compare against the expected value
unescape() { sed -e "s/\\\$'/'/g" -e 's/\$\$/$/g'; }

check() {
	local name="$1" expect="$2" line lit val
	line=$(grep -E "^[[:space:]]$name :" RevInfo.var)
	lit=${line#*:= \'}
	lit=${lit%\';}
	# Any ' must be escaped, and any $ must start $$ or $'
	if printf '%s' "$lit" | sed -e "s/\\\$'//g" -e 's/\$\$//g' | grep -q "[\$']"; then
		echo "FAIL $name: malformed literal: $line"; fail=1; return
	fi
	val=$(printf '%s' "$lit" | unescape)
	if [ ${#val} -gt 80 ]; then
		echo "FAIL $name: ${#val} characters: $line"; fail=1; return
	fi
	if printf '%s' "$val" | LC_ALL=C grep -q '[^ -~]'; then
		echo "FAIL $name: non-printable or non-ASCII: $line"; fail=1; return
	fi
	if [ -n "$expect" ] && [ "$val" != "$expect" ]; then
		echo "FAIL $name: got '$val', expected '$expect'"; fail=1; return
	fi
}

run() {
	AS_CONFIGURATION="$2" AS_USER_NAME="$1" bash getRevInfo.sh
	check builder "$3"
	check buildConfiguration "$4"
	check revisionAuthor "O'Brien \$x ?sa"
	check branchName "feat/it's\$money"
}

run 'PC$'                          Intel 'PC$'                         Intel
run "O'Brien"                      Intel "O'Brien"                     Intel
run 'a$Nb'                         Intel 'a$Nb'                        Intel
run '-n'                           Intel '-n'                          Intel
run '$(touch PWNED)'               Intel '$(touch PWNED)'              Intel
run "x';evil:BOOL;y:STRING[1]:='"  Intel "x';evil:BOOL;y:STRING[1]:='" Intel
run "$long"                        "$dollars" "${long:0:80}"           "${dollars:0:80}"
run $'tab\there\nnew'              Intel 'tabherenew'                  Intel
run 'Jens Åsa 日本'                 Intel 'Jens ?sa ??'                 Intel

[ -e PWNED ] && { echo "FAIL shell command ran from AS_USER_NAME"; fail=1; }
[ $fail -eq 0 ] && echo "PASS" || exit 1
