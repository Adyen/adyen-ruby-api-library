## Overview

This is the Adyen Ruby API Library, providing Ruby developers with an easy way to interact with the Adyen API. The library is a wrapper around the Adyen API, with services generated from OpenAPI specifications.

## Code Generation

A significant portion of this library, particularly the API services, is automatically generated.

- **Engine**: We use [OpenAPI Generator](https://openapi-generator.tech/) with custom [Mustache](https://mustache.github.io/) templates to convert Adyen's OpenAPI specifications into Ruby code.
- **Templates**: The custom templates are located in the `/templates` directory. These templates are tailored to fit our custom HTTP client and service structure.
- **Automation**:
    - **Centralized**: The primary generation process is managed in a separate repository, [`adyen-sdk-automation`](https://github.com/Adyen/adyen-sdk-automation). Changes to the OpenAPI specs trigger a GitHub workflow in that repository, which generates the code and opens Pull Requests in this library.
    - **Local**: For development and testing, you must use the [`adyen-sdk-automation`](https://github.com/Adyen/adyen-sdk-automation) repository.

### Local Code Generation

To test new features or changes to the templates, you must run the generation process from a local clone of the `adyen-sdk-automation` repository.

1.  **Clone the automation repository**:
    ```bash
    git clone https://github.com/Adyen/adyen-sdk-automation.git
    ```

2.  **Link this library**: The automation project needs to target your local clone of `adyen-ruby-api-library`. From inside the `adyen-sdk-automation` directory, run the following commands. This will replace the `ruby/repo` directory with a symlink to your local project.
    ```bash
    rm -rf ruby/repo
    ln -s /path/to/your/adyen-ruby-api-library ruby/repo
    ```

3.  **Run the generator**: You can now run the Gradle commands to generate code.
    - **To generate all services for the Ruby library**:
      ```bash
      ./gradlew :ruby:services
      ```
    - **To generate a single service (e.g., Checkout)**:
      ```bash
      ./gradlew :ruby:checkout
      ```
    - **To clean the repository before generating**:
      ```bash
      ./gradlew :ruby:cleanRepo :ruby:checkout
      ```

## Core Components

- **`Adyen::Client`**: The main class in `lib/adyen/client.rb` that provides easy access to all API services and handles configuration (API key, environment, etc.).
- **`Adyen::Service`**: The base class located in `lib/adyen/services/service.rb` from which all generated services inherit. It contains the logic for making API calls.
- **`lib/adyen/services/`**: This directory contains the generated service classes (e.g., `Checkout`, `Management`) that expose methods for specific API endpoints. This library does not use generated models for requests and responses; standard Ruby Hashes are used instead.

## Development Workflow

### Setup

To install the library and its development dependencies, run:
```bash
bundle install --with development
```

### Running Tests

To run the RSpec test suite, use the following command:
```bash
bundle exec rspec
```
This is the command used in our GitHub Actions workflow to ensure code quality and correctness.

## Release Process

The release process is automated via GitHub Actions and involves two main workflows:

1.  **Release PR Creation**: After a pull request is merged to `main`, the `release.yml` workflow automatically creates a new pull request that bumps the version number in `lib/adyen/version.rb`.
2.  **Publishing to RubyGems**: Once the version bump PR is merged, a maintainer can create a GitHub Release. This can be done by manually running the `Release` workflow with the `github-release` option. The creation of a published release on GitHub triggers the `rubygems_release.yml` workflow, which publishes the new version of the gem to RubyGems.
