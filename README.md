# BEASTRO by Marshawn Lynch - Hours of Operation App

## Assumptions
- The app assumes that the JSON data provided is always in the correct format.
- Edge cases such as late-night hours and "open 24 hours" are handled by checking the end time and start time accordingly.
- Time intervals spanning past midnight are considered to belong to the starting day.

## Design Decisions
- Used SwiftUI for a modern, declarative approach to UI development.
- Employed Combine framework for data fetching to ensure real-time updates.
- Followed MVVM pattern for better separation of concerns and maintainability.
- Added basic animations for expanding and collapsing the hours list for a better user experience.
- Grouped and formatted business hours per day and combined all time segments into one day's block as required.

## Improvements
- Add more sophisticated handling for edge cases.
- Implement more robust error handling and loading states.
- Add unit tests to ensure data parsing and business logic are functioning correctly.

## Future Enhancements
- Include more detailed status updates based on current time.
- Add support for multiple locations.
- Provide localization support for different time formats and languages.

