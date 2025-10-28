	
Feature: Validar POST en API de creación de posts
  Como tester de APIs
  Quiero enviar un POST a la API
  Para verificar que responde con código 200 OK y campos esperados

Scenario: TC001-Crear un nuevo post exitosamente
    Given que tengo acceso al endpoint "https://jsonplaceholder.typicode.com/"
    And preparo una request POST a "/posts" con el siguiente body:
      """
      {
        "title": "Título de prueba",
        "body": "Contenido de prueba",
        "userId": 1
      }
      """
    When ejecuto la petición POST
    Then la respuesta debe tener el código de estado 201
    And los campos "title", "body" y "userId" deben coincidir con lo enviado
    And el campo "id" debe ser un número entero autogenerado
	
*************************************************************************************************
Scenario: TC002 Listar usuarios exitosamente
    Given que tengo acceso al endpoint "https://jsonplaceholder.typicode.com/"
    And preparo una request GET a "/users"
    When ejecuto la petición GET
    Then la respuesta debe tener el código de estado 200
	And la lista de usuarios no debe estar vacía
    And cada usuario debe contener los campos "id", "name", "username" y "email"
    
*************************************************************************************************
Scenario: TC003 Listar comentarios de un post exitosamente
    Given que tengo acceso al endpoint "https://jsonplaceholder.typicode.com/"
    And preparo una request GET a "/comments?postId={id}"
    When ejecuto la petición GET
    Then la respuesta debe tener el código de estado 200
	And la lista de usuarios no debe estar vacía
    And cada comentario del usuario debe contener los campos "id", "name", "email" y "body"
        