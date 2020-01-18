
#5 ユーザとして、TODOに完了を設定することができること。
*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Test Setup        Run Keywords  Open Application Page  AND  Remove DataFile  AND  Create DataFile
Test Teardown     Run Keywords  Close Application Page
Suite teardown    Run Keywords  Close all browsers

*** Variables ***
${BROWSER}     HeadlessChrome
${HOST}        localhost:8080

*** Test Cases ***
change the status "TODO" to "CLOSE"
    Given "TODO" Task was registered                           # ステータスが"TODO"のタスクが登録されている「とする」
    When Change the status from "TODO" to "CLOSE"              # 「もし」ステータス"TODO"を"CLOSE"に変更した
    And Click the update button                                 # 「かつ」更新ボタンを押した
    Then The status is updated to "CLOSE"                             # 「ならば」ステータスがCLOSEに更新される

*** Keywords ***
"TODO" Task was registered 
    Input Text    id=title    HOGEHOGE
    Click Button  css=input[value=ADD]
    Wait Until Page Contains Element  css=body

Change the status from "TODO" to "CLOSE"
    Select From List By Value  css= tr:last-child > td:nth-child(4) > select  CLOSE

Click the update button
    Click Button  css=tr:last-child > td:nth-child(5) > input

The status is updated to "CLOSE"
    Wait Until Page Contains Element  css=body
    ${n}=  Get Value    css= tr:last-child > td:nth-child(4) > select
    Should Be Equal  ${n}  CLOSE

Open Application Page
    Open Browser    http://${HOST}/index.jsp    ${BROWSER}

Close Application Page
    Close Browser

Create DataFile
    Touch	./ToDo.csv

Remove DataFile
    Remove File		./ToDo.csv