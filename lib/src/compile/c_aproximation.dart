import 'dart:typed_data';
import 'dart:convert';

String pd = "a6ExQWqgF67n4OTMWgztgPExNjsGx2bsfmvjjtbJOoMiQlkWfwYNLfyPq88GowmvzJ1kdiPGbB5QC1wNc6lPSP0RQxAItqVIRzJTeaPsrCaXByvUesQK1hh5JXjNZraWcW4s4TR5TTOhEJ9UsCJqa3J9erM1s5JjjJMur88ksRJFHaUHUWq0kG76UHwJkMNu6FFrEGJ63kdBeh1qzywvXbIfNYZKDKUIRs1VfCxSMzwszgH2JPMZfrCLDlrZTMCIo0QUWwlnyLAW9ty1OT5jZkcPYoJJ7nFgGJh1OAG7q0CRxTBehOQ6sSBsF2m0rlzoW4d0BskTs2JH6mtldJiI";

String ba2String(Uint8List data) {
  return utf8.decode(data);
}

String reverse(String str) {
  String r = "";
  for (int i = str.length - 1; i >= 0; i--) r += str[i];
  return r;
}

// Joins the key with the auxiliar
String join(String aux, String key) {
  if (aux.length == 0) {
    return key;
  } else {
    int size = aux.length + key.length;
    String val = "";

    int a = 0;
    int b = 0;
    for (int i = 0; i < size; i++) {
      if (a == b && a < aux.length) {
        val += aux[a];
        a++;
      } else if (a > b && b < key.length) {
        val += key[b];
        b++;
      } else if (a < aux.length) {
        val += aux[a];
        a++;
      } else if (b < key.length) {
        val += key[b];
        b++;
      }
    }
    return val;
  }
}

String sign(String key) {
  try {
    String val = "";
    int i = 0;
    int u = 0;
    for (String c in key.split("")) {
      val += c;
      
      u++;
      i++;
      
      if (i % 2 == 0) {
        i = (c.codeUnits.first + (3 * u));
      } else if (u % 2 == 0) {
        i = (u * 3 + c.codeUnits.first + (4 * u));
      } else {
        i = (u * 2 + c.codeUnits.first + (6 * u));
      }
      
      val += i.toString();
      val = reverse(val);
    }
    return reverse(val);
  } catch (e) {
    print("sign error: $e");
    return "";
  }
}

String testHash(String key) {
  String hash = join(key, pd);
  return hash;
}

String testSign(String key) {
  String hash = join(key, pd);
  return sign(hash);
}

