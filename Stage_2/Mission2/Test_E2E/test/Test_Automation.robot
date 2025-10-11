*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    String
Resource  ../resource/keywords/createUser.resource

*** Variables ***
${BASE_URL}    https://gorest.co.in
${TOKEN}       6d2f35d6345bedf64c8baadb077d551e84aa47aa1326ad1a9e42c46a2db5737d
#${ID_USER}	   8172151

*** Test Cases ***
Crear usuario exitosamente
      [Documentation]  Se crea un usuario nuevo,si es exitoso se crea un post asociado a ese usuario; si es exitoso, se crea un comment asociado a ese post; de lo contrario, muestra mensaje que no se creo usuario, post o comment
      Given el usuario crea un nuevo usuario
      When la API responde el userId
      Then el Codigo de respuesta es 201 para el userId
            And se crea un post asociado a ese usuario
            When la API responde el postId
            Then el Codigo de respuesta es 201 para el postId
                And se crea un comentario asociado a esa publicación
                When la API responde el commentId
                Then el Codigo de respuesta es 201 para el commentId
                And se muestra mensaje: Se creó usuario, post y comment exitosamente
                #Else se muestra mensaje: No se creo commentario
            #Else se muestra mensaje: No se creo publicacion
      #Else se muestra mensaje: No se creo usuario






