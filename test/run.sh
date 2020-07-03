#!/bin/sh

mktmpdir() {
  dir=$(mktemp -t testXXXXX)
  rm -rf $dir
  mkdir $dir
  echo $dir
}

main() {
  bp_dir=$(mktmpdir)
  compile_dir=$(mktmpdir)
  env_dir=$(mktmpdir)
  cp -a "$(pwd)"/* ${bp_dir}
  ${bp_dir}/bin/compile ${compile_dir} ${2:-$(mktmpdir)} $env_dir
}

main