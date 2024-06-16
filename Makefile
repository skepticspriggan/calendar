#$(error DIR is $(DIR))

all : $(DIR)/calendar-future.txt

$(DIR)/calendar-future.txt : $(DIR)/events-onetime.txt $(DIR)/events-recurring.txt
		fill-calendar.sh $(DIR) > $(DIR)/calendar-future.txt
