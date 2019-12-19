Feature: Sortable Planning Columns
  In order to make sense of data
  As a user
  I want to order any column ascending or descending at will

  @javascript
  Scenario Outline: Every non-US-formatted date column sortable by clicking header
    Given 3 employees
      And I'm on the planning page
    When I click the "<header>" column header
      Then table rows are sorted by ascending "<header>"
    When I click the "<header>" column header
      Then table rows are sorted by descending "<header>"
    Examples:
      | header              |
      | First Name          |
      | Last Name           |
      | Current             |
      | Since               |
      | Previous            |
      | Proposed Raise      |
      | Proposal Discussion |

  @javascript
  Scenario Outline: Every US-formatted date column sortable by clicking header
    Given 3 employees
      And I'm on the planning page
    When I click the "<header>" column header
      Then table US date rows are sorted by ascending "<header>"
    When I click the "<header>" column header
      Then table US date rows are sorted by descending "<header>"
    Examples:
      | header        |
      | Proposed Date |
