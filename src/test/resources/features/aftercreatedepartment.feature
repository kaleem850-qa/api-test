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
    Given user has an endpoint "/department/create-department/"
    And user sets the auth-token in request
    And user sets the Content-Type in request
    And user sets the body for department
      """
      {
        "name":"%s",
        "employees":["%s"],
        "business":"%s"
      }
      """
    When user makes a post request
    Then user sees 200 response code
    And user saves the dept_id for upcoming APIs
    And reinitializing the request to remove all the previous headers

  @new
  Scenario: Get department by id (for user that created a business with an employee)
    Given user has an endpoint "/department/get-department-by-id/"
    And user sets the auth-token in request
    When user makes a get request
    Then user sees 200 response code

  @new
  Scenario: Get department by business (for user that created a business with an employee)
    Given user has an endpoint "/department/get-departments-by-business/"
    And user sets the auth-token in request
    When user makes a get request
    Then user sees 200 response code

  @new
  Scenario: Delete department (for user that created a business with an employee)
    Given user has an endpoint "/department/delete-department/"
    And user sets the auth-token in request
    When user makes a delete request
    Then user sees 200 response code

  @new
  Scenario: Edit department (for user that created a business with an employee)
    Given user has an endpoint "/department/edit-department/"
    And user sets the auth-token in request
    And user sets the Content-Type in request
    And user sets the edit body for department
    """
      {
        "name":"%s",
        "employees":["%s"],
        "business":"%s"
      }
    """
    When user makes a patch request
    Then user sees 200 response code

  @new
  Scenario: Delete department (for user that created a business with an employee)
    Given user has an endpoint "/department/delete-department/"
    And user sets the auth-token in request
    When user makes a delete request
    Then user sees 200 response code