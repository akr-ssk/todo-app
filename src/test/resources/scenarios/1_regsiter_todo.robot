*** Settings ***
Library           SeleniumLibrary
Suite teardown    Close all browsers

*** Variables ***
${BROWSER}        chrome
${HOST}        localhost:8080

*** Test Cases ***
Register Operation Works Well
    [Template]    Register Operation Workflow
    # input     output(task)    output(error message)
    ABC         ABC             ${EMPTY}
    ${EMPTY}   ${EMPTY}        タスク名は空にできません
    ;           ${EMPTY}        入力できない文字がセットされています

*** Keywords ***
Register Operation Workflow
    [Arguments]    ${arg}   ${expected-task}   ${expected-error}
    Open Application Page
    ${task}     ${error}=    Register Todo  ${arg}
    Should Be Equal    ${task}    ${expected-task}
    Should Be Equal    ${error}   ${expected-error}
    Close Application Page

Open Application Page
    Open Browser    http://${HOST}/index.jsp    ${BROWSER}

Register Todo
    [Arguments]    ${arg}
    Input Text    id=title    ${arg}
    Submit Form
    BuiltIn.Sleep	1
    ${result-task}=    Get Text    css=body > table > tbody > tr:last-child
    ${result-error}=    Get Text    id=error-Message
    [Return]    ${result-task}  ${result-error}

Close Application Page
    Close Browser