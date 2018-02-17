*** Settings ***
Library     Collections
Library     RequestsLibrary
Library     Process
Suite Setup     Start
Suite Teardown  End

*** Variables ***
${PROCESS}

*** Test Cases ***
Valid String
    [Template]    Get Request Of ${str} Should Be   200
    aaa
    123sae
    123456789012
    qwertyuiopas
    asdfghjklzx
    ${EMPTY}

Invalid String
    [Template]    Get Request Of ${str} Should Be   406
    [Tags]  not_ready
    67*69
    *:%???
    1234567890123
    qwertyuiopasu
    uuuuuuuuuuuuuuuiiiiiiiiiiiiiiiiiiiiiiiiuuuud

*** KeyWords ***
Get Request of ${str} should be ${expected}
    Create Session    httpd    http://localhost:60000
    ${HEADERS}=     Create Dictionary  IMSI=${str}
    ${resp}=    Get Request    httpd    /   ${HEADERS}
    Should Be Equal As Strings  ${resp.status_code}     ${expected}

Start
    ${TEMP}=    Start Process    python server.py 60000    shell=True    cwd=${CURDIR}
    Set Global Variable    ${PROCESS}    ${TEMP}
    Sleep   0.1 sec

End
    Terminate Process    ${PROCESS}
