*** Settings ***
Library    SeleniumLibrary
Suite Setup      Open Browser    ${URL}      ${BROWSER}
Suite Teardown   Close Browser

*** Variables ***
${URL}                  http://the-internet.herokuapp.com/login
${BROWSER}              headlesschrome
${VALID_USERNAME}       tomsmith
${VALID_PASSWORD}       SuperSecretPassword!
${INVALID_USERNAME}     tomholland
${INVALID_PASSWORD}     Password!
${ERROR_MESSAGE_INVALID_PASSWORD}    Your password is invalid!
${ERROR_MESSAGE_INVALID_USERNAME}    Your username is invalid!
${SUCCESS_MESSAGE_LOGIN}      You logged into a secure area!
${SUCCESS_MESSAGE_LOGOUT}     You logged out of the secure area!
${TITLE_LOGIN_PAGE}    Login Page

${TEXTBOX_USERNAME}    id=username
${TEXTBOX_PASSWORD}    id=password
${BUTTON_LOGIN}     //i[contains(text(), " Login")]
${BUTTON_LOGOUT}    //i[contains(text(), " Logout")]

*** Keywords ***
Login with username and password
    [Arguments]    ${username}    ${password}
    Wait Until Page Contains    ${TITLE_LOGIN_PAGE}    
    Wait Until Page Contains Element    ${TEXTBOX_USERNAME}
    Wait Until Page Contains Element    ${TEXTBOX_PASSWORD}
    Input Text    ${TEXTBOX_USERNAME}    ${username}
    Input Text    ${TEXTBOX_PASSWORD}    ${password}
    Click Element    ${BUTTON_LOGIN}
    
Logout
    Click Element    ${BUTTON_LOGOUT} 
    Page Should Contain    ${SUCCESS_MESSAGE_LOGOUT}

Verify Login Success
    Page Should Contain    ${SUCCESS_MESSAGE_LOGIN} 

Verify Login Failure
    [Arguments]    ${expected_error}
    Page Should Contain    ${expected_error}

*** Test Cases ***
TC_FE_001 Login success
    [Documentation]    To verify that users can login successfully when input a correct username and password.
    [Tags]    success
    Login with username and password    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Login Success
    Logout

TC_FE_002 Login failed - Password incorrect
    [Documentation]    To verify that users can login unsuccessfully when they input a correct username but wrong password.
    [Tags]    failed
    Login with username and password    ${VALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Failure    ${ERROR_MESSAGE_INVALID_PASSWORD}

TC_FE_003 Login failed - Username not found
    [Documentation]    To verify that users cannot log in with a username that does not exist.
    [Tags]    failed
    Login with username and password    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Failure    ${ERROR_MESSAGE_INVALID_USERNAME}