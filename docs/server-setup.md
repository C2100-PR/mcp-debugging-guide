# MCP Server Setup and Verification

## Initial Setup

### Environment Configuration

```bash
# Required environment variables
export MCP_SERVER_PORT=3000
export MCP_LOG_LEVEL=debug

# Optional but recommended
export MCP_INSPECTOR_ENABLED=true
```

### Verification Steps

1. Start your server
2. Use MCP Inspector to test connectivity
3. Monitor server logs

## Common Setup Issues

### Port Conflicts
- Check if port is already in use
- Verify permissions

### Environment Issues
- Missing variables
- Incorrect paths
- Permission problems

### Connection Problems
- Network configuration
- Firewall settings
- SSL/TLS issues
