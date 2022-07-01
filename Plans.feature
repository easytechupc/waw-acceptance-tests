Feature: Plans API
    As a developer
    I want to manage Plans through an API
    In order to make it available for client applications.

    Scenario: Get all Plans
        Given I am a Plans client
        And the Plans repository has data
            | Id | Name     | Description             | Price |
            | 1  | Free     | Free plan               | 0     |
            | 2  | Personal | Plan with more benefits | 59.90 |
        When a GET request is sent to Plans
        Then a PlanResource response with status 200 is received
        And a list of PlanResources is included in the body
            | Id | Name     | Description             | Price |
            | 1  | Free     | Free plan               | 0     |
            | 2  | Personal | Plan with more benefits | 59.90 |
    Scenario: Add Subscription plan with data
        Given I am a Plans client
        And the Plans repository has data
            | Id | Name     | Description             | Price |
            | 1  | Free     | Free plan               | 0     |
            | 2  | Personal | Plan with more benefits | 59.90 |
        When a POST request is sent to Plans
            | Name       | Description        | Price  |
            | Enterprise | Plan for companies | 129.00 |
        Then a PlanResource response with status 201 is received
        And a PlanResource is included in the body
            | Id | Name       | Description        | Price  |
            | 3  | Enterprise | Plan for companies | 129.00 |

    Scenario: Add invalid Subscription plan
        Given I am a Plans client
        When a POST request is sent to Plans
            | Name       | Description        | Price |
            | Enterprise | Plan for companies |       |
        Then a PlanResource response with status 400 is received
        And a PlanResource Error Message is included in the body
            | Message                      |
            | The Price field is required. |

    Scenario: Update existing Subscription plan
        Given I am a Plans client
        And the Plans repository has data
            | Id | Name     | Description             | Price |
            | 1  | Free     | Free plan               | 0     |
            | 2  | Personal | Plan with more benefits | 59.90 |
        When a PUT request is sent to Plans with Id 1
            | Name      | Description                  | Price |
            | Free plan | Free plan for beginner users | 0     |
        Then a PlanResource response with status 200 is received
        And a PlanResource is included in the body
            | Id | Name      | Description                  | Price |
            | 1  | Free plan | Free plan for beginner users | 0     |

    Scenario: Delete existing Subscription plan
        Given I am a Plans client
        And the Plans repository has data
            | Id | Name     | Description             | Price |
            | 1  | Free     | Free plan               | 0     |
            | 2  | Personal | Plan with more benefits | 59.90 |
        When a DELETE request is sent to Plans with Id 1
        Then a PlanResource response with status 204 is received