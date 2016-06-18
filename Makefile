################################################################
#
# $Id:$
#
# $Log:$
#
# microAptiv_UP makefile for MIPSfpga

ifndef MIPS_ELF_ROOT
$(error MIPS_ELF_ROOT must be set to point to toolkit installation root)
endif

CC=mips-mti-elf-gcc
LD=mips-mti-elf-ld
OD=mips-mti-elf-objdump
OC=mips-mti-elf-objcopy
SZ=mips-mti-elf-size

CFLAGS=  -O2 -g -EL -lc -msoft-float -march=m14kec -msoft-float -mno-dsp -mno-dspr2 -mno-dspr3 -Wall #-DNORMALUNIX -DLINUX
LDFLAGS_FPGA_RAM= -T FPGA_Ram.ld -EL -lc -march=m14kec -mno-mips16 -mno-micromips -mno-dsp -mno-dspr2 -mno-dspr3 -msoft-float -Wl,-Map=FPGA_Ram_map.txt

#ASOURCES= \
#boot.S

# subdirectory for objects
O=build

# not too sophisticated dependency
OBJS=				\
		$(O)/Doom1_WAD.o		\
		$(O)/boot.o			\
		$(O)/doomdef.o		\
		$(O)/doomstat.o		\
		$(O)/dstrings.o		\
		$(O)/i_system.o		\
		$(O)/i_sound.o		\
		$(O)/i_video.o		\
		$(O)/i_net.o			\
		$(O)/tables.o			\
		$(O)/f_finale.o		\
		$(O)/f_wipe.o 		\
		$(O)/d_main.o			\
		$(O)/d_net.o			\
		$(O)/d_items.o		\
		$(O)/g_game.o			\
		$(O)/m_menu.o			\
		$(O)/m_misc.o			\
		$(O)/m_argv.o  		\
		$(O)/m_bbox.o			\
		$(O)/m_fixed.o		\
		$(O)/m_swap.o			\
		$(O)/m_cheat.o		\
		$(O)/m_random.o		\
		$(O)/am_map.o			\
		$(O)/p_ceilng.o		\
		$(O)/p_doors.o		\
		$(O)/p_enemy.o		\
		$(O)/p_floor.o		\
		$(O)/p_inter.o		\
		$(O)/p_lights.o		\
		$(O)/p_map.o			\
		$(O)/p_maputl.o		\
		$(O)/p_plats.o		\
		$(O)/p_pspr.o			\
		$(O)/p_setup.o		\
		$(O)/p_sight.o		\
		$(O)/p_spec.o			\
		$(O)/p_switch.o		\
		$(O)/p_mobj.o			\
		$(O)/p_telept.o		\
		$(O)/p_tick.o			\
		$(O)/p_saveg.o		\
		$(O)/p_user.o			\
		$(O)/r_bsp.o			\
		$(O)/r_data.o			\
		$(O)/r_draw.o			\
		$(O)/r_main.o			\
		$(O)/r_plane.o		\
		$(O)/r_segs.o			\
		$(O)/r_sky.o			\
		$(O)/r_things.o		\
		$(O)/w_wad.o			\
		$(O)/wi_stuff.o		\
		$(O)/v_video.o		\
		$(O)/st_lib.o			\
		$(O)/st_stuff.o		\
		$(O)/hu_stuff.o		\
		$(O)/hu_lib.o			\
		$(O)/s_sound.o		\
		$(O)/z_zone.o			\
		$(O)/info.o				\
		$(O)/sounds.o

all:	$(O)/FPGA_RAM

clean:
	rm -f *.o *~ *.flc
	rm -f build/*

$(O)/FPGA_RAM:	$(AOBJECTS) $(OBJS) $(O)/i_main.o
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(O)/i_main.o \
	-o $(O)/FPGA_Ram.elf -lc
	$(SZ) $(O)/FPGA_Ram.elf
	$(OD) -d -S -l $(O)/FPGA_Ram.elf > $(O)/FPGA_Ram_dasm.txt
	$(OD) -d $(O)/FPGA_Ram.elf > $(O)/FPGA_Ram_modelsim.txt
	$(OC) $(O)/FPGA_Ram.elf -O srec $(O)/FPGA_Ram.rec

$(O)/boot.o:
	$(CC) $(CFLAGS) -c boot.S -o $(O)/boot.o

#http://www.pc-freak.net/blog/doom-1-doom-2-doom-3-game-wad-files-for-download-playing-doom-on-debian-linux-via-freedoom-open-source-doom-engine/
$(O)/Doom1_WAD.o:
	$(LD) -r -EL -b binary Doom1.WAD -o $(O)/Doom1_WAD.o

$(O)/%.o:	%.c
	$(CC) $(CFLAGS) -c $< -o $@

#############################################################
#
#############################################################
