package main

import (
	"crypto/md5"
	"fmt"
	"os"
)

func main() {
	i := 0
	prefix := os.Args[1]
	for index := 0; i < 8; index++ {
		data := fmt.Sprintf("%s%d", prefix, index)
		sum := md5.Sum([]byte(data))
		if sum[0] == 0 && sum[1] == 0 && (sum[2]&0xf0 == 0) {
			fmt.Printf("%x %s\n", sum, data)
			i++
		}
	}
}
