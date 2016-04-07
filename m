Received: from mail.kernel.org ([198.145.29.136]:33927 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbcDGSJZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 7 Apr 2016 14:09:25 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id EC24820212
	for <fstests@vger.kernel.org>; Thu,  7 Apr 2016 18:09:23 +0000 (UTC)
Received: from debian3.lan (dsl-112-39.bl26.telepac.pt [176.78.112.39])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CED4620166
	for <fstests@vger.kernel.org>; Thu,  7 Apr 2016 18:09:22 +0000 (UTC)
From: fdmanana@kernel.org
Subject: [PATCH] Pass --retry to dmsetup when removing flakey and error devices
Date: Thu,  7 Apr 2016 07:12:28 +0100
Message-Id: <1460009548-20668-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

When running multiple tests using dm's flakey target, often (very rarely)
I was getting an error when a test tried to setup a dm flakey target,
resulting in the following messages in the test's .out.bad file:

  device-mapper: reload ioctl on flakey-test failed: Device or resource busy
  Command failed
  failed to create flakey device

Upon further investigation it turns out that it was because the previous
test that ran had failed to remove the flakey device because the device
was being used at the time but this has not made that previous test fail
because we simply redirect the stderr (and stdout) to /dev/null and don't
fail if the dmsetup remove command exits with a non-zero status.
The device was in use, when the test attempted to remove it, by an udev
rule (btrfs udev rule).

Fix this by passing the option --retry to dmsetup remove, which serves to
deal with such cases. From dmsetup's man page:

  "If an attempt to remove a device fails, perhaps because a process run
   from a quick udev rule temporarily opened the device, the --retry
   option will cause the operation to be retried for a few seconds before
   failing."

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/dmerror  | 4 ++--
 common/dmflakey | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/dmerror b/common/dmerror
index 5d2c1b6..c898df0 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -22,7 +22,7 @@ _dmerror_init()
 {
 	local dm_backing_dev=$SCRATCH_DEV
 
-	$DMSETUP_PROG remove error-test > /dev/null 2>&1
+	$DMSETUP_PROG remove --retry error-test > /dev/null 2>&1
 
 	local blk_dev_size=`blockdev --getsz $dm_backing_dev`
 
@@ -57,7 +57,7 @@ _dmerror_cleanup()
 	# wait for device to be fully settled so that 'dmsetup remove' doesn't
 	# fail due to EBUSY
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
-	$DMSETUP_PROG remove error-test > /dev/null 2>&1
+	$DMSETUP_PROG remove --retry error-test > /dev/null 2>&1
 }
 
 _dmerror_load_error_table()
diff --git a/common/dmflakey b/common/dmflakey
index 4434307..cc458f0 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -57,7 +57,7 @@ _cleanup_flakey()
 	# wait for device to be fully settled so that 'dmsetup remove' doesn't
 	# fail due to EBUSY
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
-	$DMSETUP_PROG remove flakey-test > /dev/null 2>&1
+	$DMSETUP_PROG remove --retry flakey-test > /dev/null 2>&1
 	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
-- 
2.7.0.rc3

