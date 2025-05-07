*** Settings ***
Documentation    This file contains the negative Test Cases for the Dispatch tests
Resource         resources/dispatch_variables.robot
Resource         resources/dispatch_keywords.robot

Suite Setup      Create Fire Dispatch Session
Suite Teardown   Delete All Sessions


*** Test Cases ***
Incomplete Dispatch
    [Documentation]    Try sending a dispatch without location and expect error
    [Tags]    negative    incomplete    error-handling    dispatch    api
    Send Incomplete Dispatch And Expect Error

Empty or Null Fields
    [Documentation]    Try sending invalid dispatch with empty or null fields and validate error response
    [Tags]    negative    empty    null    dispatch    api
    Send Dispatch with Empty or Null Fields
    Check Dispatch Error Response