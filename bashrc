alias ls='exa'
alias ll='ls -lh'
alias la='ls -alh'

f() {
  local file
  q=$1

  file=$(ag -l -g ""| fzf --query="$q" --select-1 --exit-0 -x)
  if [ -n "$file" ] ;then
    code "$file"
  fi
}
fd() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
fs(){
  local file
  q=$1
  if [ -z "$q"] ;then
    q="."
  fi
  result=$(ag "$q" | fzf)
  IFS=':' read file line other <<< "$result"
  [ -n "$file" ] && code -g "$file":"$line";
}
