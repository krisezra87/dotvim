# GNUPG (GPG) for Key Management

Sourced from https://www.youtube.com/watch?v=DMGIlj7u7Eo
## Generating a profile

gpg --full-gen-key

> Creates GNUPG directories.  Default options are fine for all except perhaps
> key expiration timeline.

## To Encrypt

gpg -r <target_email_address> -e <filename>

> At this point, may want to "shred -u" the sourced file

## To Decrypt

gpg -d <filename.gpg>

> Password is cached in gpg.
