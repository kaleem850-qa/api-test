Feature: In order to consume API

  Scenario: get test
    Given user has an endpoint "/api/users/2"
    When user makes a get request
    Then user sees 200 response code

  Scenario: post test
    Given user has an endpoint "/api/users"
    And body is "{\"name\": \"Kaleem\", \"job\": \"Software Engineer\"}"
    When user makes a post request
    Then user sees 201 response code

  Scenario: put test
    Given user has an endpoint "/api/users/2"
    And body is "{\"name\": \"Kaleem\", \"job\": \"Software Engineer\"}"
    When user makes a put request
    Then user sees 200 response code