*** Settings ***
Resource    ../resource/minidesafio_api_variables.resource
Library     RequestsLibrary
Library    Collections
Library    BuiltIn
Library    String

*** Test Cases ***
Crear un nuevo post
    [Documentation]    Verifica que un POST a /posts cree un recurso y devuelva 201 con datos correctos.
    ${body}=    Create Dictionary    title=Mi primer post    body=Contenido de prueba    userId=1
    ${response}=    POST    ${BASE_URL}/posts    json=${body}    expected_status=201
    Log    ${response.status_code}
    Log    ${response.json()}

    # Validaciones sobre el body
    Dictionary Should Contain Key    ${response.json()}    id
    Should Be Equal    ${response.json()}[title]    Mi primer post
    Should Be Equal    ${response.json()}[body]     Contenido de prueba
    Should Be Equal As Integers    ${response.json()}[userId]    1

CP02 - Listar usuarios
    [Documentation]    Verifica que un GET a /users devuelva lista no vacía con campos esperados.
    ${response}=    GET    ${BASE_URL}/users    expected_status=200
    ${users}=    Set Variable    ${response.json()}

    FOR    ${item}    IN    @{users}

    # Extraer valores
    ${id}=             Get From Dictionary    ${item}         id
    ${name}=           Get From Dictionary    ${item}         name
    ${username}=       Get From Dictionary    ${item}         username
    ${email}=          Get From Dictionary    ${item}         email

    # Validaciones
    Dictionary Should Contain Key    ${users[0]}    id
    Dictionary Should Contain Key    ${users[0]}    name
    Dictionary Should Contain Key    ${users[0]}    username
    Dictionary Should Contain Key    ${users[0]}    email

    END

CP03 - Listar comentarios de un post
    [Documentation]    Verifica que un GET a /comments?postId=1 devuelva comentarios con campos esperados.
    ${response}=    GET    ${BASE_URL}/comments    params=postId=2    expected_status=200
    ${comments}=    Set Variable    ${response.json()}

    FOR    ${item}    IN    @{comments}

    # Extraer valores
    ${postId}=       Get From Dictionary    ${item}         postId
    ${id}=           Get From Dictionary    ${item}         id
    ${name}=         Get From Dictionary    ${item}         name
    ${email}=        Get From Dictionary    ${item}         email
    ${body}=         Get From Dictionary    ${item}         body

    # Validaciones
    Dictionary Should Contain Key    ${item}    id
    Dictionary Should Contain Key    ${item}    name
    Dictionary Should Contain Key    ${item}    email
    Dictionary Should Contain Key    ${item}   body

    END