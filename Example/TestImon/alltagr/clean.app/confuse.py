import os
import sys
import random



################################################################
from Crypto.Cipher import AES
import base64
import binascii


BS = AES.block_size
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
unpad = lambda s : s[0:-ord(s[-1])]

def aes_decypt(data, key):
    
    data = base64.b64decode(data)
    
    tmp_key = bytearray(32)
    tmp_key[:len(key)] = key
    
    iv = '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
    
    obj = AES.new(str(tmp_key), AES.MODE_CBC, iv)
    
    compressed_data = obj.decrypt(data)
    
    print unpad(compressed_data)

def aes_encypt(srcdata, key):
    
    
    tmp_key = bytearray(32)
    tmp_key[:len(key)] = key
    
    BS = AES.block_size
    pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
    
    iv = '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
    
    obj = AES.new(str(tmp_key), AES.MODE_CBC, iv)
    
    
    data = obj.encrypt(pad(srcdata))
    
    b64_data = base64.b64encode(data)
    
    return b64_data

#################################################################

g_used_banner = []
g_candidate_class = []
g_candidate_func = []
#################################################################


def get_candidate_words(candidate_file):
    g_candidate = []
    with open(candidate_file, 'r') as fp:
        word_list = fp.readlines()
        for word in word_list:
            word = word.strip()
            if len(word) >= 7 and (not word.startswith("init")) and word.find(";") == -1 and ( not word.startswith(('0', '1', '2', '3', '4', '5', '6', '7', '8', '9'))):
                word = word.replace(".", "").replace("_", "")
                g_candidate.append(word)
        fp.close()

    return g_candidate

def getradomstr(randomlength=8 , chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'):
    str = ''
    length = len(chars) - 1
    rand = random.Random()
    for index in range(randomlength):
        str+=chars[rand.randint(0, length)]
    return str
#################################################################

def get_rand_len(min=1 , max=8):
    rand = random.Random()
    return rand.randint(min, max)
#################################################################

def get_one_symbol_class(candidate_file):
    global g_candidate_class
    if len(g_candidate_class) == 0:
        g_candidate_class = get_candidate_words(candidate_file)
    ret_sym = random.choice(g_candidate_class)
    
    if ret_sym in g_used_banner:
        return get_one_symbol_class(candidate_file)

    g_used_banner.append(ret_sym)
    return ret_sym

#################################################################
black_list = ['dealloc', 'init', 'request', 'serializer', 'copyWith', 'appendData', 'statusCode', 'isEqual',
              'backgroundColor', 'maxLength', 'setDelegate', 'delegateQueue', 'string', 'hexStringValue', 'writeData', 'copy', 'new', 'register', 'IOSurface']

def symbol_in_black_list(ret_sym):
    for black in black_list:
        if ret_sym.find(black) != -1:
            return True

    return False
#################################################################
def get_one_symbol_func(candidate_file):
    global g_candidate_func
    if len(g_candidate_func) == 0:
        g_candidate_func = get_candidate_words(candidate_file)
    ret_sym = random.choice(g_candidate_func)

    if ret_sym in g_used_banner or symbol_in_black_list(ret_sym):
        return get_one_symbol_func(candidate_file)



    g_used_banner.append(ret_sym)
    return ret_sym

#    ret_sym = ""
#    sym_len = get_rand_len(min = 2 , max = 5)
#    for i in range(0 , sym_len):
#        if ret_sym != "":
#            ret_sym = ret_sym + "_"
#        ret_sym = ret_sym + getradomstr(randomlength=get_rand_len(3 , 6))
#    if ret_sym in g_used_banner:
#        return get_one_symbol()
#
#    g_used_banner.append(ret_sym)
#    return ret_sym
#################################################################
def re_enc(in_data):
    ret_data = ""
    KEY = ""
    ary = in_data.split("\n")
    for line in ary:
        if line.find("AES_KEY") != -1 :
            lineary = line.split(" ")
            for got in lineary :
                if got != "" and got != "#define" and got != "AES_KEY":
                    got = got.replace("\n" , "").replace(" " , "")
                    KEY = got[2 : len(got) -1 ]
                    print KEY
            break


    if KEY == "":
        return in_data

    writein = []
    writein.append("#define AES_KEY @\"" + KEY + "\"\n")

    sept = "@#@#@#@#"
    for line in ary:
        if line.find(sept) != -1:
            lineary = line.split(sept)
            if len(lineary) != 4:
                return ret_data
            defkey = lineary[1].replace(" " , "").replace("\n" , "")
            defvalue = lineary[2].replace(" " , "").replace("\n" , "")
                
            writedata =  line + "\n"  + "#define " + defkey + " @\"" + aes_encypt(defvalue , KEY) + "\""
            writedata = writedata + "\n" + "#define " + "SZ_" + defkey + " \"" + aes_encypt(defvalue , KEY) + "\""
            writein.append(writedata)
                
    ret_data = ""
    for tag in writein:
        ret_data = ret_data + tag  + "\n\n"

    return ret_data
#################################################################

def gen_class_define():

    g_gen_define = ""

    target_class_file_name = "target_class.list"

    if os.path.exists(target_class_file_name) == False:
        return

    targetFile = open(target_class_file_name, "rb")
    line = targetFile.readline()
    while line:
        linedata = line.replace("\n", "")
        if linedata != "":
            class_sym = get_one_symbol_class("words_alpha_class.txt")

            class_sym = getradomstr(2, "ABCDEFGHIJKLMNOPQRST") + class_sym[2:]

            append_define = "#define    " + linedata + "    " + class_sym + "\n"
            g_gen_define = g_gen_define + append_define
        line = targetFile.readline()

    return g_gen_define



def gen_func_define():

    g_gen_define = ""

    target_class_file_name = "target_func.list"

    if os.path.exists(target_class_file_name) == False:
        return

    targetFile = open(target_class_file_name, "rb")
    line = targetFile.readline()
    while line:
        linedata = line.replace("\n", "")
        if linedata != "":
            append_define = "#define    " + linedata + "    " + get_one_symbol_func("words_alpha_func.txt") + "\n"
            g_gen_define = g_gen_define + append_define
        line = targetFile.readline()

    return g_gen_define


def doWork():
    class_define = gen_class_define()

    func_define = gen_func_define()

    pch_file_name = "clean.pch"
    if os.path.exists(pch_file_name) == False:
        return

    pchfile = open(pch_file_name, "r")
    orig_data = pchfile.read()
    pchfile.close()

    ary = orig_data.split("#define __REPLACE_TAG__\n")
    if len(ary) != 3:
        return
    orig_data = ary[0] + "#define __REPLACE_TAG__\n" + class_define + "\n\n" + func_define + "#define __REPLACE_TAG__\n"+ary[2]
    
    ary = orig_data.split("#define     __ENC_TAG__\n")
    if len(ary) != 3:
        return
    orig_data = ary[0] + "#define     __ENC_TAG__\n" + re_enc(ary[1]) + "#define     __ENC_TAG__\n" + ary[2]


    pchfile = open(pch_file_name , "w")
    pchfile.write(orig_data)
    pchfile.close()
    return


doWork()

