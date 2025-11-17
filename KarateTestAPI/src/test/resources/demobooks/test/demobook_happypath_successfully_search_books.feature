Feature: Retrieve a single book by ISBN

  Background:
    * def isUserAuthorized = read('classpath:demobooks/steps/check_user_authorized.feature')
    * def createNewUser = read('classpath:demobooks/steps/create_new_user.feature')
    * def getToken = read('classpath:demobooks/steps/get_user_token.feature')
    * def login = read('classpath:demobooks/steps/login.feature')
    * def getAllBooks = read('classpath:demobooks/steps/get_list_books.feature')
    * def getBooksByISBN = read('classpath:demobooks/steps/get_list_books_by_ISBN.feature')
    * def saveBooks = read('classpath:demobooks/steps/add_books.feature')
    * def deleteBooks = read('classpath:demobooks/steps/delete_books.feature')
    * def getBooksById = read('classpath:demobooks/steps/get_list_books_by_userId.feature')
    * def jsUtil = read('classpath:demobooks/function/generate_random_string.js')


    #test credentials
    * def password = "Lara123!"
    * def ISBN = "9781593275846"

  Scenario: Successfully retrieve all book list

    #1 create new user and check is user authorized
    * def randomName = jsUtil(5)
    * def username = 'user'+ randomName.toString()
    * karate.log(randomName)
    
    * call createNewUser { username: '#(username)', password: '#(password)'}
    And match response.userID != null
    And match response.username == username
    * def userId = response.userID

    #2 generate user token and do login
    * call getToken  { username: '#(username)', password: '#(password)'}
    And match response.token != null
    And match response.expires != null
    And match response.status == "Success"

    * call login { username: '#(username)', password: '#(password)'}
    And match response.token != null
    And match response.expires != null
    And match response.userId == userId
    And match response.username == username
    And match response.password == password

    * call isUserAuthorized { username: '#(username)', password: '#(password)'}
    And match response == "true"

    #4 get list books and assert books property
    * call getAllBooks
    * match response.books[*] == '#notnull'
    * match response.books[0].isbn == '#notnull'
    * match response.books[0].title == '#notnull'
    * match response.books[0].subTitle == '#notnull'
    * match response.books[0].author == '#notnull'
    * match response.books[0].publish_date == '#notnull'
    * match response.books[0].publisher == '#notnull'
    * match response.books[0].pages == '#notnull'
    * match response.books[0].description == '#notnull'

    #5 get books by ISBN
    * call getBooksByISBN { isbn: '#(ISBN)'}
    * match response.isbn == isbn
    * match response.title == "Eloquent JavaScript, Second Edition"
    * match response.subTitle == "A Modern Introduction to Programming"
    * match response.author == "Marijn Haverbeke"
    * match response.website == "http://eloquentjavascript.net/"

    #6 get saved book in user ID and verify it is still empty
    * call getBooksById { userId: '#(userId)'}
    * match response.userId == userId
    * match response.username == username
    * match response.books[] == null

    #7 save book to userId
    * call getBooksByISBN { userId: '#(userId)', isbn: '#(ISBN)'}
    * match response.isbn == isbn

    #8 verify books already saved in profile
    * call getBooksById { userId: '#(userId)'}
    * match response.userId == userId
    * match response.username == username
    * match response.books[0].isbn == isbn

    #9 delete saved books in profile
    * call deleteBooks { isbn: '#(ISBN)',userId: '#(userId)'}
    * match response.userId == userId
    * match response.isbn == isbn

    #10 verify updated data saved books in profile
    * call getBooksById { userId: '#(userId)'}
    * match response.userId == userId
    * match response.username == username
    * match response.books[] == null

