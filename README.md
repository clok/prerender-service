# prerender-service

Simple Docker container that runs a [Prerender](https://github.com/prerender/prerender) server with S3 caching enabled.

## Default Extensions

- sendPrerenderHeader
- blacklist
- logger
- removeScriptTags
- httpHeaders
- s3HtmlCache

## Optional Extensions

See sections below on enabling these extensions.

- s3HtmlCache
- inMemoryHtmlCache
- basicAuth
- whitelist
- blacklist

### s3HtmlCache

To enable `s3HtmlCache` just set the following **4** required environment variables at run time.

**Required Env Vars**

```
S3_BUCKET_NAME
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
```

### inMemoryHtmlCache

To use an in memory HTML cache, just set `MEMORY_CACHE=true` at runtime.


### basicAuth

To enable `basicAuth` just set the following **2** required environment variables at run time.

**Required Env Vars**

```
BASIC_AUTH_USERNAME
BASIC_AUTH_PASSWORD
```

### whitelist

Just set the environment variable `ALLOWED_DOMAINS` to the domains to permit.

Example:

```
ALLOWED_DOMAINS=www.prerender.io,prerender.io
```

### blacklist

Just set the environment variable `BLACKLISTED_DOMAINS` to the domains to block.

Example:

```
BLACKLISTED_DOMAINS=yahoo.com,www.google.com
```

## Optional Prerender Worker Env Vars

```
PRERENDER_NUM_ITERATIONS
PRERENDER_NUM_WORKERS
```
