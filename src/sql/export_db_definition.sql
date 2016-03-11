#!/bin/sh

targetdir=`dirname $0`
tmpfile=/tmp/pfitmap-eval.schema.sql
prefile=$targetdir/pfitmap-eval.schema_pre.sql
postfile=$targetdir/pfitmap-eval.schema_post.sql

pg_dump -s $DBDEV > $tmpfile

from=`grep -n CONSTRAINT $tmpfile|sed 's/:.*//'|sort -n|head -n 1`
lines=`wc -l $tmpfile|sed 's/ .*//'`

head -n $((from - 2)) $tmpfile > $prefile
tail -n $((lines - from + 2)) $tmpfile > $postfile
