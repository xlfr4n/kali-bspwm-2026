#!/usr/bin/env python3
import json
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlparse

HOST = '0.0.0.0'
PORT = int(os.environ.get('LAB_PORT', '8080'))
LAB_MODE = os.environ.get('LAB_MODE', '')
if LAB_MODE != 'isolated-lab':
    raise SystemExit('Set LAB_MODE=isolated-lab to start the training target.')

USERS = {
    1: {'id': 1, 'username': 'alice', 'role': 'user'},
    2: {'id': 2, 'username': 'bob', 'role': 'user'},
    3: {'id': 3, 'username': 'labadmin', 'role': 'admin'},
}

class Handler(BaseHTTPRequestHandler):
    server_version = 'xLFr4n-WebLab/1.0'
    def respond(self, body, content_type='text/html; charset=utf-8', status=200):
        payload = body if isinstance(body, bytes) else body.encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', content_type)
        self.send_header('Content-Length', str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)
    def do_GET(self):
        parsed = urlparse(self.path)
        query = parse_qs(parsed.query)
        path = parsed.path
        if path == '/healthz':
            return self.respond(json.dumps({'status':'ok','service':'xlfr4n-web-lab'}).encode(), 'application/json; charset=utf-8')
        if path == '/':
            return self.respond('<!doctype html><title>xLFr4n Web Lab</title><h1>⚡ xLFr4n Web Lab</h1><p>Local synthetic training target.</p>')
        if path == '/search':
            value = query.get('q', [''])[0]
            return self.respond(f'<h1>Search</h1><p>You searched for: {value}</p>')
        if path.startswith('/api/users/') and path.rsplit('/', 1)[-1].isdigit():
            user = USERS.get(int(path.rsplit('/', 1)[-1]))
            if not user: return self.respond(json.dumps({'error':'not found'}).encode(), 'application/json; charset=utf-8', 404)
            return self.respond(json.dumps(user).encode(), 'application/json; charset=utf-8')
        if path == '/api/admin/users':
            return self.respond(json.dumps(list(USERS.values())).encode(), 'application/json; charset=utf-8')
        if path == '/api/config':
            return self.respond(json.dumps({'service':'xlfr4n-web-lab','training_mode':True,'environment':'isolated-lab'}).encode(), 'application/json; charset=utf-8')
        return self.respond(json.dumps({'error':'not found'}).encode(), 'application/json; charset=utf-8', 404)
    def log_message(self, fmt, *args):
        print('[WEBLAB] ' + (fmt % args), flush=True)

if __name__ == '__main__':
    print(f'⚡ xLFr4n Web Lab listening on {HOST}:{PORT}', flush=True)
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()
