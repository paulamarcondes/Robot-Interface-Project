*** Settings ***
Documentation  This file contains the negative Test Cases for the Dispatch tests
Resource       ../resources/dispatch_keywords.robot
Resource       ../resources/dispatch_variables.robot

Suite Setup     Create Fire Dispatch Session
Suite Teardown  Session Exists    fire_dispatch


*** Test Cases ***
Send Incomplete Dispatch (Negative Test)
    [Documentation]    Try sending a dispatch without location and expect error
    [Tags]    negative    dispatch    api
    Create incomplete dispatch
    Send the request and expect error