echo on
ghdl -a reg13bits.vhd
ghdl -e reg13bits
ghdl -a bancreg.vhd
ghdl -e bancreg
ghdl -a maquina_de_estados.vhd
ghdl -e maquina_de_estados
ghdl -a mux_2_entradas.vhd
ghdl -e mux_2_entradas
ghdl -a mux_pc.vhd
ghdl -e mux_pc
ghdl -a pc.vhd
ghdl -e pc
ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a rom.vhd
ghdl -e rom
ghdl -a ram.vhd
ghdl -e ram
ghdl -a mux2e7bits.vhd
ghdl -e mux2e7bits
ghdl -a somaum.vhd
ghdl -e somaum
ghdl -a uc.vhd
ghdl -e uc
ghdl -a ula.vhd
ghdl -e ula
ghdl -a reg1bit.vhd
ghdl -e reg1bit
ghdl -a jump_controller.vhd
ghdl -e jump_controller
ghdl -a toplevelgeral.vhd
ghdl -e toplevelgeral


ghdl -a reg13bits.vhd
ghdl -e reg13bits
ghdl -a bancreg.vhd
ghdl -e bancreg
ghdl -a maquina_de_estados.vhd
ghdl -e maquina_de_estados
ghdl -a mux_2_entradas.vhd
ghdl -e mux_2_entradas
ghdl -a mux_pc.vhd
ghdl -e mux_pc
ghdl -a pc.vhd
ghdl -e pc
ghdl -a reg16bits.vhd
ghdl -e reg16bits
ghdl -a rom.vhd
ghdl -e rom
ghdl -a ram.vhd
ghdl -e ram
ghdl -a mux2e7bits.vhd
ghdl -e mux2e7bits
ghdl -a somaum.vhd
ghdl -e somaum
ghdl -a uc.vhd
ghdl -e uc
ghdl -a ula.vhd
ghdl -e ula
ghdl -a reg1bit.vhd
ghdl -e reg1bit
ghdl -a jump_controller.vhd
ghdl -e jump_controller
ghdl -a toplevelgeral.vhd
ghdl -e toplevelgeral


ghdl -a processador_tb.vhd
ghdl -e processador_tb
ghdl -r processador_tb --stop-time=150000ns --wave=processador_tb.ghw
gtkwave processador_tb.ghw --save=OndaProc.gtkw
PAUSE

