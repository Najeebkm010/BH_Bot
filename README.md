# Security Scanner Discord Bot

A Discord bot that provides security scanning capabilities through simple commands. The bot integrates multiple security scanning tools including subfinder for subdomain enumeration, nmap for port scanning, and nf for additional scanning functionality.

## Features

- **Subdomain Enumeration**: Scan for subdomains using subfinder
- **Port Scanning**: Perform port scans using nmap
- **NF Scanning**: Execute nf scans for additional security checks
- **Automatic File Handling**: Results are automatically saved and cleaned up
- **Smart Output**: Sends results directly in Discord for small outputs, or as files for larger scans

## Prerequisites

Before running this bot, you need to have the following installed on your system:

- Python 3.8 or higher
- discord.py library
- subfinder
- nmap
- nf (Nuclear Fuzzer )

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Najeebkm010/BH_Bot.git
cd BH_Bot
```

2. Install Python dependencies:
```bash
pip install discord.py
```

3. Install system dependencies:
```bash
# For Debian/Ubuntu systems
sudo apt-get update
sudo apt-get install nmap

# Install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install nf (follow the tool's specific installation instructions)
```

4. Set up the configuration:
- Replace `'Your Discord Token'` in `bot.py` with your actual Discord bot token
- Ensure all shell scripts have execution permissions:
```bash
chmod +x subfinder_scan.sh nmap_scan.sh nf_scan.sh
```

## Usage

The bot responds to the following commands:

- `!subs <domain>`: Enumerate subdomains
  ```
  Example: !subs example.com
  ```

- `!port <domain>`: Perform port scanning
  ```
  Example: !port example.com
  ```

- `!nf <domain>`: Run nf scan
  ```
  Example: !nf example.com
  ```

## Project Structure

```
BH_Bot/
├── bot.py                # Main Discord bot code
├── subfinder_scan.sh     # Subfinder wrapper script
├── nmap_scan.sh          # Nmap wrapper script
├── nf_scan.sh            # NF wrapper script
└── README.md             # This file
```

## Security Considerations

- The bot automatically cleans up scan result files after sending them
- Make sure to run scans only against domains you have permission to test
- Consider implementing rate limiting and access controls
- Keep your Discord bot token secure and never share it publicly

## Error Handling

The bot includes error handling for:
- Failed scans
- File operations
- Command execution
- Discord message size limits

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Disclaimer

This tool is for educational and authorized testing purposes only. Users are responsible for ensuring they have permission to scan any target domains. The authors are not responsible for any misuse or damage caused by this tool.
