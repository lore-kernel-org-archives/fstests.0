Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfGXOzO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Jul 2019 10:55:14 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FAB020665
        for <fstests@vger.kernel.org>; Wed, 24 Jul 2019 14:55:12 +0000 (UTC)
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] generic/062: more restrictive namespace for getfattr on cephfs
Date: Wed, 24 Jul 2019 10:55:11 -0400
Message-Id: <20190724145511.1155-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

cephfs exposes some information via virtual xattrs and their presence
causes this test to fail. When running on cephfs, only search for
specific xattr classes to ensure that we skip the ceph.* ones.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/062 | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

I'm not thrilled with this patch, but it does seem to fix the problem
I was seeing running this test on cephfs. If there are better ways to
fix this, then I'd be open to them

It would be nice if we could use a negative lookahead for this, but
getfattr doesn't seem to accept those in its regexes.

diff --git a/tests/generic/062 b/tests/generic/062
index 3fef02e8fc28..4aab20bc3135 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -78,6 +78,13 @@ if [ "$USE_ATTR_SECURE" = yes ]; then
 else
     ATTR_MODES="user trusted"
 fi
+
+if [ "$FSTYP" = ceph ]; then
+	GLOBAL_NSP_FILTER='^(security|system|trusted|user)\.'
+else
+	GLOBAL_NSP_FILTER='.'
+fi
+
 for nsp in $ATTR_MODES; do
 	for inode in reg dir lnk dev/b dev/c dev/p; do
 
@@ -119,7 +126,7 @@ for nsp in $ATTR_MODES; do
 		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
 
 		echo "*** final list (strings, type=$inode, nsp=$nsp)"
-		getfattr -m '.' -e hex $SCRATCH_MNT/$inode
+		getfattr -m $GLOBAL_NSP_FILTER -e hex $SCRATCH_MNT/$inode
 	
 	done
 done
@@ -149,11 +156,11 @@ _extend_test_bed
 
 echo
 echo "*** directory descent with us following symlinks"
-getfattr -h -L -R -m '.' -e hex $SCRATCH_MNT | _sort_getfattr_output
+getfattr -h -L -R -m $GLOBAL_NSP_FILTER -e hex $SCRATCH_MNT | _sort_getfattr_output
 
 echo
 echo "*** directory descent without following symlinks"
-getfattr -h -P -R -m '.' -e hex $SCRATCH_MNT | _sort_getfattr_output
+getfattr -h -P -R -m $GLOBAL_NSP_FILTER -e hex $SCRATCH_MNT | _sort_getfattr_output
 
 # 
 # Test the backup/restore code
@@ -166,7 +173,7 @@ _backup()
 	# we *do* sort the output by path, since it otherwise would depend on
 	# readdir order, which on some filesystems may change after re-creating
 	# the files.
-	_getfattr --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
+	_getfattr --absolute-names -dh -R -m $GLOBAL_NSP_FILTER $SCRATCH_MNT | _sort_getfattr_output >$1
 	echo BACKUP $1 >>$seqres.full
 	cat $1 >> $seqres.full
 	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"
@@ -178,7 +185,7 @@ _backup $tmp.backup1
 echo "*** clear out the scratch device"
 rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
 echo "AFTER REMOVE" >>$seqres.full
-getfattr -L -R -m '.' $SCRATCH_MNT >>$seqres.full
+getfattr -L -R -m $GLOBAL_NSP_FILTER $SCRATCH_MNT >>$seqres.full
 
 echo "*** reset test bed with no extended attributes"
 _create_test_bed
@@ -189,7 +196,7 @@ setfattr -h --restore=$tmp.backup1
 _backup $tmp.backup2
 
 echo "AFTER RESTORE" >>$seqres.full
-getfattr -L -R -m '.' $SCRATCH_MNT >>$seqres.full
+getfattr -L -R -m $GLOBAL_NSP_FILTER $SCRATCH_MNT >>$seqres.full
 
 echo "*** compare before and after backups"
 diff $tmp.backup1 $tmp.backup2
-- 
2.21.0
