*** Settings ***
Library           String
Library           SeleniumLibrary

*** Variables ***
${BaseURL}        https://hub.knime.com/
${Cookie_Accept}    css=.accept-button
${Sign_In}        //button[contains(text(),'Sign in')]
${Username}       gayatrijd
${Password}       abc123
${Username_Textbox}    //input[@id="edit-name"]
${Password_Textbox}    //input[@id="edit-pass"]
${Welcome_Message}    //p[contains(text(),'Welcome to the')]
${Login_Title}    //div[@title=\'${Username}\']
${Profile_Name}    //span[contains(text(),\'${Username}\')]
${Create_Private_Space_Button}    //button[contains(text(),'Private space')]
${Create_Public_Space_Button}    //button[contains(text(),'Public space')]
${Delete_Space_Button}    //button[contains(text(),'Delete space')]
${Spaces_Count}    //p[contains(text(),'Spaces')]/..//em[@class='count']
${More_Button}    //button[@class='toggle function-button single']
${Delete_Space_Name_TextBox}    //input[@type='text']
${Space_Delete_Confirmation_Button}    //button[@form='confirmationForm']
${Space_Name_TextBox}    //textarea[@class='text']
${Space_Save_Button}    //button[@title='Save']
${Spaces_Breadcrumb_link}    //a[contains(text(),'Spaces')]
${Logout_Button}    //span[contains(text(),'Logout')]

*** Keywords ***
User_Login
    [Arguments]    ${username}    ${password}
    Open Browser    ${BaseURL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${Cookie_Accept}
    Click Element    ${Cookie_Accept}
    Wait Until Element Is Visible    ${Sign_In}
    Click Button    ${Sign_In}
    Wait Until Element Is Visible    ${Username_Textbox}
    Input Text    ${Username_Textbox}    ${username}
    Input Password    ${Password_Textbox}    ${password}
    Click Button    ${Sign_In}
    Wait Until Element Is Visible    ${Welcome_Message}
    Element Should Contain    ${Welcome_Message}    Welcome to the
    ${cookies}    Get Cookies
    [Return]    ${cookies}

Create_Space_Private
    [Arguments]    ${space_name}
    Click Element    ${Login_Title}
    Click Element    ${Profile_Name}
    sleep    4s
    Wait Until Element Is Visible    ${Spaces_Count}
    Wait Until Element Is Enabled    ${Create_Private_Space_Button}
    ${spacecount}    Get Element Attribute    ${Spaces_Count}    innerText
    Click Button    ${Create_Private_Space_Button}
    Wait Until Element Is Visible    ${Space_Name_TextBox}
    Clear Element Text    ${Space_Name_TextBox}
    Input Text    ${Space_Name_TextBox}    ${space_name}
    Click Button    ${Space_Save_Button}
    Wait Until Element Is Not Visible    ${Space_Save_Button}
    Click Element    ${Spaces_Breadcrumb_link}
    Sleep    4s
    ${spacecount1}    Get Element Attribute    ${Spaces_Count}    innerText
    Should Be Equal As Numbers    ${${spacecount1}}    ${${${spacecount}} + ${{1}}}
    ${spacecount}    Set Variable    ${spacecount1}
    [Return]    ${spacecount}

Create_Space_Public
    [Arguments]    ${space_name}
    Click Element    ${Login_Title}
    Click Element    ${Profile_Name}
    sleep    4s
    Wait Until Element Is Visible    ${Spaces_Count}
    Wait Until Element Is Enabled    ${Create_Public_Space_Button}
    ${spacecount}    Get Element Attribute    ${Spaces_Count}    innerText
    Click Button    ${Create_Public_Space_Button}
    Wait Until Element Is Visible    ${Space_Name_TextBox}
    Clear Element Text    ${Space_Name_TextBox}
    Input Text    ${Space_Name_TextBox}    ${space_name}
    Click Button    ${Space_Save_Button}
    Wait Until Element Is Not Visible    ${Space_Save_Button}
    Click Element    ${Spaces_Breadcrumb_link}
    Sleep    4s
    ${spacecount1}    Get Element Attribute    ${Spaces_Count}    innerText
    Should Be Equal As Numbers    ${${spacecount1}}    ${${${spacecount}} + ${{1}}}
    ${spacecount}    Set Variable    ${spacecount1}
    [Return]    ${spacecount}

Delete_Space
    [Arguments]    ${space_name}    ${spacecount}
    Reload Page
    Click Element    ${Login_Title}
    Click Element    ${Profile_Name}
    sleep    4s
    Wait Until Element Is Visible    ${Spaces_Count}
    Wait Until Element Is Visible    //h3[contains(text(),\'${space_name}\')]
    Mouse Over    //h3[contains(text(),\'${space_name}\')]
    Click Element    //h3[contains(text(),\'${space_name}\')]
    Wait Until Element Is Visible    ${More_Button}
    Click Button    ${More_Button}
    Wait Until Element Is Visible    ${Delete_Space_Button}
    Click Button    ${Delete_Space_Button}
    Wait Until Element Is Visible    ${Delete_Space_Name_TextBox}
    Input Text    ${Delete_Space_Name_TextBox}    ${space_name}
    Wait Until Element Is Enabled    ${Space_Delete_Confirmation_Button}
    Click Button    ${Space_Delete_Confirmation_Button}
    sleep    4s
    Wait Until Element Is Visible    ${Spaces_Count}
    ${spacecount1}    Get Element Attribute    ${Spaces_Count}    innerText
    Should Be Equal As Numbers    ${${spacecount1}}    ${${${spacecount}} - ${{1}}}
    ${spacecount}    Set Variable    ${spacecount1}

User_Logout
    Click Element    ${Login_Title}
    Wait Until Element Is Visible    ${Logout_Button}
    Click Element    ${Logout_Button}
