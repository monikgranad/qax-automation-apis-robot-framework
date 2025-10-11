*** Settings ***
Library    RequestsLibrary
Library    String    # Para generar email aleatorio

*** Variables ***
${BASE_URL}     https://gorest.co.in
${TOKEN}        6d2f35d6345bedf64c8baadb077d551e84aa47aa1326ad1a9e42c46a2db5737d

*** Test Cases ***
Crear Usuario y Validar Con IF-ELSE
    [Documentation]    Crea un usuario y verifica la respuesta con un solo bloque IF/ELSE.

    # Paso 1: Realizar la petición para crear el usuario
    ${response} =    Peticion Para Crear Usuario

    # Paso 2: Usar IF/ELSE para validar si la creación fue exitosa
    IF    ${response.status_code} == 201
        Log To Console    ✅ Éxito: El usuario fue creado correctamente.
        ${user_id} =    Set Variable    ${response.json()}[id]
        Log To Console    ID del nuevo usuario: ${user_id}
        # Aquí podrías continuar con los siguientes pasos, como crear el post.
    ELSE
        Fail    ❌ Error: La creación del usuario falló. Código de respuesta: ${response.status_code}
    END

*** Keywords ***
Peticion Para Crear Usuario
    [Documentation]    Envía una petición POST para crear un nuevo usuario y retorna la respuesta completa.
    &{headers} =    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json

    # Usamos un email aleatorio para evitar que el test falle en ejecuciones repetidas
    ${random_email} =    Generate Random String    10    [LOWER]
    &{body} =       Create Dictionary    name=Itzel Test    gender=female    email=${random_email}@test.com    status=active

    # IMPORTANTE: Quitamos 'expected_status' para poder manejar el resultado con nuestro IF/ELSE
    ${response} =   POST
    ...    url=${BASE_URL}/public/v2/users
    ...    json=${body}
    ...    headers=${headers}

    [Return]    ${response}

