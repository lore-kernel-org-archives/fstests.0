Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0CC4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiKNIf3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiKNIfZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 03:35:25 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731EC1B9E8
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668414922; i=@fujitsu.com;
        bh=aNbAN94YSff/AjxLADnDngbXdvwOkhSogdFqwg3cc/k=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=HrpCZKctV7NhpA/GACXmSOruWWShyRASSpm93NN8Ja8m+1ByjLw8NV5SlFtvKQoZO
         P/3Go3G6XIXzZ27Pqr5neOIT9/3SEizTllz+13+hFQz1fC7fATKv9jTzG0xolxIZoN
         o/2H2XjT1wI/3T6rDHGZsJGCGf/r8KasGb26utDl8x5DddAZHooG+yxU1uQttdtTay
         DOYNoERCDZrLR4r5UIj7hsDBNxhxbhMpmHfDZfzsFVcWmEWP9c7glQqywtY+gKFW8C
         llJS2kPsEcQHk+y9Y0sp+vZpyc3zzPTPOSeq6iRs6IaSigch2R7zqf5bzCdeaDxL6F
         V6QdDm2Vy/KCA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsViZ8OxWffU38J
  kg/utUhbvPldZXH7CZ3G6ZS+7xd6TO1kdWDw2repk83i/7yqbx+dNcgHMUayZeUn5FQmsGec6
  mxkL+qQq/h5bw9rAuFKsi5GLQ0hgI6PEzlVvWCCcxUwSf+a8hXL2M0r8nr6JsYuRk4NNQE1i5
  /SXLCC2iIC2xNqtT1hBbGaBHIm3hxeyg9jCAt4SXxpngtWwCKhKHOo+xwRi8wo4Shz8/QisXk
  JAQWLKw/fMIDangJPE5W29YL1CQDVTT75khagXlDg58wkLxHwJiYMvXjBD9CpKtC35xw5hV0j
  MmtXGBGGrSVw9t4l5AqPgLCTts5C0L2BkWsVoVpxaVJZapGtoppdUlJmeUZKbmJmjl1ilm6iX
  Wqpbnlpcomukl1herJdaXKxXXJmbnJOil5dasokRGOopxYpbdzDeWPZH7xCjJAeTkijv5T+Fy
  UJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeL1AcoJFqempFWmZOcC4g0lLcPAoifAq/wRK8xYXJO
  YWZ6ZDpE4xWnKsbTiwl5nj45+LQHLq7H/7mYVY8vLzUqXEeZmB0S0kANKQUZoHNw6WGi4xyko
  J8zIyMDAI8RSkFuVmlqDKv2IU52BUEuat/w00hSczrwRu6yugg5iADvoemQdyUEkiQkqqgan+
  xlWjK1nNMnP9Zed++MiR57iMv+Ne8ocnHQKrIp3nfHp999eqvlcKmnudrrb2X93T/kXd6NHKY
  68r+btLDvX82fn31h6jnROnlVtH7DGtKBbZVLUnoyjY7valglcr+ibslt+1zN34jWmlnVLzY4
  c9c6tXf0lS/WHBKd/qbm42wz/uA+MRBuXtfA2lal3rmZP6Pq3wrsxL3Ll4boi7JdO1T5OiDr9
  kDtVxCf8UEBqSJyPz9Tn72vObM05bl9/f84Avjf3gu+49itVfIr8dsJTudQ6SOyaeUPR2i1TX
  uWsmoc8+zt6p+DcmzMF7tcPe3UsX8TqbP/6zdbbV/03p6csKlT6pymfs75nbvmuGbrQSS3FGo
  qEWc1FxIgBQQpK/iAMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-10.tower-571.messagelabs.com!1668414922!103757!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23317 invoked from network); 14 Nov 2022 08:35:22 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-10.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Nov 2022 08:35:22 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 23C22142;
        Mon, 14 Nov 2022 08:35:22 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 179467B;
        Mon, 14 Nov 2022 08:35:22 +0000 (GMT)
Received: from 66819b64675f.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 14 Nov 2022 08:35:19 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <djwong@kernel.org>, <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>, <bfoster@redhat.com>,
        <y-goto@fujitsu.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 2/2] generic/470: Replace thin volume with blkdiscard -z
