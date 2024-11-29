#Feature: In order to consume API for businesses
#
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
#
#  Scenario: user creates a business
#    Given user has an endpoint "/setup/create-business"
#    And user sets the body
#    When user makes a post request
#    Then user sees 200 response code
#
#  Scenario Outline: user creates a business with invalid data
#    Given user has an endpoint "/setup/create-business"
#    And user sets the body with invalid data
#      | contactInformation.businessEmail                 | <businessEmail>          |
#      | contactInformation.businessWebsite               | <businessWebsite>        |
#      | contactInformation.twitter                       | <twitter>                |
#      | contactInformation.facebook                      | <facebook>               |
#      | contactInformation.businessCountryCode           | <businessCountryCode>    |
#      | contactInformation.billingAddress.country        | <country>                |
#      | contactInformation.billingAddress.city           | <city>                   |
#      | contactInformation.billingAddress.street         | <street>                 |
#      | contactInformation.billingAddress.postalCode     | <postalCode>             |
#      | contactInformation.billingAddress.buildingNumber | <buildingNumber>         |
#      | contactInformation.linkedIn                      | <linkedIn>               |
#      | contactInformation.registeredOffice              | <registeredOffice>       |
#      | contactInformation.businessPhoneNumber           | <businessPhoneNumber>    |
#      | generalInformation.businessName                  | <businessName>           |
#      | generalInformation.accountingYearEndDate         | <accountingYearEndDate>  |
#      | generalInformation.natureOfBusiness              | <natureOfBusiness>       |
#      | generalInformation.businessOwnerName             | <businessOwnerName>      |
#      | generalInformation.numberOfEmployees             | <numberOfEmployees>      |
#      | businessType                                     | <businessType>           |
#      | businessAddress.businessbuildingNumber           | <businessbuildingNumber> |
#      | businessAddress.businesscity                     | <businesscity>           |
#      | businessAddress.businessstreet                   | <businessstreet>         |
#      | businessAddress.businesscountry                  | <businesscountry>        |
#      | businessAddress.businesspostalCode               | <businesspostalCode>     |
#      | crn                                              | <crn>                    |
#      | businessImage                                    | <businessImage>          |
#    When user makes a post request
#    Then user sees 200 response code
#    And above mongoDB entry is created
#
#
#    Examples:
#      | businessEmail          | businessWebsite           | twitter                           | facebook                           | businessCountryCode | country | city   | street        | postalCode | buildingNumber | linkedIn      | registeredOffice  | businessPhoneNumber | businessName   | accountingYearEndDate | natureOfBusiness | businessOwnerName | numberOfEmployees | businessType | businessbuildingNumber | businesscity | businessstreet  | businesscountry | businesspostalCode | crn | businessImage |
#      | info@techsolutions.com | https://techsolutions.com | https://twitter.com/techsolutions | https://facebook.com/techsolutions | +44                 | UK      | London | Argyle Avenue | TW3 3QN    | 20A            | Linkedin.com/ | 22 Rossindel Road | 07491060730         | QA Fusion Ltd. | 28-Feb-2025           | Others           | Kaleem Urrehman   | 40                | ltd          | 22                     | London       | Argyle Avenue 2 | UK              | TW3 3QN            |     |               |
#      | info@techsolutions.com | https://techsolutions.com | https://twitter.com/techsolutions | https://facebook.com/techsolutions | +44                 | UK      | London | Argyle Avenue | TW3 3QN    | 20A            | Linkedin.com/ | 22 Rossindel Road | 07491060730         | XYZ Ltd.       | 28-Feb-2025           | Others           | Kaleem Urrehman   | 40                | ltd          | 22                     | London       | Argyle Avenue 2 | UK              | TW3 3QN            |     |               |
