# MCP Debugging Guide

A comprehensive guide to debugging Model Context Protocol (MCP) integrations. This guide is currently focused on macOS, with guides for other platforms coming soon.

## Table of Contents

- [Overview](#overview)
- [Tools](#tools)
- [Installation](#installation)
- [Documentation](#documentation)

## Overview

This repository contains detailed documentation and examples for debugging MCP servers and integrations. Whether you're developing a new MCP server or integrating existing ones into your applications, you'll find resources here to help you debug effectively.

## Tools

The MCP ecosystem provides several debugging tools:

- **MCP Inspector**: Interactive debugging interface and direct server testing
- **Claude Desktop Developer Tools**: Integration testing and log collection
- **Server Logging**: Custom logging implementations and error tracking

## Installation

To access Chrome DevTools in Claude Desktop:

```bash
jq '.allowDevTools = true' ~/Library/Application\ Support/Claude/developer_settings.json > tmp.json \
  && mv tmp.json ~/Library/Application\ Support/Claude/developer_settings.json
```

Open DevTools with: Command-Option-Shift-i

## Documentation

- [Getting Started](docs/getting-started.md)
- [Debugging Tools](docs/debugging-tools.md)
- [Common Issues](docs/common-issues.md)
- [Logging Guide](docs/logging-guide.md)
- [Security Guidelines](docs/security.md)
- [Best Practices](docs/best-practices.md)

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.