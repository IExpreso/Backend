#include <stdio.h>

#define MAX 100000;

int a[256];
int b[256];
int c[256];

int main(int argc, char const *argv[]) {
  int i, j;
  for (i = 0; i < 1000000; i++)
    for (j = 0; j < sizeof(a) / sizeof(a[0]); j++)
      c[j] = a[j] + b[j];
  return 0;
}
