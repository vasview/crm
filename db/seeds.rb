# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CITIES = %w[Баткен Бишкек Жалалабад Кант Карабалта Каракол Каракуль Кызыл-Кия Нарын Ош Талас Токмак]

CATEGORIES = ['A', 'B', 'C', 'D',
              'Ассоциативный член',
              'Почетный член',
              'Партнер',
              'Государственный орган']

COMMITTEES = ['Комитет по минеральным ресурсам',
              'Комитет по фискальной политике',
              'Комитет по интеллектуальной собственности',
              'Налоговый комитет',
              'Комитет по человеческим ресурсам',
              'Комитет по недвижимости и строительству',
              'Комитет по УС и КСО',
              'Комитет по туризму',
              'Комитет по финансовому рынку',
              'Cовет правления']

INDUSTRIES = ['Недропользование',
              'Производство',
              'Телекоммуникация',
              'Страхование',
              'Аудит и консальтинг',
              'Туризм',
              'Торговля',
              'Строительство',
              'Пишевая промышленность',
              'Логистика',
              'Финансовый сектор',
              'Другие услуги']

IBCSERVICES = ['Встреча',
               'Формальное мероприятие',
               'Неформальное мероприятие',
               'Поздравление (личное)',
               'Поздравление (через email)',
               'Звонок',
               'Консультация',
               'Предоставление рекомендации',
               'Информирование о деятельности МДС',
               'Законотворческая деятельность',
               'Письмо',
               'Интервью',
               'AGM',
               'Гольф турнир']

JOB_POSITIONS = ['Генеральный директор',
                 'Председатель правления',
                 'Директор по корпоративным и юридическим вопросам',
                 'Заместитель председателя правления',
                 'Управляющий партнер',
                 'Вице-президент по управлению рисками, соблюдению нормативной базы и устойчивому развитию',
                 'Старший банкир',
                 'Директор',
                 'Исполнительный директор',
                 'Управляющий директор',
                 'Менеджер']

ROLES =         {'ADMIN': 'Администратор системы. Имеет полные права.',
                 'OPERATOR': 'Оператор системы. Может создавать записи.',
                 'USER': 'Пользователь системы. Может просматривать записи.'}

USERS =          ['Асель', 'Данияр', 'Аскар', 'Лидия', 'Рустам', 'Дастан']

USER_EMAILS =   ['asel@yandex.ru', 
                 'daniyar@yandex.ru', 
                 'askar@yandex.ru',
                 'lidia@yandex.ru',
                 'rustam@yandex.ru',
                 'dastan@yandex.ru' ]                 

# Добавляем список городов
puts "Добавляем список городов"
begin
  CITIES.each do |city|
    City.create(name: city)
  end
rescue Exception => e
  puts "\x1b[31m Проблема при добавлении списка городов \x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Города успешно добавлены! \x1b[0m"
  puts "=========================="
end

# Создаем категории
puts "Создаем категории"
begin
  CATEGORIES.each do |cat|
    Category.create(title: cat)
  end
rescue Exception => e
  puts "\x1b[31mПроблема при добавлении списка категорий\x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Категории успешно добавлены! \x1b[0m"
  puts "========================="
end

# Создаем комитеты
puts "Создаем комитеты"
begin
  COMMITTEES.each do |com|
    Committee.create(title: com)
  end
rescue Exception => e
  puts "\x1b[31mПроблема при создании списка комитетов\x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Комитеты успешно добавлены! \x1b[0m"
  puts "========================="
end


# Создаем список секторов экономики
puts "Создаем список секторов экономики"

begin
  INDUSTRIES.each do |industry|
    Industry.create(title: industry)
  end
rescue Exception => e
  puts "\x1b[31mПроблема при добавлении списка секторов экономики\x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Сектора экономики успешно добавлены! \x1b[0m"
  puts "========================="
end

# Создаем список предоставляемых услуг
begin
  puts "Создаем список предоставляемых услуг"

  IBCSERVICES.each do |service|
    service == 'Поздравление (через email)' ? cost = 0.25 : cost = 1.0
    Service.create(name: service, cost: cost, committee_cost: 0.25)
  end
rescue Exception => e
  puts "\x1b[31mПроблема при добавлении списка предоставляемых услуг\x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Список предоставляемых услуг успешно добавлен! \x1b[0m"
  puts "========================="
end


# Создаем список должностей
begin
  puts "Создаем список должностей"

  JOB_POSITIONS.each do |position|
    JobPosition.create(title: position)
  end
rescue Exception => e
  puts "\x1b[31m Проблема при добавлении списка должностей \x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Список должностей успешно добавлен! \x1b[0m"
  puts "========================="
end

# Добавляем роли для пользователей системы
begin
  puts "Добавляем роли для пользователей системы"

  ROLES.each_pair{|k,v| Role.create(title: k, description: v)}
rescue Exception => e
  puts "\x1b[31m Проблема при добавлении ролей для пользователей системы \x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Список ролей пользователей системы успешно добавлен! \x1b[0m"
  puts "========================="
end

# Добавляем админа системы
begin
  puts "Добавляем админа системы"

  PASSWORD = 'Passw0rd'
  
  User.create!(firstname: 'Admin',
              job_position_id: JobPosition.find_by_title('Менеджер').id,
              role_id: Role.find_by_title('ADMIN').id,
              password: PASSWORD,
              password_confirmation: PASSWORD,
              email: 'admin@yandex.ru')
rescue Exception => e
  puts "\x1b[31m Проблема при добавлении администратора системы \x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Администратор системы успешно добавлен! \x1b[0m"
  puts "========================="
end

# Добавляем пользователей системы
begin
  puts "Добавляем пользователей системы"

  USER_PASSWORD = '123456'

<<<<<<< HEAD
  USERS.each do |user| 
=======
  USERS.each_with_index do |user, i| 
>>>>>>> #2 Seeds for system users and admin were added
    new_user = User.new
    new_user.firstname = user
    new_user.job_position = JobPosition.find_by_title('Менеджер')
    new_user.role = Role.find_by_title('OPERATOR')
    new_user.password = USER_PASSWORD
    new_user.password_confirmation = USER_PASSWORD
<<<<<<< HEAD
    new_user.email = "#{user}@yandex.ru"
=======
    new_user.email = USER_EMAILS[i]
>>>>>>> #2 Seeds for system users and admin were added
    new_user.save!
  end
rescue Exception => e
  puts "\x1b[31m Проблема при добавлении пользователей системы \x1b[0m"
  puts "Начало листинг +++++++++++++++++++++++++++++++++++"
  puts e.backtrace.join("\n")
  puts "Конец листинга +++++++++++++++++++++++++++++++++++"
else
  puts "\x1b[32m Пользователи системы успешно добавлены! \x1b[0m"
  puts "========================="
end
