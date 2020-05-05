package main

import (
	"flag"
	"fmt"
	"os"
	"sort"

	"./utils"
)

func main() {

	vName := flag.String("vName", "", "虚拟机名")
	vCpu := flag.Int("vCpu", 0, "CPU核数")
	vMem := flag.Int("vMem", 0, "内存大小")
	vDisk := flag.Int("vDisk", 0, "挂载磁盘大小")
	vHost := flag.String("vHost", "", "主机IP")
	vGateway := flag.String("vGateway", "", "主机网关")
	dataStore := flag.String("dataStore", "", "主机存储")
	vsphereFolder := flag.String("vsphereFolder", "", "虚拟机存放目录")
	vCount := flag.Int("vCount", 0, "创建主机数量")

	flag.Parse()

	if len(os.Args) == 1 {
		utils.Usage()
		return
	}

	ips := utils.CallCheckHost(*vHost)

	sort.Strings(*ips)
	fmt.Printf("\n\n未使用IP清单:\n %v\n", *ips)

	s := utils.NewVMVarsSlice(*vCount, *vName, *vHost, *dataStore, *vCpu, *vMem, *vDisk, *vGateway, *vsphereFolder, *ips)
	err := utils.UpdateTpl(s)
	if err != nil {
		panic(err)
	}

	status := true
	err = utils.ExecTF(status)
	if err != nil {
		panic(err)
	}

	fmt.Printf("\n本次创建主机IP列表:\n")
	for i := 0; i < *vCount; i++ {
		fmt.Printf("%v\n", (*ips)[i])
	}
}
