Simulação do Relógio Digital no ModelSim (Quartus 13.0)
=================================================================

Este projeto implementa um relógio digital com contagem de horas, minutos e segundos, 
mostrando os valores em displays de 7 segmentos simulados. A simulação é feita no 
ModelSim-Altera incluído no Quartus 13.0, com clock de 50MHz e divisão para 1Hz.

=======================
1. Estrutura do Projeto
=======================

Arquivos necessários:
- contador_horas.sv
- contador_minutos.sv
- contador_segundos.sv
- decoder_7seg.sv
- divisor_clock.sv
- Relogio.sv        ← Módulo principal (top-level)
- Relogio_tb.sv     ← Testbench de simulação

======================
2. Preparação do Setup
======================

1. Abra o Quartus 13.0
2. Crie um novo projeto com os seguintes passos:
   - File → New Project Wizard
   - Nome do projeto: `RelogioDigital`
   - Diretório: escolha onde estão os arquivos `.sv`
   - Selecione qualquer FPGA (ex: Cyclone IV, EP4CE22F17C6) só para completar o assistente

3. Vá em:
   - Assignments → Settings → Simulation → Tool name: **ModelSim-Altera**
   - Language: **SystemVerilog**

4. Adicione os arquivos ao projeto:
   - Project → Add/Remove Files in Project
   - Adicione todos os arquivos `.sv` listados acima

5. Defina o módulo top-level de simulação:
   - Vá em "Simulation" e defina `Relogio_tb` como Top-Level Simulation Entity

==============================
3. Rodando a Simulação no ModelSim
==============================

1. Vá em:
   - Tools → Run Simulation Tool → RTL Simulation (isso abrirá o ModelSim)

2. No ModelSim, digite os comandos abaixo no Prompt (Transcript):

	vlib work
	vlog -reportprogress 300 -work work Relogio.sv divisor_clock.sv contador_segundos.sv contador_minutos.sv contador_horas.sv decoder_7seg.sv Relogio_tb.sv
	vsim -voptargs=+acc -do "add wave -position insertpoint sim:/Relogio_tb/*; run -all; wave zoom full" Relogio_tb

Durante a simulação, você verá no console:
- Horário atual simulado (em formato HH:MM:SS)
- Transições de carry (segundos para minutos, minutos para horas)
- Clock de 1Hz ativando a contagem

================================
4. Sobre a Simulação e Debugging
================================

- A simulação simula **1 minuto completo** (60 segundos).
- O testbench exibe o valor dos displays em formato legível.
- O módulo `decode_7seg` converte os segmentos de 7 segmentos para caracteres para facilitar a leitura.
- O sinal `clk_1hz` é gerado pelo `divisor_clock` e aciona os contadores de segundo, minuto e hora.
- O tempo simulado é impresso com `$time` para referência em nanosegundos.

===================
5. Observações Finais
===================

- O sistema usa reset ativo em nível baixo.
- O `clock` de entrada da top-level é de 50MHz, simulado com `#10` (20ns por ciclo).
- Use o botão "Restart Simulation" do ModelSim para reiniciar entre testes.

===================
6. Requisitos
===================

- Quartus 13.0 + ModelSim-Altera Edition
- Todos os arquivos `.sv` na mesma pasta
- Projeto configurado para SystemVerilog

==========================
Dúvidas? Sugestões?
==========================
Para dúvidas, procure pelo canal de suporte da Altera (Intel FPGA), ou consulte a documentação do ModelSim.

Bom trabalho e boa simulação!

