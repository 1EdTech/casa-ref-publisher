# CASA Publisher Module

The [Community App Sharing Architecture (CASA)](http://imsglobal.github.io/casa) provides a mechanism for
discovering and sharing metadata about web resources such as websites, mobile
apps and LTI tools. It models real-world decision-making through extensible
attributes, filter and transform operations, flexible peering relationships,
etc.

This Ruby gem is part of the CASA reference implementation. It provides an
implementation of the CASA Publisher Module; further, it can be hooked into
a larger environment such as the [CASA engine](https://github.com/IMSGlobal/casa-engine).

## License

This software is **open-source** and licensed under the Apache 2 license.
The full text of the license may be found in the `LICENSE` file.

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
