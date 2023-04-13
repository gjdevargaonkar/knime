*** Settings ***
Test Teardown     Close Browser
Resource          ../Resources/UIResources.resource

*** Test Cases ***
UI_Create and delete Private Space_Loggedin User
    ${cookies}    User_Login    ${Username}    ${Password}
    ${space_name}    Generate Random String    4    [UPPER]
    ${spacecount}    Create_Space_Private    ${space_name}
    ${spacecount}    Delete_Space    ${space_name}    ${spacecount}
    User_Logout

UI_Create and delete Public Space_Loggedin User
    ${cookies}    User_Login    ${Username}    ${Password}
    ${space_name}    Generate Random String    4    [UPPER]
    ${spacecount}    Create_Space_Public    ${space_name}
    ${spacecount}    Delete_Space    ${space_name}    ${spacecount}
    User_Logout
