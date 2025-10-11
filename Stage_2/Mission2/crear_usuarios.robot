*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    String

*** Variables ***
${BASE_URL}    https://gorest.co.in
${TOKEN}       6d2f35d6345bedf64c8baadb077d551e84aa47aa1326ad1a9e42c46a2db5737d

*** Test Cases ***
Crear un usuario exitosamente
   [Documentation]    Verifica que un POST a public/v2/users cree un recurso y devuelva 201 con datos correctos
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=    Create Dictionary    name=Osmar Granados     gender=male       email=osmargranad22@gmail.com      status=active
   ${response}=    POST    ${BASE_URL}/public/v2/users    json=${body}    headers=${headers}    expected_status=201
   Log    ${response.status_code}
   Log    ${response.json()}

    # Validaciones
    ${user}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${user}    id
    Dictionary Should Contain Key    ${user}    name
    Dictionary Should Contain Key    ${user}    gender
    Dictionary Should Contain Key    ${user}    email
    Dictionary Should Contain Key    ${user}    status
