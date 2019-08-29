
# #.PHONY: hello

# hello:
# 	echo "hello makefile"

# hm := hello makefile
# defineVar:
# 	@echo "hm => $(hm)"

# two:
# 	@echo "my two"

# test:  two hello
# 	@echo "\$$@ => $@"
# 	@echo "$$^ => $^"
# 	@echo "$$< => $<"


# src := a.cc b.cc c.cc
# obj := $(src:cc=bb)
# blth:
# 	@echo "src => $(src)"
# 	@echo "obj => $(obj)"

# src2 := a11b.c a22b.c a222b.c
# obj2 := $(src2:a%b.c=x%y)
# blmsth:
# 	@echo "src2 => $(src2)"
# 	@echo "obj2 => $(obj2)"


define func1
	@echo "my name is $(0)"
endef

define func2
	@echo "func2 name is $(0)"
	@echo "param1 => $(1)"
	@echo "param2 => $(2)"
endef

# var2 := ${call func1}
# var3 := ${func1}

callfunc:
	@echo "var2 => $(var2)"
	@echo "var3 => $(var3)"
	${call func1}
	${call func2, study, makefile}
	${func1 woca}

# edit: main.o kbd.o command.o display.o  insert.o search.o files.o utils.o
# 	ld -o edit  main.o kbd.o command.o display.o insert.o search.o files.o utils.o


# main.o : main.c defs.h
# 	cc -c main.c

# kbd.o: kbd.c defs.h command.h
# 	cc -c kbd.c

# command.o: command.c defs.h command.h
# 	cc -c command.c

# display.o: display.c defs.h command.h
# 	cc -c display.c

# insert.o: insert.c defs.h buffer.h
# 	cc -c insert.c

# search.o : search.c defs.h buffer.h
# 	cc -c search.c

# files.o : files.c  defs.h buffer.h command.h
# 	cc -c files.c


# utils.o : utils.c defs.h
# 	cc -c utils.c

# clean:
# 	rm edit main.o kbd.o command.o display.o insert.o search.o files.o utils.o

rmallc:
	sh text.sh
	rm -f *.h

hello: 
	echo "makefile里的hello"






















