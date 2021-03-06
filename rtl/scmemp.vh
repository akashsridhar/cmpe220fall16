

`define RISCV_ASIDLEN  8

// IC fetch width 1,2,4,8 instructions (*4 for bytes, *32 for bits)
`define IC_BITWIDTH (8*32)

// DC max number of oustanding requests
`define L1_REQIDBITS  5
`define L1_REQIDS    (1<<`L1_REQIDBITS)

// MQ ID
`define MQ_REQIDBITS  6
`define MQ_REQIDS     (1<<`MQ_REQIDBITS)

// L2 ID
`define L2_REQIDBITS  6
`define L2_REQIDS     (1<<`L2_REQIDBITS)

// Node ID (needed for directory). Max num of L2s in the system
`define SC_NODEIDBITS 5
`define SC_NODEIDS  (1<<`SC_NODEIDBITS)

// IC ID
`define IC_REQIDBITS  3
`define IC_REQIDS     (1<<`IC_REQBITS)

// DR
`define DR_REQIDBITS  6
`define DR_REQIDS     (1<<`DR_REQBITS)

// max number of checkpoints
`define DC_CKPBITS     4
`define DC_CKPS        (1<<`DC_CKPS)

// Physical address bits (less than 64)
// paddr: Physical address
// laddr: Logical Address
// claddr: Logical cache aligned address (lower bits not used -> 0)

`define SC_PADDRBITS   49
// SV39 from RISCV (bits 39 to 63 musts be equal to bit 38)
`define SC_LADDRBITS   39

`define SC_PCSIGNBITS  13

// RISC CSR register for address base translation (also threadid)
`define SC_SBPTRBITS     (`SC_PADDRBITS-12)

`define SC_LINEBITS   512
`define SC_LINEBYTES (`SC_LINEBITS/8)

// Command request L1 -> L2
`define SC_CMDBITS     3

`define SC_PAGESIZEBITS    2
`define SC_PAGESIZE_4KB    2'b00
`define SC_PAGESIZE_2MB    2'b01
`define SC_PAGESIZE_4MB    2'b10
`define SC_PAGESIZE_4GB    2'b11

`define TB_DCTLB_INDEXBITS 9
`define TB_DCTLB_ENTRIES    (1<<(`TB_DCTLB_INDEXBITS))

`define TB_L2TLB_0INDEXBITS 14 // just 4KB page size
`define TB_L2TLB_1INDEXBITS 6  // Any page size
`define TB_L2TLB_0ENTRIES    (1<<(`TB_L2TLB_0INDEXBITS))
`define TB_L2TLB_1ENTRIES    (1<<(`TB_L2TLB_1INDEXBITS))

`define PF_STATBITS        7
`define PF_DELTABITS       5
`define PF_WEIGTHBITS      4
`define PF_REQIDBITS       5

// VALID CONFIGURATION OPTIONS (2 or 4 pipes)
`define SC_4PIPE 1 // 1..4 pipes

//-------------------
// Prefetching Parameters

`define PF_PE_L1_MAXDEGREE  4
`define PF_PE_L2_MAXDEGREE 16


