package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"net"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/domainr/whois"
	"github.com/likexian/doh-go"
	"github.com/likexian/simplejson-go"
	"github.com/projectdiscovery/shodan/v2/pkg/shodan"
	"github.com/tidwall/gjson"
)

var (
	resolver        = "1.1.1.1"
	ipinfoToken     string
	hostFile        string
	shodanAPIKey    string
	shodanClient    *shodan.Client
	shodanCache     = make(map[string]shodanResponse)
	httpClient      = &http.Client{Timeout: 10 * time.Second}
)

type shodanResponse struct {
	OpenPorts []int
	Vulns     []string
}

type ipInfoResponse struct {
	ASN          string `json:"asn"`
	Organization string `json:"org"`
	City         string `json:"city"`
	Region       string `json:"region"`
	Country      string `json:"country"`
}

func main() {
	flag.StringVar(&hostFile, "hostfile", "", "A txt file with hosts per newline")
	flag.StringVar(&ipinfoToken, "ipinfo-token", "", "API token for ipinfo.com")
	flag.StringVar(&shodanAPIKey, "shodan-apikey", "", "API key for Shodan")
	flag.Parse()

	if hostFile == "" {
		fmt.Println("[ERROR] missing required flag: --hostfile")
		os.Exit(1)
	}

	if ipinfoToken == "" {
		fmt.Println("[ERROR] missing required flag: --ipinfo-token")
		os.Exit(1)
	}

	if shodanAPIKey == "" {
		fmt.Println("[ERROR] missing required flag: --shodan-apikey")
		os.Exit(1)
	}

	shodanClient = shodan.NewClient(nil, shodanAPIKey)

	hosts, err := readHostFile(hostFile)
	if err != nil {
		fmt.Printf("[ERROR] failed to read host file: %v\n", err)
		os.Exit(1)
	}

	ips, err := resolveHosts(hosts)
	if err != nil {
		fmt.Printf("[ERROR] failed to resolve hosts: %v\n", err)
		os.Exit(1)
	}

	results := make([][]string, len(hosts))
	for i, host := range hosts {
		ip := ips[i]
		openPorts, vulns, err := getShodanInfo(ip)
		if err != nil {
			fmt.Printf("[WARN] failed to get Shodan info for %s: %v\n", host, err)
		}
		ipInfo, err := getIpInfo(ip)
		if err != nil {
			fmt.Printf("[WARN] failed to get IP info for %s: %v\n", host, err)
		}
		results[i] = []string{
			fmt.Sprintf("HOST-%d", i),
			getRootDomain(host),
			host,
			ip,
			intSliceToString(openPorts),
			strings.Join(vulns, ","),
			ipInfo.ASN,
			ipInfo.Organization,
			ipInfo.City,
			ipInfo.Region,
			ipInfo.Country,
		}
	}

	fmt.Println("ID;ROOT;DOMAIN;IP;PORTS;CVE;ASN;ORG;CITY;REGION;COUNTRY")
	for _, result := range results {
		fmt.Println(strings.Join(result, ";"))
	}
}

func readHostFile(filename string)
