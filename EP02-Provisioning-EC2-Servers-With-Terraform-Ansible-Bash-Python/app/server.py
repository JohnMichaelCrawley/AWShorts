# Import list
from http.server import BaseHTTPRequestHandler, HTTPServer
import socket
import subprocess
import psutil
import os

HOSTNAME = socket.gethostname()

def get_tag():
    try:
        with open("/etc/server_tag") as f:
            return f.read().strip()
    except:
        return "Unknown"
    
def uptime():
    return subprocess.check_output("uptime -p", shell=True).decode()

def os_version():
    return subprocess.check_output("lsb_release -d", shell=True).decode().split(":")[1].strip()

def cpu():
    return str(psutil.cpu_percent(interval=1)) + "%"

def memory():
    mem = psutil.virtual_memory()
    return f"{mem.percent}% used ({round(mem.used/1024/1024/1024)}GB/{round(mem.total/1024/1024/1024)}GB)"

def disk():
    disk = psutil.disk_usage("/")
    return f"{disk.percent}% used ({round(disk.used/1024/1024/1024)}GB/{round(disk.total/1024/1024/1024)}GB)"

def load():
    return os.getloadavg()

def get_ascii():
    try:
        with open ("/etc/server_ascii") as f:
            return f.read()
    except:
        return ""

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        tag = get_tag()
        ascii_banner = get_ascii()
        page = f"""
            <!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>{tag}</title>
    </head>
    <body>
        <div class="d-flex flex-column justify-content-center align-items-center vh-100">
            <pre>{ascii_banner}</pre>
            <h1>{tag}</h1>
            <h2>Server details</h2>
            Hostname: {HOSTNAME}<br>
            Server Tag: {tag}<br>
            Uptime: {uptime()}<br>
            OS: {os_version()}<br>

            <h2>System metrics</h2>
            CPU Usage: {cpu()}<br>
            Memory Usage: {memory()}<br>
            Disk Usage: {disk()}<br>
            Load Avg: {load()}<br>
        </div>

    </body>
</html>
        """


        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(page.encode("utf-8"))

HTTPServer(("",8000), Handler).serve_forever()
