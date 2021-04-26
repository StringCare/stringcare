#include <stdint.h>

#include <cstring>
#include <iostream>
#include <string>

std::string pd = "a6ExQWqgF67n4OTMWgztgPExNjsGx2bsfmvjjtbJOoMiQlkWfwYNLfyPq88GowmvzJ1kdiPGbB5QC1wNc6lPSP0RQxAItqVIRzJTeaPsrCaXByvUesQK1hh5JXjNZraWcW4s4TR5TTOhEJ9UsCJqa3J9erM1s5JjjJMur88ksRJFHaUHUWq0kG76UHwJkMNu6FFrEGJ63kdBeh1qzywvXbIfNYZKDKUIRs1VfCxSMzwszgH2JPMZfrCLDlrZTMCIo0QUWwlnyLAW9ty1OT5jZkcPYoJJ7nFgGJh1OAG7q0CRxTBehOQ6sSBsF2m0rlzoW4d0BskTs2JH6mtldJiI";

char *string2Char(const std::string &str) {
    char *cstr = new char[str.length() + 1];
    std::strcpy(cstr, str.c_str());
    return cstr;
}

std::string char2String(char const *chars) {
    std::string str(chars);
    return str;
}

// Joins the key with the auxiliar
std::string join(std::string aux, std::string key) {
    if (aux.length() == 0) {
        return key;
    } else {
        int size = (int) aux.length() + (int) key.length();
        std::string val = "";
        
        int a = 0;
        int b = 0;
        for (int i = 0; i < size; i++) {
            if (a == b && a < aux.length()) {
                val += aux[a];
                a++;
            } else if (a > b && b < key.length()) {
                val += key[b];
                b++;
            } else if (a < aux.length()) {
                val += aux[a];
                a++;
            } else if (b < key.length()) {
                val += key[b];
                b++;
            }
        }
        return val;
    }
}

std::string reverse(std::string str) {
    std::string r = "";
    for (int i = (int) str.length() - 1; i >= 0; i--)
        r += str[i];
    return r;
}

std::string sign(std::string key) {
    std::string val = "";

    int i = 0;
    int u = 0;
    for (char &c : key) {
        val = val + c;

        u++;
        i++;

        if (i % 2 == 0) {
            i = ((int) c + (3 * u));
        } else if (u % 2 == 0) {
            i = (u * 3 + (int) c + (4 * u));
        } else {
            i = (u * 2 + (int) c + (6 * u));
        }

        val += std::to_string(i);
        val = reverse(val);
    }
    return reverse(val);
}

#if defined _WIN32 || defined __CYGWIN__
    extern "C" __declspec(dllexport)
#else
    extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
char* hashTest(char const *key) {
    std::string strKey = char2String(key);
    std::string hash = join(strKey, pd);
    return string2Char(hash);
}

#if defined _WIN32 || defined __CYGWIN__
    extern "C" __declspec(dllexport)
#else
    extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
char* signTest(char const *key) {
    std::string strKey = char2String(key);
    std::string hash = join(strKey, pd);
    std::string na = sign(hash);
    return string2Char(na);
}

#if defined _WIN32 || defined __CYGWIN__
    extern "C" __declspec(dllexport)
#else
    extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
