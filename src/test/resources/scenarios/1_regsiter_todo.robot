*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           String
Test Setup        Run Keywords  Open Application Page  AND  Log To Console  ${EMPTY}
Test Teardown     Run Keywords  Close Application Page  AND  Remove DataFile
Suite teardown    Run Keywords  Close all browsers

*** Variables ***
${BROWSER}     HeadlessChrome
${HOST}        localhost:8080

*** Test Cases ***
タスクを正しく登録できる
    [Template]  「${input}」は${expectedWord}こと
    ABC         登録される
    123         登録される
    ${EMPTY}    登録されない
    ;           登録されない


エラーメッセージが正しく表示される
    [Template]  「${input}」を登録しようとすると、「${errorMessage}」と表示される
    ${EMPTY}    タスク名は空にできません
    ;           入力できない文字がセットされています

*** Keywords ***
「${input}」は${expectedWord}こと
    Run Keywords  Create DataFile
    Log To Console  「${input}」は${expectedWord}こと
    Run Keyword  ${expectedWord}  ${input}
    Run Keywords  Remove DataFile

「${input}」を登録しようとすると、「${errorMessage}」と表示される
    登録する  ${input}
    ${currentErrorMessage}=  表示されているエラーメッセージ
    Should Be Equal  ${currentErrorMessage}  ${errorMessage}

登録される
    [Arguments]    ${arg}
    登録する  ${arg}
    ${contents}=  タスクリストの最後の要素
    Should Be Equal    ${contents}  ${arg}

登録されない
    [Arguments]    ${arg}
    登録する  ${arg}
    ${number}=  表示されているタスクの個数
    Should Be Equal As Integers  ${number}  0

登録する
    [Arguments]    ${arg}
    Input Text    id=title    ${arg}
    Submit Form
    Wait Until Page Contains Element  css=body

タスクリストの最後の要素
    ${contents}=    Get Value    css=body > table > tbody > tr > td:nth-child(2) > input
    [Return]  ${contents}

表示されているタスクの個数
    ${Number}=    Get Element Count    css=body > table > tbody > tr
    [Return]  ${Number}

表示されているエラーメッセージ
    ${errorMessage}=    Get Text    id=error-Message
    [Return]  ${errorMessage}

Open Application Page
    Open Browser    http://${HOST}/index.jsp    ${BROWSER}

Close Application Page
    Close Browser

Create DataFile
    Touch	./ToDo.csv

Remove DataFile
    Remove File		./ToDo.csv
