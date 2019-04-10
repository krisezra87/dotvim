# Mutt info

## Reading HTML
From the Arch Wiki, to read in HTML, install lynx
> pacman -S lynx

and create the file ~/.mutt/mailcap with the following contents
> text/html; lynx -assume_charset=%{charset} -display_charset=utf-8 -dump %s; nametemplate=%s.html; copiousoutput
