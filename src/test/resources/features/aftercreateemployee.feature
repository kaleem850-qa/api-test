Feature: In order to consume API for businesses 3

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
    Given user has an endpoint "/invites/create-invitation"
    And the employee body is
      """
      {
        "user": {
          "Email": "%s",
          "firstName": "KaleemTWO",
          "lastName": "UrrehmanTWO"
        },
        "businessId": "%s"
      }
      """
    And user sets the auth-token in request
    And user sets the Content-Type in request
    And user sets the body in request
    When user makes a post request
    Then user sees 200 response code
    And user saves the employeeid for upcoming APIs
    Given user has an endpoint "/auth/sign-up"
    And employee body is "KaleemTWO", "UrrehmanTWO", "Pakistan.1", "email"
    When user makes a post request
    Then user sees 200 response code
    When employee makes a patch request for "/auth/activate-user/"
    Then user sees 200 response code
    And reinitializing the request to remove all the previous headers
#    When user has a delete endpoint "/setup/delete-user-from-business/"
#    And user deletes
#    Then user sees 200 response code

  @new
  Scenario: Getting user business employee by id
    Given user has an endpoint "/setup/get-user-by-id/"
    And user sets the auth-token in request
    When user makes a get request
    Then user sees 200 response code

  @new
  Scenario: Get user business employee
    Given user has an endpoint "/setup/get-business-employees/"
    And user sets the auth-token in request
    When user makes a get request
    Then user sees 200 response code

  @new
  Scenario Outline: user creates a team inside a business with an employee
    Given user has an endpoint "/team/create-team"
    And user sets the auth-token in request
    And user sets the Content-Type in request
    And user sets the body for team
  """
  {
  "name": "<name>",
  "employees": ["<employees>"],
  "business": "<business>"
  }
  """
    When user makes a post request
    Then user sees 200 response code
    And business has a team with name not null

    Examples:
      | name | employees | business |
      | %s   | %s        | %s       |
      |      | %s        | %s       |