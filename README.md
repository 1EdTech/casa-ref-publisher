# CASA Publisher Module

[![Build Status](https://travis-ci.org/AppSharing/casa-publisher.png)](https://travis-ci.org/AppSharing/casa-publisher) [![Dependency Status](https://gemnasium.com/AppSharing/casa-publisher.png)](https://gemnasium.com/AppSharing/casa-publisher) [![Code Climate](https://codeclimate.com/github/AppSharing/casa-publisher.png)](https://codeclimate.com/github/AppSharing/casa-publisher)

## Setup

Install gems via Bundler:

```
bundle
```

## Run

This module is intended to be run as part of the [CASA Engine reference implementation](https://github.com/AppSharing/casa-engine); however, it may also be run directly standalone as detailed herein.

To run with payloads as defined in the `data` directory:

```
bundle exec rackup
```

See the `example/data` directory for samples.

To run with the payloads defined in `example/data`:

```
bundle exec rackup example/config.ru
```
