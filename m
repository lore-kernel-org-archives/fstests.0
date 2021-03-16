Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF49C433E9
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 10:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16C565027
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 10:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhCPKhC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:37:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42080 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbhCPKgo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Mar 2021 06:36:44 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lM746-0008JF-N5; Tue, 16 Mar 2021 10:36:42 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v9 4/4] xfs/530: quotas on idmapped mounts
Date:   Tue, 16 Mar 2021 11:36:27 +0100
Message-Id: <20210316103627.2954121-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is basically a re-implementation of xfs/050 but each file creation
call is done through an idmapped mount which verifies that the semantics
are identical even when the mount is idmapped.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch not present

/* v3 */
patch not present

/* v4 */
patch not present

/* v5 */
patch not present

/* v6 */
patch not present

/* v7 */
patch not present

/* v8 */
patch introduced

/* v9 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Rebased onto current master.
---
 tests/xfs/530     | 274 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/530.out | 129 ++++++++++++++++++++++
 tests/xfs/group   |   1 +
 3 files changed, 404 insertions(+)
 create mode 100644 tests/xfs/530
 create mode 100644 tests/xfs/530.out

diff --git a/tests/xfs/530 b/tests/xfs/530
new file mode 100644
index 00000000..9e10c40d
--- /dev/null
+++ b/tests/xfs/530
@@ -0,0 +1,274 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
+# All Rights Reserved.
+#
+# FS QA Test No. 530
+#
+# Exercises basic XFS quota functionality
+#       uquota, gquota, uqnoenforce, gqnoenforce
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+_cleanup()
+{
+	cd /
+	_scratch_unmount 2>/dev/null
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs xfs
+
+cp /dev/null $seqres.full
+chmod a+rwx $seqres.full	# arbitrary users will write here
+
+_require_scratch
+_require_xfs_quota
+_require_user fsgqa
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+bsize=$(_get_file_block_size $SCRATCH_MNT)
+_scratch_unmount
+
+bsoft=$(( 200 * $bsize ))
+bhard=$(( 1000 * $bsize ))
+isoft=4
+ihard=10
+
+_filter_report()
+{
+	tr -s '[:space:]' | \
+	perl -npe '
+		s/^\#'$id' /[NAME] /g;
+		s/^\#0 \d+ /[ROOT] 0 /g;
+		s/6 days/7 days/g' |
+	perl -npe '
+		$val = 0;
+		if ($ENV{'LARGE_SCRATCH_DEV'}) {
+			$val = $ENV{'NUM_SPACE_FILES'};
+		}
+		s/(^\[ROOT\] \S+ \S+ \S+ \S+ \[--------\] )(\S+)/$1@{[$2 - $val]}/g' |
+	sed -e 's/ 65535 \[--------\]/ 00 \[--------\]/g' |
+	perl -npe '
+		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
+}
+
+# The actual point at which limit enforcement takes place for the
+# hard block limit is variable depending on filesystem blocksize,
+# and iosize.  What we want to test is that the limit is enforced
+# (ie. blksize less than limit but not unduly less - ~85% is kind)
+# nowadays we actually get much closer to the limit before EDQUOT.
+#
+_filter_and_check_blks()
+{
+	perl -npe '
+		if (/^\#'$id'\s+(\d+)/ && '$enforce') {
+			$maximum = '$bhard';
+			$minimum = '$bhard' * 85/100;
+			$used = $1 * 1024;
+			if (($used < $minimum || $used > $maximum) && '$noextsz') {
+				printf(" URK %d: %d is out of range! [%d,%d]\n",
+					'$id', $used, $minimum, $maximum);
+			}
+			s/^(\#'$id'\s+)(\d+)/\1 =OK=/g;
+		}
+	' | _filter_report
+}
+
+_qsetup()
+{
+	opt=$1
+	enforce=0
+	if [ $opt = "u" -o $opt = "uno" ]; then
+		type=u
+		eval `_choose_uid`
+	elif [ $opt = "g" -o $opt = "gno" ]; then
+		type=g
+		eval `_choose_gid`
+	elif [ $opt = "p" -o $opt = "pno" ]; then
+		type=p
+		eval `_choose_prid`
+	fi
+	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
+
+	echo "Using type=$type id=$id" >> $seqres.full
+}
+
+_mount_idmapped()
+{
+	if [ "$type" == "u" ]; then
+		# This means root will be able to create files as uid %id in
+		# the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount u:0:$id:1 \
+							 --map-mount u:$id:0:1 \
+							 --map-mount g:0:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	else
+		# This means root will be able to create files as gid %id in
+		# the underlying filesystem by going through the idmapped mount.
+		$here/src/idmapped-mounts/mount-idmapped --map-mount g:0:$id:1 \
+							 --map-mount g:$id:0:1 \
+							 --map-mount u:0:0:1 \
+							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+	fi
+}
+
+_umount_idmapped()
+{
+	# ls -al "$SCRATCH_MNT"
+	umount -l -q "${SCRATCH_MNT}" >/dev/null 2>&1
+	# ls -al "$SCRATCH_MNT"
+}
+
+_exercise()
+{
+	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
+	cat $tmp.mkfs >>$seqres.full
+
+	# keep the blocksize and data size for dd later
+	. $tmp.mkfs
+
+	_qmount
+
+	# Figure out whether we're doing large allocations
+	# (bail out if they're so large they stuff the test up)
+	_test_inode_flag extsz-inherit $SCRATCH_MNT
+	noextsz=$?
+	extsize=`_test_inode_extsz $SCRATCH_MNT`
+	[ $extsize -ge 512000 ] && \
+		_notrun "Extent size hint is too large ($extsize bytes)"
+
+	_qsetup $1
+
+	echo "Using type=$type id=$id" >>$seqres.full
+
+	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
+
+	echo
+	echo "*** report no quota settings" | tee -a $seqres.full
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** report initial settings" | tee -a $seqres.full
+	_mount_idmapped
+	_file_as_id $SCRATCH_MNT/initme 0 $type 1024 0
+	_umount_idmapped
+	echo "ls -l $SCRATCH_MNT" >>$seqres.full
+	ls -l $SCRATCH_MNT >>$seqres.full
+	$XFS_QUOTA_PROG -D $tmp.projects -P $temp.projid -x \
+		-c "limit -$type bsoft=${bsoft} bhard=${bhard} $id" \
+		-c "limit -$type isoft=$isoft ihard=$ihard $id" \
+		$SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** push past the soft inode limit" | tee -a $seqres.full
+	_mount_idmapped
+	_file_as_id $SCRATCH_MNT/softie1 0 $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie2 0 $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie3 0 $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie4 0 $type 1024 0
+	_umount_idmapped
+	_qmount
+	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** push past the soft block limit" | tee -a $seqres.full
+	_mount_idmapped
+	_file_as_id $SCRATCH_MNT/softie 0 $type $bsize 300
+	_umount_idmapped
+	_qmount
+	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
+		-c "warn -b -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	# Note: for quota accounting (not enforcement), EDQUOT is not expected
+	echo "*** push past the hard inode limit (expect EDQUOT)" | tee -a $seqres.full
+	for i in 1 2 3 4 5 6 7 8 9 10 11 12
+	do
+		_mount_idmapped
+		_file_as_id $SCRATCH_MNT/hard$i 0 $type 1024 0
+		_umount_idmapped
+	done
+	_qmount
+	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
+		-c "warn -i -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	# Note: for quota accounting (not enforcement), EDQUOT is not expected
+	echo "*** push past the hard block limit (expect EDQUOT)" | tee -a $seqres.full
+	_mount_idmapped
+	_file_as_id $SCRATCH_MNT/softie 0 $type $bsize 1200
+	_umount_idmapped
+	echo "ls -l $SCRATCH_MNT" >>$seqres.full
+	ls -l $SCRATCH_MNT >>$seqres.full
+	_qmount
+	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** unmount"
+	_scratch_unmount
+
+}
+
+cat >$tmp.projects <<EOF
+1:$SCRATCH_MNT
+EOF
+
+cat >$tmp.projid <<EOF
+root:0
+scrach:1
+EOF
+
+projid_file="$tmp.projid"
+
+echo "*** user"
+_qmount_option "uquota"
+_exercise u
+
+echo "*** group"
+_qmount_option "gquota"
+_exercise g
+
+echo "*** uqnoenforce"
+_qmount_option "uqnoenforce"
+_exercise uno
+
+echo "*** gqnoenforce"
+_qmount_option "gqnoenforce"
+_exercise gno
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/530.out b/tests/xfs/530.out
new file mode 100644
index 00000000..39266b38
--- /dev/null
+++ b/tests/xfs/530.out
@@ -0,0 +1,129 @@
+QA output created by 530
+*** user
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** unmount
+*** group
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** unmount
+*** uqnoenforce
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 1200 200 1000 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** unmount
+*** gqnoenforce
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 1200 200 1000 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** unmount
diff --git a/tests/xfs/group b/tests/xfs/group
index fb4599ca..a536d01a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -506,3 +506,4 @@
 527 auto quick quota
 528 auto quick rw realtime
 529 auto quick quota
+530 auto quick quota
-- 
2.27.0

