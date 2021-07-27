Account.seed do |s|
  s.id = 10000
  s.account_name = '博士太郎'
  s.email = 'hakase@gmail.com'
  s.password = 1234567890
  s.role = 99
  s.ex_status = 1
  
end

Account.seed do |s|
  s.id = 10001
  s.account_name = '一般太郎'
  # s.email = 'ippan@gmail.com'
  s.password = 1234567890
  s.role = 0
  s.ex_status = 0
  
end

Account.seed do |s|
  s.id = 10002
  s.account_name = '会員太郎'
  s.email = 'kaiin@gmail.com'
  s.password = 1234567890
  s.role = 50
  s.ex_status = 1
  
end