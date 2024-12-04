Feature: In order to consume API for businesses

  Background:
    Given user has an endpoint "/auth/sign-up"
    And body is "Kaleem", "Urrehman", "Pakistan.1", "email"
    When user makes a post request
    Then user sees 200 response code
    And above mongoDB entry is created
    When user makes a patch request for "/auth/activate-user/"
    Then user sees 200 response code
    When user makes a post request for "/auth/sign-in", body as "Pakistan.1"
    Then user sees 200 response code
    And user saves the id and auth-token for upcoming APIs
    Given user has an endpoint "/setup/create-business"
    And user sets the body
    When user makes a post request
    Then user sees 200 response code
    And above mongoDB entry is created
    And user saves the business id for upcoming APIs
    And reinitializing the request to remove all the previous headers

  Scenario: Get businesses by id
    Given user has an endpoint "/setup/get-business-by-id/"
    And user sets the auth-token in request
    When user makes a get request
    Then user sees 200 response code

  Scenario: Get all my businesses
    Given user has an endpoint "/setup/get-my-businesses/"
    And user sets the auth-token in request
    When user makes a get request
    Then user sees 200 response code

  Scenario Outline: Create invitation to users/employees in a business
    Given user has an endpoint "/invites/create-invitation"
    And the employee body is
      """
      {
        "user": {
          "Email": "<Email>",
          "firstName": "<firstName>",
          "lastName": "<lastName>"
        },
        "businessId": "<businessId>"
      }
      """
    And user sets the auth-token in request
    And user sets the Content-Type in request
    And user sets the body in request
    When user makes a post request
    Then user sees 200 response code
    And user saves the employeeid for upcoming APIs
    When user has a delete endpoint "/setup/delete-user-from-business/"
    Examples:
      | Email             | firstName | lastName | businessId |
      | aqdwwad@wdawd.com | abc       | xyz      | %s         |
      | test@wdawd.com    | abc       | xyz      | %s         |

    Scenario: Get business by CRN
      Given user has an endpoint "/setup/get-business-by-CRN/"
      And user sets the auth-token in request
      When user makes a get request
      Then user sees 200 response code
