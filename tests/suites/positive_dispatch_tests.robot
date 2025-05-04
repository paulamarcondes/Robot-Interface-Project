*** Settings ***
Documentation  This file contains the positive Test Cases for the Dispatch tests
Resource       ../resources/dispatch_keywords.robot
Resource       ../resources/dispatch_variables.robot

Suite Setup     Create Fire Dispatch Session
Suite Teardown  Session Exists    fire_dispatch


*** Test Cases ***
Send Emergency Dispatch
    [Documentation]    Send dispatch with predefined data and validate response
    [Tags]    dispatch    api
    Send Emergency Dispatch
    Check Dispatch Response

Send Random Dispatch
    [Documentation]    Genarate random dispatch data, send it, and validate response
    [Tags]    dispatch    api
    Generate Random Dispatch
    Send Random Dispatch
    Check Dispatch Response