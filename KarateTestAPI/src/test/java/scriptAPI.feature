Feature: API Test

  Background: 
    * url 'https://jsonplaceholder.cypress.io'
    * header Accept = 'Application/json'

  Scenario: Test Data Type
    Given path '/posts'
    When method GET
    Then status 200
    And match response[0] == {'userId': '#number', 'id': '#number', 'title':'#string', 'body':'#string'}
    And match response[0] == {'userId': 1, 'id': 1, 'title':'sunt aut facere repellat provident occaecati excepturi optio reprehenderit', 'body':'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'}

  Scenario: Test Post Data
    Given path '/posts'
    And request {"title": 'recommendation', "body": 'motorcycle', "userId": '12'}
    When method POST
    Then status 201
    And print response
    And match response == {'title': 'recommendation', 'body': 'motorcycle', 'userId':'12', 'id':"#number"}
