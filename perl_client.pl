use IO::Socket::INET;
use MIME::Base64;

$| = 1;
my $our_secret = "asd";
if (@ARGV) {
    $our_secret = $ARGV[0];

} else {
    print "Please add username credentials : 'perl perl_client.pl {user_cred}' \n";
    exit;
}



sub make_remote_connection {
  my $socket = new IO::Socket::INET (
      PeerHost => '0.0.0.0',
      PeerPort => '8321',
      Proto => 'tcp',
  );
  die "Server connection failed $!\n" unless $socket;

  print "connected to the server\n";
  return $socket
}


while (1) {

    my $socket = make_remote_connection();
    my $req = <STDIN>;
    my $req = encode_base64($req);
    my $key = encode_base64($our_secret);
    # print $key;
    my $enc_req = $req.$key;
    # my $enc_req = encode_base64($req);
    my $size = $socket->send($enc_req);
    shutdown($socket, 1);

    my $response = "";
    $socket->recv($response, 1024);
    print "Remote machine: $response\n";
}
$socket->close() or die "Can't close socket ($!)\n";
