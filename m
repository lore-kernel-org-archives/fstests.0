Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19DC432BE
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Aug 2021 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB32560FDA
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Aug 2021 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhHKPpm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Aug 2021 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhHKPpk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Aug 2021 11:45:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B2C061765;
        Wed, 11 Aug 2021 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F1cdFO/HMSW74Xo13hr750mIwMV4fTBWscYd6QDc6Wk=; b=N0lS0JdkdfmAUKeyb2H2fKXl3M
        vS4T/a9t9ZHecmyulCwJJjBxxIzpzNV7wCRxZfk9ksL/IZC8hAfSCCaQn+I0U7WJeRfWdyqndpnj8
        WmqnWYPeNVVIWWXwdrhRTRN+Tc9ovgd90YYDbdydQaZvreaMENd/0BxPOAHCqD9usyOdcyJyJeBPu
        QyfB+EjAgRs/erSuU1612WWBveITilSzCxcW2aqxoYQt5l9LGVzg5fhMv1Lkb1w9zPaOubWq0CRQA
        /gNYXHV4hOtvtQ7lffOuI3hi6zuwPvBSisS/4x+5E1IVlZQBYAqnNGDfTuaE+no9so6cKZyzpm7Go
        7ytQNCZg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDqPr-007bpG-3W; Wed, 11 Aug 2021 15:45:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 1/3] fstests: use udevadm settle after pvremove
Date:   Wed, 11 Aug 2021 08:45:10 -0700
Message-Id: <20210811154512.1813622-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811154512.1813622-1-mcgrof@kernel.org>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As with creation, we also need to use udevadm settle
when removing a pv, otherwise we can trip on races with
module removals for the block devices in use.

This reduces the amount of time in which a block device
module refcnt for test modules such as scsi_debug spends
outside of 0.

Races with the refcnt being greater than 0 means module
removal can fail causing false positives. This helps
ensure that the pv is really long gone. These issues
are tracked for scsi_debug [0] and later found to be a
generic issue regardless of filesystem with pvremove [1].

Using udevadm settle *helps*, it does not address all
possible races with the refcnt as noted in the generic
bug entry [1].

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/generic/081 | 5 ++++-
 tests/generic/108 | 1 +
 tests/generic/459 | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/081 b/tests/generic/081
index f795b2c1..8e552074 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -12,6 +12,7 @@ _begin_fstest auto quick
 # Override the default cleanup function.
 _cleanup()
 {
+	local pv_ret
 	cd /
 	rm -f $tmp.*
 
@@ -34,7 +35,9 @@ _cleanup()
 		$UMOUNT_PROG $mnt >> $seqres.full 2>&1
 		$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 		$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
-		test $? -eq 0 && break
+		pv_ret=$?
+		$UDEV_SETTLE_PROG
+		test $pv_ret -eq 0 && break
 		sleep 2
 	done
 }
diff --git a/tests/generic/108 b/tests/generic/108
index 7dd426c1..b7797e8f 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -21,6 +21,7 @@ _cleanup()
 	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
 	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -f $SCRATCH_DEV $SCSI_DEBUG_DEV >>$seqres.full 2>&1
+	$UDEV_SETTLE_PROG
 	_put_scsi_debug_dev
 	rm -f $tmp.*
 }
diff --git a/tests/generic/459 b/tests/generic/459
index e5e5e9ab..5b44e245 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -29,6 +29,7 @@ _cleanup()
 	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
 	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
+	$UDEV_SETTLE_PROG
 }
 
 # Import common functions.
-- 
2.30.2

