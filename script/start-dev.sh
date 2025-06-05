#!/bin/bash

bundle exec rails server -p 3000 &
RAILS_PID=$!

cd web
npm run dev &
VITE_PID=$!

cleanup() {
    echo "[start-dev] Stopping services..."
    kill $RAILS_PID $VITE_PID
    exit
}

trap cleanup SIGINT SIGTERM

echo "[start-dev] Services started:"
echo "[start-dev] Rails API: http://localhost:3000"
echo "[start-dev] React App: http://localhost:5173"
echo "[start-dev] Ctrl+C to stop"

wait
