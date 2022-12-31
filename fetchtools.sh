! /bin/bash

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest

go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest

go install github.com/projectdiscovery/asnmap/cmd/asnmap@latest

go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

go install -v github.com/lc/gau/v2/cmd/gau@latest

go install -v github.com/lc/subjs@latest
