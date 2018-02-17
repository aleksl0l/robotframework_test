*** Variables ***
@{VALUES} =    Create List    first    second    third

*** Test Cases ***
Using backslash
    Do Something    first arg    \
Using ${EMPTY}
    Do Something    first arg    ${EMPTY}
Non-trailing empty
    Do Something    ${EMPTY}     second arg    # Escaping needed in space separated format
For loop
    :FOR    ${var}    IN    @{VALUES}
    \    Log    ${var}

*** Keywords ***
Do Something
    [Arguments]    ${args}    ${path}
    Log    ${args}
    Log    ${path}
