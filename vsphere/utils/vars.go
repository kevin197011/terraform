package utils

var MaxProcess = 255

var VMTpl = `
{{- range . }}
module "{{ .VMName }}-{{ .Index }}-{{ .Uuid }}" {
  source = "./modules/base"
  vm_name = "{{ .VMName }}-{{ .Index }}-{{ .Uuid }}"
  vsphere_folder = "{{ .VSphereFolder }}"
  vsphere_host_datastore = {
    host = "{{ .VsHost }}"
    datastore = "{{ .DataStore }}"  
  }
  vm_ip = "{{ .IP }}"
  vm_ipv4_gateway = "{{ .Ipv4Gateway }}"
  vm_cpu = {{ .CPU }}
  vm_mem = {{ .MEM }}
  disk_size = {{ .DiskSize }}
}
{{ end }}
`