int *obfuscate(char const *key, int *value, int const keySize, int const valueSize) {
    std::string strKey = char2String(key);
    std::string hash = join(strKey, pd);
    std::string na = sign(hash);

    int keyS = keySize +  (int) pd.length();

    for (unsigned int a = 19; a < valueSize + 20; a = a + 20) {
        if (a >= keyS) {
            if (a - 19 < valueSize) {
                int reminder = (a - 19) % keyS;
                int mark = na[reminder];
                value[a - 19] = value[a - 19] + mark;
            }
            if (a - 18 < valueSize) {
                int reminder = (a - 18) % keyS;
                int mark = na[reminder];
                value[a - 18] = value[a - 18] + mark;
            }
            if (a - 17 < valueSize) {
                int reminder = (a - 17) % keyS;
                int mark = na[reminder];
                value[a - 17] = value[a - 17] + mark;
            }
            if (a - 16 < valueSize) {
                int reminder = (a - 16) % keyS;
                int mark = na[reminder];
                value[a - 16] = value[a - 16] + mark;
            }
            if (a - 15 < valueSize) {
                int reminder = (a - 15) % keyS;
                int mark = na[reminder];
                value[a - 15] = value[a - 15] + mark;
            }
            if (a - 14 < valueSize) {
                int reminder = (a - 14) % keyS;
                int mark = na[reminder];
                value[a - 14] = value[a - 14] + mark;
            }
            if (a - 13 < valueSize) {
                int reminder = (a - 13) % keyS;
                int mark = na[reminder];
                value[a - 13] = value[a - 13] + mark;
            }
            if (a - 12 < valueSize) {
                int reminder = (a - 12) % keyS;
                int mark = na[reminder];
                value[a - 12] = value[a - 12] + mark;
            }
            if (a - 11 < valueSize) {
                int reminder = (a - 11) % keyS;
                int mark = na[reminder];
                value[a - 11] = value[a - 11] + mark;
            }
            if (a - 10 < valueSize) {
                int reminder = (a - 10) % keyS;
                int mark = na[reminder];
                value[a - 10] = value[a - 10] + mark;
            }
            if (a - 9 < valueSize) {
                int reminder = (a - 9) % keyS;
                int mark = na[reminder];
                value[a - 9] = value[a - 9] + mark;
            }
            if (a - 8 < valueSize) {
                int reminder = (a - 8) % keyS;
                int mark = na[reminder];
                value[a - 8] = value[a - 8] + mark;
            }
            if (a - 7 < valueSize) {
                int reminder = (a - 7) % keyS;
                int mark = na[reminder];
                value[a - 7] = value[a - 7] + mark;
            }
            if (a - 6 < valueSize) {
                int reminder = (a - 6) % keyS;
                int mark = na[reminder];
                value[a - 6] = value[a - 6] + mark;
            }
            if (a - 5 < valueSize) {
                int reminder = (a - 5) % keyS;
                int mark = na[reminder];
                value[a - 5] = value[a - 5] + mark;
            }
            if (a - 4 < valueSize) {
                int reminder = (a - 4) % keyS;
                int mark = na[reminder];
                value[a - 4] = value[a - 4] + mark;
            }
            if (a - 3 < valueSize) {
                int reminder = (a - 3) % keyS;
                int mark = na[reminder];
                value[a - 3] = value[a - 3] + mark;
            }
            if (a - 2 < valueSize) {
                int reminder = (a - 2) % keyS;
                int mark = na[reminder];
                value[a - 2] = value[a - 2] + mark;
            }
            if (a - 1 < valueSize) {
                int reminder = (a - 1) % keyS;
                int mark = na[reminder];
                value[a - 1] = value[a - 1] + mark;
            }
            if (a < valueSize) {
                int reminder = a % keyS;
                int mark = na[reminder];
                value[a] = value[a] + mark;
            }
        } else {
            if (a - 19 < valueSize) {
                value[a - 19] = value[a - 19] + na[a - 19];
            }
            if (a - 18 < valueSize) {
                value[a - 18] = value[a - 18] + na[a - 18];
            }
            if (a - 17 < valueSize) {
                value[a - 17] = value[a - 17] + na[a - 17];
            }
            if (a - 16 < valueSize) {
                value[a - 16] = value[a - 16] + na[a - 16];
            }
            if (a - 15 < valueSize) {
                value[a - 15] = value[a - 15] + na[a - 15];
            }
            if (a - 14 < valueSize) {
                value[a - 14] = value[a - 14] + na[a - 14];
            }
            if (a - 13 < valueSize) {
                value[a - 13] = value[a - 13] + na[a - 13];
            }
            if (a - 12 < valueSize) {
                value[a - 12] = value[a - 12] + na[a - 12];
            }
            if (a - 11 < valueSize) {
                value[a - 11] = value[a - 11] + na[a - 11];
            }
            if (a - 10 < valueSize) {
                value[a - 10] = value[a - 10] + na[a - 10];
            }
            if (a - 9 < valueSize) {
                value[a - 9] = value[a - 9] + na[a - 9];
            }
            if (a - 8 < valueSize) {
                value[a - 8] = value[a - 8] + na[a - 8];
            }
            if (a - 7 < valueSize) {
                value[a - 7] = value[a - 7] + na[a - 7];
            }
            if (a - 6 < valueSize) {
                value[a - 6] = value[a - 6] + na[a - 6];
            }
            if (a - 5 < valueSize) {
                value[a - 5] = value[a - 5] + na[a - 5];
            }
            if (a - 4 < valueSize) {
                value[a - 4] = value[a - 4] + na[a - 4];
            }
            if (a - 3 < valueSize) {
                value[a - 3] = value[a - 3] + na[a - 3];
            }
            if (a - 2 < valueSize) {
                value[a - 2] = value[a - 2] + na[a - 2];
            }
            if (a - 1 < valueSize) {
                value[a - 1] = value[a - 1] + na[a - 1];
            }
            if (a < valueSize) {
                value[a] = value[a] + na[a];
            }
        }
    }

    return value;
}

#if defined _WIN32 || defined __CYGWIN__
    extern "C" __declspec(dllexport)
#else
    extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
