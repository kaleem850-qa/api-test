Feature: In order to

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

  Scenario Outline: Create roles (for user that created a business with an employee)
    Given user has an endpoint "/role/create-role/"
    And user sets the auth-token in request
    And user sets the Content-Type in request
    And user sets the body for roles
    """
      {
        "name":"<name>",
        "businessId":"<businessId>",
        "permissions":["<permissions>"],
        "description":"<description>"
}
    """
    When user makes a post request
    Then user sees 200 response code
    And user saves the role_id for upcoming APIs

    Examples:
      | name | businessId | permissions | description |
      | %s   | %s         | %s          | %s          |