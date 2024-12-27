# Debugging US-West1 MCP Google Search Implementation

## Setup Verification

### Environment Configuration
```bash
# Required for US-West1 MCP
export MCP_REGION=us-west1
export GOOGLE_API_KEY=your_key
export GOOGLE_SEARCH_ENGINE_ID=your_cse_id
```

## Common Debug Scenarios

### Search Request Issues
1. **API Authentication**
   - Verify API key validity
   - Check quota limits
   - Monitor rate limiting

2. **Search Engine Configuration**
   - Verify CSE ID
   - Check search restrictions
   - Monitor search parameters

### Response Processing
1. **Data Parsing**
   - Validate response format
   - Check field mappings
   - Monitor result counts

2. **Error Handling**
   - Log API errors
   - Handle timeouts
   - Manage quotas

## Debugging Tools

### MCP Inspector for Search
```javascript
// Test search functionality
await inspector.testSearch({
  query: "test query",
  region: "us-west1"
});
```

### Logging Best Practices
1. **Request Logging**
   - Log search queries
   - Track request parameters
   - Monitor timing

2. **Response Logging**
   - Log result counts
   - Track error rates
   - Monitor performance

## Troubleshooting Steps

1. Verify Environment
   - Check all required env vars
   - Validate API credentials
   - Test basic connectivity

2. Test Search Flow
   - Use Inspector for direct tests
   - Monitor request/response cycle
   - Check error handling

3. Performance Analysis
   - Monitor response times
   - Track resource usage
   - Optimize as needed
