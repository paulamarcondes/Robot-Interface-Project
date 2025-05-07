*** Settings ***
Documentation   This file contains the Keywords for the Dispatch Tests
Library         RequestsLibrary
Library         Collections
Library         FakerLibrary
Resource        ../resources/dispatch_variables.robot


*** Keywords ***

# --- Session Keywords ---
Create Fire Dispatch Session
    Create Session    fire_dispatch    ${BASE_URL}
    Log    Session created with base URL: ${BASE_URL}



# --- Helper Keywords ---
Create Emergency Dispatch Payload
    ${payload}=    Create Dictionary
    ...    incident_id=12345
    ...    location=MainStreet
    ...    type=Accident
    ...    priority=High
    Log    Created emergency dispatch payload: ${payload}
    RETURN    ${payload}

Generate Random Dispatch Payload
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
    RETURN    ${payload}

Send Dispatch And Return Response
    [Arguments]    ${payload}
    ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}
    Log    Sent dispatch with payload: ${payload}
    Log    Received response with status code: ${response.status_code}
    RETURN    ${response}

Log Full Response JSON
    [Arguments]    ${json}
    Log    Full API Response: ${json}    level=INFO



# --- Positive Test Keywords ---
Send Emergency Dispatch
    ${payload}=    Create Emergency Dispatch Payload
    ${response}=   Send Dispatch And Return Response    ${payload}
    Set Suite Variable    ${response}

Generate And Send Random Dispatch
    ${payload}=    Generate Random Dispatch Payload
    ${response}=   Send Dispatch And Return Response    ${payload}
    Set Suite Variable    ${response}

Send Multiple Dispatches
    [Arguments]    ${count}=5
    ${responses}=    Create List
    FOR    ${i}    IN RANGE    ${count}
        ${payload}=    Generate Random Dispatch Payload
        ${response}=   Send Dispatch And Return Response    ${payload}
        Append To List    ${responses}    ${response}
    END
    Set Suite Variable    ${responses}

Check Dispatch Response
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    Call Method    ${response}    json
    Log Full Response JSON    ${json}
    Should Be Equal As Strings    ${json['message']}    Dispatch created

Check Based on Priority
    ${json}=    Call Method    ${response}    json
    Should Be Equal As Strings    ${json['message']}    Dispatch created
    Log    Priority validated: ${json['data']['priority']} for incident ${json['data']['incident_id']}

Check Responses for Required Fields
    FOR    ${response}    IN    @{responses}
        ${json}=    Call Method    ${response}    json
        Log Full Response JSON    ${json}
        Dictionary Should Contain Key    ${json}    data
        Log    Response contains expected field: data
    END



# --- Negative Test Keywords ---
Create Incomplete Dispatch Payload
    ${payload}=    Create Dictionary
    ...    incident_id=99999
    ...    type=Fire
    ...    priority=High
    Log    Created incomplete dispatch payload: ${payload}
    RETURN    ${payload}

Send Incomplete Dispatch And Expect Error
    ${payload}=    Create Incomplete Dispatch Payload
    Run Keyword And Expect Error    HTTPError: 400*    POST On Session    fire_dispatch    /api/dispatch    json=${payload}

Send Dispatch With Empty Or Null Fields
    ${payload}=    Create Dictionary
    ...    incident_id=${EMPTY}
    ...    location=${None}
    ...    type=${EMPTY}
    ...    priority=Medium
    ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}    expected_status=any
    Set Suite Variable    ${response}

Check Dispatch Error Response
    Should Be Equal As Integers    ${response.status_code}    400
    ${json}=    Call Method    ${response}    json
    Log    Full error response: ${json}
    Dictionary Should Contain Key    ${json}    error
    Should Contain    ${json['error']}    Missing or empty field