*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary

*** Variables ***
${BASE_URL}         https://reqres.in/api/users
${VALID_USER_ID}    12
${INVALID_USER_ID}  1234

${EXPECTED_ID}       12
${EXPECTED_EMAIL}    rachel.howell@reqres.in
${EXPECTED_FIRST_NAME}   Rachel
${EXPECTED_LAST_NAME}    Howell
${EXPECTED_AVATAR}  https://reqres.in/img/faces/12-image.jpg

*** Keywords ***
Get User Profile
    [Arguments]    ${user_id}
    ${url}=    Set Variable    ${BASE_URL}/${user_id}
    ${response}=    Get    ${url} 
    [Return]    ${response}

*** Test Cases ***
TC_API_001 Get User Profile Success
    [Documentation]    To verify get user profile API will return correct data when trying to get profile of an existing user
    ${response}=    Get User Profile    ${VALID_USER_ID}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${response_body}=    Convert String To Json    ${response.content}
    Should Be Equal As Numbers    ${response_body['data']['id']}    ${EXPECTED_ID}
    Should Be Equal    ${response_body['data']['email']}    ${EXPECTED_EMAIL}
    Should Be Equal    ${response_body['data']['first_name']}    ${EXPECTED_FIRST_NAME}
    Should Be Equal    ${response_body['data']['last_name']}    ${EXPECTED_LAST_NAME}
    Should Be Equal    ${response_body['data']['avatar']}    ${EXPECTED_AVATAR}

TC_API_002 Get User Profile But User Not Found
    [Documentation]    To verify get user profile API will return 404 when trying to get a profile of a non-existing user
    ${response}=    Get User Profile    ${INVALID_USER_ID}
    Run Keyword And Ignore Error     Should Be Equal As Numbers    ${response.status_code}    404