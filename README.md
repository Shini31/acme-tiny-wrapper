acme-tiny-wrapper
=================


# Review
Bash script using acme.sh for renewing let's encrypt certificates

# Version
2.0

# Requirements
* Bash
* [acme.sh](https://github.com/Neilpang/acme.sh)

# Installation
* Clone the repository (`git clone https://github.com/Shini31/acme-wrapper`) or download and unpack the archives
* Modify [renew_certificates.sh](renew_certificates.sh) with correct directories and domain name
* Create a cron job: `* * 1 * *  /path/to/renew_certificate.sh`

# Configuration
Change these following variables according to your certificates, acme.sh installation and web server:
* `HTTPSERVER`: Name of your HTTP web server
* `ACMEDIR`: Path to acme.sh binary
* `ACMETINY`: Name of acme.sh binary
* `ACMEDOMAINDIR`: Path to domains directory
* `ACMESECRETSDIR`: Path to Let's Encrypt account private key
* `ACCOUNTKEY`: Name of Let's Encrypt account private key
* `DOMAINS`: List of your domains
