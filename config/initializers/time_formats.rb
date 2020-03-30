Time::DATE_FORMATS[:default] = '%Y/%m/%d %H:%M'
Time::DATE_FORMATS[:datetime] = '%Y/%m/%d %H:%M'
Time::DATE_FORMATS[:date] = '%Y/%m/%d'
Time::DATE_FORMATS[:time] = '%H:%M:%S'
Date::DATE_FORMATS[:date] = '%Y-%m-%d'
Date::DATE_FORMATS[:default] = '%Y-%m-%d'
Date::DATE_FORMATS[:monthday] = '%m/%d'


# > Time.now.to_s
#  => "2014/03/03 15:22"

# > Time.now.to_s(:date)
#  => "2014/03/03"

# > Time.now.to_s(:datetime)
#  => "2014/03/03 15:23"

# > Time.now.to_s(:time)
#  => "15:23:07" 