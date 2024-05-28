local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function fn(args)
	return args[1][1]
end

local function fn_st(args)
	local num = tonumber(args[1][1])
	if num == nil then
		return ""
	end
	if num % 8 ~= 0 then
		return tostring(num) .. " # WARNING: stack missaligned"
	end
	return tostring(num)
end

local function fn_ra(args)
	local num = tonumber(args[1][1])
	if num == nil then
		return ""
	elseif num < 4 then
		return "!!"
	end
	return tostring(num - 4)
end

local function fn_r(args)
	if args[1][1] == "" then
		return "GP"
	end
	return args[1][1]
end

local function fn_i(args)
	if args[1][1] == "" then
		return "imm"
	end
	return args[1][1]
end

-- BASIC --
ls.add_snippets("asm", {
	s({
		trig = "st",
		name = "st",
	}, {
		t({
			".section .rodata",
			"",
			".section .data",
			"",
			".section .bss",
			"",
			".section .text",
			"",
			".global main",
			"main:",
			"  ",
		}),
		i(0),
		t({ "", "  addiu $v0, $0, 0", "  jr $ra" }),
	}),
	s({
		trig = "start",
		name = "start",
	}, {
		t({
			".section .rodata",
			"",
			".section .data",
			"",
			".section .bss",
			"",
			".section .text",
			"",
			".global main",
			"main:",
			"  ",
		}),
		i(0),
		t({ "", "  addiu $v0, $0, 0", "  jr $ra" }),
	}),
	s({
		trig = "func",
		name = "global function with return",
	}, {
		t(".globl "),
		f(fn, { 1 }),
		t({ "", "" }),
		i(1),
		t({ ":", "  " }),
		i(0),
		t({ "", "  jr $ra" }),
	}),
	s({
		trig = "mmain",
		name = "mmain",
	}, {
		t({
			".global main",
			"main:",
			"  ",
		}),
		i(0),
		t({ "", "  addiu $v0, $0, 0", "  jr $ra" }),
	}),
	s({
		trig = "stack",
		name = "stack allocation",
	}, {
		t("addiu $sp, $sp, -"),
		i(1),
		t({ "", "" }),
		t("addiu $sp, $sp, "),
		f(fn_st, { 1 }),
	}),
	s({
		trig = "sstack",
		name = "stack allocation and $ra store",
	}, {
		t("addiu $sp, $sp, -"),
		i(1),
		t({ "", "sw $ra, " }),
		f(fn_ra, { 1 }),
		t({ "($sp)", "" }),
		i(0),
		t({ "", "lw $ra, " }),
		f(fn_ra, { 1 }),
		t({ "($sp)", "addiu $sp, $sp, " }),
		f(fn_st, { 1 }),
	}),
	s({
		trig = "stsw",
		name = "stack store word",
	}, {
		t("sw $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
	}),
	s({
		trig = "stsh",
		name = "stack store half-word",
	}, {
		t("sh $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
	}),
	s({
		trig = "stsb",
		name = "stack store byte",
	}, {
		t("sb $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
	}),
	s({
		trig = "stlw",
		name = "stack load word",
	}, {
		t("lw $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
	}),
	s({
		trig = "stlh",
		name = "stack load half-word",
	}, {
		t("lh $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
	}),
	s({
		trig = "stlb",
		name = "stack load byte",
	}, {
		t("lb $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
	}),
	s({
		trig = "stslw",
		name = "stack store load word",
	}, {
		t("sw $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
		t({ "", "lw $" }),
		f(fn_r, { 1 }),
		t(", "),
		f(fn_i, { 2 }),
		t("($sp)"),
	}),
	s({
		trig = "stslh",
		name = "stack store load half-word",
	}, {
		t("sh $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
		t({ "", "lh $" }),
		f(fn_r, { 1 }),
		t(", "),
		f(fn_i, { 2 }),
		t("($sp)"),
	}),
	s({
		trig = "stslb",
		name = "stack store load byte",
	}, {
		t("sb $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t({ "($sp)", "" }),
		i(0),
		t({ "", "lb $" }),
		f(fn_r, { 1 }),
		t(", "),
		f(fn_i, { 2 }),
		t("($sp)"),
	}),
	s({
		trig = "gll",
		name = "global label",
	}, {
		t(".globl "),
		f(fn, { 1 }),
		t({ "", "" }),
		i(1),
		t({ ": " }),
		i(0),
	}),
	s({
		trig = "return",
		name = "return",
	}, {
		t({ "", "jr $ra" }),
	}),
	s({
		trig = "stext",
		name = "text section",
	}, {
		t({ ".section .text", "" }),
	}),
	s({
		trig = "sdata",
		name = "data section",
	}, {
		t({ ".section .data", "" }),
	}),
	s({
		trig = "sbss",
		name = "bss section",
	}, {
		t({ ".section .bss", "" }),
	}),
	s({
		trig = "srodata",
		name = "rodata section",
	}, {
		t({ ".section .rodata", "" }),
	}),
})

-- DIRECTIVES --
ls.add_snippets("asm", {
	s({
		trig = "ascz",
		name = "array of ascii characters",
		desc = "Null terminated.",
	}, {
		t('.asciiz "'),
		i(0),
		t('"'),
	}),
	s({
		trig = "asciiz",
		name = "array of ascii characters",
		desc = "Null terminated.",
	}, {
		t('.asciiz "'),
		i(0),
		t('"'),
	}),
	s({
		trig = "ascii",
		name = "array of ascii characters",
		desc = "Non null terminated.",
	}, {
		t('.ascii "'),
		i(0),
		t('"'),
	}),
	s({
		trig = "string",
		name = "array of ascii characters",
		desc = "Null terminated.\nSame as .asciiz.",
	}, {
		t('.string "'),
		i(0),
		t('"'),
	}),
	s({
		trig = "zero",
		name = "zero initialize",
		desc = "Zero initialize N bytes of memory.",
	}, {
		t(".zero "),
		i(0, "N"),
	}),
	s({
		trig = "space",
		name = "reserve space",
		desc = "Space reserves N bytes of memory.",
	}, {
		t(".space "),
		i(0, "N"),
	}),
	s({
		trig = "align",
		name = "align directive",
		desc = "Align next directive to address divisible by 2^n.",
	}, {
		t(".align "),
		i(0, "N"),
	}),
	s({
		trig = "fill",
		name = "fill",
		desc = "Fill N times, B bytes with value V",
	}, {
		t(".fill "),
		i(1, "N"),
		t(", "),
		i(2, "B"),
		t(", "),
		i(0, "V"),
	}),
})

-- INSTRUCTIONS --
ls.add_snippets("asm", {
	s({
		trig = "add",
		name = "add",
	}, {
		t("add $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "addu",
		name = "unsigned add",
	}, {
		t("addu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "addi",
		name = "add immediate",
	}, {
		t("addi $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "addiu",
		name = "add unsigned immediate",
	}, {
		t("addiu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "sub",
		name = "subtract",
	}, {
		t("sub $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "subu",
		name = "subtract immediate",
	}, {
		t("subu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),

	s({
		trig = "mult",
		name = "multiply",
	}, {
		t("mult $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "multu",
		name = "multiply unsigned",
	}, {
		t("multu $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "pmul",
		name = "multiply",
		desc = "Pseudo instruction",
	}, {
		t("mul $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "pmulo",
		name = "multiply with overflow",
		desc = "Pseudo instruction",
	}, {
		t("mulo $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),

	s({
		trig = "div",
		name = "divide",
	}, {
		t("div $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "divu",
		name = "divide unsigned",
	}, {
		t("divu $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "pdiv",
		name = "divide",
		desc = "Pseudo instruction",
	}, {
		t("div $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "pdivu",
		name = "divide unsigned",
		desc = "Pseudo instruction",
	}, {
		t("divu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "abs",
		name = "absolute",
		desc = "Pseudo instruction",
	}, {
		t("abs $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "neg",
		name = "negative",
		desc = "Pseudo instruction",
	}, {
		t("neg $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "rem",
		name = "remainder",
		desc = "Pseudo instruction",
	}, {
		t("rem $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "remu",
		name = "remainder unsigned",
		desc = "Pseudo instruction",
	}, {
		t("remu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "rol",
		name = "rotate left",
		desc = "Pseudo instruction",
	}, {
		t("rol $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "ror",
		name = "rotate right",
		desc = "Pseudo instruction",
	}, {
		t("ror $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),

	s({
		trig = "sll",
		name = "shift left logical",
	}, {
		t("sll $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "srl",
		name = "shift right logical",
	}, {
		t("srl $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "sra",
		name = "shift right arithmetic",
	}, {
		t("sra $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "sllv",
		name = "shift left logical variable",
	}, {
		t("sllv $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "srlv",
		name = "shift right logical variable",
	}, {
		t("srlv $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "srav",
		name = "shift right arithmetic variable",
	}, {
		t("srav $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "and",
		name = "and",
	}, {
		t("and $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "andi",
		name = "and immediate",
	}, {
		t("andi $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "or",
		name = "or",
	}, {
		t("or $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "ori",
		name = "or immediate",
	}, {
		t("ori $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "xor",
		name = "exclusive or",
	}, {
		t("xor $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "xori",
		name = "exclusive or immediate",
	}, {
		t("xori $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "nor",
		name = "not or",
	}, {
		t("nor $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),

	s({
		trig = "not",
		name = "bitwise logical negation",
	}, {
		t("not $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),

	s({
		trig = "seq",
		name = "set on equal",
		desc = "Pseudo instruction",
	}, {
		t("seq $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "sne",
		name = "set on not equal",
		desc = "Pseudo instruction",
	}, {
		t("sne $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "sgt",
		name = "set on greater than",
		desc = "Pseudo instruction",
	}, {
		t("sgt $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "sgtu",
		name = "unsigned set on greater than",
		desc = "Pseudo instruction",
	}, {
		t("sgtu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "slt",
		name = "set less than",
	}, {
		t("slt $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "sltu",
		name = "set less than unsigned",
	}, {
		t("sltu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", $"),
		i(0, "GP"),
	}),
	s({
		trig = "slti",
		name = "set less than immediate",
	}, {
		t("slti $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "sltiu",
		name = "set less than immediate unsigned",
	}, {
		t("sltiu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "b",
		name = "branch",
	}, {
		t("b "),
		i(0, "label"),
	}),
	s({
		trig = "beq",
		name = "branch on equal",
	}, {
		t("beq $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "beqz",
		name = "branch on equal to zero",
		desc = "Pseudo instruction",
	}, {
		t("beqz $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bne",
		name = "branch on not equal",
	}, {
		t("bne $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bnez",
		name = "branch on not equal to zero",
		desc = "Pseudo instruction",
	}, {
		t("bnez $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "blt",
		name = "branch on less than",
		desc = "Pseudo instruction",
	}, {
		t("blt $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bltu",
		name = "unsigned branch on less than",
		desc = "Pseudo instruction",
	}, {
		t("bltu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "ble",
		name = "branch on less than or equal",
		desc = "Pseudo instruction",
	}, {
		t("ble $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bleu",
		name = "unsigned branch on less than or equal",
		desc = "Pseudo instruction",
	}, {
		t("bleu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgt",
		name = "branch on greater than",
		desc = "Pseudo instruction",
	}, {
		t("bgt $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgtu",
		name = "unsigned branch on greater than",
		desc = "Pseudo instruction",
	}, {
		t("bgtu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bge",
		name = "branch on greater than or equal",
		desc = "Pseudo instruction",
	}, {
		t("bge $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgeu",
		name = "unsigned branch on greater than or equal",
		desc = "Pseudo instruction",
	}, {
		t("bgeu $"),
		i(1, "GP"),
		t(", $"),
		i(2, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgez",
		name = "branch on greater than or equal to zero",
	}, {
		t("bgez $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgezal",
		name = "branch on greater than or equal to zero and link",
	}, {
		t("bgezal $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgtz",
		name = "branch on greater than to zero",
	}, {
		t("bgtz $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bgtzal",
		name = "branch on greater than to zero and link",
	}, {
		t("bgtzal $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "blez",
		name = "branch on less than or equal to zero",
	}, {
		t("blez $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bltz",
		name = "branch on less than zero",
	}, {
		t("bltz $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "bltzal",
		name = "branch on less than zero and link",
	}, {
		t("bltzal $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),

	s({
		trig = "j",
		name = "jump",
	}, {
		t("j "),
		i(0, "label"),
	}),
	s({
		trig = "jr",
		name = "jump register",
	}, {
		t("jr $"),
		i(0, "GP"),
	}),
	s({
		trig = "jal",
		name = "jump and link",
	}, {
		t("jal "),
		i(0, "label"),
	}),
	s({
		trig = "jalr",
		name = "jump and link register",
	}, {
		t("jalr $"),
		i(0, "GP"),
	}),

	s({
		trig = "lb",
		name = "load byte",
	}, {
		t("lb $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "lh",
		name = "load half-word",
	}, {
		t("lh $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "lw",
		name = "load word",
	}, {
		t("lw $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "lbu",
		name = "load byte unsigned",
	}, {
		t("lbu $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "lhu",
		name = "load half-word unsigned",
	}, {
		t("lhu $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),

	s({
		trig = "la",
		name = "load address",
		desc = "Pseudo instruction",
	}, {
		t("la $"),
		i(1, "GP"),
		t(", "),
		i(0, "label"),
	}),
	s({
		trig = "li",
		name = "load immediate",
		desc = "Pseudo instruction",
	}, {
		t("li $"),
		i(1, "GP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "lui",
		name = "load upper immediate",
	}, {
		t("lui $"),
		i(1, "GP"),
		t(", "),
		i(0, "imm"),
	}),

	s({
		trig = "sb",
		name = "store byte",
	}, {
		t("sb $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "sh",
		name = "store half-word",
	}, {
		t("sh $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "sw",
		name = "store word",
	}, {
		t("sw $"),
		i(1, "GP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),

	s({
		trig = "mfhi",
		name = "move from HI",
	}, {
		t("mfhi $"),
		i(0, "GP"),
	}),
	s({
		trig = "mflo",
		name = "move from LO",
	}, {
		t("mflo $"),
		i(0, "GP"),
	}),
	s({
		trig = "mthi",
		name = "move to HI",
	}, {
		t("mthi $"),
		i(0, "GP"),
	}),
	s({
		trig = "mtlo",
		name = "move to LO",
	}, {
		t("mtlo $"),
		i(0, "GP"),
	}),
	s({
		trig = "move",
		name = "move",
		desc = "Pseudo instruction",
	}, {
		t("move $"),
		i(1, "GP"),
		t(", $"),
		i(0, "GP"),
	}),

	s({
		trig = "syscall",
		name = "system call",
	}, {
		t("syscall"),
	}),
	s({
		trig = "sys",
		name = "system call",
	}, {
		t("syscall"),
	}),
	s({
		trig = "nop",
		name = "no operation",
	}, {
		t("nop"),
	}),

	s({
		trig = "mtc1",
		name = "move to coprocessor 1",
	}, {
		t("mtc1 $"),
		i(1, "GP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "mfc1",
		name = "move from coprocessor 1",
	}, {
		t("mfc1 $"),
		i(1, "GP"),
		t(", $"),
		i(0, "FP"),
	}),

	s({
		trig = "lwc1",
		name = "load word coprocessor 1",
	}, {
		t("lwc1 $"),
		i(1, "FP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "swc1",
		name = "save word coprocessor 1",
	}, {
		t("swc1 $"),
		i(1, "FP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),

	s({
		trig = "cvt",
		name = "convert",
	}, {
		t("cvt."),
		i(1, "TO"),
		t("."),
		i(2, "FROM"),
		t(" $"),
		i(3, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "bc1t",
		name = "branch coprocessor 1 true",
	}, {
		t("bc1t "),
		i(0, "label"),
	}),
	s({
		trig = "bc1f",
		name = "branch coprocessor 1 false",
	}, {
		t("bc1f "),
		i(0, "label"),
	}),

	s({
		trig = "fadd",
		name = "add floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("add."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(3, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fsub",
		name = "subtract floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("sub."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(3, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fmul",
		name = "multiply floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("mul."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(3, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fdiv",
		name = "divide floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("div."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(3, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fabs",
		name = "absolute value floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("abs."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fneg",
		name = "negative value floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("neg."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fmov",
		name = "move floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("mov."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "fl",
		name = "load floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("l."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", "),
		i(3, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "fs",
		name = "store floating point",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("s."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", "),
		i(3, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "fli",
		name = "load floating point immediate",
		desc = "TYPE -> s(single, 32bit), d(double, 64bit)",
	}, {
		t("li."),
		i(1, "TYPE"),
		t(" $"),
		i(2, "FP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "fc",
		name = "compare",
		desc = {
			"OP -> eq(==), le(<=), lt(<)",
			"TYPE -> s(single, 32bit), d(double, 64bit)",
		},
	}, {
		t("c."),
		i(1, "OP"),
		t("."),
		i(2, "TYPE"),
		t(" $"),
		i(3, "FP"),
		t(", $"),
		i(0, "FP"),
	}),

	s({
		trig = "sadd",
		name = "add single precision floating point",
	}, {
		t("add.s $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "ssub",
		name = "subtract single precision floating point",
	}, {
		t("sub.s $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "smul",
		name = "multiply single precision floating point",
	}, {
		t("mul.s $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "sdiv",
		name = "divide single precision floating point",
	}, {
		t("div.s $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "sabs",
		name = "absolute value single precision floating point",
	}, {
		t("abs.s $"),
		i(1, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "sneg",
		name = "negative value single precision floating point",
	}, {
		t("neg.s $"),
		i(1, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "smov",
		name = "move single precision floating point",
	}, {
		t("mov.s $"),
		i(1, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "sl",
		name = "load single precision floating point",
	}, {
		t("l.s $"),
		i(1, "FP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "ss",
		name = "store single precision floating point",
	}, {
		t("s.s $"),
		i(1, "FP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "sli",
		name = "load single precision floating point immediate",
	}, {
		t("li.s $"),
		i(1, "FP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "sc",
		name = "compare single precision floating point",
		desc = "OP -> eq(==), le(<=), lt(<)",
	}, {
		t("c."),
		i(1, "OP"),
		t(".s $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),

	s({
		trig = "dadd",
		name = "add double precision floating point",
	}, {
		t("add.d $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "dsub",
		name = "subtract double precision floating point",
	}, {
		t("sub.d $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "dmul",
		name = "multiply double precision floating point",
	}, {
		t("mul.d $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "ddiv",
		name = "divide double precision floating point",
	}, {
		t("div.d $"),
		i(1, "FP"),
		t(", $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "dabs",
		name = "absolute value double precision floating point",
	}, {
		t("abs.d $"),
		i(1, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "dneg",
		name = "negative value double precision floating point",
	}, {
		t("neg.d $"),
		i(1, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "dmov",
		name = "move double precision floating point",
	}, {
		t("mov.d $"),
		i(1, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
	s({
		trig = "dl",
		name = "load double precision floating point",
	}, {
		t("l.d $"),
		i(1, "FP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "ds",
		name = "store double precision floating point",
	}, {
		t("s.d $"),
		i(1, "FP"),
		t(", "),
		i(2, "imm"),
		t("($"),
		i(0, "GP"),
		t(")"),
	}),
	s({
		trig = "dli",
		name = "load double precision floating point immediate",
	}, {
		t("li.d $"),
		i(1, "FP"),
		t(", "),
		i(0, "imm"),
	}),
	s({
		trig = "dc",
		name = "compare double precision floating point",
		desc = "OP -> eq(==), le(<=), lt(<)",
	}, {
		t("c."),
		i(1, "OP"),
		t(".d $"),
		i(2, "FP"),
		t(", $"),
		i(0, "FP"),
	}),
})
