new_project \
    -name {aes_ip_apb} \
    -location {E:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\designer\impl1\aes_ip_apb_fp} \
    -mode {single}
set_device_type -type {A2F200M3F}
set_device_package -package {484 FBGA}
update_programming_file \
    -feature {prog_fpga:on} \
    -fdb_source {fdb} \
    -fdb_file {E:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\designer\impl1\aes_ip_apb.fdb} \
    -feature {prog_from:off} \
    -feature {prog_nvm:on} \
    -efm_content {location:0;source:efc} \
    -efm_block {location:0;config_file:{E:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\component\work\aes_ip_apb_MSS\MSS_ENVM_0\MSS_ENVM_0.efc}} \
    -pdb_file {E:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\designer\impl1\aes_ip_apb_fp\aes_ip_apb.pdb}
set_programming_action -action {PROGRAM}
catch {run_selected_actions} return_val
save_project
close_project
if { $return_val != 0 } {
  exit 1 }
