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


# --- Positive Test Keywords ---
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
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Call Method    ${response}    json
    Log    Full response JSON: ${json}
    Should Be Equal As Strings    ${json['status']}    Received
    RETURN FROM KEYWORD    ${json}

Send Multiple Dispatches
    [Arguments]    ${count}=5
    ${responses}=    Create List

    FOR    ${i}    IN RANGE    ${count}
        Generate Random Dispatch
        ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}
        Append To List    ${responses}    ${response}
    END

    Set Suite Variable    ${responses}

Log Priority Message
    [Arguments]    ${priority}    ${incident_id}
    Log    ${priority} priority validated: ${incident_id}

Validate Based on Priority
    ${json}=    Check Dispatch Response

    Should Be Equal As Strings    
    ...    ${json['status']}    Received
    ...    msg=Expected status 'Received' but got '${json['status']}' 

    Log Priority Message    ${payload['priority']}    ${payload['incident_id']}

Log Full Response JSON
    [Arguments]    ${json}
    Log    Full API Response: ${json}    level=INFO

Check Responses for Required Fields
    FOR    ${response}    IN    @{responses}
        ${json}=    Call Method    ${response}    json
        Log Full Response JSON    ${json}

        Dictionary Should Contain Key    ${json}    status

        Log    Response contains expected field: status
    END



# --- Negative Test Keywords ---
Create Incomplete Dispatch 
    ${bad_payload}=    Create Dictionary    incident_id=99999    type=Fire    priority=High
    Log    Created incomplete dispatch payload: ${bad_payload}
    RETURN    ${bad_payload}

Send the Request and Expect Error
    ${bad_payload}=    Create incomplete dispatch
    Run Keyword And Expect Error    HTTPError: 400*
    ...    POST On Session    fire_dispatch    /api/dispatch    json=${bad_payload}

Send Dispatch with Empty or Null Fields
    ${payload}=    Create Dictionary
    ...    incident_id=${EMPTY}
    ...    location=${None}
    ...    type=${EMPTY}
    ...    priority=Medium
    Set Suite Variable    ${payload}

    ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}
    Set Suite Variable    ${response}

    # Run Keyword And Expect Error    HTTPError: 400*
    # ...    POST On Session    fire_dispatch    /api/dispatch    json=${payload}

# Validate 400 Error Response
#     Should Be Equal As Integers    ${response.status_code}    400
#     ${json}=    Call Method    ${response}    json
#     Dictionary Should Contain Key    ${json}    error
#     Log    Error message: ${json['error']}