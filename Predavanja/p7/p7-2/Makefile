runfoo: foo
	qemu-mipsel foo

runbar: bar
	qemu-mipsel bar

foo: p2.cpp foo.s
	ecc++ -std=c++14 -static -o foo -target mips32r2el-linux p2.cpp foo.s

bar: p3.cpp bar.s
	ecc++ -std=c++14 -static -o bar -target mips32r2el-linux p3.cpp bar.s

clean:
	rm -rf *.o foo bar 
