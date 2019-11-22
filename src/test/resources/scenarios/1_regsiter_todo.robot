*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Test Setup        Create DataFile
Test Teardown     Remove DataFile
Suite setup       Open Headless Chrome
Suite teardown    Close all browsers

*** Variables ***
${BROWSER}        Chrome
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

Create DataFile
    Touch	./ToDo.csv

Remove DataFile
    Remove File		./ToDo.csv

Open Headless Chrome
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${options}  add_argument  --headless
    call method  ${options}  add_argument  --no-sandbox
    create webdriver  Chrome  chrome_options=${options} 

https://stackoverflow.com/questions/46812155/how-to-run-headless-remote-chrome-using-robot-framework