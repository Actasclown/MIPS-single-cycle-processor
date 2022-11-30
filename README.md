# Brief

## Files

    - alu_design
        - bin
            "run_test" (executable)     \\ script for run_test
        - lib                           \\ lib provided
        - src                           \\ all src.v files
        - test                          \\ all tb files, can be directly launched by properly commenting lines in "run_test"
        - traces                        \\ log files of different simulations

## Control table

    control [3] [2] [1] [0] op          \\ type rt, shamt, rd => result
             0   0   0   0   sll
             0   0   1   0   srl

                                        \\ type a, b => result, carry_out, overflow
             1   0   0   0   add
             1   0   1   0   sub

                                        \\ type a, b => result, overflow
             1   0   0   1   slt
             1   0   1   1   sltu

                                        \\ type a, b => result
             1   1   0   0   and
             1   1   0   1   or
             1   1   1   0   xor
