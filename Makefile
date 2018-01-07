all: tests runnable

analysis:
	make -f MakeAnalysis.mk V=${V} all

runnable:
	make -f MakeRunnable.mk V=${V} all

tests:
	make -f MakeTests.mk V=${V} all

tests_coverage:
	make -f MakeTests.mk V=${V} coverage

clean:
	make -f MakeRunnable.mk V=${V} clean
	make -f MakeTests.mk V=${V} clean
	make -f MakeTests.mk V=${V} coverage_clean
	@ rm -rf ./build/objs/ ./build/lib/
