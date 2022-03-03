Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFC3C433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 13:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiCCN3i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiCCN3i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 08:29:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECAE0AD3
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 05:28:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 555821F382;
        Thu,  3 Mar 2022 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646314131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/aZFFBHhecbRx3Xil/adj/Sw+asKvvE8ePk+GgtZn7o=;
        b=UJjEQc1ykA4qLtz/HSovtbbsEa8lleweVjzd50mlKnmt8VdKavHqEic6mDdKJ+GKvNQxI1
        xhjbU5uMUkauh4HQTU4TNrXP+RTNo7PEIveodGaTdZoWbKeiCUTnbOn4UASgf9uAmLPF3b
        J2YRZMwHWXSqUSsB4fVQktNRem86k6A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3466B13C23;
        Thu,  3 Mar 2022 13:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6JK7CpPCIGKHWwAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 03 Mar 2022 13:28:51 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 2/4] README: Adjust and add btrfs testing information
Date:   Thu,  3 Mar 2022 14:28:02 +0100
Message-Id: <20220303132804.4151-3-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303132804.4151-1-gniebler@suse.com>
References: <20220303132804.4151-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The system preparation info for btrfs specific tests was a little outdated,
as many tests require at least 5 indepedent scratch disks, which should be
of the same size and at least 10GB each. This patch fixes that.

There are also a few places in the README that assume the FS under test is XFS.
This changes these lines to extend to other filesystems,
to clarify this is an option.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 README | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/README b/README
index 7e36905e..65e7ed7b 100644
--- a/README
+++ b/README
@@ -34,7 +34,8 @@ ______________________
 
 Preparing system for tests:
 
-    - compile XFS into your kernel or load XFS modules
+    - If you wish to test XFS, compile XFS into your kernel or load XFS modules,
+      same for btrfs.
     - install administrative tools specific to the filesystem you wish to test
     - If you wish to run the udf components of the suite install
       mkudffs. Also download and build the Philips UDF Verification Software
@@ -42,9 +43,9 @@ Preparing system for tests:
       binary to xfstests/src/. If you wish to disable UDF verification test
       set the environment variable DISABLE_UDF_TEST to 1.
 
-    - create one or two partitions to use for testing
+    - create one or more partitions to use for testing
         - one TEST partition
-            - format as XFS, mount & optionally populate with
+            - format as XFS (or FS of choice), mount & optionally populate with
               NON-IMPORTANT stuff
         - one SCRATCH partition (optional)
             - leave empty and expect this partition to be clobbered
@@ -52,12 +53,13 @@ Preparing system for tests:
               not be run.
               (SCRATCH and TEST must be two DIFFERENT partitions)
               OR
-        - for btrfs only: some btrfs test cases will need 3 or more independent
-              SCRATCH disks which should be set using SCRATCH_DEV_POOL (for eg:
-              SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc") with which
-              SCRATCH_DEV should be unused by the tester, and for the legacy
-              support SCRATCH_DEV will be set to the first disk of the
-              SCRATCH_DEV_POOL by xfstests script.
+        - for btrfs only: some btrfs test cases will need up to 5 independent,
+              equally sized SCRATCH disks of at least 10GB each, which should be
+              set using SCRATCH_DEV_POOL
+              (e.g.: SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc …"),
+              in which case SCRATCH_DEV should be unset by the tester, and for
+              legacy support SCRATCH_DEV will be set to the first disk of the
+              SCRATCH_DEV_POOL by the xfstests scripts.
 
     - setup your environment
 	Quick start:
@@ -69,7 +71,8 @@ Preparing system for tests:
         - setenv TEST_DIR "mount point of TEST PARTITION"
 	- optionally:
              - setenv SCRATCH_DEV "device containing SCRATCH PARTITION" OR
-               (btrfs only) setenv SCRATCH_DEV_POOL "to 3 or more SCRATCH disks for
+               (btrfs only) setenv SCRATCH_DEV_POOL "3 or more (ideally 5)
+               SCRATCH disks (ideally of equal size and at least 10GB each) for
                testing btrfs raid concepts"
              - setenv SCRATCH_MNT "mount point for SCRATCH PARTITION"
              - setenv TAPE_DEV "tape device for testing xfsdump"
@@ -143,7 +146,7 @@ Preparing system for tests:
     - if testing xfsdump, make sure the tape devices have a
       tape which can be overwritten.
 
-    - make sure $TEST_DEV is a mounted XFS partition
+    - make sure $TEST_DEV is a mounted XFS (or FS of choice) partition
     - make sure that $SCRATCH_DEV or $SCRATCH_DEV_POOL contains nothing useful
 
 Running tests:
-- 
2.35.1

