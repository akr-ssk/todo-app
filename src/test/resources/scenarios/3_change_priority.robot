*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Test Teardown     Run Keywords  Close Application Page  AND  Remove DataFile
Suite teardown    Run Keywords  Close all browsers

*** Variables ***
${BROWSER}     HeadlessChrome
${HOST}        localhost:8080

*** Test Cases ***
優先度を選択して追加できる
    [template]  優先度「${priority}」を選択して追加できる
    2
    4

*** Keywords ***
優先度「${priority}」を選択して追加できる
    アプリケーションを開く
    優先度を選択する  ${priority}
    タスク名を入力する  勉強する
    登録ボタンを押す
    ページが表示されるまで待つ
    タスクが追加されている  勉強する  ${priority}

優先度を選択する
    [Arguments]    ${arg}
    Select From List By Value  id=priority  ${arg}

タスク名を入力する
    [Arguments]    ${arg}
    Input Text    id=title    ${arg}

登録ボタンを押す
    Click Button  css=input[value=ADD]

ページが表示されるまで待つ
    Wait Until Page Contains Element  css=body

タスクが追加されている
    [Arguments]    ${taskname}  ${priority}
    ${n}=  Get Value    css= tr:last-child > td:nth-child(2) > input
    ${p}=  Get Value    css= tr:last-child > td:nth-child(3) > select
    Should Be Equal  ${n}  ${taskname}
    Should Be Equal  ${p}  ${priority}

アプリケーションを開く
    Open Browser    http://${HOST}/index.jsp    ${BROWSER}

Close Application Page
    Close Browser

Create DataFile
    Touch	./ToDo.csv

Remove DataFile
    Remove File		./ToDo.csv
