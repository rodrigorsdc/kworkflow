#!/bin/bash

. ./tests/utils --source-only
. ./kw --source-only > /dev/null

function suite
{
  suite_addTest "testVariables"
  suite_addTest "testExported"
}

function testVariables
{
  VARS=( EASY_KERNEL_WORKFLOW src_script_path external_script_path )
  for v in "${VARS[@]}"; do
    test -z ${!v+x}; assertEquals "Variable $v should exist." $? 1
  done
}

function testExported
{
  VARS=( EASY_KERNEL_WORKFLOW )
  for v in "${VARS[@]}"; do
    [[ $(declare -p $v)  =~ ^declare\ -[aAilrtu]*x[aAilrtu]*\  ]] ||
      fail "Variable $v should have been exported"
  done
}

invoke_shunit
