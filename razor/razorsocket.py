#!/usr/bin/python3
import argparse
import os
import subprocess
import threading
import time
import datetime
from socketserver import TCPServer, ThreadingMixIn, StreamRequestHandler

def kill_process(process):                                      
    print("Razor timed out")                        
    process.kill()

class RequestHandler(StreamRequestHandler):

    def handle(self):

        try:
            msg = bytearray()
            while True:
                request = self.rfile.readline()
                if not request:
                    break
                msg.extend(request.rstrip() + b'\n')
            res = self.check_razor2(msg)

            res_msg = self.switch_res(res)
            self.wfile.write(res_msg.encode())
            f = open('/proc/1/fd/1', 'w')
            d = datetime.datetime.now().strftime("%b %d %H:%M:%S.%f")
            f.write(d + ' Razor2 exit code: ' + str(res) + '\n')

            d = datetime.datetime.now().strftime("%b %d %H:%M:%S.%f")
            if res_msg == 'spam' or res_msg == 'ham':
                f.write(d + ' This mail is ' + str(res_msg) + '\n')
            else:
                f.write(d + ' There is some problem checking this email' + '\n')
            f.close()
        except Exception as e:
            print(e)
        d = datetime.datetime.now().strftime("%b %d %H:%M:%S.%f")
        f = open('/proc/1/fd/1', 'w')
        f.write(d + ' Client disconnected: ' + self.client_address[0] + '\n')
        f.close()

    def check_razor2(req, msg):
        """ Checks a mail against the distributed Razor Catalogue
        by communicating with a Razor Catalogue Server.
            If we have returncode = 1 => it's not a spam
            If we have returncode = 0 => it's a spam
        :param msg: Message to be check
        :param full: Not used
        :param target: "None" by default
        :return:True if the message is listed on Rayzor
        """

        try:
            #proc = subprocess.Popen(['/usr/bin/razor-check', '-logfile=/razor.log'], stderr=subprocess.PIPE,
            proc = subprocess.Popen(['/usr/bin/razor-check', '-dl=3', '-logfile=/proc/1/fd/1'], stderr=subprocess.PIPE,
                                    stdin=subprocess.PIPE,
                                    stdout=subprocess.PIPE)
        except OSError as e:
            d = datetime.datetime.now().strftime("%b %d %H:%M:%S.%f")
            print(d + " Unable to run razor-check: %s\n", e)
            return

        my_timer = threading.Timer(10, kill_process, [proc])
        try:
            my_timer.start()
            outs, errs = proc.communicate(input=msg)
        finally:
            my_timer.cancel()

        return proc.returncode

    def switch_res(res, arg):
        switcher = {
            0: "spam",
            1: "ham"
        }
        return switcher.get(arg, "error")

class Server(ThreadingMixIn, TCPServer):
    pass

def main():
    argp = argparse.ArgumentParser(description="Expose pyzor on a socket")
    argp.add_argument("addr", help="address to listen on")
    argp.add_argument("port", help="port to listen on")
    args = argp.parse_args()

    addr = (args.addr, int(args.port))

    srv = Server(addr, RequestHandler)
    try:
        srv.serve_forever()
    finally:
        srv.server_close()


if __name__ == "__main__":
    main()

