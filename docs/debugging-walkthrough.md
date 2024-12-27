# Step-by-Step Debugging Walkthrough

## Common Scenarios

### Scenario 1: API Authentication Failed

1. **Check Environment Variables**
```bash
echo $GOOGLE_API_KEY
echo $GOOGLE_CSE_ID
```

2. **Verify API Key Status**
- Check Google Cloud Console
- Verify billing status
- Check usage quotas

3. **Test Direct API Access**
```bash
curl -H "Authorization: Bearer $GOOGLE_API_KEY" \
     "https://www.googleapis.com/customsearch/v1?key=${GOOGLE_API_KEY}&cx=${GOOGLE_CSE_ID}&q=test"
```

### Scenario 2: No Results Returned

1. **Check Query Formation**
```javascript
console.log('Query parameters:', {
  key: process.env.GOOGLE_API_KEY,
  cx: process.env.GOOGLE_CSE_ID,
  q: searchQuery
});
```

2. **Verify Search Engine Settings**
- Check CSE configuration
- Verify search restrictions
- Test direct in CSE interface

3. **Monitor Network Requests**
```javascript
axios.interceptors.request.use(request => {
  console.log('Request:', {
    url: request.url,
    method: request.method,
    params: request.params
  });
  return request;
});
```

### Scenario 3: Performance Issues

1. **Profile Request Timing**
```javascript
const startTime = process.hrtime();
try {
  const results = await performSearch(query);
  const [seconds, nanoseconds] = process.hrtime(startTime);
  console.log(`Search took ${seconds}s ${nanoseconds/1000000}ms`);
  return results;
} catch (error) {
  console.error('Search failed:', error);
  throw error;
}
```

2. **Check Resource Usage**
```javascript
const usage = process.memoryUsage();
console.log('Memory usage:', {
  heapTotal: `${Math.round(usage.heapTotal / 1024 / 1024)} MB`,
  heapUsed: `${Math.round(usage.heapUsed / 1024 / 1024)} MB`
});
```

3. **Monitor Rate Limits**
```javascript
class RateLimitMonitor {
  constructor() {
    this.requests = [];
    this.windowMs = 60000; // 1 minute
  }

  trackRequest() {
    const now = Date.now();
    this.requests = this.requests.filter(time => time > now - this.windowMs);
    this.requests.push(now);
    
    console.log(`Requests in last minute: ${this.requests.length}`);
    if (this.requests.length > 100) {
      console.warn('Rate limit warning: High request volume');
    }
  }
}
```

## Integration Testing

### Test Suite Setup
```javascript
const { MCPServer } = require('@modelcontextprotocol/server');
const { GoogleSearchProvider } = require('./providers/google-search');

describe('Google Search Integration', () => {
  let server;
  let provider;

  beforeEach(() => {
    provider = new GoogleSearchProvider({
      apiKey: process.env.GOOGLE_API_KEY,
      searchEngineId: process.env.GOOGLE_CSE_ID
    });
    
    server = new MCPServer({
      region: 'us-west1',
      providers: [provider]
    });
  });

  test('should handle basic search', async () => {
    const results = await provider.search('test query');
    expect(results).toBeDefined();
    expect(Array.isArray(results.items)).toBe(true);
  });

  test('should handle empty results', async () => {
    const results = await provider.search('xyzabc123nonexistent');
    expect(results.items).toHaveLength(0);
  });

  test('should respect result limit', async () => {
    const limit = 5;
    const results = await provider.search('test', { limit });
    expect(results.items.length).toBeLessThanOrEqual(limit);
  });
});
```