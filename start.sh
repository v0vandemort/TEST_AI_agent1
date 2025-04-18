#!/bin/bash

echo "📂 Папка проекта: $(pwd)"
echo "🧪 Проверка виртуального окружения..."

# Создание venv, если нет
if [ ! -d "venv" ]; then
    echo "🔧 Виртуальное окружение не найдено. Создаю..."
    python3 -m venv venv
else
    echo "✅ Виртуальное окружение уже есть."
fi

# Активация окружения
source venv/bin/activate
echo "🟢 Виртуальное окружение активировано."

# Установка зависимостей
if [ -f "requirements.txt" ]; then
    echo "📦 Установка зависимостей из requirements.txt..."
    pip install --upgrade pip
    pip install -r requirements.txt
else
    echo "⚠️ Файл requirements.txt не найден!"
fi

# Проверка .env
if [ ! -f ".env" ]; then
    echo "❌ Файл .env не найден. Создай его и добавь BOT_TOKEN и OPENAI_TOKEN."
    exit 1
fi

# Проверка наличия токенов в .env
BOT_TOKEN=$(grep BOT_TOKEN .env | cut -d '=' -f2)
OPENAI_TOKEN=$(grep OPENAI_TOKEN .env | cut -d '=' -f2)

if [ -z "$BOT_TOKEN" ] || [ -z "$OPENAI_TOKEN" ]; then
    echo "⚠️ Один или оба токена пустые в .env. Проверь содержимое."
    exit 1
fi

# Запуск бота
echo "🚀 Запуск бота..."
python bot.py
