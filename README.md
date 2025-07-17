# Task Tracker API

REST API для системы управления задачами, разработанное на Ruby on Rails.

## Технологии

- Ruby on Rails 8.0.2
- PostgreSQL
- Devise + JWT
- Alba для сериализации JSON

## Обзор проекта

Task Tracker API предоставляет следующие основные возможности:

- Аутентификация пользователей через JWT
- Управление досками задач
- Управление задачами внутри досок
- Система членства в досках

### Структура базы данных (упрощенная)
![image](https://github.com/user-attachments/assets/b2b201ce-2cb6-4049-b0d5-45a1f6eceb25)


## API Endpoints

### Аутентификация

```
POST   /api/auth/signup      # Регистрация нового пользователя
POST   /api/auth/login       # Вход в систему
DELETE /api/auth/logout      # Выход из системы
```

### Доски (Boards)

```
GET    /api/boards          # Получение списка досок
POST   /api/boards          # Создание новой доски
GET    /api/boards/:id      # Получение информации о доске
PUT    /api/boards/:id      # Обновление доски
DELETE /api/boards/:id      # Удаление доски
```

### Задачи (Tasks)

```
GET    /api/boards/:board_id/tasks          # Получение списка задач доски
POST   /api/boards/:board_id/tasks          # Создание новой задачи
GET    /api/boards/:board_id/tasks/:id      # Получение информации о задаче
PUT    /api/boards/:board_id/tasks/:id      # Обновление задачи
DELETE /api/boards/:board_id/tasks/:id      # Удаление задачи
```

### Членство в досках (Board Memberships)

```
GET    /api/boards/:board_id/memberships          # Получение списка участников доски
PUT    /api/boards/:board_id/memberships/:id      # Обновление членства
DELETE /api/boards/:board_id/memberships/:id      # Удаление участника из доски
```

## Безопасность

- Все запросы к API должны быть аутентифицированы через JWT
- Токен передается в заголовке `Authorization`
- Срок действия токена 30 минут

## Разработка

1. Клонируйте репозиторий
2. Установите зависимости: `bundle install`
3. Убедитесь, что у вас установлен и запущен PostgreSQL
4. Укажите параметры подключения к базе данных через переменную окружения `DATABASE_URL`.
   ```
   $env:DATABASE_URL="postgresql://myuser:mypassword@localhost"
   ```
5. Подготовьте базу данных и выполните миграции: `rails db:prepare`
6. Запустите сервер: `rails server`

API будет доступно по адресу `http://localhost:3000`
