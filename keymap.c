#define NSCAN 58
/* Scan codes to ASCII dor unshifted keys */
char unshift[NSCAN] = { // NSCAN = 58
  0, 033, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b', '\t',
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\r', 0, 'a', 's', 
  'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', 0, 0, 0, 0, 'z', 'x', 'c', 'v', 
  'b', 'n', 'm', ',', '.', '/', 0 ,'*', 0, ' '};
/* Scan codes to ASCII for shifted keys */
char shift[NSCAN] = { // NSCAN = 58
  0, 033, '!', '@', '#', '$', '%', 'ˆ', '&', '*', '(', ')', '_', '+', '\b', '\t',
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\r', 0, 'A', 'S', 
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', 0, '~', 0, '|', 'Z', 'X', 'C', 'V', 
  'B', 'N', 'M', '<', '>', '?', 0 ,'*', 0, ' '};