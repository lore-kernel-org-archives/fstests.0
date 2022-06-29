Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B3C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiF2Mps (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiF2Mpr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:45:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09234BBA
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:45:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCjgqX023646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656506743; bh=XG+hnu9mROxsJTC2kB1xkHm453/LWB9CmxU0RSe+fxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=O4krPtwBTZ5D+/bqg+Ym0461xXQK2tesu/5OVFXifvPqNOi9eOd1Jb2vLpl2+KHDP
         PbSLLKhJi/rY0X49Hw/jbHQz/2cTB546qLREf2nZ/aveUW4uKvp6eHHa/bkTgje+u/
         KVp4mmHicl05il/rjc0ATHJMQcT+ux9Ihw74ly3Fn+t7IEf1K+4vfNCt9Hj7xU/T+x
         2/2sZVXxsTSjhG0OHTbHiuQSM4CJE/nBWBWEAMFTHNu7X/wypEMNscm1B3u6fNs7fz
         qte+aKv2xodk5LJw07225oNxlXKvwPWZAHstOgmhZC5dhqlwYX4G4aoJl7ymyFd9Tm
         2ElO+PQfBw9Lw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3918115C4331; Wed, 29 Jun 2022 08:45:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v3 6/7] ext4/035: skip this test if the scratch device does not support 1k block sizes
Date:   Wed, 29 Jun 2022 08:45:39 -0400
Message-Id: <20220629124540.175775-7-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629124540.175775-1-tytso@mit.edu>
References: <20220629124540.175775-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/035 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/ext4/035 b/tests/ext4/035
index cad3595b..1f26e766 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -26,6 +26,9 @@ _exclude_scratch_mount_option dax
 _require_command "$RESIZE2FS_PROG" resize2fs
 
 $MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+    _notrun "Can't make file system with a block size of 1024"
+fi
 _scratch_mount
 
 echo "Resizing to 262145 blocks"
-- 
2.31.0

