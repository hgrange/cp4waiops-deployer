# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



## [34.1.1] - 2022-06-29

Realease for 3.4.0 GA. 
Some specifics apply: please see the README file.

### Major changes

- Support for version WAIOPS 3.4
- Completely revamped the Ansible project structure

### Changed features

- All steps for demo content are now automated



## [34.1.0] - 2022-06-14

Complete rewrite for future integration into CloudPak Deployer.
The installation is now based on configuration files containing the features to be installed.
For a complete example see ./ansible/configs/cp4waiops-roks-all-33.yaml 

### Major changes

- New file structure



## [34.0.1] - 2022-06-09

Realease for Field Validation Testing. 
Some specifics apply: please see the README file.

### Major changes

- Support for version WAIOPS 3.4
- All steps can be executed sequentially as connections are getting created by the script

### Changed features

- Updated AWX based install

### Fixes

- Fix for training not running through
- Fix for Turbonomic install