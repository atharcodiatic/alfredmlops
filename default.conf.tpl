server {
    listen 8080;
    server_name localhost;

    # Static files
    location /static/ {
        alias /app/staticfiles/;  # Make sure this matches your Docker volume
        access_log off;
        expires 7d;
        add_header Cache-Control "public, max-age=604800";
    }

    # Django app
    location / {
        proxy_pass http://web:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
