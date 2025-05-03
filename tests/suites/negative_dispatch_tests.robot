*** Settings ***
Library        RequestsLibrary
Library        Collections
Resource       ../resources/dispatch_keywords.robot


*** Variables ***
${BASE_URL}    http://localhost:5000


*** Test Cases ***
Send Incomplete Dispatch (Negative Test)
    [Documentation]    Try sending a dispatch without location and expect error
    Create Fire Dispatch Session
    ${bad_payload}=    Create Dictionary    incident_id=99999    type=Fire    priority=High
    Run Keyword And Expect Error    HTTPError: 400 Client Error: BAD REQUEST*
    ...    POST On Session    fire_dispatch    /api/dispatch    json=${bad_payload}