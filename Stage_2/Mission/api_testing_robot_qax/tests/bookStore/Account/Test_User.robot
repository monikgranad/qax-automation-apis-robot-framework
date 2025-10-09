  *** Settings ***
  Documentation     Test Case: Crear usuario con POST /Account/v1/User
  ...               Verifica que se cree un usuario con userName único y password válida
  Resource  ../../../resource/keywords/createUser.resource

  *** Test Cases ***
  Crear usuario exitosamente
      [Documentation]    Crear un usuario nuevo usando datos validos.
      Given que el usuario desea crear un nuevo usuario
      When el usuario envia la peticion para la creación del usuario
      Then la API responde el userId
