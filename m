Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BDDCCA481
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiF3Oqs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiF3Oqp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0481C926
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkdIC005658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600400; bh=2yLLJtETHLber272kFlagdGoN7x6KydHhAf7PrS3Wrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iyN46H9Z8szwfZoyRGqlkTVvVlFYiVteWwisc1OLZuAeZAqWyRfPI8KC5cmi/LHaA
         /DcSZq0833F3bCTuFlItZF+1MH8KtB6Tl4oBLdmqJO8nEk5I3xSPEOBl6MD1LEqPpz
         wTSQQpoIzhfOMKz5sJVyP08KcwGDZ6XAj2lLfyob0dl4qw+3jgt9E5ehVik37/+DuB
         zk47XcGhsyULgCJ4ZW7w6ROLMQYWvUztGrOUA/ZIqfxn1pR9T5YvuUU6KcYrUgkkwr
         vxJupS9X3EdxZq7beLgOloXnU3IgVp5/cKfwr6VDgXtIXwcoEhkKFjRlNwYZNJBL0W
         pOz15yPTwrvZg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4ABDA15C432F; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH -v4 4/7] ext4/054: skip test if the dax mount option is enabled
Date:   Thu, 30 Jun 2022 10:46:34 -0400
Message-Id: <20220630144637.478568-5-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630144637.478568-1-tytso@mit.edu>
References: <20220630144637.478568-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The ext4/054 test explicitly creates a file system with a 1k
blocksize.  This can't possibly work on if the dax mount option is
enabled, so change ext4/054 to use _scratch_mkfs_blocksized, and and a
check to _scratch_mkfs_blocksized to _notrun the test if the block
size is less than the page size.

Also remove an unnecessary _require_test declaration since this test
does not use the test device.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 common/rc      | 3 +++
 tests/ext4/054 | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 3c072c16..b608d2f6 100644
--- a/common/rc
+++ b/common/rc
@@ -1199,6 +1199,9 @@ _scratch_mkfs_blocksized()
 	if ! [[ $blocksize =~ $re ]] ; then
 		_notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
 	fi
+	if [ $blocksize -lt $(get_page_size) ]; then
+		_exclude_scratch_mount_option dax
+	fi
 
 	case $FSTYP in
 	btrfs)
diff --git a/tests/ext4/054 b/tests/ext4/054
index 9a11719f..e23acbb1 100755
--- a/tests/ext4/054
+++ b/tests/ext4/054
@@ -19,7 +19,6 @@ _begin_fstest auto quick dangerous_fuzzers
 
 # real QA test starts here
 _supported_fs ext4
-_require_test
 _require_scratch_nocheck
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "pwrite"
@@ -28,8 +27,8 @@ _require_xfs_io_command "fpunch"
 _require_command "$DEBUGFS_PROG" debugfs
 
 # In order to accurately construct the damaged extent in the following
-# test steps, the blocksize is set to 1024 here
-_scratch_mkfs "-b 1024" > $seqres.full 2>&1
+# test steps, the block size is set to 1024 here
+_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
 _scratch_mount
 
 TEST_FILE="${SCRATCH_MNT}/testfile"
-- 
2.31.0