int *reveal(char const *key, int *value, int const keySize, int const valueSize) {
    std::string strKey = char2String(key);
    std::string hash = join(strKey, pd);
    std::string na = sign(hash);

    int keyS = keySize +  (int) pd.length();

    for (unsigned int a = 19; a < valueSize + 20; a = a + 20) {
        if (a >= keyS) {
            if (a - 19 < valueSize) {
                int reminder = (a - 19) % keyS;
                int mark = na[reminder];
                value[a - 19] = value[a - 19] - mark;
            }
            if (a - 18 < valueSize) {
                int reminder = (a - 18) % keyS;
                int mark = na[reminder];
                value[a - 18] = value[a - 18] - mark;
            }
            if (a - 17 < valueSize) {
                int reminder = (a - 17) % keyS;
                int mark = na[reminder];
                value[a - 17] = value[a - 17] - mark;
            }
            if (a - 16 < valueSize) {
                int reminder = (a - 16) % keyS;
                int mark = na[reminder];
                value[a - 16] = value[a - 16] - mark;
            }
            if (a - 15 < valueSize) {
                int reminder = (a - 15) % keyS;
                int mark = na[reminder];
                value[a - 15] = value[a - 15] - mark;
            }
            if (a - 14 < valueSize) {
                int reminder = (a - 14) % keyS;
                int mark = na[reminder];
                value[a - 14] = value[a - 14] - mark;
            }
            if (a - 13 < valueSize) {
                int reminder = (a - 13) % keyS;
                int mark = na[reminder];
                value[a - 13] = value[a - 13] - mark;
            }
            if (a - 12 < valueSize) {
                int reminder = (a - 12) % keyS;
                int mark = na[reminder];
                value[a - 12] = value[a - 12] - mark;
            }
            if (a - 11 < valueSize) {
                int reminder = (a - 11) % keyS;
                int mark = na[reminder];
                value[a - 11] = value[a - 11] - mark;
            }
            if (a - 10 < valueSize) {
                int reminder = (a - 10) % keyS;
                int mark = na[reminder];
                value[a - 10] = value[a - 10] - mark;
            }
            if (a - 9 < valueSize) {
                int reminder = (a - 9) % keyS;
                int mark = na[reminder];
                value[a - 9] = value[a - 9] - mark;
            }
            if (a - 8 < valueSize) {
                int reminder = (a - 8) % keyS;
                int mark = na[reminder];
                value[a - 8] = value[a - 8] - mark;
            }
            if (a - 7 < valueSize) {
                int reminder = (a - 7) % keyS;
                int mark = na[reminder];
                value[a - 7] = value[a - 7] - mark;
            }
            if (a - 6 < valueSize) {
                int reminder = (a - 6) % keyS;
                int mark = na[reminder];
                value[a - 6] = value[a - 6] - mark;
            }
            if (a - 5 < valueSize) {
                int reminder = (a - 5) % keyS;
                int mark = na[reminder];
                value[a - 5] = value[a - 5] - mark;
            }
            if (a - 4 < valueSize) {
                int reminder = (a - 4) % keyS;
                int mark = na[reminder];
                value[a - 4] = value[a - 4] - mark;
            }
            if (a - 3 < valueSize) {
                int reminder = (a - 3) % keyS;
                int mark = na[reminder];
                value[a - 3] = value[a - 3] - mark;
            }
            if (a - 2 < valueSize) {
                int reminder = (a - 2) % keyS;
                int mark = na[reminder];
                value[a - 2] = value[a - 2] - mark;
            }
            if (a - 1 < valueSize) {
                int reminder = (a - 1) % keyS;
                int mark = na[reminder];
                value[a - 1] = value[a - 1] - mark;
            }
            if (a < valueSize) {
                int reminder = a % keyS;
                int mark = na[reminder];
                value[a] = value[a] - mark;
            }
        } else {
            if (a - 19 < valueSize) {
                value[a - 19] = value[a - 19] - na[a - 19];
            }
            if (a - 18 < valueSize) {
                value[a - 18] = value[a - 18] - na[a - 18];
            }
            if (a - 17 < valueSize) {
                value[a - 17] = value[a - 17] - na[a - 17];
            }
            if (a - 16 < valueSize) {
                value[a - 16] = value[a - 16] - na[a - 16];
            }
            if (a - 15 < valueSize) {
                value[a - 15] = value[a - 15] - na[a - 15];
            }
            if (a - 14 < valueSize) {
                value[a - 14] = value[a - 14] - na[a - 14];
            }
            if (a - 13 < valueSize) {
                value[a - 13] = value[a - 13] - na[a - 13];
            }
            if (a - 12 < valueSize) {
                value[a - 12] = value[a - 12] - na[a - 12];
            }
            if (a - 11 < valueSize) {
                value[a - 11] = value[a - 11] - na[a - 11];
            }
            if (a - 10 < valueSize) {
                value[a - 10] = value[a - 10] - na[a - 10];
            }
            if (a - 9 < valueSize) {
                value[a - 9] = value[a - 9] - na[a - 9];
            }
            if (a - 8 < valueSize) {
                value[a - 8] = value[a - 8] - na[a - 8];
            }
            if (a - 7 < valueSize) {
                value[a - 7] = value[a - 7] - na[a - 7];
            }
            if (a - 6 < valueSize) {
                value[a - 6] = value[a - 6] - na[a - 6];
            }
            if (a - 5 < valueSize) {
                value[a - 5] = value[a - 5] - na[a - 5];
            }
            if (a - 4 < valueSize) {
                value[a - 4] = value[a - 4] - na[a - 4];
            }
            if (a - 3 < valueSize) {
                value[a - 3] = value[a - 3] - na[a - 3];
            }
            if (a - 2 < valueSize) {
                value[a - 2] = value[a - 2] - na[a - 2];
            }
            if (a - 1 < valueSize) {
                value[a - 1] = value[a - 1] - na[a - 1];
            }
            if (a < valueSize) {
                value[a] = value[a] - na[a];
            }
        }
    }

    return value;
}

