# Remote Shell Execution

Remote command execution over TCP.

Files: perl_client.pl , perl_server.pl

## Getting Started
- Running port is `8321`
- On remote machine, run : `perl perl_server.pl`
- On your machine, run `perl perl_client.pl {user_credential}`  (_Default user key is **seven**_)
- Command output can be seen on user terminal.

### Features:
- Basic Authentication
- Message is base64 encoded. _Crypto module was also used but we didn't want to install any additional libraries_
