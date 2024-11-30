Feature: In order to consume API for signup users

  Scenario:
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