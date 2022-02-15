Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD690C43219
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Feb 2022 01:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiBOBs6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Feb 2022 20:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiBOBs4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Feb 2022 20:48:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02401405D1
        for <fstests@vger.kernel.org>; Mon, 14 Feb 2022 17:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZfUUwOnB66Rgh4AZekrnHnl4fiKzzFUbYveHj0W8Org=; b=ffu5D0iCMYYLjWYUA2FJB1D9uI
        HbHpt5KlfhEvtdMXgu6E0qxhTgHyx5taH9Flvk4HJtXAzYyDzPZfW9UdnwQJSb3I1WSmzFinEhnGT
        UA2H4OzHX6Ba8n8gwELNe8Xpr1x1EtRERmxaWPIRr4AuM66zycFTR9q9tf0jUC1ixYwdIvBv5xPOT
        /sTVBEQjkhIAwUtHM/Oc/R9y1FQCYl7XoS3ibpWGbrg+xcaWuUj1bEWyZXv6ICK3aZN3ZsAUbwCpp
        W3elSBfkWa7yugzengt6Vlp7B+ELWaqsbuhOk52qzO1d0YSXntkOnrJPMN1vNC7q3+Fp5c38Chp4t
        r+u9zoXQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJmxS-00HTRv-1L; Tue, 15 Feb 2022 01:48:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, johannes.thumshirn@wdc.com
Cc:     a.manzanares@samsung.com, p.raghav@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 3/3] tests/btrfs: use $AWK_PROG instead of awk
Date:   Mon, 14 Feb 2022 17:48:45 -0800
Message-Id: <20220215014845.4164719-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215014845.4164719-1-mcgrof@kernel.org>
References: <20220215014845.4164719-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Use $AWK_PROG instead of awk in case the default awk
program is not called awk.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/btrfs/001 |  2 +-
 tests/btrfs/003 |  2 +-
 tests/btrfs/006 |  6 +++---
 tests/btrfs/011 |  2 +-
 tests/btrfs/022 | 12 ++++++------
 tests/btrfs/027 |  4 ++--
 tests/btrfs/035 |  4 ++--
 tests/btrfs/085 |  2 +-
 tests/btrfs/090 |  2 +-
 tests/btrfs/124 |  4 ++--
 tests/btrfs/125 |  6 +++---
 tests/btrfs/149 |  8 ++++----
 tests/btrfs/161 |  4 ++--
 tests/btrfs/162 |  6 +++---
 tests/btrfs/163 |  6 +++---
 tests/btrfs/164 |  4 ++--
 tests/btrfs/175 |  2 +-
 tests/btrfs/176 |  6 +++---
 tests/btrfs/181 |  2 +-
 tests/btrfs/184 |  2 +-
 tests/btrfs/185 |  8 ++++----
 tests/btrfs/194 |  4 ++--
 tests/btrfs/197 |  4 ++--
 tests/btrfs/198 |  4 ++--
 tests/btrfs/215 |  4 ++--
 tests/btrfs/216 |  4 ++--
 tests/btrfs/218 |  4 ++--
 tests/btrfs/254 |  4 ++--
 28 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 000aeb34..6c263999 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -66,7 +66,7 @@ ls $SCRATCH_MNT
 
 # Test listing the subvolumes
 echo "Listing subvolumes"
-$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
 
 # Delete the snapshot
 $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/snap | _filter_btrfs_subvol_delete
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index 0aa4c991..cf605730 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -167,7 +167,7 @@ _test_remove()
 	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
 
 	# pick last dev in the list
-	dev_del=`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
+	dev_del=`echo ${SCRATCH_DEV_POOL} | $AWK_PROG '{print $NF}'`
 	$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs device delete failed"
 	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV 2>&1 | grep $dev_del >> $seqres.full && _fail "btrfs still shows the deleted dev"
 	_scratch_unmount
diff --git a/tests/btrfs/006 b/tests/btrfs/006
index fd0f89e2..bff6f980 100755
--- a/tests/btrfs/006
+++ b/tests/btrfs/006
@@ -20,8 +20,8 @@ _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
 
-FIRST_POOL_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
-LAST_POOL_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $NF}'`
+FIRST_POOL_DEV=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
+LAST_POOL_DEV=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $NF}'`
 TOTAL_DEVS=`echo $SCRATCH_DEV_POOL | wc -w`
 LABEL=TestLabel.$seq
 
