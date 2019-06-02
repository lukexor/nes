cargo build --release
TESTS=(
tests/cpu/instr_timing.nes # passes, but calls ahx(), xaa(), shy(), shx()
tests/cpu/instr_misc.nes # ROL abs 03-dummy_reads #9 3/4
tests/cpu/exec_space_apu.nes # 4016 00 ERROR landed at $4018 #2
tests/cpu/flag_concurrency.nes # Timing doesn't match 29823 table should match OpenEMU results
tests/cpu/registers_after_reset.nes # Message doesn't disappear
tests/cpu/ram_after_reset.nes # Message doesn't disappear
tests/cpu/all_instrs.nes # 03-immediate 3/16
tests/cpu/interrupts.nes # IRQ when $4017 == $00 1-cli_latency #3 1/5
tests/apu/04.clock_jitter.nes # $03
tests/apu/sweep_sub.nes # Supposed to be a constant beat
tests/apu/triangle.nes # Not silent during step #2
tests/apu/test_8.nes # failed
tests/apu/test_9.nes # failed
tests/apu/volumes.nes # Not sure what it's supposed to do?
tests/apu/06.len_timing_mode1.nes # $03
tests/apu/test_10.nes # failed
tests/apu/10.len_halt_timing.nes # $03
tests/apu/03.irq_flag.nes # $04
tests/apu/lin_ctr.nes # More whip-like then a beep
tests/apu/test_3.nes # failed
tests/apu/09.reset_timing.nes # $04
tests/apu/test_7.nes # failed
tests/apu/05.len_timing_mode0.nes # $03
tests/apu/11.len_reload_timing.nes # $03
tests/apu/test_4.nes # failed
tests/apu/07.irq_flag_timing.nes # $03
tests/apu/test.nes # writing $00 to $4017 shouldn't clock length immediately, 1-len_ctr #5 1/8
tests/ppu/vbl_nmi.nes # 02-vbl_set_time 2/10
tests/ppu/oam_stress.nes # failed
tests/ppu/sprdma_and_dmc_dma_512.nes # Supposed to print a table
tests/ppu/read_buffer.nes # passes but has unhandled CNROM reads
tests/ppu/vbl_nmi_timing/6.nmi_disable.nes # #3
tests/ppu/vbl_nmi_timing/5.nmi_suppression.nes #4
tests/ppu/vbl_nmi_timing/3.even_odd_frames.nes # #3
tests/ppu/vbl_nmi_timing/7.nmi_timing.nes # #7
tests/ppu/vbl_nmi_timing/2.vbl_timing.nes # #8
tests/ppu/ntsc_torture.nes # No NTSC raster effects
tests/ppu/open_bus.nes # ppu_open_bus #3 - should decay after 1 sec
tests/ppu/sprdma_and_dmc_dma.nes # Supposed to print a table
tests/ppu/sprite_overflow.nes # flag cleared too late at end of VBL 03-timing #4 3/5
tests/ppu/nmi_sync_ntsc.nes # Not sure what it tests
tests/ppu/sprite_hit.nes # flag set too soon for lower-left corner 09-timing #7 9/10
)

trap ctrl_c INT

function ctrl_c() {
    echo "** Trapped CTRL-C...Exiting"
    exit
}

for test in ${TESTS[*]}; do
    echo $test
    target/release/rustynes $test
done

