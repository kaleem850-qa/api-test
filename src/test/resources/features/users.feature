Feature: In order to consume API for users

#  Background:
#    Given user has an endpoint "/auth/sign-up"
#    And body is "Kaleem", "Urrehman", "Pakistan.1", "email"
#    When user makes a post request
#    Then user sees 200 response code
#    And above mongoDB entry is created
#    When user makes a patch request for "/auth/activate-user/"
#    Then user sees 200 response code
#    When user makes a post request for "/auth/sign-in", body as "Pakistan.1"
#    Then user sees 200 response code
#    And user saves the id and auth-token for upcoming APIs

  Scenario Outline: user signs up with invalid EMAIL test data
    Given user has an endpoint "/auth/sign-up"
    And body is "<firstName>", "<lastName>", "<Password>", "<Email>", "<SignupType>"
    When user makes a post request
    Then user sees <signUpcode> response code

    Examples:
      | firstName | lastName | Password   | Email                                                                                                                        | SignupType | signUpcode |
      | Kaleem    | Urrehman | Pakistan.1 | kaleem.ur-rehman                                                                                                             | email      | 200        |
      | Kaleem    | Urrehman | Pakistan.1 | kaleem.ur-rehman.com                                                                                                         | email      | 200        |
      | Kaleem    | Urrehman | Pakistan.1 |                                                                                                                              | email      | 200        |

      | Kaleem    | Urrehman | Pakistan.1 | (*&^^%@cinqd.com                                                                                                             | email      | 200        |
      | Kaleem    | Urrehman | Pakistan.1 | 12345@cinqd.com                                                                                                              | email      | 200        |
      | Kaleem    | Urrehman | Pakistan.1 | kaleem.ur-rehman@cinqd                                                                                                       | email      | 200        |
      | Kaleem    | Urrehman | Pakistan.1 | kaleem.ur-rehman@cinqd.co                                                                                                    | email      | 200        |
      | Kaleem    | Urrehman | Pakistan.1 | kaleem.ur-rehmankaleem.ur-rehmankaleem.ur-rehmankaleem.ur-rehmankaleem.ur-rehmankaleem.ur-rehmankaleem.ur-rehman@cinqd.co.uk | email      | 200        |

  Scenario Outline: user signs up with invalid test data and valid email
    Given user has an endpoint "/auth/sign-up"
    And body is "<firstName>", "<lastName>", "<Password>", "<SignupType>"
    When user makes a post request
    Then user sees <signUpcode> response code
    Examples:
      | firstName                                                                                                      | lastName                                                                                                       | Password                                                                                                       | SignupType | signUpcode |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | 1234567                                                                                                        | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | PAKISTAN                                                                                                       | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | Pakistan                                                                                                       | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | pakistan                                                                                                       | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | (*&^%$£                                                                                                        | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | Pak123                                                                                                         | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | pak123                                                                                                         | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | (*&123                                                                                                         | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | Pak(*&                                                                                                         | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | pak(*&                                                                                                         | email      | 200        |
      | Kaleem                                                                                                         | Urrehman                                                                                                       | 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789 | email      | 200        |
      | Tester50                                                                                                       | Urrehman                                                                                                       | Pakistan.1                                                                                                     | email      | 200        |
      | Tester(*&                                                                                                      | Urrehman                                                                                                       | Pakistan.1                                                                                                     | email      | 200        |
      | 12345                                                                                                          | Urrehman                                                                                                       | Pakistan.1                                                                                                     | email      | 200        |
      |                                                                                                                | Urrehman                                                                                                       | Pakistan.1                                                                                                     | email      | 200        |
      | KaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKa | Urrehman                                                                                                       | Pakistan.1                                                                                                     | email      | 200        |
      | Kaleem                                                                                                         | Tester50                                                                                                       | Pakistan.1                                                                                                     | email      | 200        |
      | Kaleem                                                                                                         | Tester(*&                                                                                                      | Pakistan.1                                                                                                     | email      | 200        |
      | Kaleem                                                                                                         | 12345                                                                                                          | Pakistan.1                                                                                                     | email      | 200        |
      | Kaleem                                                                                                         |                                                                                                                | Pakistan.1                                                                                                     | email      | 200        |
      | Kaleem                                                                                                         | KaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKaleemKa | Pakistan.1                                                                                                     | email      | 200        |

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