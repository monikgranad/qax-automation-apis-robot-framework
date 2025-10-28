Feature: Gestión de lista de razas de perros en la API dogapi.dog
  Como tester de APIs
  Quiero validar los endpoints de GET para consultar lista de razas de perros
  Para asegurarme de que funcionan correctamente


Scenario: TC001-Consultar lista de razas de perros exitosamente
    Given que tengo acceso al endpoint "https://dogapi.dog/api/v2/breeds"
    And preparo una request GET a "/breeds" con el siguiente body:
    When ejecuto la petición GET
    Then la respuesta debe tener el código de estado 200 OK
	And la lista de usuarios no debe estar vacía
    And cada usuario debe contener los campos "id", "type", "attributes.name", "attributes.description", 
		"attributes.hypoallergenic","attributes.life", "attributes.male_weight.min", "attributes.male_weight.max",
		"attributes.female_weight.min", "attributes.female_weight.max","relationships.group.data.type"
    


Scenario: TC002-Consultar lista de razas de perros existente
    Given que tengo acceso al endpoint "https://dogapi.dog/api/v2/breeds"
    And preparo una request GET a "/breeds/{id}" con el siguiente body:
      """
      {
        "id": "036feed0-da8a-42c9-ab9a-57449b530b13"
	  }
      """
    When ejecuto la petición GET
    Then la respuesta debe tener el código de estado 200 OK
    And cada usuario debe contener los campos "id", "type", "attributes.name", "attributes.description", 
		"attributes.hypoallergenic","attributes.life", "attributes.male_weight.min", "attributes.male_weight.max",
		"attributes.female_weight.min", "attributes.female_weight.max","relationships.group.data.type"
    And el campo "id" debe coincidir con lo enviado
	


Scenario: TC003-Consultar lista de razas de perros inexistente 
    Given que tengo acceso al endpoint "https://dogapi.dog/api/v2/breeds"
    And preparo una request GET a "/breeds/{id}" con el siguiente body:
      """
      {
        "id": "036feed0-da8a-42c9-ab9a-57449b530b13xxx"
	  }
      """
    When ejecuto la petición GET
    Then la respuesta debe tener el código de estado 404
    And el campo "id" no debe coincidir con lo enviado
	And se muestra mensaje: "404 Not found"


