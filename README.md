# Image Processing

Cервис по сжатию изображений реализован в виде API с **rails 6.1.4** и **ruby 3.0.1**, 
в который пользователь загружает изображение и оно сжимается, если изображение сжато удачно, пользователь
 получает оповещение на указанную почту с сылкой на сжатое изображение, если сжать не удалось, пользователь получит уведомление на
 указанную почту.

В приложении реализовано загрузка файлов через carrierwave, обработкой изображений mini_magick,
очередями worker sidekiq, redis.
```
Ввиду того, что gem letter_opener не работает в Docker, рекомендации разработчика гема не помогли, 
а альтернатива не работает в текущей конфигурации, будет приведено два варианта установки проекта.
```
## Установка в Docker
```
$ git clone ... && cd ...
$ cp config/database.yml.example config/database.yml
$ cp config/cable.yml.example config/cable.yml
$ cp .env.example .env
$ docker-compose build
$ docker-compose run --rm runner bundle
$ docker-compose run --rm runner rails db:create
$ docker-compose run --rm runner rails db:migrate
```
## Использование Gmail почты
Прописать **username** и **password** от почты Gmail в файл **.env**
```bigquery
GMAIL_USERNAME="your username"
GMAIL_PASSWORD="your password"
``` 
## Запуск контейнеров
`$ docker-compose up`

## Классическая установка
```bigquery
$ git clone ... && cd ...
$ cp config/database.yml.example config/database.yml
$ cp config/cable.yml.example config/cable.yml
$ cp .env.example .env
$ bundle
$ rails db:create
$ rails db:migrate
$ sudo apt-get install imagemagick
```

## Использование gem letter_opener
В приложении перейти в файл `config/environments/development.rb`

Закомментировать:
```bigquery
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
       address: "smtp.gmail.com",
       port: 587,
       user_name: ENV['GMAIL_USERNAME'],
       password: ENV['GMAIL_PASSWORD'],
       authentication: :plain,
       enable_starttls_auto: true
  }
```

Убрать комментарий:
```bigquery
  config.action_mailer.default_url_options = { protocol: 'http', host: 'localhost:3000' }
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true
``` 

## Запуск приложения
```bigquery
$ rails s
$ bundle exec sidekiq
```

## Загрузка изображений
Для загрузки изображений можно использовать ***[Postman][1]***, нужно отправить **POST**
запрос с **email** и **картинкой** на адрес:

`http://localhost:3000/images/compress`

После обработки изображения, на указанный адрес придет сообщение об успешной или нет
обработке изображения.

### Допустимые форматы для загрузки - jpg/jpeg/png

[1]: https://www.postman.com/
