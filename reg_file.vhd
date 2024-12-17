-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul        : 01
-- Percobaan    : 4
-- Tanggal      : 20 November 2024
-- Kelompok     : 7
-- Rombongan    : A
-- Nama (NIM) 1 : Salsabilla Putri Aprillia (13222011)
-- Nama (NIM) 2 : I Made Medika Surya W.M. (13222021)
-- Nama File    : Instruction_memory.vhd
-- Deskripsi    : Implementasi register dengan VHDL pada Quartus II

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity reg_file is
    port
    (
        clock       : in std_logic;
        wr_en       : in std_logic;
        
        addr_1      : in std_logic_vector (4 downto 0);
        addr_2      : in std_logic_vector (4 downto 0);
        addr_3      : in std_logic_vector (4 downto 0);
        
        rd_data_1   : out std_logic_vector (31 downto 0);
        rd_data_2   : out std_logic_vector (31 downto 0);
        
        wr_data_3   : in std_logic_vector (31 downto 0)
    );
end reg_file;

architecture behavioural of reg_file is
    type ramtype is array (31 downto 0) of std_logic_vector (31 downto 0);
    signal mem: ramtype := 
	(
        others => X"00000000"
    );
    
    signal zero : std_logic_vector (31 downto 0);
    
begin
    process (clock, zero)
    begin
        if (falling_edge(clock) and wr_en = '0') then
            rd_data_1 <= mem(to_integer(unsigned(addr_1)));
            rd_data_2 <= mem(to_integer(unsigned(addr_2)));
        else
			rd_data_1 <= zero;
			rd_data_2 <= zero;
        end if;
    end process;

    process (clock)
    begin
        if (rising_edge(clock) and wr_en = '1') then
            mem(to_integer(unsigned(addr_3))) <= wr_data_3;
        end if;
    end process;
	
end behavioural;