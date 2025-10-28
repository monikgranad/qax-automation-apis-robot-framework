*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    String

*** Variables ***
${BASE_URL}    https://gorest.co.in
${TOKEN}       6d2f35d6345bedf64c8baadb077d551e84aa47aa1326ad1a9e42c46a2db5737d
${ID_USER}	   8172151

*** Test Cases ***
Crear un post de un usuario exitosamente
   [Documentation]    Verifica que un POST a /public/v2/users/ID_USER/posts cree un recurso y devuelva 201 con datos correctos
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=    Create Dictionary    user_id=${ID_USER}		title=Mi primer post automatizado 		body=Contenido de prueba generado por la automatización.
   ${response}=    POST    ${BASE_URL}/public/v2/users/${ID_USER}/posts    json=${body}    headers=${headers}    expected_status=201
   Log    ${response.status_code}
   Log    ${response.json()}

   # Validaciones
    ${post}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${post}    id
    Dictionary Should Contain Key    ${post}    user_id
    Dictionary Should Contain Key    ${post}    title
    Dictionary Should Contain Key    ${post}    body

