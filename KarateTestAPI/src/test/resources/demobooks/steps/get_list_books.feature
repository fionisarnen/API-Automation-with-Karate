Feature: User do search for books

  Background:

  Scenario: Get all book list

    Given url 'https://demoqa.com/BookStore/v1/Books'
    And header Content-Type = 'application/json'
    And header Origin = 'https://demoqa.com'

    When method GET
    * karate.log("Response", response)
    Then status 200