@@ -40,7 +40,7 @@ _scratch_mount
 
 echo "== Show filesystem by label"
 $BTRFS_UTIL_PROG filesystem show $LABEL | _filter_btrfs_filesystem_show $TOTAL_DEVS
-UUID=`$BTRFS_UTIL_PROG filesystem show $LABEL | grep uuid: | awk '{print $NF}'`
+UUID=`$BTRFS_UTIL_PROG filesystem show $LABEL | grep uuid: | $AWK_PROG '{print $NF}'`
 
 echo "UUID $UUID" >> $seqres.full
 
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 05ea96b9..0665e126 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -107,7 +107,7 @@ workout()
 	local num_devs4raid="$2"
 	local with_cancel="$3"
 	local fssize="$4"
-	local source_dev="`echo ${SCRATCH_DEV_POOL} | awk '{print $1}'`"
+	local source_dev="`echo ${SCRATCH_DEV_POOL} | $AWK_PROG '{print $1}'`"
 	local quick="quick"
 
 	[[ $fssize != 64 ]] && quick="thorough"
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index bfd6ac7f..e2d37b09 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -35,12 +35,12 @@ _basic_test()
 	# the shared values of both the original subvol and snapshot should
 	# match
 	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
-	a_shared=$(echo $a_shared | awk '{ print $2 }')
+	a_shared=$(echo $a_shared | $AWK_PROG '{ print $2 }')
 	echo "subvol a id=$subvolid" >> $seqres.full
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
 	echo "subvol b id=$subvolid" >> $seqres.full
 	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
-	b_shared=$(echo $b_shared | awk '{ print $2 }')
+	b_shared=$(echo $b_shared | $AWK_PROG '{ print $2 }')
 	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT >> $seqres.full
 	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
 }
@@ -59,14 +59,14 @@ _rescan_test()
 	sync
 	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	echo "qgroup values before rescan: $output" >> $seqres.full
-	refer=$(echo $output | awk '{ print $2 }')
-	excl=$(echo $output | awk '{ print $3 }')
+	refer=$(echo $output | $AWK_PROG '{ print $2 }')
+	excl=$(echo $output | $AWK_PROG '{ print $3 }')
 	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	echo "qgroup values after rescan: $output" >> $seqres.full
-	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
+	[ $refer -eq $(echo $output | $AWK_PROG '{ print $2 }') ] || \
 		_fail "reference values don't match after rescan"
-	[ $excl -eq $(echo $output | awk '{ print $3 }') ] || \
+	[ $excl -eq $(echo $output | $AWK_PROG '{ print $3 }') ] || \
 		_fail "exclusive values don't match after rescan"
 }
 
diff --git a/tests/btrfs/027 b/tests/btrfs/027
index e8679248..46c14b9c 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -45,8 +45,8 @@ run_test()
 	fi
 	_scratch_mount >>$seqres.full 2>&1
 
-	local missing_dev=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
-	local missing_dev_id=`$BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT | grep $missing_dev | awk '{print $2}'`
+	local missing_dev=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
+	local missing_dev_id=`$BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT | grep $missing_dev | $AWK_PROG '{print $2}'`
 
 	# get some data on the filesystem so there's something to replace
 	_ddt of="$SCRATCH_MNT"/file1 bs=1M count=1 >> $seqres.full 2>&1
diff --git a/tests/btrfs/035 b/tests/btrfs/035
index 4ddc5bf6..7e644ecf 100755
--- a/tests/btrfs/035
+++ b/tests/btrfs/035
@@ -33,7 +33,7 @@ echo -n "$src_str" > $SCRATCH_MNT/src
 
 $CLONER_PROG $SCRATCH_MNT/src $SCRATCH_MNT/src.clone2
 
