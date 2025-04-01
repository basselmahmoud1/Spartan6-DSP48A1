vlib work
vlog DSP.v DSP_tb.v REG_MUX.v 
vsim -voptargs=+acc work.Spartan6_DSP48A1_tb

add wave -position insertpoint  \
sim:/Spartan6_DSP48A1_tb/B \
sim:/Spartan6_DSP48A1_tb/DUT/B0_1 \
sim:/Spartan6_DSP48A1_tb/DUT/B1_1 \
sim:/Spartan6_DSP48A1_tb/A \
sim:/Spartan6_DSP48A1_tb/DUT/A0_1 \
sim:/Spartan6_DSP48A1_tb/DUT/A1_1 \
sim:/Spartan6_DSP48A1_tb/D \
sim:/Spartan6_DSP48A1_tb/C \
sim:/Spartan6_DSP48A1_tb/M \
sim:/Spartan6_DSP48A1_tb/P \
sim:/Spartan6_DSP48A1_tb/OPMODE \
sim:/Spartan6_DSP48A1_tb/BCOUT \
sim:/Spartan6_DSP48A1_tb/PCOUT  \
sim:/Spartan6_DSP48A1_tb/DUT/X_1 \
sim:/Spartan6_DSP48A1_tb/DUT/Z_1 \
sim:/Spartan6_DSP48A1_tb/DUT/CIN \

run -all
