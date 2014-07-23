Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:26435 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbaGWLIh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 23 Jul 2014 07:08:37 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 1/3] xfstests: add options to _defrag helper
Date: Wed, 23 Jul 2014 15:08:16 +0400
Message-Id: <1406113698-9387-2-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1406113698-9387-1-git-send-email-dmonakhov@openvz.org>
References: <1406113698-9387-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Sometimes it is not easy to know number of expected extents in advance.
In that case it is reasonable to provide sane MIN and MAX values.
Also helper will check that number of extents before defragmentaion
is not greather than after.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/defrag     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++----
 tests/generic/018 |   12 +++---
 2 files changed, 99 insertions(+), 14 deletions(-)

diff --git a/common/defrag b/common/defrag
index 732cd64..f5e36fb 100644
--- a/common/defrag
+++ b/common/defrag
@@ -43,29 +43,114 @@ _require_defrag()
 
 _extent_count()
 {
-	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
 	$XFS_IO_PROG -c "fiemap" $1  >> $seqres.full 2>&1
+	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l| $AWK_PROG '{print $1}'
+}
+
+_check_extent_count()
+{
+	min=$1
+	max=$2
+	ext_cnt=$3
+
+	[ "$min" -gt "$ext_cnt" ] && _fail "Found $ext_cnt extents  min:$max"
+	[ "$max" -ne -1 ] && [ "$ext_cnt" -gt "$max" ] && _fail "Found $ext_cnt max: $max"
+
+	if [ $max -ne $min ]; then
+	    echo "in_range($min, $max)"
+	else
+	    echo "$ext_cnt"
+	fi
+	return $ext_cnt
 }
 
 # Defrag file, check it, and remove it.
 _defrag()
 {
+	min_before=0
+	max_before=-1
+	min_after=0
+	max_after=-1
+	csum=1
+	mtime=1
+
+	while [ $# -gt 1 ]
+	do
+            case $1
+		in
+		--min_before)
+		    [ -z "$2" ] && _fail "missing argument for --min_before"
+		    min_before=$2
+		    shift
+		    ;;
+		--max_before)
+		    [ -z "$2" ] && _fail "missing argument for --max_before"
+		    max_before=$2
+		    shift
+		    ;;
+		--min_after)
+		    [ -z "$2" ] && _fail "missing argument for --min_after"
+		    min_after=$2
+		    shift
+		    ;;
+		--max_after)
+		    [ -z "$2" ] && _fail "missing argument for --max_after"
+		    max_after=$2
+		    shift
+		    ;;
+		--before)
+		    [ -z "$2" ] && _fail "missing argument for --before"
+		    min_before=$2
+		    max_before=$2
+		    shift
+		    ;;
+		--after)
+		    [ -z "$2" ] && _fail "missing argument for --after"
+		    min_after=$2
+		    max_after=$2
+		    shift
+		    ;;
+		--no_csum)
+		    csum=
+		    ;;
+		--no_mtime)
+		    mtime=
+		    ;;
+		--no_unlink)
+		    no_unlink=1
+		    ;;
+		*)
+		    _fail "invalid argument to common/dump function: $1"
+		    ;;
+            esac
+	    shift
+	done
+
 	echo -n "Before: "
-	_extent_count $1
-	CSUM_BEFORE=`md5sum $1`
+	ext_before=$(_extent_count $1)
+	_check_extent_count $min_before $max_before $ext_before
+
+	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
 	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+
 	_scratch_remount
 	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
-	CSUM_AFTER=`md5sum $1`
+	[ ! -z $csum ] && CSUM_AFTER=`md5sum $1`
+
 	echo -n "After: "
-	_extent_count $1
-	if [ "$CSUM_BEFORE" != "$CSUM_AFTER" ]; then
+	ext_after=$(_extent_count $1)
+	_check_extent_count $min_after $max_after $ext_after
+
+	[ "$ext_before" -lt "$ext_after" ] && \
+		_fail "Number of extents increased after defragmentation," \
+		      " before:$ext_before, after:$ext_after"
+	if [ ! -z $csum ] && [ "$CSUM_BEFORE" != "$CSUM_AFTER" ]; then
 		_fail "file checksum changed post-defrag ($CSUM_BEFORE/$CSUM_AFTER)"
 	fi
-	if [ "$STAT_BEFORE" != "$STAT_AFTER" ]; then
+	if [ ! -z $mtime ] && [ "$STAT_BEFORE" != "$STAT_AFTER" ]; then
 		_fail "file timestamps changed post-defrag:\n$STAT_BEFORE\n$STAT_AFTER"
 	fi
-	rm -f $1
+	[ -z $no_unlink ] && rm -f $1
 }
 
diff --git a/tests/generic/018 b/tests/generic/018
index 2544391..2b804b5 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -60,33 +60,33 @@ rm -f $fragfile
 
 echo "zero-length file:" | tee -a $seqres.full
 touch $fragfile
-_defrag $fragfile
+_defrag --before 0 --after 0 $fragfile
 
 echo "Sparse file (no blocks):" | tee -a $seqres.full
 $XFS_IO_PROG -f -c "truncate 1m" $fragfile
-_defrag $fragfile
+_defrag --before 0 --after 0 $fragfile
 
 echo "Contiguous file:" | tee -a $seqres.full
 dd if=/dev/zero of=$fragfile bs=4k count=4 &>/dev/null
-_defrag $fragfile
+_defrag --before 1 --after 1 $fragfile
 
 echo "Write backwards sync, but contiguous - should defrag to 1 extent" | tee -a $seqres.full
 for I in `seq 9 -1 0`; do
 	dd if=/dev/zero of=$fragfile bs=4k count=1 conv=notrunc seek=$I oflag=sync &>/dev/null
 done
-_defrag $fragfile
+_defrag --before 10 --after 1 $fragfile
 
 echo "Write backwards sync leaving holes - defrag should do nothing" | tee -a $seqres.full
 for I in `seq 31 -2 0`; do
 	dd if=/dev/zero of=$fragfile bs=4k count=1 conv=notrunc seek=$I oflag=sync &>/dev/null
 done
-_defrag $fragfile
+_defrag --before 16 --after 16 $fragfile
 
 echo "Write forwards sync leaving holes - defrag should do nothing" | tee -a $seqres.full
 for I in `seq 0 2 31`; do
 	dd if=/dev/zero of=$fragfile bs=4k count=1 conv=notrunc seek=$I oflag=sync &>/dev/null
 done
-_defrag $fragfile
+_defrag --before 16 --after 16 $fragfile
 
 rm -f $seqres.full
 status=0
-- 
1.7.1

