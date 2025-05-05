*** Settings ***
Documentation  This file contains the negative Test Cases for the Dispatch tests
Resource       ../resources/dispatch_keywords.robot
Resource       ../resources/dispatch_variables.robot

Suite Setup     Create Fire Dispatch Session
Suite Teardown  Session Exists    fire_dispatch


*** Test Cases ***
Incomplete Dispatch (Negative Test)
    [Documentation]    Try sending a dispatch without location and expect error
    [Tags]    negative    incomplete    error-handling    dispatch    api
    Create Incomplete Dispatch
    Send the Request and Expect Error

Empty or Null Fields
    [Documentation]    Try sending invalid dispatch with empty or null fields and validate error response
    [Tags]    negative    empty    null    dispatch    api
    Send Dispatch with Empty or Null Fields
    # Validate 400 Error Response
    Check Dispatch Response