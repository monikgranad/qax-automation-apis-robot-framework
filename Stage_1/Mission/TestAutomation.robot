*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://dogapi.dog

*** Test Cases ***
TC001-Consultar lista de razas de perros exitosamente
    [Documentation]    Verifica que un GET a api/v2/breeds devuelva la lista de razas de perros no vacia con campos esperados
    ${response}=    GET    ${BASE_URL}/api/v2/breeds    expected_status=200
    ${breeds}=    Set Variable    ${response.json()}
    # Validar campos mínimos del primer usuario (se asume que la estructura es homogénea)
    Dictionary Should Contain Key    ${breeds[0]}    id
    Dictionary Should Contain Key    ${breeds[0]}    type
    Dictionary Should Contain Key    ${breeds[0]}    attributes.name
    Dictionary Should Contain Key    ${breeds[0]}    attributes.description
    Dictionary Should Contain Key    ${breeds[0]}    attributes.hypoallergenic
    Dictionary Should Contain Key    ${breeds[0]}    attributes.life
    Dictionary Should Contain Key    ${breeds[0]}    attributes.male_weight.max
    Dictionary Should Contain Key    ${breeds[0]}    attributes.male_weight.min
    Dictionary Should Contain Key    ${breeds[0]}    attributes.female_weight.max
    Dictionary Should Contain Key    ${breeds[0]}    attributes.female_weight.min
    Dictionary Should Contain Key    ${breeds[0]}    relationships.group.data.type



TC002-Consultar una raza de perro existente
    [Documentation]    Verifica que un GET a api/v2/breeds/{id} devuelva la raza de perro indicada con campos esperados
    ${response}=    GET    ${BASE_URL}/api/v2/breeds/036feed0-da8a-42c9-ab9a-57449b530b13     expected_status=200
    ${breeds}=    Set Variable    ${response.json()}
    # Validar campos mínimos del primer usuario (se asume que la estructura es homogénea)
    ***Should Be Equal As Strings    036feed0-da8a-42c9-ab9a-57449b530b13  ${response.json()}[id]
    ***Dictionary Should Contain Key    ${breeds[0]}    Id
    Dictionary Should Contain Key    ${breeds[0]}    type
    Dictionary Should Contain Key    ${breeds[0]}    attributes.name
    Dictionary Should Contain Key    ${breeds[0]}    attributes.description
    Dictionary Should Contain Key    ${breeds[0]}    attributes.hypoallergenic
    Dictionary Should Contain Key    ${breeds[0]}    attributes.life
    Dictionary Should Contain Key    ${breeds[0]}    attributes.male_weight.max
    Dictionary Should Contain Key    ${breeds[0]}    attributes.male_weight.min
    Dictionary Should Contain Key    ${breeds[0]}    attributes.female_weight.max
    Dictionary Should Contain Key    ${breeds[0]}    attributes.female_weight.min
    Dictionary Should Contain Key    ${breeds[0]}    relationships.group.data.type
    FOR   ${key}    ${value}    IN    &{my_dict}
        Log Many    ${key}    ${value}
    END


TC003-Consultar una raza de perro inexistente
    [Documentation]    Verifica que un GET a api/v2/breeds/{Id} devuelva mensaje de error 404 Not Found cuando el Id no existe
    ${response}=    GET    ${BASE_URL}/api/v2/breeds/036feed0-da8a-42c9-ab9a-57449b530b13000     expected_status=404
    ${breeds}=    Set Variable    ${response.json()}
    # Validar campos mínimos del primer usuario (se asume que la estructura es homogénea)
    ***Dictionary Should Contain Key    ${breeds[0]}    Id
    Dictionary Should Contain Key    ${breeds[0]}    type
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.name
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.description
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.hypoallergenic
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.life
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.male_weight.max
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.male_weight.min
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.female_weight.max
    ***Dictionary Should Contain Key    ${breeds[0]}    attributes.female_weight.min
    ***Dictionary Should Contain Key    ${breeds[0]}    relationships.group.data.type