Uint8List obfuscate(String key, Uint8List value, int keySize, int valueSize) {
  String hash = join(key, pd);
  String na = sign(hash);
  int keyS = keySize + pd.length;

  for (int a = 19; a < valueSize + 20; a = a + 20) {
    if (a >= keyS) {
      if (a - 19 < valueSize) {
        int reminder = (a - 19) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 19] = value[a - 19] + mark;
      }
      if (a - 18 < valueSize) {
        int reminder = (a - 18) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 18] = value[a - 18] + mark;
      }
      if (a - 17 < valueSize) {
        int reminder = (a - 17) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 17] = value[a - 17] + mark;
      }
      if (a - 16 < valueSize) {
        int reminder = (a - 16) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 16] = value[a - 16] + mark;
      }
      if (a - 15 < valueSize) {
        int reminder = (a - 15) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 15] = value[a - 15] + mark;
      }
      if (a - 14 < valueSize) {
        int reminder = (a - 14) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 14] = value[a - 14] + mark;
      }
      if (a - 13 < valueSize) {
        int reminder = (a - 13) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 13] = value[a - 13] + mark;
      }
      if (a - 12 < valueSize) {
        int reminder = (a - 12) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 12] = value[a - 12] + mark;
      }
      if (a - 11 < valueSize) {
        int reminder = (a - 11) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 11] = value[a - 11] + mark;
      }
      if (a - 10 < valueSize) {
        int reminder = (a - 10) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 10] = value[a - 10] + mark;
      }
      if (a - 9 < valueSize) {
        int reminder = (a - 9) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 9] = value[a - 9] + mark;
      }
      if (a - 8 < valueSize) {
        int reminder = (a - 8) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 8] = value[a - 8] + mark;
      }
      if (a - 7 < valueSize) {
        int reminder = (a - 7) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 7] = value[a - 7] + mark;
      }
      if (a - 6 < valueSize) {
        int reminder = (a - 6) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 6] = value[a - 6] + mark;
      }
      if (a - 5 < valueSize) {
        int reminder = (a - 5) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 5] = value[a - 5] + mark;
      }
      if (a - 4 < valueSize) {
        int reminder = (a - 4) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 4] = value[a - 4] + mark;
      }
      if (a - 3 < valueSize) {
        int reminder = (a - 3) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 3] = value[a - 3] + mark;
      }
      if (a - 2 < valueSize) {
        int reminder = (a - 2) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 2] = value[a - 2] + mark;
      }
      if (a - 1 < valueSize) {
        int reminder = (a - 1) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 1] = value[a - 1] + mark;
      }
      if (a < valueSize) {
        int reminder = a % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a] = value[a] + mark;
      }
    } else {
      if (a - 19 < valueSize) {
        value[a - 19] = value[a - 19] + na[a - 19].codeUnits.first;
      }
      if (a - 18 < valueSize) {
        value[a - 18] = value[a - 18] + na[a - 18].codeUnits.first;
      }
      if (a - 17 < valueSize) {
        value[a - 17] = value[a - 17] + na[a - 17].codeUnits.first;
      }
      if (a - 16 < valueSize) {
        value[a - 16] = value[a - 16] + na[a - 16].codeUnits.first;
      }
      if (a - 15 < valueSize) {
        value[a - 15] = value[a - 15] + na[a - 15].codeUnits.first;
      }
      if (a - 14 < valueSize) {
        value[a - 14] = value[a - 14] + na[a - 14].codeUnits.first;
      }
      if (a - 13 < valueSize) {
        value[a - 13] = value[a - 13] + na[a - 13].codeUnits.first;
      }
      if (a - 12 < valueSize) {
        value[a - 12] = value[a - 12] + na[a - 12].codeUnits.first;
      }
      if (a - 11 < valueSize) {
        value[a - 11] = value[a - 11] + na[a - 11].codeUnits.first;
      }
      if (a - 10 < valueSize) {
        value[a - 10] = value[a - 10] + na[a - 10].codeUnits.first;
      }
      if (a - 9 < valueSize) {
        value[a - 9] = value[a - 9] + na[a - 9].codeUnits.first;
      }
      if (a - 8 < valueSize) {
        value[a - 8] = value[a - 8] + na[a - 8].codeUnits.first;
      }
      if (a - 7 < valueSize) {
        value[a - 7] = value[a - 7] + na[a - 7].codeUnits.first;
      }
      if (a - 6 < valueSize) {
        value[a - 6] = value[a - 6] + na[a - 6].codeUnits.first;
      }
      if (a - 5 < valueSize) {
        value[a - 5] = value[a - 5] + na[a - 5].codeUnits.first;
      }
      if (a - 4 < valueSize) {
        value[a - 4] = value[a - 4] + na[a - 4].codeUnits.first;
      }
      if (a - 3 < valueSize) {
        value[a - 3] = value[a - 3] + na[a - 3].codeUnits.first;
      }
      if (a - 2 < valueSize) {
        value[a - 2] = value[a - 2] + na[a - 2].codeUnits.first;
      }
      if (a - 1 < valueSize) {
        value[a - 1] = value[a - 1] + na[a - 1].codeUnits.first;
      }
      if (a < valueSize) {
        value[a] = value[a] + na[a].codeUnits.first;
      }
    }
  }

  return value;
}

