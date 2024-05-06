# Technical Design

## Data Entities

**How will the weekday be printed**

The weekday is specified by a number from 1 through 7, starting with Monday and ending on Sunday (standard from ISO 8601.)

1. Monday
2. Tuesday
3. Wednesday
4. Thursday
5. Friday
6. Saturday
7. Sunday

The number weekday format is the simplest.

- _Easy to process:_ Numbers are language independent unlike weekday names making it easy to generate and process. When a language dependent word is used (e.g. Zaterdag) it would be much more work to fill the calendar with recurring events that happen on each weekday since each language has other names.
- _Compact:_ Numbers reduce noise and leave more room for the events.

## Architecture

**How will the empty calendar be created?**

Use a bash script to create the empty calendar. Bash is widely available and it can easily loop through dates and print it in the desired format.

**How will the calendar be filled?**

Use go to fill the calendar.

Bash is harder to use in this more complicated use-case. It is difficult to add a separator between different types of events that occur at the same date because the while loops in bash create a new scope from which outer variables cannot be called.

**How will the input calendar and events be parameterized?**

_Option 1 - Explicit in config_

Features:
- More complex

Note that the calendar can be printed from anywhere.

_Option 2 - Implicit by directory of execution_

Features:
- Simpler

Note that the calendar can only be printed from the directory in which it is stored.

_Conclusion_

Parameterize the input by looking for it in the directory from which the command is called.
