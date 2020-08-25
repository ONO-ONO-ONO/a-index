Account.seed do |s|
  s.id = 1
  s.account_name = '博士太郎'
  s.email = 'hakase@gmail.com'
  s.password = 1234567890
  s.role = 99
  
end

Account.seed do |s|
  s.id = 2
  s.account_name = '一般太郎'
  s.email = 'ippan@gmail.com'
  s.password = 1234567890
  s.role = 0
  
end

Account.seed do |s|
  s.id = 3
  s.account_name = '会員太郎'
  s.email = 'kaiin@gmail.com'
  s.password = 1234567890
  s.role = 10
  
end