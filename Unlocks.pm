package Unlocks;

sub new {
  my $class = shift;

  my $data = shift;
  $data =~ m/D\t(\d+)\t(\w+)\t/;
  my $self = {
    pid  => $1,
    nick => $2,
  };

  bless $self, $class;
  return $self;
}

sub cached {
  my $class = shift;
  my $self = {
    pid  => shift,
    nick => shift,
  };

  bless $self, $class;
  return $self;
}

sub nick {
  my ($self) = @_;
  return $self->{nick};
}

sub stringify {
  my ($self) = @_;

  my $pid = $self->{pid};
  my $nick = $self->{nick};
  my $epoch = time();

  my $string = "O\n";
  $string .= "H\tpid\tnick\tasof\n";
  $string .= "D\t$pid\t$nick\t$epoch\n";
  $string .= "H\tenlisted\tofficer\n";
  $string .= "D\t0\t0\n";
  $string .= "H\tid\tstate\n";
  $string .= "D\t11\ts\n";
  $string .= "D\t22\ts\n";
  $string .= "D\t33\ts\n";
  $string .= "D\t44\ts\n";
  $string .= "D\t55\ts\n";
  $string .= "D\t66\ts\n";
  $string .= "D\t77\ts\n";
  $string .= "D\t88\ts\n";
  $string .= "D\t99\ts\n";
  $string .= "D\t111\ts\n";
  $string .= "D\t222\ts\n";
  $string .= "D\t333\ts\n";
  $string .= "D\t444\ts\n";
  $string .= "D\t555\ts\n";

  my $length = chars($string);
  
  $string .= "\$\t$length\t\$\n"; 
  return $string;
}

sub chars {
  my ($string) = @_;
 
  $string =~ s/\t//g;
  $string =~ s/\n//g;
  return length($string);
}


1;
