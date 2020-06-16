require 'erb'

def greeting(event, inviter, invitee)
  template = 'Дорогой(ая), <%= invitee %>!
  Приглашаю тебя на наше чудесное мероприятие <%= event%>!
                    Твоя <%= inviter %>' # Описываем шаблон
  renderer = ERB.new(template) # Создаём шаблонизатор
  context = binding # Захватываем контекст выполнения
  puts renderer.result(context) # Формируем строку и печатаем её
end

greeting('День народного единства', 'Сонечка', 'Артемий')

