/*Pentru urmatoarele probleme se cere cel putin un subprogram implementat in asm iar programul principal implementat in C.
11. Se citeste de la tastatura un sir de mai multe numere in baza 2. Sa se afiseze aceste numere in baza 16. */

#include <stdio.h>

void convert();

int main()
{
	long int x, c = 1, remainder, hxa = 0;
	int n, i;
	printf("Input the number of numbers: ");
	scanf("%d", &n);
		for (i = 1;i <= n;i++)
		{
			printf("Number %d :", i);

			scanf("%ld", &x);

			while (x != 0)
			{
				remainder = x % 10;
				hxa = hxa + remainder * c;
				c = c * 2;
				x = x / 10;
			}

			
			convert(hxa);
			printf("\n");
		}

	return 0;

}