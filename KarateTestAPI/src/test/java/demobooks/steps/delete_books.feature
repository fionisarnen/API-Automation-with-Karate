Feature: User do search for books

  Background:
    * json delete_books_by_id = read('classpath:demobooks/data/delete_books_by_userId.json.json')

  Scenario: Delete saved books in user credentials

    Given url 'https://demoqa.com/BookStore/v1/Books'
    And header Content-Type = 'application/json'
    And header Origin = 'https://demoqa.com'
    And request delete_books_by_id

    * set delete_books_by_id
    | path                       | value
    | user                       | userId
    | isbn                       | isbn

    When method DELETE
    * karate.log("Request", credentials)
    * karate.log("Response", response)
    Then status 204