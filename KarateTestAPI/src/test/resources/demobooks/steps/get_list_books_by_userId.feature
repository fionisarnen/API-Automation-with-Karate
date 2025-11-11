Feature: User do search for books

  Background:
    * url 'https://demoqa.com/BookStore/v1'

  Scenario: Get books details by ISBN

    Given url 'https://demoqa.com/Account/v1/User'
    And path userId
    And header Content-Type = 'application/json'
    And header Origin = 'https://demoqa.com'

    When method GET
    * karate.log("Response", response)
    Then status 200