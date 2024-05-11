# Calendar

## Installation

Go to the repository's root directory.

Create the empty calendar:

```
./create-calendar.sh 2024-05-06 2025-05-06 > $HOME/calendar.txt
```

Fill the calendar from any directory:

```
ln -f -s $HOME/repos/calendar/fill-calendar.sh $HOME/.local/bin/fill-calendar.sh
ln -f -s $HOME/repos/calendar/archive-past-calendar-events.sh $HOME/.local/bin/archive-past-calendar-events.sh
```

Automatically archive past events:

```bash
crontab -l | cat - <(echo "0 */6 * * * archive-past-calendar-events.sh /path/to/calender-dir") | crontab -
```

## Usage

Add one-time events:

```
echo "2024-05-06 Create calendar" >> events-one-time.txt
```

Add recurring events:

```
echo "1,3,5 Do workout" >> events-recurring.txt
echo "05-06 birthday calendar" >> events-recurring.txt
```

Fill calendar and cache results:

```
./fill-calendar.sh > calendar-future.txt
```
