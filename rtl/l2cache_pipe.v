
// L2 Cache Pipeline
//
// There is ONE to ONE L2_cache pipe to dcache_pipe.
//
// Each L2_cache pipe has different addresses from other L2 cache pipes in the
// same level. 
//
// L2 main parameters
//
// 128KB or 512KB L2 cache
// 16 way associative
//
// Normal MESI coherence protocol (Not U like the dcache or transactions)
//
// 3 Outstading requests queues:
//
// -Req  : Cache requests to E or NC (addr no data)
// -Disp : Displacements, hold the whole cache line
// -Pref : Prefetch (addr no data)
// -snoop: Snoop reuqests 2 reqs.
//
// Configurable # outstanding requests  (req_queue): 16, 32, 64 (configurable)
//
// Configurable # outstanding disps  (disp_queue): 4,8, 16 (configurable)
//
// Configurable # oustanding prefetches (pref_queue): 32, 64 (configurable)
//
// The oldest prefetch gets dropped if the prefetch buffer gets full
//
// The priority between queues is: 1st req, 2nd snoops, 3rd Disp, 4th Pref
//
// If the snoop queue is full or it has been with an entry over 4 cycles, all
// the other inputs are set to retry, and the snoops are drained with the
// highest priority.
//
// The L2 cache replacement:
//
// Lines pushed from the directory have low reuse priority (LRU)
// Prefetche lines have LRU too 
//
// Displacements move to LRU too
//
// Demand hits promote to MRU
//
// Options for cache replacement: 3-bit RRIP with Hawkeye
//
// Haweye focuses on reqs. Disp and pref request
// are know to have low reuse, they automatically set the low priority RRIP.
// (It should be configurable, but prefetch should have 7 for RRIP, disp 6 or
// 7, and push lines 7). A prefetched line hitted with a demand load reads the
// hawkeye predictor and sets the RRIP accordingly.
//
// For the hawkeye use the paper predictor sizes (12KB total)
//
// For PC use in hawkeye use pcsign.
//
// Hawkeye:https://www.cs.utexas.edu/users/lin/papers/isca16.pdf 
//

module l2cache_pipe(
  /* verilator lint_off UNUSED */
   input                           clk
  ,input                           reset

  //---------------------------
  // L1 (icache or dcache)<->l2cache_pipe interface
  ,input                           l1tol2_req_valid
  ,output                          l1tol2_req_retry
  ,input  I_l1tol2_req_type        l1tol2_req

  ,output                          l2tol1_snack_valid
  ,input                           l2tol1_snack_retry
  ,output I_l2tol1_snack_type      l2tol1_snack

  ,input                           l1tol2_snoop_ack_valid
  ,output                          l1tol2_snoop_ack_retry
  ,input  I_l2snoop_ack_type       l1tol2_snoop_ack

  ,input                           l1tol2_disp_valid
  ,output                          l1tol2_disp_retry
  ,input  I_l1tol2_disp_type       l1tol2_disp

  ,output                          l2tol1_dack_valid
  ,input                           l2tol1_dack_retry
  ,output I_l2tol1_dack_type       l2tol1_dack

  //---------------------------
  // Prefetch interface
  ,output logic                    pftocache_req_valid
  ,input  logic                    pftocache_req_retry
  ,output I_pftocache_req_type     pftocache_req

  ,output PF_cache_stats_type      cachetopf_stats

  //---------------------------
  // Directory interface
  ,output                          l2todr_req_valid
  ,input                           l2todr_req_retry
  ,output I_l2todr_req_type        l2todr_req

  ,input                           drtol2_snack_valid
  ,output                          drtol2_snack_retry
  ,input  I_drtol2_snack_type      drtol2_snack

  ,output                          l2todr_snoop_ack_valid
  ,input                           l2todr_snoop_ack_retry
  ,output I_l2snoop_ack_type       l2todr_snoop_ack

  ,output                          l2todr_disp_valid
  ,input                           l2todr_disp_retry
  ,output I_l2todr_disp_type       l2todr_disp

  ,input                           drtol2_dack_valid
  ,output                          drtol2_dack_retry
  ,input  I_drtol2_dack_type       drtol2_dack

  ,input                           pftol2_pfreq_valid
  ,output                          pftol2_pfreq_retry
  ,input  I_pftocache_req_type     pftol2_pfreq       // NOTE: pfreq does not have ack if dropped

  /* verilator lint_on UNUSED */
);


endmodule

