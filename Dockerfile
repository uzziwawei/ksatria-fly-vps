FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update repository dan install XFCE, VNC Server, noVNC, OpenJDK, serta Supervisor
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xvfb \
    tigervnc-standalone-server \
    novnc \
    websockify \
    openjdk-21-jre \
    openjdk-21-jre-headless- \
    supervisor \
    wget \
    curl \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:1
ENV RESOLUTION=1024x768x24

WORKDIR /app

# Salin konfigurasi proses manager ke dalam sistem
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Salin file game utama ke dalam kontainer
COPY res.jar /app/res.jar

# Buka akses port 8080 untuk lalu lintas web noVNC (Sesuai port internal standar Fly.io)
EXPOSE 8080

# Berikan izin eksekusi penuh ke folder kerja agar user non-root Fly.io dapat beroperasi
RUN chmod -R 777 /app /tmp

# Pemicu utama untuk mengaktifkan seluruh proses secara simultan
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
