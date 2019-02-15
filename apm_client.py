import socket


def get_apm():
  try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(('localhost', 9006))
    apm = s.recv(1024)
    print(apm)
  except socket.error:
    print(0)


def main():
  get_apm()


if __name__ == '__main__':
  main()
