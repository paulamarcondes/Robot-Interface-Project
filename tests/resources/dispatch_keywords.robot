*** Settings ***
Library        RequestsLibrary
Library        Collections


*** Variables ***
${BASE_URL}    http://localhost:5000


*** Keywords ***
Create Fire Dispatch Session
    [Documentation]    Create a session to dispatch API
    Create Session    fire_dispatch    ${BASE_URL}

Send Dispatch
    [Documentation]    Send a dispatch to the mock server
    [Arguments]    ${incident_id}    ${location}    ${type}    ${priority}
    ${payload}=    Create Dictionary    incident_id=${incident_id}    location=${location}    type=${type}    priority=${priority}
    ${response}=    POST On Session    fire_dispatch    /api/dispatch    json=${payload}
    [Return]    ${response}

# Send Bad Dispatch
#     [Documentation]    Send a wrong dispatch to the mock server (in case you want to use this code)
#     [Arguments]    ${incident_id}    ${type}    ${priority}
#     ${bad_payload}=    Create Dictionary    incident_id=${incident_id}    type=${type}    priority=${priority}

