# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in Docvanta, please report it responsibly:

1. **Do NOT open a public issue** for security vulnerabilities
2. For upstream LiteParse vulnerabilities, follow the upstream disclosure process (security@llamaindex.ai). For Docvanta-specific issues, use this repository's private vulnerability reporting if enabled.
3. Include as much detail as possible:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Scope

### In Scope

Security issues we will address:

- Remote code execution in the CLI tool or library
- Vulnerabilities in LiteParse's own code that could be exploited
- Dependency vulnerabilities with known, exploitable CVEs

### Out of Scope

Docvanta is intended to be a local CLI tool and library, designed to process documents you provide. The following are not security vulnerabilities we will address:

- **Malicious input files** - Processing untrusted documents (zip bombs, malformed PDFs, path traversal in filenames, etc.) is the user's responsibility. If you're building a service that accepts untrusted uploads, you must implement your own validation, sandboxing, and resource limits.
- **Denial of service via large/complex files** - Documents that cause high memory usage, long processing times, or crashes are not security issues. Use `--max-pages`, timeouts, and resource limits in your deployment.
- **Issues requiring a server setup** - Docvanta does not include or recommend any specific production server deployment. Security of web services built on top of Docvanta is the deployer's responsibility.
- **Theoretical attacks without proof of concept** - Please include a working demonstration.

### Building Secure Services

If you're exposing Docvanta through a web service or API:

1. Validate uploads:  Check file types, sizes, and origins before processing
2. Use sandboxing:  Run parsing in isolated containers with resource limits
3. Set timeouts:  Don't allow unbounded processing time
4. Limit concurrency:  Prevent resource exhaustion from parallel requests
5. Don't trust filenames:  Sanitize any paths derived from user input

These concerns are standard for any document processing service and are outside Docvanta's scope.
