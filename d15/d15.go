package main

import (
	"fmt"
	"os"
)

func main() {
	for i := 0; true; i += 5 * 17 {
		if ((i+1+10)%13 == 0) &&
			((i+3+17)%19 == 0) &&
			((i+4+1)%7 == 0) &&
			((i+6+1)%3 == 0) &&
			((i+7+0)%11 == 0) {
			fmt.Printf("%d\n", i)
			os.Exit(0)
		}
	}

}

// Disc #1 has 13 positions; at time=0, it is at position 10.
// Disc #2 has 17 positions; at time=0, it is at position 15.
// Disc #3 has 19 positions; at time=0, it is at position 17.
// Disc #4 has 7 positions; at time=0, it is at position 1.
// Disc #5 has 5 positions; at time=0, it is at position 0.
// Disc #6 has 3 positions; at time=0, it is at position 1.
