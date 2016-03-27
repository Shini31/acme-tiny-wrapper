acme-tiny-wrapper
=================


#Review
Bash script using acme-tiny for renew let's encrypt certificates

#Version
1.0

#Requirements
* Python
* [acme-tiny](https://github.com/diafygi/acme-tiny)

#Installation
* Clone the repository (`git clone https://github.com/Shini31/acme-tiny-wrapper`) or download and unpack the archives
* Modify [renew_certificates.sh](renew_certificates.sh) with correct directories
* Create a cron job: `* * 1 * *  /path/to/renew_certificate.sh`

#Configuration
Change these following variables according to your acme-tiny installation:
* `HTTPSERVER`: Name of your HTTP web server
* `PYTHONDIR`: Path to python binary
* `ACMEDIR`: Path to acme-tiny binary
* `ACMETINY`: Name of acme-tiny binary
* `ACMECHALLENGESDIR`: Path to challenges directory
* `ACMEDOMAINDIR`: Path to domains directory
* `ACMESECRETSDIR`: Path to Let's Encrypt account private key
* `ACCOUNTKEY`: Name of Let's Encrypt account private key
* `DOMAINS`: List of your domains
