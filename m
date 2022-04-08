Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440CC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Apr 2022 19:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiDHTV7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiDHTV7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Apr 2022 15:21:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088FB25584
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 12:19:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 84D7A1F862
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649445593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YRYMu1dxkcN1gP85d9bwXE48edVzcPSeUEWopAv76Ck=;
        b=P2ON8FHe0GMT25b6OAQJ5mJs4r5VQ8ZCTnDjp/oY3aYAlvtsh37hqGkFA/q1K7gTQ4fSSp
        +KWoWIGnotlmK8/kUprWIF+3rDFlLv4c8B+pdCqtNzjzwTPc9ZTxDD0Bjo6eySLIYbG31e
        VQMJ+TfbiXpxwWjyniQlkU8Vk3ftqcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649445593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YRYMu1dxkcN1gP85d9bwXE48edVzcPSeUEWopAv76Ck=;
        b=NCSCSHRRdAFe2dv4H+rK7unEie8d371ob3ypBMPpCDdUsweznDrhimYP7pE0mz265Y/XaB
        sQt4CbokjVwdu6BA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DD8AA3B83;
        Fri,  8 Apr 2022 19:19:53 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common/attr: reduce MAX_ATTRVAL_SIZE for NFS
Date:   Fri,  8 Apr 2022 21:19:43 +0200
Message-Id: <20220408191943.27655-1-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When testing against an NFS export backed by a Btrfs filesystem,
generic/020 may fail, e.g.

  --- /xfstests/tests/generic/020.out
  +++ /xfstests/results/generic/020.out.bad
  @@ -47,9 +47,13 @@
   user.snrub="fish2\012"

   *** really long value
  -0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  -*
  -ATTRSIZE
  +attr_set: No space left on device
  +Could not set "long_attr" for <TESTFILE>
  +attr_get: No data available
  +Could not get "long_attr" for <TESTFILE>
  +0000000
  +attr_remove: No data available
  +Could not remove "long_attr" for <TESTFILE>

This is due to the MAX_ATTRVAL_SIZE=65536 setting for NFS, which exceeds
the Btrfs (and XFS) limit of MAX_ATTRVAL_SIZE=64. Change NFS to use this
lower bound value.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/attr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/attr b/common/attr
index dae8a1bb..1778e8b2 100644
--- a/common/attr
+++ b/common/attr
@@ -319,13 +319,13 @@ export MAX_ATTRS
 
 # Set max attr value size based on fs type
 case "$FSTYP" in
-xfs|udf|btrfs)
+xfs|udf|btrfs|nfs)
 	MAX_ATTRVAL_SIZE=64
 	;;
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-9p|ceph|nfs)
+9p|ceph)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 bcachefs)
-- 
2.34.1

