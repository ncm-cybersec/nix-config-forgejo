# ==========================================================================
# Nixos System - Security Tools For Homelab Testing
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{

  environment.systemPackages = with pkgs; [
     
     # Code
     trufflehog

     # Containers
     trivy

     # Exploit Testing
     exploitdb
     metasploit

     # Forensics
     autopsy
     ddrescue
     sleuthkit
     volatility3

     # Fuzzers
     ffuf
     regexploit
     wfuzz

     # General
     cyberchef
     dorkscout
     it-tools

     # Host
     chkrootkit
     lynis
     vulnix

     # Load Testing
     ddosify

     # Malware Analysis
     ghidra
     yara
     yara-x

     # OSINT
     maltego
     theharvester

     # Passwords
     hashcat
     hashcat-utils
     hashdeep
     john

     # Proxies
     burpsuite
     caido-cli
     caido-desktop
     proxychains

     # Vulnerability Scanning
     nuclei
     nuclei-templates

     # Web
     nikto
     xsubfind3r
     

  ]);
}