transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/altera/Projetos/Relogio {C:/altera/Projetos/Relogio/Relogio.sv}
vlog -sv -work work +incdir+C:/altera/Projetos/Relogio {C:/altera/Projetos/Relogio/divisor_clock.sv}
vlog -sv -work work +incdir+C:/altera/Projetos/Relogio {C:/altera/Projetos/Relogio/contador_segundos.sv}
vlog -sv -work work +incdir+C:/altera/Projetos/Relogio {C:/altera/Projetos/Relogio/contador_minutos.sv}
vlog -sv -work work +incdir+C:/altera/Projetos/Relogio {C:/altera/Projetos/Relogio/contador_horas.sv}
vlog -sv -work work +incdir+C:/altera/Projetos/Relogio {C:/altera/Projetos/Relogio/decoder_7seg.sv}

