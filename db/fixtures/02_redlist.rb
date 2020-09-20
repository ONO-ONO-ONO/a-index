Redlist.seed do |s|
  s.id = 1
  s.red_list_name = 'LC'
  s.red_list_full_name = 'Least Concern'
  s.red_list_details = '低危険種'
end

Redlist.seed do |s|
  s.id = 2
  s.red_list_name = 'NT'
  s.red_list_full_name = 'Near Threatened'
  s.red_list_details = '近危険種'
end

Redlist.seed do |s|
  s.id = 3
  s.red_list_name = 'VU'
  s.red_list_full_name = 'Vulnerable'
  s.red_list_details = '危急種'
end

Redlist.seed do |s|
  s.id = 4
  s.red_list_name = 'EN'
  s.red_list_full_name = 'Endangered'
  s.red_list_details = '絶滅危惧種'
end

Redlist.seed do |s|
  s.id = 5
  s.red_list_name = 'CR'
  s.red_list_full_name = 'Critically Endangered'
  s.red_list_details = '近絶滅種'
end

Redlist.seed do |s|
  s.id = 6
  s.red_list_name = 'EW'
  s.red_list_full_name = 'Extinct in the Wild'
  s.red_list_details = '野生絶滅種'
end

Redlist.seed do |s|
  s.id = 7
  s.red_list_name = 'EX'
  s.red_list_full_name = 'Extinct'
  s.red_list_details = '絶滅種'
end

Redlist.seed do |s|
  s.id = 8
  s.red_list_name = 'DD'
  s.red_list_full_name = 'Data Deficient'
  s.red_list_details = '情報不足種'
end

Redlist.seed do |s|
  s.id = 9
  s.red_list_name = 'ND'
  s.red_list_full_name = 'Not Evaluated'
  s.red_list_details = '未評価'
end
