package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"net"
	"net/http"
	"os"
	"strings"
	"sync"

	"github.com/domainr/tldextract"
	"github.com/miekg/dns"
	"github.com/shadowscatcher/shodan"
)

var dnsServer = "1.1.1.1"

type ipinfoResponse struct {
	IP          string `json:"ip"`
	ASN         string `json:"asn"`
	Org         string `json:"org"`
	City        string `json:"city"`
	Region      string `json:"region"`
	Country     string `json:"country"`
	Postal      string `json:"postal"`
	Latitude    string `json:"latitude"`
	Longitude   string `json:"longitude"`
	Timezone    string `json:"timezone"`
	Hostname    string `json:"hostname"`
	Network     string `json:"network"`
	Anycast     bool   `json:"anycast"`
	ThreatLevel int    `json:"threat_level"`
}

type shodanResponse struct {
	IP    string   `json:"ip"`
	Ports []int    `json:"ports"`
	Vulns []string `json:"vulns"`
}

type prscanResult struct {
	Domains       []string
	IPs           []string
	OpenPorts     []string
	Vulns         []string
	ASN           []string
	Organization  []string
	City          []string
	Region        []string
	Country       []string
}

func prscan(hostfile string, ipinfoToken string) {
	var domains []string

	file, err := os.Open(hostfile)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		domains = append(domains, strings.TrimSpace(scanner.Text()))
	}
	if err := scanner.Err(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	// get unique hosts by converting to set and back
	uniqueDomains := make(map[string]bool)
	for _, domain := range domains {
		uniqueDomains[domain] = true
	}
	domains = make([]string, 0, len(uniqueDomains))
	for domain := range uniqueDomains {
		domains = append(domains, domain)
	}

	ips := make([]string, len(domains))
	wg := sync.WaitGroup{}
	wg.Add(len(domains))
	for i, domain := range domains {
		go func(i int, domain string) {
			defer wg.Done()
			dnsresolver := dns.Client{}
			dnsresolver.Net = "udp"
			dnsresolver.Timeout = 5 * time.Second
			m := dns.Msg{}
			m.SetQuestion(domain+".", dns.TypeA)
			r, _, err := dnsresolver.Exchange(&m, dnsServer+":53")
			if err != nil {
				fmt.Println(err)
				return
			}
			if len(r.Answer) == 0 {
				return
			}
			ip := r.Answer[0].(*dns.A).A.String()
			ips[i] = ip
		}(i, domain)
	}
	wg.Wait()

	client := shodan.NewClient(nil, "")
	result := make([]prscanResult, len(domains))

	for i, ip := range ips {
		if ip == "" {
			continue
		}
		openPorts := make([]string, 0)
		vulns := make([]string, 0)
		asn := ""
		organization := ""
		city := ""
