Feature: Companies API
    As a developer
    I want to manage Companies through an API
    In order to make it available for client applications.

    Scenario: Get all Companies
        Given I am a Companies client
        And the Companies repository has data
            | Id | Name        | Address      | Email           |
            | 1  | Google Inc. | Lima, PE     | google@fake.com |
            | 2  | Meta Inc.   | Santiago, CH | meta@fake.com   |
        When a GET request is sent to Companies
        Then a CompanyResource response with status 200 is received
        And a list of CompanyResources is included in the body
            | Id | Name        | Address      | Email           |
            | 1  | Google Inc. | Lima, PE     | google@fake.com |
            | 2  | Meta Inc.   | Santiago, CH | meta@fake.com   |

    Scenario: Add Company with data
        Given I am a Companies client
        And the Companies repository has data
            | Id | Name        | Address      | Email           |
            | 1  | Google Inc. | Lima, PE     | google@fake.com |
            | 2  | Meta Inc.   | Santiago, CH | meta@fake.com   |
        When a POST request is sent to Companies
            | Name   | Address          | Email           |
            | Oracle | Buenos Aires, AR | oracle@fake.com |
        Then a CompanyResource response with status 201 is received
        And a CompanyResource is included in the body
            | Id | Name   | Address          | Email           |
            | 3  | Oracle | Buenos Aires, AR | oracle@fake.com |

    Scenario: Add invalid Company
        Given I am a Companies client
        When a POST request is sent to Companies
            | Name | Address   | Email            |
            |      | Quito, EC | company@fake.com |
        Then a CompanyResource response with status 400 is received
        And a CompanyResource Error Message is included in the body
            | Message                     |
            | The Name field is required. |

    Scenario: Update existing Company
        Given I am a Companies client
        And the Companies repository has data
            | Id | Name        | Address  | Email           |
            | 1  | Google Inc. | Lima, PE | google@fake.com |
        When a PUT request is sent to Companies with Id 1
            | Name        | Address    | Email              |
            | Google Inc. | Huacho, PE | newgoogle@fake.com |
        Then a CompanyResource response with status 200 is received
        And a CompanyResource is included in the body
            | Id | Name        | Address    | Email              |
            | 1  | Google Inc. | Huacho, PE | newgoogle@fake.com |

    Scenario: Delete existing Company
        Given I am a Companies client
        And the Companies repository has data
            | Id | Name        | Address  | Email           |
            | 1  | Google Inc. | Lima, PE | google@fake.com |
        When a DELETE request is sent to Companies with Id 1
        Then a CompanyResource response with status 204 is received