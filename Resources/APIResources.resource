*** Settings ***
Library           Collections
Library           String
Library           DateTime
Library           OperatingSystem
Library           ../lib/rest_util/RestGeneric.py
Library           ExcelLibrary

*** Variables ***
${Token_URL}      https://hub.knime.com/_/token
${Space_Create_URL}    https://api.hub.knime.com/repository/Users/account:user:691ff4bf-da92-439a-89f2-ac4d4976da94
