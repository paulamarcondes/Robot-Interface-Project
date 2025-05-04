*** Settings ***
Documentation   This file contains the Keywords for the Dispatch Tests
Library         RequestsLibrary
Library         Collections
Library         FakerLibrary
Resource        ../resources/dispatch_variables.robot


*** Keywords ***
Create Fire Dispatch Session
    Create Session    fire_dispatch    ${BASE_URL}
    Log    Session created with base URL: ${BASE_URL}

Send Emergency Dispatch
    ${payload}=    Create Dictionary
    ...    incident_id=12345
    ...    location=MainStreet
    ...    type=Accident
    ...    priority=High
    Log    Sending emergency dispatch with payload: ${payload}
    ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}
    Set Suite Variable    ${response}
    Log    Received response with status code: ${response.status_code}
    RETURN    ${response}

Generate Random Dispatch
    ${incident_id}=    RandomNumber    digits=6
    ${location}=       City
    ${type}=           RandomElement    ('Accident', 'Fire', 'Medical', 'Rescue', 'Theft')
    ${priority}=       RandomElement    ('High', 'Medium', 'Low', 'Critical')
    ${payload}=        Create Dictionary
    ...    incident_id=${incident_id}
    ...    location=${location}
    ...    type=${type}
    ...    priority=${priority}
    Log    Generated random dispatch payload: ${payload}
    Set Suite Variable    ${payload}
    RETURN    ${payload}

Send Random Dispatch
    ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}
    Set Suite Variable    ${response}
    Log    Received response with status code: ${response.status_code}

Check Dispatch Response
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    ...    msg=Expected status code 200 but got ${response.status_code}
    ${json}=    Call Method    ${response}    json
    Log    Validating response JSON: ${json}
    Should Be Equal As Strings    
    ...    ${json['status']}    Received
    ...    msg=Expected response status 'Received' but got '${json['status']}'

Create incomplete dispatch 
    ${bad_payload}=    Create Dictionary    incident_id=99999    type=Fire    priority=High
    Log    Created incomplete dispatch payload: ${bad_payload}
    RETURN    ${bad_payload}

Send the request and expect error
    ${bad_payload}=    Create incomplete dispatch
    Run Keyword And Expect Error    HTTPError: 400*
    ...    POST On Session    fire_dispatch    /api/dispatch    json=${bad_payload}