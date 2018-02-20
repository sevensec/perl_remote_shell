use IO::Socket::INET;
use MIME::Base64;



# use Data::Dumper qw(Dumper);

# print Dumper \@ARGV;
$| = 1;

# create a connecting socket
sub make_remote_connection {
  my $socket = new IO::Socket::INET (
      PeerHost => '0.0.0.0',
      PeerPort => '8321',
      Proto => 'tcp',
  );
  die "cannot connect to the server $!\n" unless $socket;
  print "connected to the server\n";

  return $socket
}
my $our_secret = $ARGV[0];

# data to send to a server

while (1) {
    my $socket = make_remote_connection();
    my $req = <STDIN>;
    my $req = $req.$our_secret;
    my $enc_req = encode_base64($req);;
    my $size = $socket->send($enc_req);
    shutdown($socket, 1);

    # receive a response of up to 1024 characters from server
    my $response = "";
    $socket->recv($response, 1024);
    print "Remote machine: $response\n";

    # print $socket $msg;
    # print scalar <$socket>;
}
$socket->close()
    or die "Can't close socket ($!)\n";
