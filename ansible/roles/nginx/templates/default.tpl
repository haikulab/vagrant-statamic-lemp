server {
    listen  80;

    server_name {{ ansible_eth1.ipv4.address }} {{ nginx.server_name }} default_server;

    root {{ nginx.doc_root }};
    index index.html index.php;

    location / {
        rewrite ^/admin.php.*$ /admin.php;
        try_files $uri $uri/ /index.php?$args;
    }

    error_page 404 /404.html;

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        root /var/share/nginx/www;
    }

    location ~ /(_app|_config|_content|/layouts/) {
      deny all;
    }
    location ~ /.(yml|yaml|html) { deny all; }

    location ~ \.php$ {
        gzip off;
        expires off;
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        include fastcgi_params;

        fastcgi_ignore_client_abort off;
        fastcgi_buffers 16 16k;
        fastcgi_buffer_size 32k;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_index index.php;
    }

    # location ~ \.php$ {
    #     gzip off;
    #     expires off;
    #     try_files $uri =404;
    #     fastcgi_pass unix:/var/run/php5-fpm.sock;

    #     include /etc/nginx/fastcgi_params;

    #     fastcgi_param APPLICATION_ENV "{{ application_env }}";

    #     fastcgi_index index.php;
    #     fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    # }
}
