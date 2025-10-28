*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    String

*** Variables ***
${BASE_URL}    https://gorest.co.in
${TOKEN}       6d2f35d6345bedf64c8baadb077d551e84aa47aa1326ad1a9e42c46a2db5737d
${POST_ID}     249203
${POST}	       8172151

*** Test Cases ***
Crear un comentario a un post de un usuario exitosamente
   [Documentation]    Verifica que un POST a /public/v2/users/${POST}/posts cree un recurso y devuelva 201 con datos correctos
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=    Create Dictionary      post= ${POST}      name=Ninja2       email=ninja@example.com   body=Este es un comentario de prueba
   ${response}=    POST    ${BASE_URL}/public/v2/posts/${POST_ID}/comments    json=${body}    headers=${headers}    expected_status=201
   Log    ${response.status_code}
   Log    ${response.json()}

   # Validaciones
    ${comment}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${comment}    id
    Dictionary Should Contain Key    ${comment}    name
    Dictionary Should Contain Key    ${comment}    email
    Dictionary Should Contain Key    ${comment}    body
