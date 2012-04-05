def remove_tags(input_text):
    s_list = list(input_text)
    i,j = 0,0
    while i < len(s_list):
        if s_list[i] == '<':
            while s_list[i] != '>':
                s_list.pop(i)
            s_list.pop(i)
        else:
            i=i+1
    join_char=''
    return join_char.join(s_list)