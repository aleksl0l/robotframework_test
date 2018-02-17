#!/usr/bin/env python
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
from sys import argv
import re


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        print(self.headers)
        if re.match(r'^[a-zA-Z0-9]{,12}$', self.headers['IMSI']):
            self.send_response(200)
        else:
            self.send_response(406)
        self.end_headers()


def run(server_class=HTTPServer, handler_class=Handler, port=60000):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting serving...'
    httpd.serve_forever()

if __name__ == "__main__":
    if len(argv) == 2:
        run(port=int(argv[1]))
    else:
        run()