Date:   Mon, 14 Nov 2022 08:35:03 +0000
Message-ID: <1668414903-13-2-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
References: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

generic/470 was original designed to verify mmap(MAP_SYNC) which
is only valid to the DAX capable device(e.g. PMEM). Thin volume[1] was
introduced to fix the inconsistent filesystem issue[2] but it make
the test become not run because it doesn't support DAX. As Darrick
mentioned[3], zeroing the entire mapped range of scartch device
can fix the issue as well, so I try to use blkdiscard -z instead.

[1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=fc5870da485aec0f9196a0f2bed32f73f6b2c664
[2]: https://lore.kernel.org/fstests/20190227061529.GF16436@dastard/
[3]: https://lore.kernel.org/linux-xfs/Y1NRNtToQTjs0Dbd@magnolia/T/#me0e77cb0ecd80bf4b5109e4433cb4863ae6e6727

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/generic/470 | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tests/generic/470 b/tests/generic/470
index f3407511..6da2ec22 100755
--- a/tests/generic/470
+++ b/tests/generic/470
@@ -15,38 +15,29 @@ _cleanup()
 {
 	cd /
 	_log_writes_cleanup
-	_dmthin_cleanup
 	rm -f $tmp.*
 }
 
 # Import common functions.
 . ./common/filter
-. ./common/dmthin
 . ./common/dmlogwrites
 
 # real QA test starts here
 _supported_fs generic
-_require_scratch_nocheck
+_require_scratch
 _require_no_logdev
 _require_log_writes_dax_mountopt "dax"
-_require_dm_target thin-pool
 _require_xfs_io_command "mmap" "-S"
 _require_xfs_io_command "log_writes"
+_require_command "$BLKDISCARD_PROG" blkdiscard
 
-devsize=$((1024*1024*200 / 512))        # 200m phys/virt size
-csize=$((1024*64 / 512))                # 64k cluster size
-lowspace=$((1024*1024 / 512))           # 1m low space threshold
-
-# Use a thin device to provide deterministic discard behavior. Discards are used
-# by the log replay tool for fast zeroing to prevent out-of-order replay issues.
-_dmthin_init $devsize $devsize $csize $lowspace
+MAPPED_LEN=$((512 * 1024 * 1024)) # 512 MiB
+LEN=$((1024 * 1024)) # 1 MiB
 
-_log_writes_init $DMTHIN_VOL_DEV
+_log_writes_init $SCRATCH_DEV $MAPPED_LEN
 _log_writes_mkfs >> $seqres.full 2>&1
 _log_writes_mount -o dax
 
-LEN=$((1024 * 1024)) # 1 MiB
-
 $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
 	-c "log_writes -d $LOGWRITES_NAME -m preunmap" \
 	-f $SCRATCH_MNT/test
@@ -54,14 +45,19 @@ $XFS_IO_PROG -t -c "truncate $LEN" -c "mmap -S 0 $LEN" -c "mwrite 0 $LEN" \
 # Unmount the scratch dir and tear down the log writes target
 _log_writes_unmount
 _log_writes_remove
-_dmthin_check_fs
+_check_scratch_fs
 
-# destroy previous filesystem so we can be sure our rebuild works
-_mkfs_dev $DMTHIN_VOL_DEV >> $seqres.full 2>&1
+# Forcibly zero the mapped range of scratch device and destroy
+# previous filesystem so we can be sure our rebuild works.
+# Note that blkdiscard -z will fall back to writing buffers of zeroes
+# if scratch device doesn't support write zeroes operation(i.e.
+# REQ_OP_WRITE_ZEROES).
+$BLKDISCARD_PROG -fzl $MAPPED_LEN $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_mkfs >> $seqres.full 2>&1
 
 # check pre-unmap state
-_log_writes_replay_log preunmap $DMTHIN_VOL_DEV
-_dmthin_mount
+_log_writes_replay_log preunmap $SCRATCH_DEV
+_scratch_mount
 
 # We should see $SCRATCH_MNT/test as having 1 MiB in block allocations
 du -sh $SCRATCH_MNT/test | _filter_scratch | _filter_spaces
-- 
2.34.1

