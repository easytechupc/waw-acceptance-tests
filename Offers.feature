Feature: Job offers API
    As a developer
    I want to manage Job offers through an API
    In order to make it available for client applications.

    Scenario: Get all Job offers
        Given I am a Job offers client
        And the Job offers repository has data
            | Id | Title            | Image             | Description                                             | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with experience in HTML, CSS, JavaScript | true   |
            | 2  | Mobile Developer | image.test.com    | Expert mobile apps dev with Swift                       | false  |
        When a GET request is sent to Job offers
        Then a OfferResource response with status 200 is received
        And a list of OfferResources is included in the body
            | Id | Title            | Image             | Description                                             | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with experience in HTML, CSS, JavaScript | true   |
            | 2  | Mobile Developer | image.test.com    | Expert mobile apps dev with Swift                       | false  |

    Scenario: Add Job offer with data
        Given I am a Job offers client
        And the Job offers repository has data
            | Id | Title            | Image             | Description                                             | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with experience in HTML, CSS, JavaScript | true   |
            | 2  | Mobile Developer | image.test.com    | Expert mobile apps dev with Swift                       | false  |
        When a POST request is sent to Job offers
            | Title            | Image                   | Description             | Status |
            | C++ developer    | img.curriculum.test.com | Beginner c++, developer | true   |
        Then a OfferResource response with status 201 is received
        And a OfferResource is included in the body
            | Title            | Image                   | Description             | Status |
            | C++ developer    | img.curriculum.test.com | Beginner c++, developer | true   |

    Scenario: Add invalid Job offer
        Given I am a Job offers client
        When a POST request is sent to Job offers
            | Title    | Image                   | Description             | Status |
            |          | img.curriculum.test.com | Beginner c++, developer | true   |
        Then a OfferResource response with status 400 is received
        And a OfferResource Error Message is included in the body
            | Message                     |
            | The Title field is required. |

    Scenario: Update existing Job offer
        Given I am a Job offers client
        And the Job offers repository has data
            | Id | Title            | Image             | Description                                             | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with experience in HTML, CSS, JavaScript | true   |
            | 2  | Mobile Developer | image.test.com    | Expert mobile apps dev with Swift                       | false  |
        When a PUT request is sent to Job offers with Id 1
            | Id | Title            | Image             | Description                          | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with Angular and Vue  | false  |
        Then a OfferResource response with status 200 is received
        And a OfferResource is included in the body
            | Id | Title            | Image             | Description                          | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with Angular and Vue  | false  |

    Scenario: Delete existing Job offer
        Given I am a Job offers client
        And the Job offers repository has data
            | Id | Title            | Image             | Description                                             | Status |
            | 1  | Web Developer    | example.image.com | Expert web dev with experience in HTML, CSS, JavaScript | true   |
            | 2  | Mobile Developer | image.test.com    | Expert mobile apps dev with Swift                       | false  |
        When a DELETE request is sent to Job offers with Id 1
        Then a OfferResource response with status 204 is received