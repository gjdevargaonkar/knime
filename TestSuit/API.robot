*** Settings ***
Test Teardown     Close All Browsers
Resource          ../Resources/APIResources.resource
Resource          ../Resources/UIResources.resource

*** Test Cases ***
test
    ${cookies}    User_Login    ${Username}    ${Password}
    log    ${cookies}
    ${space_name}    Generate Random String    4    [UPPER]
    ${header1}    Create Dictionary    cookie=${cookies}    referer=https://hub.knime.com/
    ${content}    ${response_code}    ${header}    Execute Get Request    ${Token_URL}    ${header1}
    log    ${content}
    log    ${response_code}
    log    ${header}
    ${token_response}    Load Json    ${content}
    ${token_response}    Convert To Dictionary    ${token_response}
    ${access_token}    Get Value By Key From Json    ${token_response}    access_token
    log    ${access_token}
    ${header1}    Create Dictionary    Authorization=Bearer ${access_token}    Accept=application/json, text/plain, */*    Accept-Language=en-GB,en-US;q=0.9,en;q=0.8
    ${date1}    Create Dictionary    private=true    type=Space
    log    ${date1}
    log    ${Space_Create_URL}/${space_name}?overwrite=false
    ${content}    ${response_code}    ${header}    Execute Put Request    ${Space_Create_URL}/${space_name}?overwrite=false    ${header1}    ${date1}
    log    ${content}
    log    ${response_code}
    log    ${header}
