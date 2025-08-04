# Security Scanner Discord Bot

A Discord bot that provides security scanning capabilities through simple commands. The bot integrates multiple security tools including `subfinder`, `nmap`, `nf` (Nuclear Fuzzer), `paramspider`, and `kxss` to automate basic security reconnaissance directly from Discord.

---

## ✨ Features

- **Subdomain Enumeration**: Scan for subdomains using `subfinder`
- **Port Scanning**: Perform port scans using `nmap`
- **NF Scanning**: Run Nuclear Fuzzer (nf) scans for security testing
- **XSS Detection**: Discover reflected XSS using `paramspider` + `kxss`
- **IP Lookup**: Resolve domain to IP address using built-in Python libraries
- **Smart Output**: Results sent directly in Discord if small, or uploaded as a file if large
- **Automatic Cleanup**: Temporary result files are removed after sending
- **Basic Error Filtering**: Logs only real errors, ignores tool info/debug output

---

## 🧰 Prerequisites

Make sure you have the following installed and accessible from your system's PATH:

- Python 3.8+
- `discord.py` library
- [`subfinder`](https://github.com/projectdiscovery/subfinder)
- [`nmap`](https://nmap.org/)
- [`nf` (Nuclear Fuzzer)](https://github.com/devanshbatham/Nuclear)
- [`paramspider`](https://github.com/devanshbatham/paramspider)
- [`kxss`](https://github.com/tomnomnom/kxss)
- Go language (for subfinder and kxss)

---

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
golang git

# Install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install paramspider
git clone https://github.com/devanshbatham/paramspider
cd paramspider && pip install -r requirements.txt && cd ..

# Install kxss
go install github.com/tomnomnom/kxss@latest

# Install nf (Nuclear Fuzzer)
git clone https://github.com/devanshbatham/Nuclear
cd Nuclear && pip install -r requirements.txt && cd ..

# Install nf (follow the tool's specific installation instructions)
```

4. Set Execution Permissions
chmod +x subfinder_scan.sh nmap_scan.sh nf_scan.sh

5. Configure Bot
Replace 'Your Discord Token' in bot.py with your actual Discord Bot Token

## Usage

Once the bot is running, use the following commands in your Discord server:

```
| Command          | Description                                 |
| ---------------- | ------------------------------------------- |
| `!subs <domain>` | Enumerate subdomains                        |
| `!port <domain>` | Perform port scanning                       |
| `!nf <domain>`   | Run Nuclear Fuzzer scan                     |
| `!xss <domain>`  | Detect reflected XSS via paramspider + kxss |
| `!ip <domain>`   | Resolve domain to IP address                |
```

Example usage:

```
!subs example.com
!port example.com
!nf example.com
!xss testphp.vulnweb.com
!ip google.com
```

## Project Structure

```
BH_Bot/
├── bot.py                # Main bot logic
├── subfinder_scan.sh     # Subfinder wrapper script
├── nmap_scan.sh          # Nmap wrapper script
├── nf_scan.sh            # Nuclear wrapper script
├── getips.sh             # IP crawling script
├── xss_scan.sh           # XSS script
└── README.md             # This file
```

## Security Considerations

- Cleanup: All temporary files are deleted after execution
- Permissions: Only scan domains you are authorized to test
- Token Safety: Never share your Discord token publicly
- Rate Limiting: Consider implementing user access control

## Error Handling

The bot includes error handling for:
- Tool execution failures
- Missing output files
- Message size limits (Discord max 2000 characters)
- Logs only serious errors, filters out harmless info/debug logs

## Contributing

Contributions are welcome! Feel free to submit a pull request with improvements or new features.

## Disclaimer

This tool is intended only for educational and authorized testing purposes. Scanning unauthorized targets may be illegal. The authors are not responsible for any misuse or damage caused by this tool.


Let me know if you'd like:
- a badge-style README (`![build]`, etc.)
- screenshots of the bot in action
- a Docker setup for easier deployment
