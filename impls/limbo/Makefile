steps = step0_repl step1_read_print step2_eval step3_env step4_if_fn_do step5_tco step6_file step7_quote step8_macros step9_try stepA_mal

all: $(steps)

clean:
	find step*/ -iname "*.dis" -exec rm -v {} \;
	find step*/ -iname "*.sbl" -exec rm -v {} \;

$(steps): clean
	cd $@ && \
	limbo "$@.b"
