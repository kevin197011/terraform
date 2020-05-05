package utils

import (
	"fmt"
	"html/template"
	"log"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"sync"
)

type VMVar struct {
	Index         int
	Uuid          string
	VMName        string
	VsHost        string
	DataStore     string
	CPU           int
	MEM           int
	DiskSize      int
	IP            string
	Ipv4Gateway   string
	VSphereFolder string
}

func newVMVar(index int, uuid string, vmName string, vsHost string, dataStore string, cpuNums int, mem int, diskSize int, ipv4Gateway string, vsphereFolder string, ip string) *VMVar {
	return &VMVar{
		Index:         index,
		Uuid:          uuid,
		VMName:        vmName,
		VsHost:        vsHost,
		DataStore:     dataStore,
		CPU:           cpuNums,
		MEM:           mem,
		DiskSize:      diskSize,
		IP:            ip,
		Ipv4Gateway:   ipv4Gateway,
		VSphereFolder: vsphereFolder,
	}
}

func NewVMVarsSlice(c int, vmName string, vsHost string, dataStore string, cpuNums int, mem int, diskSize int, ipv4Gateway string, vsphereFolder string, ips []string) *[]VMVar {
	var vmVars = make([]VMVar, 0)
	//fmt.Println(ips)
	if c > len(ips) {
		log.Fatalf("需要创建主机: %v, 可用IP: %v 不满足条件,退出!", c, len(ips))
	}
	for i := 1; i < c+1; i++ {

		vmVars = append(vmVars, *newVMVar(i, Uuid(), vmName, vsHost, dataStore, cpuNums, mem, diskSize, ipv4Gateway, vsphereFolder, ips[i-1]))
	}
	return &vmVars
}

func checkHost(h string, num int, limiter chan bool, wg *sync.WaitGroup, ips *[]string) {
	var host string
	defer wg.Done()

	networkHost1 := strings.Split(h, ".")
	networkHost2 := networkHost1[:len(networkHost1)-1]
	networkHost3 := strings.Join(networkHost2, ".")

	host = networkHost3 + "." + strconv.Itoa(num)
	//log.Println(host)

	res := PingTool(host)
	if res {
		*ips = append(*ips, host)
	}
	//log.Println(ips)
	<-limiter
}

func CallCheckHost(h string) *[]string {
	var IPS []string
	limiter := make(chan bool, MaxProcess)
	wg := &sync.WaitGroup{}
	mask := 254
	for i := 1; i < mask; i++ {
		wg.Add(1)
		limiter <- true
		go checkHost(h, i, limiter, wg, &IPS)
	}
	wg.Wait()
	//log.Println(IPS)
	return &IPS

}

func UpdateTpl(s *[]VMVar) error {
	t := template.Must(template.New("").Parse(VMTpl))
	err := t.Execute(os.Stdout, s)
	if err != nil {
		return err
	}

	f, err := os.Create("./vms.tf")
	defer f.Close()
	if err != nil {
		log.Println("create file: ", err)
		return err
	}

	err = t.Execute(f, s)
	if err != nil {
		log.Print("execute: ", err)
		return err
	}
	return nil
}

func ExecTF(b bool) error {
	if b {
		initRes, err := exec.Command("terraform", "init").Output()
		if err != nil {
			return err
		}
		fmt.Println(string(initRes))
		planRes, err := exec.Command("terraform", "plan").Output()
		if err != nil {
			return err
		}
		fmt.Println(string(planRes))

		applyRes, err := exec.Command("terraform", "apply", "--auto-approve").Output()
		if err != nil {
			return err
		}
		fmt.Println(string(applyRes))
		return nil
	}
	return nil
}

func Usage() {
	fmt.Println("Usage: \n    tf-cli -h [help info]")
}
