Feature: User do search for books

  Background:
    * json add_books_by_id = read('classpath:demobooks/data/add_books_by_userId.json')

  Scenario: Add books to user credentials

    Given url 'https://demoqa.com/BookStore/v1/Books'
    And header Content-Type = 'application/json'
    And header Origin = 'https://demoqa.com'
    And request add_books_by_id

    * set add_books_by_id
    | path                                            | value
    | user                                            | userId
    | collectionOfIsbns[0].isbn                       | isbn

    When method POST
    * karate.log("Request", credentials)
    * karate.log("Response", response)
    Then status 200