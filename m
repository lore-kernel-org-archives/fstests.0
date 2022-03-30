Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DCCC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbiC3Lrn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343748AbiC3Lri (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 07:47:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14ED25DAA1
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 04:45:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81A181F37B;
        Wed, 30 Mar 2022 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648640752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1zkBJxX729Y3nsGjP+R/dCEcjT/0NwUFyWv+TtbwJt8=;
        b=Q9v0BgXBgPhF/EIPt1TxHrBNBJ+MvfzXTSJaaBJQUX5DoCuwAp9alwYZaEfEoZUPQQZFgz
        Q8fsfiOeba6D4quyMaeESsoSicfA97IRwMaijsHzYwbw9QO+rMrr7FwFMoQn0YKeisIFDP
        STKSk9kgWrN10MUIrF8WTIDH7uNbMms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648640752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1zkBJxX729Y3nsGjP+R/dCEcjT/0NwUFyWv+TtbwJt8=;
        b=za7TTyGTdNPGrKKPovXg232Ss8eas2MIJyrzDWKmfUmMn2Vqh7ze+VBkWYSrRfOMLcjls6
        o/qJKjBZEqCzqlBw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62315A3B88;
        Wed, 30 Mar 2022 11:45:52 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     Anand Jain <Anand.Jain@oracle.com>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH] btrfs: drop no-op count=$(( count-- ))
Date:   Wed, 30 Mar 2022 13:45:40 +0200
Message-Id: <20220330114540.1539-1-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This line doesn't result in a changed count value. The tests don't
appear to rely on a decremented value, so remove the line.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/btrfs/124 | 1 -
 tests/btrfs/125 | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tests/btrfs/124 b/tests/btrfs/124
index e8d77aaa..3d8141a1 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -74,7 +74,6 @@ _scratch_mount >> $seqres.full 2>&1
 _run_btrfs_util_prog filesystem show
 dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
 					>>$seqres.full 2>&1
-count=$(( count-- ))
 echo "unmount" >> $seqres.full
 echo "clean btrfs ko" >> $seqres.full
 _scratch_unmount
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 44ba49ec..b58f2aa2 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -80,7 +80,6 @@ dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
 					>>$seqres.full 2>&1
 _run_btrfs_util_prog filesystem show
 _run_btrfs_util_prog filesystem df $SCRATCH_MNT
-count=$(( count-- ))
 
 #-------------degraded-init-------------------
 echo >> $seqres.full
-- 
2.34.1

