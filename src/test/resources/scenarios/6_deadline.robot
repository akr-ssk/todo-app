# ユーザとして、期限が3日以内のTODOを確認することができること。 #6

# 新規登録時に、期限(YYYYMMDD)を設定するテキストボックスがある
# 期限は設定しなくてもよい
# タスクの更新時に、期限を変更できる（期限は過去でも未来でもよい）
 
# タスクの再表示時に、現在時刻と、タスクの期限を計算する。
# タスクの期限が設定されていない場合は、UPDATEボタンの左には何も表示されない。
# タスクの期限が設定されているときは、秒単位で計算する。
#   タスクの期限 - 現在時刻 が３日1秒以上の場合は、UPDATEボタンの左には何も表示されない。
#   タスクの期限 - 現在時刻 が０(秒)以上３日以内の場合に、UPDATEボタンの左に"期限間近"を太字・赤字で表示する
#   タスクの期限 - 現在時刻 が０(秒)未満の場合に、UPDATEボタンの左に"期限切れ"を太字・赤字で表示する

# 表のヘッダは以下にする
# id:	title:	priority:	status: limit: 期限近い？: <updateボタン>

*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Test Teardown     Run Keywords  Close Application Page
Suite teardown    Run Keywords  Close all browsers

*** Variables ***
${BROWSER}     HeadlessChrome
${HOST}        localhost:8080

*** Test Cases ***
Check "TODO" tasks within 3 days
    Given The "TODO" task that will be expired at tommorrow is registered
    When The page is opened
    Then The task is marked as "期限間近"

Check expired "TODO"
    Given The task that was expired yesterday was registered
    When The page is opened
    Then The task is marked as "期限切れ"

Check the not yet expired "TODO"
    Given The "TODO" task that will be expired after one year is registered
    When The page is opened
    Then The task is marked as nothing

Check the unset deadline "TODO"
    Given The task that don't have a deadline was registered
    When The page is opened
    Then The task is marked as nothing

*** Keywords ***
# The task that will be expired within 3 days was registered

The "TODO" task that will already be expired was registered
    Remove DataFile
    Create DataFile
    Append To File  ./ToDo.csv  100,Expired Task,3,TODO,2000/01/01

# https://robotframework-ja.readthedocs.io/ja/latest/lib/DateTime.html#time-string

The "TODO" task that will be expired at tommorrow is registered
    ${today}=  Get Current Date
    ${tomorrow}=  Add Time To Date   ${today}  1 day  result_format=%Y/%m/%d
    Remove DataFile
    Create DataFile
    Append To File  ./ToDo.csv  100,Expired Task,3,TODO,${tomorrow}

The "TODO" task that will be expired after one year is registered
    ${today}=  Get Current Date
    ${tomorrow}=  Add Time To Date   ${today}  365 days  result_format=%Y/%m/%d
    Remove DataFile
    Create DataFile
    Append To File  ./ToDo.csv  100,Expired Task,3,TODO,${tomorrow}

The task that was expired yesterday was registered
    ${today}=  Get Current Date
    ${tomorrow}=  Add Time To Date   ${today}  -1  result_format=%Y/%m/%d
    Remove DataFile
    Create DataFile
    Append To File  ./ToDo.csv  100,Expired Task,3,TODO,${tomorrow}

The task that don't have a deadline was registered
    Remove DataFile
    Create DataFile
    Append To File  ./ToDo.csv  100,Expired Task,3,TODO,""

Then The task is marked as "期限切れ"
    ${status}=  Get Text    css= tr:last-child > td:nth-child(6) > p
    Should Be Equal  ${status}  期限切れ

Then The task is marked as "期限間近"
    ${status}=  Get Text    css= tr:last-child > td:nth-child(6) > p
    Should Be Equal  ${status}  期限間近

Then The task is marked as nothing
    ${status}=  Get Text    css= tr:last-child > td:nth-child(6) > p
    Should Be Equal  ${status}   ${EMPTY}

The page is opened
    Open Application Page
    Wait Until Page Contains Element  css=body

Open Application Page
    Open Browser    http://${HOST}/index.jsp    ${BROWSER}

Close Application Page
    Close Browser

Create DataFile
    Touch	./ToDo.csv

Remove DataFile
    Remove File		./ToDo.csv