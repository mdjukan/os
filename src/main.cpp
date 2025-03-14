#include "../lib/console.h"

void main() {
	while (true)
	{
		const char c = __getc();
		__putc(c);
	}
	return;
}
