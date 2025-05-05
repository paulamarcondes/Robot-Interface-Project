*** Settings ***
Documentation  This file contains the positive Test Cases for the Dispatch tests
Resource       ../resources/dispatch_keywords.robot
Resource       ../resources/dispatch_variables.robot

Suite Setup     Create Fire Dispatch Session
Suite Teardown  Session Exists    fire_dispatch


*** Test Cases ***
Emergency Dispatch
    [Documentation]    Send dispatch with predefined data and validate response
    [Tags]    dispatch    api
    Send Emergency Dispatch
    Check Dispatch Response

Random Dispatch
    [Documentation]    Generate random dispatch data, send it, and validate response
    [Tags]    random    dispatch    api
    Generate Random Dispatch
    Send Random Dispatch
    Check Dispatch Response

Multiple Dispatches by Priority
    [Documentation]    Generate and send dispatches with different priorities and validate response
    [Tags]    multiple    dispatch    api
    Send Multiple Dispatches
    Validate Based on Priority

Validate Response Includes Required Fields
    [Documentation]    Ensure all responses contain mandatory fields like status, id, and timestamp
    [Tags]    validation    multiple    dispatch    api
    Send Multiple Dispatches
    Check Responses for Required Fields