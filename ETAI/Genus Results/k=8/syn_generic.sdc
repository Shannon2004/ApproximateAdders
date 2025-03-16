# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.10-p002_1 on Thu Nov 14 22:58:37 IST 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design ETAI8

set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
