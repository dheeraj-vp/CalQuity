#cloud-config
package_update: true
package_upgrade: true
packages:
  - curl
  - git
runcmd:
  - curl -fsSL https://get.docker.com -o get-docker.sh
  - sh get-docker.sh
  - usermod -aG docker ${admin_username}
  - systemctl enable docker
  - systemctl start docker
  - curl -SL https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
  - chmod +x /usr/local/bin/docker-compose
  - git clone --depth 1 https://github.com/supabase/supabase /home/${admin_username}/supabase
  - chown -R ${admin_username}:${admin_username} /home/${admin_username}/supabase
  - cd /home/${admin_username}/supabase/docker
  - cp .env.example .env
  - sed -i "s/^POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=${supabase_db_password}/" .env
  - docker compose up -d
