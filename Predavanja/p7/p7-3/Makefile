runfoo: foo
	qemu-mipsel foo

foo: p4.cpp foo.s
	ecc++ -std=c++14 -static -o foo -target mips32r2el-linux p4.cpp foo.s

clean:
	rm -rf *.o foo 
