Feature: In order to consume API for after signup users

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

  Scenario: user recovers password
    Given body is "Lahore.1"
    When user makes a patch request for "/auth/recover-password/"
    Then user sees 200 response code
    When user makes a post request for "/auth/sign-in", body as "Lahore.1"
    Then user sees 200 response code

  Scenario Outline: user recovers password with invalid data
    Given body is "<Password>"
    When user makes a patch request for "/auth/recover-password/"
    Then user sees <recoverPasswordCode> response code
    Examples:
      | Password                                                                                                       | recoverPasswordCode |
      | Lahore.1                                                                                                       | 200                 |
      | 1234567                                                                                                        | 200                 |
      | PAKISTAN                                                                                                       | 200                 |
      | Pakistan                                                                                                       | 200                 |
      | pakistan                                                                                                       | 200                 |
      | (*&^%$£                                                                                                        | 200                 |
      | Pak123                                                                                                         | 200                 |
      | pak123                                                                                                         | 200                 |
      | (*&123                                                                                                         | 200                 |
      | Pak(*&                                                                                                         | 200                 |
      | pak(*&                                                                                                         | 200                 |
      | 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789 | 200                 |


  Scenario: user deletes itself
    Given user has a delete endpoint
    When user deletes
    Then user sees 200 response code
    And db shows no record for that user