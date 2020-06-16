require "erb"

# Класс для предоставления данных в шаблон
class Product
  def initialize(category, name, cost)
    @category = category
    @name = name
    @cost = cost
#    @features = []
  end

  def add_feature(feature)
    @features << feature
  end

  # Получение доступа к контексту объекта
  def get_binding
    binding
  end
end

# Описываем шаблон
template = <<~TEMPLATE
  <!DOCTYPE html>
  <html>
    <head><title>Магазин --</title></head>
    <body>

      <h1><%= @name %> (<%= @code %>)</h1>
      <p><%= @desc %></p>

      <p>
        <% if @category == :dress%>
          <b>Купите отличное платье !!!</b>
          <b>Цена: <%= @cost%></b>
          <b>Название: <%= @name%></b>
        <% else if @category == :shoes%>
          <b>Купите отличные ботинки !!!</b>
          <b>Цена: <%= @cost%></b>
          <b>Название: <%= @name%></b>
        <% else if @category == :tools%>
          <b>Купите отличные инструменты !!!</b>
          <b>Цена: <%= @cost%></b>
          <b>Название: <%= @name%></b>
        <% end %>
      </p>
    </body>
  </html>
TEMPLATE

# Создаём шаблонизатор и передаём ему шаблон для работы
rhtml = ERB.new(template)

# Заполняем объект с данными для отображения
dress = Product.new(dress,
                  "H&M",
                  999.95)
#toy.add_feature("Понимает голосовые команды на языке Ruby!")
#toy.add_feature("Игнорирует запросы на Perl, Java и всех вариантах языка Си")
#toy.add_feature("Знает карате!")
#toy.add_feature("Личная подпись Matz на левой ноге!")
#toy.add_feature("Глаза инкрустированы драгоценными камнями... Рубинами, конечно!")

# Формируем результат
rhtml.run(dress.get_binding)