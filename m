Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB32C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89A461289
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 11:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbhDLL6q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240790AbhDLL6q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Apr 2021 07:58:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D27FD611C9;
        Mon, 12 Apr 2021 11:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618228708;
        bh=ZODZDT+zK93ez9CRsiQAYhw7QZzKQFERBlLISSZagBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFX/rILohMth1w3AsrhEkySgy67PgZqFtVu3SqBI028d+S707aMjmiNUFCrCNhWTc
         Lm8vx16Nll+fBSCluxiyWZjKhdvgIjYUZNoAkZENi+oBQ0QD5jPUQny7HjAdH5kPcg
         /Ph65+YxKT3yadef/12BaOzXSqo/CFVNvnJ9dutSchEYAQdoqC/6HDueCDDp4EFsGG
         XSRKOC6UgumIfIzQW/WdypdzvOJHCqcINN0bbrGIN4vWKjtvZcCHZQ4uFO2rb9Mu5L
         0d10PyaGXp825fOnf4wLpQHm8iFFXllRMHgqfnKMCy8ql5wtMZIDzso7pVwPJExWqY
         EgRxhXYog+Liw==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v13 5/6] xfs/529: quotas and idmapped mounts
Date:   Mon, 12 Apr 2021 13:57:07 +0200
Message-Id: <20210412115708.1628386-6-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210412115708.1628386-1-brauner@kernel.org>
References: <20210412115708.1628386-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=EgB5KdoeorNO/mLrePkENS7nda1o1bZbOZAU19/Z4ok=; m=XH3eKrC4HukflTh6hqXAj6plSWpF+gIbFNy9Ku7qbs0=; p=EAZ622UAs4m78l9k1mKcVykkVIUiZgcNzQiuMpWM3xU=; g=91bcd5d063b630b711c0bbd4c1caa9a1e327f9c6
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHQ1gwAKCRCRxhvAZXjcop94AP9x5gq Tli4JsDbFgdqmhWOo2NMayZtvhMcrz39mOfqRrwD+NWPKkwC9LohEQ4ZoySWB+f7fp3FUjc9zGJwe Po/SvQs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Test that xfs quota behave correctly on idmapped mounts.
Mount a scratch device with user and group quota support enabled. Create
directories "unmapped" and "idmapped". Create files in the unampped
mount and verify quota behavior. Create files through the idmapped mount
and verify identical behavior.

Cc: Eryu Guan <guan@eryu.me>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 - v8 */
patch not present

/* v9 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Rebased on current master.

/* v10 */
- Eryu Guan <guan@eryu.me>:
  - Remove leading "_" from local helpers.
  - Remove redundant "-q" option from umount -l calls.
  - Use wipe_mount() in a few more places.

/* v11 */
- Amir Goldstein <amir73il@gmail.com>:
  - Add a dedicated "idmapped" tag for idmapped mounts tests.

/* v12 */
- Eryu Guan <guan@eryu.me>:
  - Don't use lazy umount if not required.

/* v13 */
- Eryu Guan <guan@eryu.me>:
  - Change mode of newly created files to match others.
---
 tests/xfs/529     | 377 ++++++++++++++++++++++++++
 tests/xfs/529.out | 657 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/group   |   1 +
 3 files changed, 1035 insertions(+)
 create mode 100755 tests/xfs/529
 create mode 100644 tests/xfs/529.out

