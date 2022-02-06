import glob
import os
import re

c_files = glob.glob('./*/*.c')
s_files = glob.glob('./*/*.s')
ld_files = glob.glob('./*/*.ld')

l = c_files + s_files + ld_files

folder = 'aux'

base_header = '''
	Arthur Pires da Fonseca, NUSP: 10773096
	Para rodar os arquivos do exercício X: 
	eabi-gcc test.c -o test.o 
	eabi-as startup.s -o startup.o 
	eabi-ld -T vector_table.ld test.o startup.o -o program.elf 
	eabi-bin program.elf program.bin 
	qemu program.bin
	'''

if not os.path.exists(folder):
	os.makedirs(folder)

paths = []
for f in l:
	content = open(f, 'r').read()
	
	path = f	

	header = ''
	for line in base_header.split('\n'):
		header = header + ( "\t%s\t" % ( "/* " + line + " */" ) ) + "\n"
	content = header + content
	#print(header)

	path = re.sub(r'^\.', '', path)
	path = re.sub(r'/+', '_', path)

	path = os.path.join('aux', path)

	paths.append(path)
	open(path, 'w').write(content)

#print(paths)
