*** Settings ***
Library  Selenium2Library
Suite Setup        Open Browser    ${URL}   ${BROWSER}
Suite Teardown    Close all browsers


*** Variables ***
${URL}              https://www.aihitdata.com/
${BROWSER}          Chrome
${email}            annahmyria94@gmail.com
${temporary}

*** Test Cases ***
Init
    Wait Until Element Is Visible  //h1[@class='text-center']
    Click Element                   xpath=//a[contains(text(),'LOG IN')]
    Input Text                      id=email  ${email}
    Input Password                  id=password  qwerty456
    Click Element                   id=submit
    Input Text                      id=company  mortgage
    Input Text                      id=location  us
    Click Button                    xpath=//button[contains(text(),'Search')]
    Wait Until Element Is Visible  //div[@class='panel panel-default']//div[@class='panel-body']//div//a

Companies loop
    log to console  \nName;Website;Address;Email;Phone
    FOR    ${i}    IN RANGE    1    2
        ${href}     Get Element Attribute   //div[@class='panel panel-default'][${i}]//div[@class='panel-body']//div//a  href
        Execute Javascript  window.open('${href}', '_blank')
        ${title_var}        Get Window Titles
        Select Window       title=${title_var}[1]
        Wait Until Element Is Visible   //div[@class='panel-body']
        ${address_xpath}=    Set Variable    //div[@class='text-muted'][2]
        ${address_flag}=    Run Keyword And Return Status    Page Should Contain Element  ${address_xpath}
        ${address}=      Run Keyword If  '${address_flag}'=='True'   Get WebElement  ${address_xpath}
        ${address_text}=    Run Keyword If  '${address_flag}'=='True'  Set Variable   '${address.text}'
        ...     ELSE    Set Variable    ${EMPTY}
        ${name_xpath}=    Set Variable    //h1[@class='text-info']
        ${name_flag}=    Run Keyword And Return Status    Page Should Contain Element  ${name_xpath}
        ${name}=      Run Keyword If  '${name_flag}'=='True'   Get WebElement  ${name_xpath}
        ${name_text}=    Run Keyword If  '${name_flag}'=='True'  Set Variable   '${name.text}'
        ...     ELSE    Set Variable    ${EMPTY}
        ${web_xpath}=    Set Variable    //span[@class='text-success']
        ${web_flag}=    Run Keyword And Return Status    Page Should Contain Element  ${web_xpath}
        ${website}=      Run Keyword If  '${web_flag}'=='True'   Get WebElement  ${web_xpath}
        ${web_text}=    Run Keyword If  '${web_flag}'=='True'  Set Variable   '${website.text}'
        ...     ELSE    Set Variable    ${EMPTY}
        #${name}=    Get WebElement    //h1[@class='text-info']
        #${website}=    Get WebElement  //span[@class='text-success']
        ${tmp}=   Get Element Count  //ul[@class='list-inline'][2]//li
        ${phone_xpath}=    Run Keyword If  ${tmp}==3  Set Variable  //ul[@class='list-inline'][2]//li[3]
        ...     ELSE    Set Variable  //ul[@class='list-inline'][2]//li[2]
        ${phone_flag}=    Run Keyword And Return Status    Page Should Contain Element  ${phone_xpath}
        ${phone}=      Run Keyword If  '${phone_flag}'=='True'   Get WebElement  ${phone_xpath}
        ${phone_text}=    Run Keyword If  '${phone_flag}'=='True'  Set Variable   '${phone.text}'
        ...     ELSE    Set Variable    ${EMPTY}
        #${phone}=    Run Keyword If  ${tmp}==3  Get WebElement  //ul[@class='list-inline'][2]//li[3]
        #...     ELSE    Get WebElement  //ul[@class='list-inline'][2]//li[2]
        ${mail_xpath}=    Run Keyword If  ${tmp}==3  Set Variable  //ul[@class='list-inline'][2]//li[2]//a
        ${mail_flag}=    Run Keyword And Return Status    Page Should Contain Element   ${mail_xpath}
        ${mail}=      Run Keyword If  '${mail_flag}'=='True'   Get WebElement  ${mail_xpath}
        ${mail_text}=    Run Keyword If  '${mail_flag}'=='True'  Set Variable   '${mail.text}'
        ...     ELSE    Set Variable    ${EMPTY}
        #${mail}=    Run Keyword If  ${tmp}==3   Get WebElement  //ul[@class='list-inline'][2]//li[2]//a
        #${flag}=    Run Keyword And Return Status    Page Should Contain Element  //ul[@class='list-inline'][2]//li[2]//a
        #log to console  \ntest
        #${text}=    Run Keyword If  '${flag}'=='True'   Set Variable   '${mail.text}'
        #...     ELSE    Set Variable    ${EMPTY}
        log to console  \n${name_text};${web_text};${address_text};${mail_text};${phone_text}
        close window
        Select Window       title=${title_var}[0]
    END