Uint8List reveal(String key, Uint8List value, int keySize, int valueSize) {
  String hash = join(key, pd);
  String na = sign(hash);
  int keyS = keySize + pd.length;

  for (int a = 19; a < valueSize + 20; a = a + 20) {
    if (a >= keyS) {
      if (a - 19 < valueSize) {
        int reminder = (a - 19) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 19] = value[a - 19] - mark;
      }
      if (a - 18 < valueSize) {
        int reminder = (a - 18) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 18] = value[a - 18] - mark;
      }
      if (a - 17 < valueSize) {
        int reminder = (a - 17) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 17] = value[a - 17] - mark;
      }
      if (a - 16 < valueSize) {
        int reminder = (a - 16) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 16] = value[a - 16] - mark;
      }
      if (a - 15 < valueSize) {
        int reminder = (a - 15) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 15] = value[a - 15] - mark;
      }
      if (a - 14 < valueSize) {
        int reminder = (a - 14) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 14] = value[a - 14] - mark;
      }
      if (a - 13 < valueSize) {
        int reminder = (a - 13) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 13] = value[a - 13] - mark;
      }
      if (a - 12 < valueSize) {
        int reminder = (a - 12) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 12] = value[a - 12] - mark;
      }
      if (a - 11 < valueSize) {
        int reminder = (a - 11) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 11] = value[a - 11] - mark;
      }
      if (a - 10 < valueSize) {
        int reminder = (a - 10) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 10] = value[a - 10] - mark;
      }
      if (a - 9 < valueSize) {
        int reminder = (a - 9) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 9] = value[a - 9] - mark;
      }
      if (a - 8 < valueSize) {
        int reminder = (a - 8) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 8] = value[a - 8] - mark;
      }
      if (a - 7 < valueSize) {
        int reminder = (a - 7) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 7] = value[a - 7] - mark;
      }
      if (a - 6 < valueSize) {
        int reminder = (a - 6) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 6] = value[a - 6] - mark;
      }
      if (a - 5 < valueSize) {
        int reminder = (a - 5) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 5] = value[a - 5] - mark;
      }
      if (a - 4 < valueSize) {
        int reminder = (a - 4) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 4] = value[a - 4] - mark;
      }
      if (a - 3 < valueSize) {
        int reminder = (a - 3) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 3] = value[a - 3] - mark;
      }
      if (a - 2 < valueSize) {
        int reminder = (a - 2) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 2] = value[a - 2] - mark;
      }
      if (a - 1 < valueSize) {
        int reminder = (a - 1) % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a - 1] = value[a - 1] - mark;
      }
      if (a < valueSize) {
        int reminder = a % keyS;
        int mark = na[reminder].codeUnits.first;
        value[a] = value[a] - mark;
      }
    } else {
      if (a - 19 < valueSize) {
        value[a - 19] = value[a - 19] - na[a - 19].codeUnits.first;
      }
      if (a - 18 < valueSize) {
        value[a - 18] = value[a - 18] - na[a - 18].codeUnits.first;
      }
      if (a - 17 < valueSize) {
        value[a - 17] = value[a - 17] - na[a - 17].codeUnits.first;
      }
      if (a - 16 < valueSize) {
        value[a - 16] = value[a - 16] - na[a - 16].codeUnits.first;
      }
      if (a - 15 < valueSize) {
        value[a - 15] = value[a - 15] - na[a - 15].codeUnits.first;
      }
      if (a - 14 < valueSize) {
        value[a - 14] = value[a - 14] - na[a - 14].codeUnits.first;
      }
      if (a - 13 < valueSize) {
        value[a - 13] = value[a - 13] - na[a - 13].codeUnits.first;
      }
      if (a - 12 < valueSize) {
        value[a - 12] = value[a - 12] - na[a - 12].codeUnits.first;
      }
      if (a - 11 < valueSize) {
        value[a - 11] = value[a - 11] - na[a - 11].codeUnits.first;
      }
      if (a - 10 < valueSize) {
        value[a - 10] = value[a - 10] - na[a - 10].codeUnits.first;
      }
      if (a - 9 < valueSize) {
        value[a - 9] = value[a - 9] - na[a - 9].codeUnits.first;
      }
      if (a - 8 < valueSize) {
        value[a - 8] = value[a - 8] - na[a - 8].codeUnits.first;
      }
      if (a - 7 < valueSize) {
        value[a - 7] = value[a - 7] - na[a - 7].codeUnits.first;
      }
      if (a - 6 < valueSize) {
        value[a - 6] = value[a - 6] - na[a - 6].codeUnits.first;
      }
      if (a - 5 < valueSize) {
        value[a - 5] = value[a - 5] - na[a - 5].codeUnits.first;
      }
      if (a - 4 < valueSize) {
        value[a - 4] = value[a - 4] - na[a - 4].codeUnits.first;
      }
      if (a - 3 < valueSize) {
        value[a - 3] = value[a - 3] - na[a - 3].codeUnits.first;
      }
      if (a - 2 < valueSize) {
        value[a - 2] = value[a - 2] - na[a - 2].codeUnits.first;
      }
      if (a - 1 < valueSize) {
        value[a - 1] = value[a - 1] - na[a - 1].codeUnits.first;
      }
      if (a < valueSize) {
        value[a] = value[a] - na[a].codeUnits.first;
      }
    }
  }

  return value;
}
