Feature: User successfully login with registered credentials

  Background:
    * json credentials = read('classpath:demobooks/data/user_credentials.json')

  Scenario: Generate token given username and password
    # Mandatory Parameter
    * def username = username
    * def password = password

    Given url 'https://demoqa.com/Account/v1/GenerateToken'
    And header Content-Type = 'application/json'
    And header Origin = 'https://demoqa.com'
    And request credentials

    * set credentials
    | path                      | value
    | userName                  | username
    | password                  | password

    When method POST
    * karate.log("Request", credentials)
    * karate.log("Response", response)
    Then status 200
    And match response.status == "Success"