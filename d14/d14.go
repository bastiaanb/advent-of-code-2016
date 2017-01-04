package main

import (
	"crypto/md5"
	"fmt"
	"os"
	"strconv"
)

func main() {
	prefix := os.Args[1]
	repeats, _ := strconv.Atoi(os.Args[2])
	for index := 0; ; index++ {
		var data string
		data = fmt.Sprintf("%s%d", prefix, index)
		for repeat := 1; repeat <= repeats; repeat++ {
			data = fmt.Sprintf("%x", md5.Sum([]byte(data)))
		}
		fmt.Printf("%s\n", data)
	}
}
