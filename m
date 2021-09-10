Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F074C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Sep 2021 12:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B400611C0
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Sep 2021 12:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhIJMPI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:15:08 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:56806 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232941AbhIJMPI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Sep 2021 08:15:08 -0400
X-Greylist: delayed 1168 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 08:15:07 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 18ABm7At123085
        for <fstests@vger.kernel.org>; Fri, 10 Sep 2021 14:54:26 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 3aywxwrp9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 10 Sep 2021 14:54:26 +0300
Received: from ari-thinkpad.ws.tuxera.com (62.78.240.173) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 10 Sep 2021 14:54:25 +0300
From:   Ari Sundholm <ari@tuxera.com>
To:     <fstests@vger.kernel.org>
CC:     Ari Sundholm <ari@tuxera.com>
Subject: [PATCH] generic/361: Require sparse file support and fix mounting the volume.
Date:   Fri, 10 Sep 2021 14:53:55 +0300
Message-ID: <20210910115355.2453046-1-ari@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [62.78.240.173]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-ORIG-GUID: SopqzrrMnYM6GN4okF2Hoj0zESNJJoPc
X-Proofpoint-GUID: SopqzrrMnYM6GN4okF2Hoj0zESNJJoPc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_04:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100071
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test case generic/361 fails on multiple filesystem implementations
due to two issues:
	1. A file is created on a 512 MB volume by truncating it to
	   1 GB. For this to work, the filesystem implementation must
	   support sparse files. However, the test case does not check
	   for sparse file support.
	2. A loop device, backed by the 1 GB file, is created, mkfs is
	   run on it and it is mounted. However, the mount command does
	   not specify the filesystem type. This doesn't always work
	   properly, as the kernel may pick the wrong driver if there
	   are multiple implementations for a particular filesystem,
	   or not find a driver at all in some cases.

To fix the behavior of the test case, this commit adds a requirement
for sparse file support to the test case, and explicitly specifies the
filesystem type as $FSTYP when mounting the loop device.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/361 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/361 b/tests/generic/361
index 173a1a51..d76d2635 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -30,6 +30,7 @@ _supported_fs generic
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_loop
+_require_sparse_files
 
 # create a small filesystem to hold another filesystem image
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
@@ -44,7 +45,7 @@ mkdir -p $fs_mnt
 # mount loop device and create a larger file to hit I/O errors on loop device
 loop_dev=$(_create_loop_device $fs_img)
 _mkfs_dev $loop_dev
-_mount $loop_dev $fs_mnt
+_mount -t $FSTYP $loop_dev $fs_mnt
 if [ "$FSTYP" = "xfs" ]; then
 	# Turn off all XFS metadata IO error retries
 	dname=$(_short_dev $loop_dev)
-- 
2.25.1

