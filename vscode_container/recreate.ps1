docker compose down
docker compose build --no-cache #--progress plain
docker compose up -d
start-sleep -seconds 1
Start-Process "http://localhost:8080"
$containerId = docker ps --filter "ancestor=vscode_container-code-server" --format "{{.ID}}"
docker exec -it $containerId bash