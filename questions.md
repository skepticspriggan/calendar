# Questions

## Why is no separator added between different types of events that happen at the same date?

_What are the steps to reproduce the problem?_

```
git checkout 72417b1eb1c52a2df73974837bcb687642c7851d
```

Create an empty calendar:

```
./create-calendar.sh 2024-05-06 2025-05-06 > calendar.txt
```

Add different types of events at the same date:

```
echo "2024-05-06 w19 1 Create calendar" >> events-one-time.txt
echo "1 Do workout" >> events-recurring.txt
```

Fill the calendar.

```bash
./fill-calendar.sh
```

_What is the expected result?_

The events are separated by a semicolon:

```
2024-05-06 w19 1 Create calendar; Do workout
```

_What happens instead?_

The events are appended without a semicolon:

```
2024-05-06 w19 1 Create calendar Do workout
```

_Answer_

The variable `event_printed` inside the while loop is different from the one outside. Piping input to a while loop creates a sub-shell with a new scope. Therefore, `event_printed` always evaluates to false and does not add a separator.