diff --git a/tests/xfs/529 b/tests/xfs/529
new file mode 100755
index 00000000..a5d92314
--- /dev/null
+++ b/tests/xfs/529
@@ -0,0 +1,377 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
+# All Rights Reserved.
+#
+# FS QA Test No. 529
+#
+# Exercise basic xfs_quota functionality (user/group/project quota)
+# Use of "sync" mount option here is an attempt to get deterministic
+# allocator behaviour.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+wipe_mounts()
+{
+	umount "${SCRATCH_MNT}/idmapped" >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
+}
+
+_cleanup()
+{
+	cd /
+	wipe_mounts
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs xfs
+_require_idmapped_mounts
+_require_test_program "idmapped-mounts/mount-idmapped"
+_require_scratch
+_require_xfs_quota
+_require_user fsgqa
+_require_user fsgqa2
+_require_group fsgqa
+_require_group fsgqa2
+
+_scratch_mkfs_xfs >>$seqres.full 2>&1
+
+uqid=`id -u fsgqa`
+gqid=`id -g fsgqa`
+
+uqid2=`id -u fsgqa2`
+gqid2=`id -g fsgqa2`
+
+pqid=10
+cat >$tmp.projects <<EOF
+$pqid:$SCRATCH_MNT
+EOF
+
+cat >$tmp.projid <<EOF
+root:0
+fsgqa:$pqid
+EOF
+
+create_files_unmapped()
+{
+	local bs=$1
+	local inum=$2
+
+	echo "Using type=$type id=$id" >> $seqres.full
+
+	for ((i=0; i<$((inum-1)); i++)); do
+		_file_as_id $SCRATCH_MNT/unmapped/inode$i $id $type 1024 0
+	done
+
+	_file_as_id $SCRATCH_MNT/unmapped/block $id $type $bs 1
+}
+
+create_files_idmapped()
+{
+	local bs=$1
+	local inum=$2
+
+	echo "Using type=$type id=$id2" >> $seqres.full
+
+	for ((i=0; i<$((inum-1)); i++)); do
+		_file_as_id $SCRATCH_MNT/idmapped/inode$i $id2 $type 1024 0
+	done
+
+	_file_as_id $SCRATCH_MNT/idmapped/block $id2 $type $bs 1
+}
+
+clean_files()
+{
+	rm -rf $SCRATCH_MNT/unmapped 2>/dev/null
+	rm -rf $SCRATCH_MNT/idmapped 2>/dev/null
+	rm -rf $tmp.quot 2>/dev/null
+	rm -rf $tmp.quota 2>/dev/null
+}
+
+filter_quot()
+{
+	_filter_quota | grep -v "root \|\#0 " \
+		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
+}
+
+filter_report()
+{
+	_filter_quota | grep -v "^root \|^\#0 " \
+		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
+}
+
+filter_quota()
+{
+	_filter_quota | sed -e "/Disk quotas for/s/([0-9]*)/(ID)/g" \
+			    -e "/Disk quotas for/s/#[0-9]*/#ID/g"
+}
+
+filter_state()
+{
+	_filter_quota | sed -e "s/Inode: #[0-9]* (0 blocks, 0 extents)/Inode: #[INO] (0 blocks, 0 extents)/g" \
+			    -e "s/Inode: #[0-9]* ([0-9]* blocks, [0-9]* extents)/Inode: #[INO] (X blocks, Y extents)/g" \
+			    -e "/[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/s/ [0-9][0-9]:[0-9][0-9]:[0-9][0-9]//g" \
+			    -e '/max warnings:/d'
+}
+
+test_quot()
+{
+	local opt="$*"
+
+	echo "checking quot command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "quot -$type $opt -bi" $SCRATCH_MNT | filter_quot
+}
+
+test_report()
+{
+	local opt="$*"
+
+	echo "checking report command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "report -$type $opt -bi" \
+			$SCRATCH_MNT | filter_report
+}
+
+test_quota()
+{
+	local opt="$*"
+
+	echo "checking quota command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "quota -$type $opt -bi $id" \
+			$SCRATCH_MNT | filter_quota
+}
+
+test_limit()
+{
+	local bs=$1
+	local bh=$2
+	local is=$3
+	local ih=$4
+
+	echo "checking limit command (type=$type, bsoft=$bs, bhard=$bh, isoft=$is, ihard=$ih)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "limit -$type bsoft=$bs bhard=$bh fsgqa" \
+			-c "limit -$type isoft=$is ihard=$ih fsgqa" \
+			$SCRATCH_MNT
+
+	# let the timer day transition happen
+	sleep 2
+}
+
+test_timer()
+{
+	echo "checking timer command (type=$type)"
+	# set 3days+1h for time won't become 2days soon
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "timer -$type -bi 73h" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+test_disable()
+{
+	echo "checking disable command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "disable -$type -v" \
+			$SCRATCH_MNT | filter_state
+}
+
+test_enable()
+{
+	echo "checking enable command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "enable -$type -v" $SCRATCH_MNT | filter_state
+}
+
+test_off()
+{
+	echo "checking off command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "off -$type -v" $SCRATCH_MNT | _filter_scratch
+}
+
+test_remove()
+{
+	echo "checking remove command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "remove -$type -v" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+test_state()
+{
+	echo "checking state command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "state -$type" $SCRATCH_MNT | filter_state
+}
+
+test_dump()
+{
+	echo "checking dump command (type=$type)"
+	rm -f $tmp.backup 2>>/dev/null
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "dump -$type -f $tmp.backup" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+test_restore()
+{
+	echo "checking restore command (type=$type)"
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+			-c "restore -$type -f $tmp.backup" \
+			$SCRATCH_MNT | _filter_scratch
+}
+
+wipe_scratch()
+{
+	wipe_mounts
+	_scratch_mkfs_xfs >>$seqres.full 2>&1
+}
+
+qmount_idmapped()
+{
+	wipe_mounts
+	_try_scratch_mount || _fail "qmount failed"
+
+	mkdir -p "${SCRATCH_MNT}/unmapped"
+	mkdir -p "${SCRATCH_MNT}/idmapped"
+
+	$here/src/idmapped-mounts/mount-idmapped \
+		--map-mount b:$id:$id2:1 \
+		--map-mount b:0:0:1 \
+		"$SCRATCH_MNT/unmapped" "$SCRATCH_MNT/idmapped" || _fail "mount-idmapped failed"
+
+	chmod ugo+rwx $SCRATCH_MNT
+	chmod ugo+rwx $SCRATCH_MNT/unmapped
+	chmod ugo+rwx $SCRATCH_MNT/idmapped
+}
+
+test_xfs_quota()
+{
+	# init quota
+	echo "init quota limit and timer, and dump it"
+	if [ "$idmapped" -eq 1 ]; then
+		echo "create_files_idmapped 1024k 15"; create_files_idmapped 1024k 15
+	else
+		echo "create_files_unmapped 1024k 15"; create_files_unmapped 1024k 15
+	fi
+	echo "quota remount"; qmount_idmapped
+	echo ; test_quot
+	echo ; test_timer
+	echo ; test_limit 512k 2048k 10 20
+	echo ; test_dump
+
+	# report options test
+	echo "report options test"
+	echo ; test_report
+	echo "-N option"; test_report -N
+	echo "-L -U options"; test_report -L $id -U $id
+	echo "-t option"; test_report -t
+	echo "-n option"; test_report -n
+	echo "-h option"; test_report -h
+
+	# quot options test
+	echo "quot options test"
+	echo ; test_quot
+	echo "-f option"; test_quot -f $tmp.quot
+	cat $tmp.quot | filter_quot
+	echo "-n option"; test_quot -n
+
+	# quota options test
+	echo ; test_quota
+	echo "-f option"; test_quota -f $tmp.quota
+	cat $tmp.quota | filter_quota
+	echo "-N option"; test_quota -N
+	echo "-n option"; test_quota -n
+	echo "-h option"; test_quota -h
+
+	# disable/enable test
+	echo "disable quota"
+	echo ; test_disable
+	echo ; test_report -N
+	echo "expect a remove error at here"; test_remove
+	echo ; test_enable
+	echo ; test_report -N
+
+	# off and remove test
+	echo "off and remove test"
+	echo ; test_limit 100m 100m 100 100
+	echo ; test_quota -N
+	echo ; test_off
+	echo ; test_state
+	echo ; test_remove
+	echo ; test_report -N
+	echo "quota remount"; qmount_idmapped
+	echo ; test_report -N
+
+	# restore test
+	echo "restore quota"
+	echo ; test_restore
+	echo ; test_report -N
+	echo ; test_state
+	echo "cleanup files"; clean_files
+}
+
+echo "----------------------- uquota,sync,unmapped ---------------------------"
+wipe_scratch
+_qmount_option "uquota,sync"
+type=u
+id=$uqid
+id2=$uqid2
+idmapped=0
+qmount_idmapped
+test_xfs_quota
+
+echo "----------------------- uquota,sync,idmapped ---------------------------"
+wipe_scratch
+_qmount_option "uquota,sync"
+type=u
+id=$uqid
+id2=$uqid2
+idmapped=1
+qmount_idmapped
+test_xfs_quota
+
+echo "----------------------- gquota,sync,unmapped ---------------------------"
+wipe_scratch
+_qmount_option "gquota,sync"
+type=g
+id=$gqid
+id2=$gqid2
+idmapped=0
+qmount_idmapped
+test_xfs_quota
+
+echo "----------------------- gquota,sync,idmapped ---------------------------"
+wipe_scratch
+_qmount_option "gquota,sync"
+type=g
+id=$gqid
+id2=$gqid2
+idmapped=1
+qmount_idmapped
+test_xfs_quota
+
+wipe_mounts
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/529.out b/tests/xfs/529.out
new file mode 100644
index 00000000..7d2cd96d
--- /dev/null
+++ b/tests/xfs/529.out
@@ -0,0 +1,657 @@
+QA output created by 529
+----------------------- uquota,sync,unmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_unmapped 1024k 15
+quota remount
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+
+checking timer command (type=u)
+
+checking limit command (type=u, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=u)
+report options test
+
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 #ID 
+
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=u)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=u)
+Disk quotas for User #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=u)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=u, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=u)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking state command (type=u)
+
+checking remove command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking report command (type=u)
+
+quota remount
+
+checking report command (type=u)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=u)
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
+----------------------- uquota,sync,idmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_idmapped 1024k 15
+quota remount
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+
+checking timer command (type=u)
+
+checking limit command (type=u, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=u)
+report options test
+
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=u)
+User quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+User ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=u)
+SCRATCH_DEV (SCRATCH_MNT) User:
+ 1024 15 #ID 
+
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=u)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=u)
+Disk quotas for User #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=u)
+Disk quotas for User fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=u)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=u, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=u)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking state command (type=u)
+
+checking remove command (type=u)
+User quota are not enabled on SCRATCH_DEV
+
+checking report command (type=u)
+
+quota remount
+
+checking report command (type=u)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=u)
+
+checking report command (type=u)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=u)
+User quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
+----------------------- gquota,sync,unmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_unmapped 1024k 15
+quota remount
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+
+checking timer command (type=g)
+
+checking limit command (type=g, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=g)
+report options test
+
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 #ID 
+
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=g)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=g)
+Disk quotas for Group #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=g)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=g, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=g)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking state command (type=g)
+
+checking remove command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking report command (type=g)
+
+quota remount
+
+checking report command (type=g)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=g)
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
+----------------------- gquota,sync,idmapped ---------------------------
+init quota limit and timer, and dump it
+create_files_idmapped 1024k 15
+quota remount
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+
+checking timer command (type=g)
+
+checking limit command (type=g, bsoft=512k, bhard=2048k, isoft=10, ihard=20)
+
+checking dump command (type=g)
+report options test
+
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-N option
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-L -U options
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-t option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-n option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/ Grace 
+---------- -------------------------------------------------- -------------------------------------------------- 
+#ID 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+-h option
+checking report command (type=g)
+Group quota on SCRATCH_MNT (SCRATCH_DEV)
+ Blocks Inodes 
+Group ID Used Soft Hard Warn/Grace Used Soft Hard Warn/Grace 
+---------- --------------------------------- --------------------------------- 
+fsgqa 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days]
+
+quot options test
+
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-f option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 fsgqa 
+-n option
+checking quot command (type=g)
+SCRATCH_DEV (SCRATCH_MNT) Group:
+ 1024 15 #ID 
+
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-f option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-N option
+checking quota command (type=g)
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-n option
+checking quota command (type=g)
+Disk quotas for Group #ID (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1024 512 2048 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+-h option
+checking quota command (type=g)
+Disk quotas for Group fsgqa (ID)
+Filesystem Blocks Quota Limit Warn/Time Files Quota Limit Warn/Time Mounted on
+SCRATCH_DEV 1M 512K 2M 00 [3 days] 15 10 20 00 [3 days] SCRATCH_MNT
+disable quota
+
+checking disable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: OFF
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [--------] 15 10 20 00 [--------]
+
+expect a remove error at here
+checking remove command (type=g)
+XFS_QUOTARM: Invalid argument
+
+checking enable command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [3 days]
+Inodes grace time: [3 days]
+Realtime Blocks grace time: [7 days]
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [3 days] 15 10 20 00 [3 days]
+
+off and remove test
+
+checking limit command (type=g, bsoft=100m, bhard=100m, isoft=100, ihard=100)
+
+checking quota command (type=g)
+SCRATCH_DEV 1024 102400 102400 00 [--------] 15 100 100 00 [--------] SCRATCH_MNT
+
+checking off command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking state command (type=g)
+
+checking remove command (type=g)
+Group quota are not enabled on SCRATCH_DEV
+
+checking report command (type=g)
+
+quota remount
+
+checking report command (type=g)
+fsgqa 1024 0 0 00 [--------] 15 0 0 00 [--------]
+
+restore quota
+
+checking restore command (type=g)
+
+checking report command (type=g)
+fsgqa 1024 512 2048 00 [7 days] 15 10 20 00 [7 days]
+
+
+checking state command (type=g)
+Group quota state on SCRATCH_MNT (SCRATCH_DEV)
+ Accounting: ON
+ Enforcement: ON
+ Inode: #[INO] (X blocks, Y extents)
+Blocks grace time: [7 days]
+Inodes grace time: [7 days]
+Realtime Blocks grace time: [7 days]
+cleanup files
diff --git a/tests/xfs/group b/tests/xfs/group
index 288b916d..03b447c7 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -505,3 +505,4 @@
 526 auto quick mkfs
 527 auto quick quota
 528 auto quick rw realtime
+529 auto quick quota idmapped
-- 
2.27.0

