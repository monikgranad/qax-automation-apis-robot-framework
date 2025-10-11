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
    #[Documentation] Generar userName único
    &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    &{body}=       Create Dictionary    name=Itzel Linares     gender=female       email=itzelyn47@gmail.com      status=active
    ${response}=    POST    ${BASE_URL}/public/v2/users    json=${body}    headers=${headers}    expected_status=201    msg=Mensaje= El usuario ya existe
    Log many   ${response.status_code}
    Log many    ${response.json()}
    ${code}=    Set Variable    ${response.status_code}
    Set Global Variable    ${response}
    Set Global Variable    ${code}


la API responde el userId
    ${user}=    Set Variable    ${response.json()}
    ${userid}=    Get From Dictionary    ${user}    id
    Log    El id del usuario creado es: ${userid}
    Set Global Variable    ${userid}

    # Validaciones
    #${user}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${user}    id
    Dictionary Should Contain Key    ${user}    name
    Dictionary Should Contain Key    ${user}    gender
    Dictionary Should Contain Key    ${user}    email
    Dictionary Should Contain Key    ${user}    status


el Codigo de respuesta es 201 para el userId
    Log many    ${code}
    ${result} =	Convert To String    ${code}
    Should Be Equal     ${result}    201    msg: No se creo usuario
    se crea un post asociado a ese usuario


se crea un post asociado a ese usuario
   #[Documentation] Generar post único para el usuario
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=    Create Dictionary    user_id=${userid}		title=Mi primer post automatizado 		body=Contenido de prueba generado por la automatización.
   ${response_post}=    POST    ${BASE_URL}/public/v2/users/${userid}/posts    json=${body}    headers=${headers}    expected_status=201
   Log    ${response_post.status_code}
   Log    ${response_post.json()}
   ${code_post}=    Set Variable    ${response_post.status_code}
    Set Global Variable    ${response_post}
    Set Global Variable    ${code_post}
    Log many    ${response_post.json()}

la API responde el postId
    ${post}=    Set Variable    ${response_post.json()}
    ${postid}=    Get From Dictionary    ${post}    id
    Log    El id del post creado es: ${postid}
    Set Global Variable    ${postid}

    # Validaciones
    #${post}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${post}    id
    Dictionary Should Contain Key    ${post}    user_id
    Dictionary Should Contain Key    ${post}    title
    Dictionary Should Contain Key    ${post}    body


el Codigo de respuesta es 201 para el postId
    Log many    ${code_post}
    ${result} =	Convert To String    ${code_post}
    Should Be Equal     ${result}    201    msg: No se creo post al usuario
    se crea un comentario asociado a esa publicación

se crea un comentario asociado a esa publicación
   #[Documentation] Generar comment para el post del usuario
   &{headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
   ${body}=    Create Dictionary      post= ${postid}      name=Ninja2       email=ninja@example.com   body=Este es un comentario de prueba
   ${response_comment}=    POST    ${BASE_URL}/public/v2/posts/${postid}/comments    json=${body}    headers=${headers}    expected_status=201
   Log    ${response_comment.status_code}
   Log    ${response_comment.json()}
   ${code_comment}=    Set Variable    ${response_comment.status_code}
   Set Global Variable    ${response_comment}
   Set Global Variable    ${code_comment}
   Log many    ${response_comment.json()}

la API responde el commentId
    ${comment}=    Set Variable    ${response_comment.json()}
    ${commentid}=    Get From Dictionary    ${comment}    id
    Log    El id del comment creado es: ${commentid}
    Set Global Variable    ${commentid}
    # Validaciones
    #${comment}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${comment}    id
    Dictionary Should Contain Key    ${comment}    name
    Dictionary Should Contain Key    ${comment}    email
    Dictionary Should Contain Key    ${comment}    body
    se muestra mensaje: Se creó usuario, post y comment exitosamente

el Codigo de respuesta es 201 para el commentId
    Log many    ${code_comment}
    ${result} =	Convert To String    ${code_comment}
    Should Be Equal     ${result}    201    msg: No se creo comment para el post del usuario
    se muestra mensaje: Se creó usuario, post y comment exitosamente

se muestra mensaje: Se creó usuario, post y comment exitosamente
    log     Se creó usuario: ${userid}, post: ${postid} y comment: ${commentid} exitosamente!!!
    log     Se creó usuario, post y comment exitosamente!!!