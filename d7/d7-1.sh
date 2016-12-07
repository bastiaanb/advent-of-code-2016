#!/bin/bash

perl -n -e 'm/([a-z])((?!\1)[a-z])\2\1/ && !m/\[[a-z]*([a-z])((?!\1)[a-z])\2\1[a-z]*\]/ && print' | wc -l
