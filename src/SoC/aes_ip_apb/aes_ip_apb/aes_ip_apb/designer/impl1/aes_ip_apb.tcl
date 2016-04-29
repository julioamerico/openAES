# Created by Microsemi Libero Software 11.3.0.112
# Sun Jul 06 12:12:03 2014

# (NEW DESIGN)

# create a new design
new_design -name "aes_ip_apb" -family "SmartFusion"
set_device -die {A2F200M3F} -package {484 FBGA} -speed {-1} -voltage {1.5} -IO_DEFT_STD {LVTTL} -RESTRICTPROBEPINS {1} -TEMPR {COM} -VCCI_1.5_VOLTR {COM} -VCCI_1.8_VOLTR {COM} -VCCI_2.5_VOLTR {COM} -VCCI_3.3_VOLTR {COM} -VOLTR {COM}


# set default back-annotation base-name
set_defvar "BA_NAME" "aes_ip_apb_ba"
set_defvar "KEEP_EXISTING_PHYSICAL_CONSTRAINTS" "0"
set_defvar "SDC_IMPORT_MERGE" "0"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {E:\Julio\Projetos\IPs\AES\src\SoC\aes_ip_apb\aes_ip_apb\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"

# set working directory
set_defvar "DESDIR" "E:/Julio/Projetos/IPs/AES/src/SoC/aes_ip_apb/aes_ip_apb/designer/impl1"

# set back-annotation output directory
set_defvar "BA_DIR" "E:/Julio/Projetos/IPs/AES/src/SoC/aes_ip_apb/aes_ip_apb/designer/impl1"

# enable the export back-annotation netlist
set_defvar "BA_NETLIST_ALSO" "1"

# set EDIF options
set_defvar "EDNINFLAVOR" "GENERIC"

# set HDL options
set_defvar "NETLIST_NAMING_STYLE" "VERILOG"

# setup status report options
set_defvar "EXPORT_STATUS_REPORT" "1"
set_defvar "EXPORT_STATUS_REPORT_FILENAME" "aes_ip_apb.rpt"

# legacy audit-mode flags (left here for historical reasons)
set_defvar "AUDIT_NETLIST_FILE" "1"
set_defvar "AUDIT_DCF_FILE" "1"
set_defvar "AUDIT_PIN_FILE" "1"
set_defvar "AUDIT_ADL_FILE" "1"

# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VERILOG" {../../synthesis/aes_ip_apb.edn} \
-format "pdc"  {..\..\component\work\aes_ip_apb\aes_ip_apb.pdc}

# save the design database
save_design {aes_ip_apb.adb}
