*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}    https://gorest.co.in
${TOKEN}       6d2f35d6345bedf64c8baadb077d551e84aa47aa1326ad1a9e42c46a2db5737d

*** Keywords ***
el usuario crea un nuevo usuario
    [Documentation]     Generar userName único
    &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}

    # Se usa un 'email aleatorio' para evitar que el test falle en ejecuciones repetidas
    ${random_email} =    Generate Random String    10    [LOWER]

    &{body}=       Create Dictionary    name=Itzel Linares     gender=female       email=${random_email}@test.com     status=active

    # IMPORTANTE:  'expected_status=any' para poder manejar el resultado con nuestro IF/ELSE
    ${response}=    POST    ${BASE_URL}/public/v2/users    json=${body}    headers=${headers}    expected_status=any

    Log many   ${response.status_code}
    Log many    ${response.json()}
    ${code}=    Set Variable    ${response.status_code}
    Set Global Variable    ${response}
    Set Global Variable    ${code}

    IF    ${code} == 201
        Log To Console    ✅ Éxito: El usuario fue creado correctamente.
        la API responde el userId
    ELSE
        Fail    ❌ Error: El usuario ya existe. Código de respuesta: ${response.status_code}
    END

la API responde el userId
    # Validaciones
    ${user}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${user}    id
    Dictionary Should Contain Key    ${user}    name
    Dictionary Should Contain Key    ${user}    gender
    Dictionary Should Contain Key    ${user}    email
    Dictionary Should Contain Key    ${user}    status

    # Extraer valores del usuario
    ${userid}=     Get From Dictionary    ${user}    id
    ${name}=       Get From Dictionary    ${user}    name
    ${gender}=     Get From Dictionary    ${user}    gender
    ${email}=      Get From Dictionary    ${user}    email
    ${status}=     Get From Dictionary    ${user}    status

    Log    El id del usuario creado es: ${userid}
    Set Global Variable    ${userid}


el Codigo de respuesta es 201 para el userId
    IF    ${code} == 201
        Log To Console    ✅ Éxito: El usuario fue creado correctamente.
        se crea un post asociado a ese usuario
    ELSE
        Fail    ❌ Error: No se creo usuario. Código de respuesta: ${response.status_code}
    END


se crea un post asociado a ese usuario
   [Documentation]  Generar post único para el usuario
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=       Create Dictionary    user_id=${userid}		title=Mi primer post automatizado 		body=Contenido de prueba generado por la automatización.
   ${response_post}=    POST    ${BASE_URL}/public/v2/users/${userid}/posts    json=${body}    headers=${headers}    expected_status=201
   Log    ${response_post.status_code}
   Log    ${response_post.json()}
   ${code_post}=    Set Variable    ${response_post.status_code}
   Set Global Variable    ${response_post}
   Set Global Variable    ${code_post}
   Log many    ${response_post.json()}


la API responde el postId
    # Validaciones
    ${post}=    Set Variable    ${response_post.json()}
    Dictionary Should Contain Key    ${post}    id
    Dictionary Should Contain Key    ${post}    user_id
    Dictionary Should Contain Key    ${post}    title
    Dictionary Should Contain Key    ${post}    body

    # Extraer valores del POST
    ${postid}=      Get From Dictionary    ${post}    id
    ${user_id}=     Get From Dictionary    ${post}    user_id
    ${title}=       Get From Dictionary    ${post}    title
    ${body}=        Get From Dictionary    ${post}    body

    Log    El id del post creado es: ${postid}
    Set Global Variable    ${postid}


el Codigo de respuesta es 201 para el postId
    IF    ${code_post} == 201
        Log To Console    ✅ Éxito: El POST fue creado correctamente.
        se crea un comentario asociado a esa publicación
    ELSE
        Fail    ❌ Error: No se creo POST. Código de respuesta: ${code_post}
    END

se crea un comentario asociado a esa publicación
   [Documentation]  Generar comment para el post del usuario
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=       Create Dictionary      post= ${postid}      name=Ninja2       email=ninja@example.com   body=Este es un comentario de prueba
   ${response_comment}=    POST    ${BASE_URL}/public/v2/posts/${postid}/comments    json=${body}    headers=${headers}    expected_status=201
   Log    ${response_comment.status_code}
   Log    ${response_comment.json()}
   ${code_comment}=    Set Variable    ${response_comment.status_code}
   Set Global Variable    ${response_comment}
   Set Global Variable    ${code_comment}
   Log many    ${response_comment.json()}

la API responde el commentId
    # Validaciones
    ${comment}=    Set Variable    ${response_comment.json()}
    Dictionary Should Contain Key    ${comment}    id
    Dictionary Should Contain Key    ${comment}    name
    Dictionary Should Contain Key    ${comment}    email
    Dictionary Should Contain Key    ${comment}    body


    # Extraer valores del comment
    ${commentid}=    Get From Dictionary    ${comment}    id
    ${post_id}=      Get From Dictionary    ${comment}    post_id
    ${name}=         Get From Dictionary    ${comment}    name
    ${email}=        Get From Dictionary    ${comment}    email
    ${body}=         Get From Dictionary    ${comment}    body

    Log    El id del comment creado es: ${commentid}
    Set Global Variable    ${commentid}

el Codigo de respuesta es 201 para el commentId
    IF    ${code_comment} == 201
        Log To Console    ✅ Éxito: El COMMENT fue creado correctamente.
        se muestra mensaje: Se creó usuario, post y comment exitosamente
    ELSE
        Fail    ❌ Error: No se creo COMMENT. Código de respuesta: ${code_comment}
    END

se muestra mensaje: Se creó usuario, post y comment exitosamente
    Log many     Se creó usuario: ${userid}, post: ${postid} y comment: ${commentid} exitosamente!!!
    Log To Console    ✅ Éxito: Se creó usuario, post y comment exitosamente!!!