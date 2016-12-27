#!/bin/bash

grep -P '([a-z])((?!\1)[a-z])\2\1' | grep -vPc '\[[a-z]*([a-z])((?!\1)[a-z])\2\1[a-z]*\]'
