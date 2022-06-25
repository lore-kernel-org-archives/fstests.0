Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14431C43334
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiFYDIP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiFYDHh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:07:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF968026
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:07:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25P37WX3010328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 23:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656126454; bh=J2LbxdWE9wmpZrLseWDZ8HH0zWC9tOq+H+KPBPPwMIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XaZ/0thPcvy6a/xdd57ZiwGuxkBd5jm8+OS/ffLrEYbo9iZ2CEsTVmX/zDEdrhedg
         zySyG6iAYMS9IVcD6EtTnnxZ8AsStr1DcIVEjGNuihYIu+O5qwVrrwnpTofhZcMH+K
         ToFNOMX37FRq2ucl1WschK2JdxOjNwvAMOcVDkTK9mc5DZC7Y4PoOg8KO9eHysbBi7
         6rldvFJo63Puik6n/vhm4a50i/b9UatRdlbVRK/HhJ335bRfMXRtUWscANK5Aaui7d
         QvQM6F5s3Cq4I/v5URFej+EAVIPXDzJWA1m44Ma25+WglQdkod6Xygvcwoo/ZI8VYh
         gorle7SeMZLbg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C765B15C4311; Fri, 24 Jun 2022 23:07:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/5] ext4/044: skip test if the file system does not have a journal
Date:   Fri, 24 Jun 2022 23:07:15 -0400
Message-Id: <20220625030718.1215980-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220625030718.1215980-1-tytso@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test mounts the file system using "mount -t ext3"; if the file
system config creates the file system without the jbd2 journal, the
"mount -t ext3" will fail.  So skip this test in that case.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/044 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/ext4/044 b/tests/ext4/044
index 46e44053..fd27ae2d 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -16,11 +16,17 @@ _begin_fstest auto quick
 _supported_fs ext4
 _require_scratch
 _require_test_program "t_get_file_time"
+_require_dumpe2fs
 
 echo "Silence is golden"
 
 echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
 _scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
+
+$DUMPE2FS_PROG -h $SCRATCH_DEV 2>> $seqres.full | grep '^Filesystem features' | grep -q has_journal
+if [ $? -ne 0 ]; then
+    _notrun "ext4 file system formatted without a journal"
+fi
 _scratch_mount
 
 # Create file
-- 
2.31.0