-snap_src_sz=`ls -lah $SCRATCH_MNT/src.clone1 | awk '{print $5}'`
+snap_src_sz=`ls -lah $SCRATCH_MNT/src.clone1 | $AWK_PROG '{print $5}'`
 echo "attempting ioctl (src.clone1 src)"
 $CLONER_PROG -s 0 -d 0 -l ${snap_src_sz} \
 	$SCRATCH_MNT/src.clone1 $SCRATCH_MNT/src | _filter_btrfs_cloner_error
@@ -48,7 +48,7 @@ $CLONER_PROG -s 0 -d 0 -l ${snap_src_sz} \
 echo "File src data after attempt to clone from src.clone1 into src:"
 od -t x1 $SCRATCH_MNT/src
 
-snap_src_sz=`ls -lah $SCRATCH_MNT/src.clone2 | awk '{print $5}'`
+snap_src_sz=`ls -lah $SCRATCH_MNT/src.clone2 | $AWK_PROG '{print $5}'`
 echo "attempting ioctl (src.clone2 src)"
 $CLONER_PROG -s 0 -d 0 -l ${snap_src_sz} \
 	$SCRATCH_MNT/src.clone2 $SCRATCH_MNT/src
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index cef4da28..bcbf1a05 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -112,7 +112,7 @@ new_subvolume()
 new_default()
 {
 	new_subvolume
-	SUB=$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT |awk '{print $2}')
+	SUB=$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{print $2}')
 	_run_btrfs_util_prog subvolume set-default $SUB $SCRATCH_MNT
 
 	_unmount_flakey
diff --git a/tests/btrfs/090 b/tests/btrfs/090
index 766c24cd..3693a3ad 100755
--- a/tests/btrfs/090
+++ b/tests/btrfs/090
@@ -26,7 +26,7 @@ _supported_fs btrfs
 _require_scratch
 _require_scratch_dev_pool
 
-FIRST_POOL_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
+FIRST_POOL_DEV=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
 TOTAL_DEVS=`echo $SCRATCH_DEV_POOL | wc -w`
 
 _scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 8771a3c1..e8d77aaa 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -45,8 +45,8 @@ _require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 2
 
-dev1=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
-dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
+dev1=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
+dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
 
 # RAID1 is not supported on zoned btrfs
 _require_non_zoned_device "$dev1"
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index b6a28f5c..44ba49ec 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -45,9 +45,9 @@ _require_btrfs_fs_feature raid56
 
 _scratch_dev_pool_get 3
 
-dev1=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
-dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
-dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
+dev1=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
+dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
+dev3=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}'`
 
 echo dev1=$dev1 >> $seqres.full
 echo dev2=$dev2 >> $seqres.full
diff --git a/tests/btrfs/149 b/tests/btrfs/149
index 176d8ec5..d6dce45d 100755
--- a/tests/btrfs/149
+++ b/tests/btrfs/149
@@ -75,8 +75,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/mysnap2 2>&1 >/dev/null | _filter_scratch
 
-sum_src_snap1=$(md5sum $SCRATCH_MNT/mysnap1/foobar | awk '{print $1}')
-sum_src_snap2=$(md5sum $SCRATCH_MNT/mysnap2/foobar | awk '{print $1}')
+sum_src_snap1=$(md5sum $SCRATCH_MNT/mysnap1/foobar | $AWK_PROG '{print $1}')
+sum_src_snap2=$(md5sum $SCRATCH_MNT/mysnap2/foobar | $AWK_PROG '{print $1}')
 echo "File digests in the original filesystem:" >> $seqres.full
 echo "md5sum $SCRATCH_MNT/mysnap1/foobar " $sum_src_snap1 >> $seqres.full
 echo "md5sum $SCRATCH_MNT/mysnap2/foobar " $sum_src_snap2 >> $seqres.full
@@ -90,8 +90,8 @@ _scratch_mount "-o compress"
 $BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 $BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
 
