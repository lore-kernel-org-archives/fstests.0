Received: from sandeen.net ([63.231.237.45]:50365 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226AbbLBRmV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Dec 2015 12:42:21 -0500
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] loosen input requirements on defrag testing
Message-ID: <565F2D7B.90501@sandeen.net>
Date: Wed, 2 Dec 2015 11:42:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>, Jeff Moyer <jmoyer@redhat.com>
List-ID: <fstests@vger.kernel.org>

We don't have perfect control of file allocation for these tests;
in some cases we may fail to adequately fragment a file prior to
defragmentation testing, and today that will fail the test.

Attack this on 2 fronts:

1) Explicitly allow fewer extents on one of the input files in
   generic/018 where the allocator has discretion.
2) _notrun rather than _fail if we don't create enough extents;
   this is a defrag test, not an allocator/fragmentation test,
   so just skip the test if we can't create an acceptable file
   for defrag testing.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/defrag b/common/defrag
index f923dc0..2e0804d 100644
--- a/common/defrag
+++ b/common/defrag
@@ -53,15 +53,24 @@ _check_extent_count()
 	max=$2
 	ext_cnt=$3
 
-	[ "$min" -gt "$ext_cnt" ] && _fail "Found $ext_cnt extents  min:$max"
-	[ "$max" -ne -1 ] && [ "$ext_cnt" -gt "$max" ] && _fail "Found $ext_cnt max: $max"
+	# Return failure if $3 isn't between $1 and $2; let caller decide
+	# action if it's not, we just return status here.
+	if [ "$min" -gt "$ext_cnt" ]; then
+		echo "Found $ext_cnt extents  min:$max"
+		return 1;
+	fi
+	if [ "$max" -ne -1 ] && [ "$ext_cnt" -gt "$max" ]; then
+		echo "Found $ext_cnt max: $max"
+		return 1;
+	fi
 
 	if [ $max -ne $min ]; then
 	    echo "in_range($min, $max)"
 	else
 	    echo "$ext_cnt"
 	fi
-	return $ext_cnt
+	# success
+	return 0
 }
 
 # Defrag file, check it, and remove it.
@@ -129,6 +138,7 @@ _defrag()
 	echo -n "Before: "
 	ext_before=$(_extent_count $1)
 	_check_extent_count $min_before $max_before $ext_before
+	[ $? -eq 0 ] || _notrun "Could not adequately fragment file"
 
 	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
@@ -141,6 +151,7 @@ _defrag()
 	echo -n "After: "
 	ext_after=$(_extent_count $1)
 	_check_extent_count $min_after $max_after $ext_after
+	[ $? -eq 0 ] || _fail "Failed to adequately defragment file"
 
 	[ "$ext_before" -lt "$ext_after" ] && \
 		_fail "Number of extents increased after defragmentation," \
diff --git a/tests/generic/018 b/tests/generic/018
index d97bb88..21bcc63 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -77,7 +77,9 @@ for i in `seq 9 -1 0`; do
 	$XFS_IO_PROG -fs -c "pwrite -b $bsize $((i * bsize)) $bsize" $fragfile \
 					> /dev/null
 done
-_defrag --before 10 --after 1 $fragfile
+
+# Accept fewer fragments than we might expect; we don't have perfect control.
+_defrag --max-before 10 --min-before 5 --after 1 $fragfile
 
 echo "Write backwards sync leaving holes - defrag should do nothing" | tee -a $seqres.full
 for i in `seq 31 -2 0`; do
