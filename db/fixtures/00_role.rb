Role.seed do |s|
  s.id = 1
  s.role_id = 0
  s.role_name = '一般'
  s.ex_status = 0
  
end

Role.seed do |s|
  s.id = 2
  s.role_id = 99
  s.role_name = '博士'
  s.ex_status = 1
  
end

Role.seed do |s|
  s.id = 3
  s.role_id = 50
  s.role_name = '隊員'
  s.ex_status = 1
  
end