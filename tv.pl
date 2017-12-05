#!/usr/bin/perl

my $outfile = pop(@ARGV);
my @videos = @ARGV;

my $filesList = "concat:";
my $i=0;

foreach $video (@videos) {
	$i++;
	my $tempFile="part$i.ts";
	system("ffmpeg", "-i", $video, "-c", "copy", "-bsf:v", "h264_mp4toannexb", "-f", "mpegts", $tempFile);
	$filesList="$filesList$tempFile|";
}

chop($filesList);

system("ffmpeg", "-i", $filesList, "-c", "copy", "-bsf:a", "aac_adtstoasc", $outfile);

for  my $z (1..$i) {
	my $tempFile = "part$z.ts";
	system("rm", $tempFile);
}