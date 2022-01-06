Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC1FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbiAFRya (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:54:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41924 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbiAFRya (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 12:54:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 386ADB822BC
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 17:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6FDC36AE3;
        Thu,  6 Jan 2022 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641491667;
        bh=3mVEEv50mjD6xYFAE+NEOMovdiIDbuZEWv8IhEhVXgc=;
        h=From:To:Cc:Subject:Date:From;
        b=od4OFfDgp5LhkMietSrCEdAiVxOQ1+KHQntE6iqzciSG7aRNKekx0F/xO64PAmm8A
         htyvhNAdNWsv5FijhJo52x8p0R5W2vatplVNsG1+gX7gIrMvf/WUh8/hvXLZNmWxr4
         QY7k9zj2ZMIjfXyAJ5Q75cY7rj0sVXYQ1FfSWOpzieepfqjP7MubIkw2vZz2ac6I7b
         0IfzNTsEhbYmDad6xbrUuSwnR6zGUcZK1eG1i9zelijncPng8RDHrupredE+6f6kna
         KwDUtX/ySMLVaLn6UodeADEi4EB1V/2NR27Ou4t+z4dGdDaxgSh3UmUN9tbV/t85P4
         kf9n1iAVQXvPA==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] common: handle ceph's new mount syntax
Date:   Thu,  6 Jan 2022 12:54:26 -0500
Message-Id: <20220106175426.86522-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Cephfs is introducing a new mount device syntax. Fix the fstests
infrastructure to handle the new syntax correctly.

Cc: Zorro Lang <zlang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/config |  8 ++++++++
 common/rc     | 22 ++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

v2: more rigorous check for ceph mount device in _check_device
v3: consolidate multiple grep commands into single regex

diff --git a/common/config b/common/config
index e0a5c5df58ff..2b357746476b 100644
--- a/common/config
+++ b/common/config
@@ -537,6 +537,14 @@ _check_device()
 		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
+	ceph)
+		# ceph has two different possible syntaxes for mount devices. The
+		# network URL check above catches the legacy syntax. Check for the
+		# new-style syntax here.
+		if ( echo $dev | grep -qEv "=/" ); then
+			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
+		fi
+		;;
 	overlay)
 		if [ ! -d "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
diff --git a/common/rc b/common/rc
index f8afd93d656c..c087875a4251 100644
--- a/common/rc
+++ b/common/rc
@@ -1592,7 +1592,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	nfs*|ceph)
+	nfs*)
 		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
@@ -1601,6 +1601,15 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	ceph)
+		echo $SCRATCH_DEV | grep -qE "=/|:/" > /dev/null 2>&1
+		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	pvfs2)
 		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1783,7 +1792,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	nfs*|ceph)
+	nfs*)
 		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
@@ -1792,6 +1801,15 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	ceph)
+		echo $TEST_DEV | grep -qE "=/|:/" > /dev/null 2>&1
+		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	cifs)
 		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
-- 
2.33.1