-sum_dest_snap1=$(md5sum $SCRATCH_MNT/mysnap1/foobar | awk '{print $1}')
-sum_dest_snap2=$(md5sum $SCRATCH_MNT/mysnap2/foobar | awk '{print $1}')
+sum_dest_snap1=$(md5sum $SCRATCH_MNT/mysnap1/foobar | $AWK_PROG '{print $1}')
+sum_dest_snap2=$(md5sum $SCRATCH_MNT/mysnap2/foobar | $AWK_PROG '{print $1}')
 echo "File digests in the new filesystem:" | tee -a $seqres.full
 echo "md5sum $SCRATCH_MNT/mysnap1/foobar " $sum_src_snap1 >> $seqres.full
 echo "md5sum $SCRATCH_MNT/mysnap2/foobar " $sum_src_snap2 >> $seqres.full
diff --git a/tests/btrfs/161 b/tests/btrfs/161
index ed5b67fa..5aac8fe9 100755
--- a/tests/btrfs/161
+++ b/tests/btrfs/161
@@ -23,8 +23,8 @@ _require_scratch_dev_pool 2
 
 _scratch_dev_pool_get 2
 
-dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 
 create_seed()
 {
diff --git a/tests/btrfs/162 b/tests/btrfs/162
index 7680e1e4..1d8dbf95 100755
--- a/tests/btrfs/162
+++ b/tests/btrfs/162
@@ -25,9 +25,9 @@ _require_scratch_dev_pool 3
 
 _scratch_dev_pool_get 3
 
-dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-dev_sprout_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
-dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')
 
 create_seed()
 {
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 59f0461b..c2a04791 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -38,9 +38,9 @@ _require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 3
 
-dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
-dev_replace_tgt=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+dev_replace_tgt=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')
 
 create_seed()
 {
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 8fd6ab62..43c55c16 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -29,8 +29,8 @@ _require_scratch_dev_pool 2
 
 _scratch_dev_pool_get 2
 
-dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 
 create_seed()
 {
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index dc6c1921..db877d41 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -48,7 +48,7 @@ _scratch_mount
 # Create the swap file, then add the device. That way we know it's all on one
 # device.
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
-scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
+scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $2 }')"
 $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 33f9a061..7080d860 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -22,9 +22,9 @@ _require_scratch_swapfile
 # We check the filesystem manually because we move devices around.
 rm -f "${RESULT_DIR}/require_scratch"
 
-scratch_dev1="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $1 }')"
-scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
-scratch_dev3="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
+scratch_dev1="$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $1 }')"
+scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $2 }')"
+scratch_dev3="$(echo "${SCRATCH_DEV_POOL}" | $AWK_PROG '{ print $3 }')"
 
 echo "Remove device"
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/btrfs/181 b/tests/btrfs/181
index 843413fc..8a3c3c17 100755
--- a/tests/btrfs/181
+++ b/tests/btrfs/181
@@ -32,7 +32,7 @@ nr_files=1024
 get_super_gen()
 {
 	local ret=$($BTRFS_UTIL_PROG inspect dump-super "$SCRATCH_DEV" |\
-		grep ^generation | awk '{print $2}')
+		grep ^generation | $AWK_PROG '{print $2}')
 	if [ -z $ret ]; then
 		_fail "failed to get super block generation"
 	fi
diff --git a/tests/btrfs/184 b/tests/btrfs/184
index 2efcfb64..ee43a8d3 100755
--- a/tests/btrfs/184
+++ b/tests/btrfs/184
@@ -27,7 +27,7 @@ _scratch_pool_mkfs "-d raid0 -m raid0" >> $seqres.full 2>&1 || _fail "mkfs faile
 _scratch_mount
 
 # pick last dev in the list
-dev_del=`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
+dev_del=`echo ${SCRATCH_DEV_POOL} | $AWK_PROG '{print $NF}'`
 $BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs device delete failed"
 for i in {0..2}; do
 	output=$($BTRFS_UTIL_PROG inspect-internal dump-super -s $i $dev_del 2>&1)
diff --git a/tests/btrfs/185 b/tests/btrfs/185
index 7850f1bc..ee97b626 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -28,8 +28,8 @@ _supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
 
-device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 
 echo device_1=$device_1 device_2=$device_2 >> $seqres.full
 
@@ -38,7 +38,7 @@ mkdir $mnt
 _mkfs_dev $device_1
 _mount $device_1 $mnt
 
-[[ $(findmnt $mnt | grep -v TARGET | awk '{print $2}') != $device_1 ]] && \
+[[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
 						_fail "mounted device changed"
 
 for sb_bytenr in 65536 67108864; do
@@ -53,7 +53,7 @@ done
 $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
 [[ $? != 1 ]] && _fail "cloned device scan should fail"
 
-[[ $(findmnt $mnt | grep -v TARGET | awk '{print $2}') != $device_1 ]] && \
+[[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
 						_fail "mounted device changed"
 
 # Original device scan should be successful
diff --git a/tests/btrfs/194 b/tests/btrfs/194
index 2431692b..228576e4 100755
--- a/tests/btrfs/194
+++ b/tests/btrfs/194
@@ -29,8 +29,8 @@ if [ $(get_page_size) != 4096 ]; then
 	_notrun "This test need 4k page size"
 fi
 
-device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 
 echo device_1=$device_1 device_2=$device_2 >> $seqres.full
 
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 22b37b4b..d259fd99 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -54,11 +54,11 @@ workout()
 
 	# don't test with the first device as auto fs check (_check_scratch_fs)
 	# picks the first device
-	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
 		$seqres.full
 
-	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
 	_mount -o degraded $device_2 $SCRATCH_MNT
 	# Check if missing device is reported as in the .out
 	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index 035c63fd..1edc8330 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -39,10 +39,10 @@ workout()
 
 	# don't test with the first device as auto fs check (_check_scratch_fs)
 	# picks the first device
-	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
 
-	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
 	_mount -o degraded $device_2 $SCRATCH_MNT
 	# Check if missing device is reported as in the 196.out
 	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 9ee1a8b3..cbcd60e0 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -72,14 +72,14 @@ echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb
 # buffered reads whould result in 2 * sectors_per_page errors since readahead code always submits
 # at least 1 page worth of IO and it will be counted as error(s) as well
 $XFS_IO_PROG -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
-errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
+errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | $AWK_PROG '/corruption_errs/ { print $2 }')
 if [ $errs -ne $((2 * $sectors_per_page)) ]; then
 	_fail "Errors: $errs expected: 2"
 fi
 
 # DIO does check every sector
 $XFS_IO_PROG -d -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
-errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
+errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | $AWK_PROG '/corruption_errs/ { print $2 }')
 if [ $errs -ne $((6 * $sectors_per_page)) ]; then
 	_fail "Errors: $errs expected: 6"
 fi
diff --git a/tests/btrfs/216 b/tests/btrfs/216
index 5d6cf902..2ed48668 100755
--- a/tests/btrfs/216
+++ b/tests/btrfs/216
@@ -21,8 +21,8 @@ _require_scratch_dev_pool 2
 
 _scratch_dev_pool_get 2
 
-seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 
 _mkfs_dev $seed
 $BTRFS_TUNE_PROG -S 1 $seed
diff --git a/tests/btrfs/218 b/tests/btrfs/218
index 83ec785e..672ad0ff 100755
--- a/tests/btrfs/218
+++ b/tests/btrfs/218
@@ -27,8 +27,8 @@ _require_scratch_dev_pool 2
 
 _scratch_dev_pool_get 2
 
-dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
 
 # Create the seed device
 _mkfs_dev $dev_seed
diff --git a/tests/btrfs/254 b/tests/btrfs/254
index 2f3ae50f..5d6e33f4 100755
--- a/tests/btrfs/254
+++ b/tests/btrfs/254
@@ -81,8 +81,8 @@ test_add_device()
 {
 	setup_dmdev
 	dmdev=$(realpath $lvdev)
-	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
-	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
+	scratch_dev2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+	scratch_dev3=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}')
 
 	_mkfs_dev $scratch_dev3
 	_mount $scratch_dev3 $seq_mnt
-- 
2.34.1

