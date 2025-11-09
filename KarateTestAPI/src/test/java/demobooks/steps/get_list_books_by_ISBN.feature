Feature: User do search for books

  Background:
    * url 'https://demoqa.com/BookStore/v1'
    # Default Value
    * def isbn_default = "9781449325862"
    * def isbn = (typeof isbn == "undefined") ? isbn_default : isbn

  Scenario: Get books details by ISBN

    Given url 'https://demoqa.com/BookStore/v1/Books?UserId='
    And param ISBN = isbn
    And header Content-Type = 'application/json'
    And header Origin = 'https://demoqa.com'

    When method GET
    * karate.log("Response", response)
    Then status 200