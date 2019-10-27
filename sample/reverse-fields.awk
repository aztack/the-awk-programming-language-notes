#!/usr/bin/awk
#https://stackoverflow.com/a/58567115/266726
{
  for (i = 1; i <= NF; i = i + 1) {
    # command line
    cmd = "echo '" $i "' | rev"
    
    # read output into revfield
    cmd | getline revfield

    # remove leading new line
    a = gensub(/^[\n\r]+/, "", "1", revfield)

    # print reversed field
    printf("%s", a)

    # print tab
    if (i != NF) printf("\t")

    # close command
    close(cmd)
  }
  # print new line
  print ""
}
