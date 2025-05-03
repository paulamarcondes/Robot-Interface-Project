*** Settings ***
Library        RequestsLibrary
Library        Collections
Resource       ../resources/dispatch_keywords.robot


*** Variables ***
${BASE_URL}    http://localhost:5000


*** Test Cases ***
Send Emergency Dispatch
    [Documentation]    Send a dispatch to the mock server and check the response
    Create Fire Dispatch Session
    ${response}=    Send Dispatch    12345    MainStreet    Accident    High
    Should Be Equal As Strings    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    status
    Should Be Equal As Strings    ${response.json()['status']}    Received