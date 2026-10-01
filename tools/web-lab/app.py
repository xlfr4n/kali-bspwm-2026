#!/usr/bin/env python3
import json
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlparse

HOST = '0.0.0.0'
PORT = int(os.environ.get('LAB_PORT', '8080'))

USERS = {
    1: {'id': 1, 'username': 'alice', 'role': 'user'},
    2: {'id': 2, 'username': 'bob', 'role': 'user'},
    3: {'id': 3, 'username': 'labadmin', 'role': 'admin'},
}

def json_bytes(value):
    return json.dumps(value, indent=2).encode('utf-8')

class Handler(BaseHTTPRequestHandler):
    server_version = 'xLFr4n-WebLab/1.0'

    def send_body(self, body, content_type='text/html; charset=utf-8', status=200):
        payload = body if isinstance(body, bytes) else body.encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', content_type)
        self.send_header('Content-Length', str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path
        query = parse_qs(parsed.query)

        if path == '/healthz':
            return self.send_body(json_bytes({'status': 'ok', 'service': 'xlfr4n-web-lab'}), 'application/json; charset=utf-8')

        if path == '/':
            html = ('<!doctype html><title>xLFr4n Web Lab</title>'
                    '<h1>⚡ xLFr4n Web Lab</h1>'
                    '<p>Local training target. Data is synthetic.</p>'
                    '<ul><li>/search?q=hello</li><li>/api/users/1</li>'
                    '<li>/api/admin/users</li><li>/api/config</li></ul>')
            return self.send_body(html)

        if path == '/search':
            value = query.get('q', [''])[0]
            # INTENTIONAL LAB FLAW: reflected user input is inserted without HTML escaping.
            html = f'<h1>Search</h1><p>You searched for: {value}</p>'
            return self.send_body(html)

        if path.startswith('/api/users/') and path.split('/')[-1].isdigit():
            user_id = int(path.split('/')[-1])
            user = USERS.get(user_id)
            if not user:
                return self.send_body(json_bytes({'error': 'not found'}), 'application/json; charset=utf-8', 404)
            # INTENTIONAL LAB FLAW: object access has no authorization check.
            return self.send_body(json_bytes(user), 'application/json; charset=utf-8')

        if path == '/api/admin/users':
            # INTENTIONAL LAB FLAW: admin data is exposed without authentication.
            return self.send_body(json_bytes(list(USERS.values())), 'application/json; charset=utf-8')

        if path == '/api/config':
            return self.send_body(json_bytes({
                'service': 'xlfr4n-web-lab',
                'training_mode': True,
                'environment': 'isolated-lab',
            }), 'application/json; charset=utf-8')

        return self.send_body(json_bytes({'error': 'not found'}), 'application/json; charset=utf-8', 404)

    def log_message(self, fmt, *args):
        print('[WEBLAB] ' + (fmt % args), flush=True)

if __name__ == '__main__':
    print(f'⚡ xLFr4n Web Lab listening on {HOST}:{PORT}', flush=True)
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()
