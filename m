Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D6C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E3A2070A
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFQVs6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:48:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:30605 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgFQVs6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jun 2020 17:48:58 -0400
IronPort-SDR: CGyEB+CtS0gsELZ0+SYHFon5HS1LjD+gkyUJYwslVTKk4IOCmXAv7OC8YCwpradwt3A1vHfJut
 upAUO3dv0BQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 14:48:57 -0700
IronPort-SDR: gE5s0M+pDBzzm7Wf0IlBiY4/Aw9y58ifuLTp1gk6rB4BdcZHSEZfkzBIs2kxIqvbR8yslywrnY
 uuBkBpPeyvBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="273653196"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2020 14:48:57 -0700
Date:   Wed, 17 Jun 2020 14:48:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 6/6] xfs/260: Move xfs/260 to generic
Message-ID: <20200617214857.GN4160762@iweiny-DESK2.sc.intel.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-7-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093204.20838-7-ice_yangxiao@163.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 17, 2020 at 05:32:04PM +0800, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
> 
> Both ext4 and xfs support per-inode DAX flag now so move it to generic.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Unfortunately this test needs to be modified to work with the final agreed upon
method for switching DAX, patch below.  Feel free to squash it into this patch
for v3.

There are more checks I had queued up but I'm happy to wait for this series to
be applied.

Again, thanks for moving this along!
Ira

From 97b67a2773627cfe91b5f33a418ab646bb5fd0a8 Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 17 Jun 2020 14:34:45 -0700
Subject: [PATCH] generic/602: Modify to work with agreed inheritance of DAX flag

Modifying the DAX flag on flies does not take effect immediately.  The
easiest way to ensure the file state for this test is to use inheritance
of the parent directory DAX state.

Modify the test to use 2 directories which we can switch the DAX state on
and create the test files in those directories after setting the desired
state.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/generic/602 | 81 +++++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/tests/generic/602 b/tests/generic/602
index 9137c5b9385f..20bf2c6bd246 100755
--- a/tests/generic/602
+++ b/tests/generic/602
@@ -36,68 +36,95 @@ _require_test_program "t_mmap_dio"
 _require_scratch_dax_iflag
 _require_xfs_io_command "falloc"
 
-prep_files()
+SRC_DIR=$SCRATCH_MNT/src
+SRC_FILE=$SRC_DIR/tf_s
+
+DST_DIR=$SCRATCH_MNT/dst
+DST_FILE=$DST_DIR/tf_d
+
+clean_files()
 {
-	rm -f $SCRATCH_MNT/tf_{s,d}
+	rm -f $SRC_FILE
+	rm -f $DST_FILE
 
+	mkdir -p $SRC_DIR
+	mkdir -p $DST_DIR
+}
+
+prep_files()
+{
+	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
+		$SRC_FILE >> $seqres.full 2>&1
 	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
-		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
+		$DST_FILE >> $seqres.full 2>&1
 }
 
 t_both_dax()
 {
+	clean_files
+	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr +x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
 	# with O_DIRECT first
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE $1 "dio both dax"
 
+	clean_files
+	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr +x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
 	# again with buffered IO
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered both dax"
 }
 
 t_nondax_to_dax()
 {
+	clean_files
+	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr +x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
 		$1 "dio nondax to dax"
 
+	clean_files
+	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr +x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered nondax to dax"
 }
 
 t_dax_to_nondax()
 {
+	clean_files
+	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr -x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
 		$1 "dio dax to nondax"
 
+	clean_files
+	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr -x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered dax to nondax"
 }
 
 t_both_nondax()
 {
+	clean_files
+	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr -x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
 		$1 "dio both nondax"
 
+	clean_files
+	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr -x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered both nondax"
 }
 
@@ -124,17 +151,11 @@ do_tests()
 # make xfs aligned for PMD fault testing
 _scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
 
-# mount with dax option
-_scratch_mount "-o dax"
-
 tsize=$((128 * 1024 * 1024))
 
-do_tests
-_scratch_unmount
-
 # mount again without dax option
 export MOUNT_OPTIONS=""
-_scratch_mount
+_scratch_mount "-o dax=inode"
 do_tests
 
 # success, all done
-- 
2.25.1

