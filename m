Received: from mx2.suse.de ([195.135.220.15]:33548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753079AbeFZRJ6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Jun 2018 13:09:58 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82903AD8B
        for <fstests@vger.kernel.org>; Tue, 26 Jun 2018 17:09:57 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH] common: run mknodes after creating/removing dm targets
Date: Tue, 26 Jun 2018 19:07:04 +0200
Message-Id: <20180626170704.26420-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

The command 'dmsetup mknodes' updates the device nodes so they match the
configured targets. This is also done by the device managers but in case
such service does not run, the devices may not exist. This was observed
in a minimal testing VM, some of the tests reported that dm-thin targets
do not exist.

Adding the mknodes command after the respective dmsetup commands fixes
that. This is already present in eg. dmflakey target setup, this patch
adds it to the remainig target setup helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/dmerror    | 2 ++
 common/dmhugedisk | 2 ++
 common/dmthin     | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/dmerror b/common/dmerror
index 4d6b8851b120..ad825479a804 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -28,6 +28,7 @@ _dmerror_init()
 	$DMSETUP_PROG remove error-test > /dev/null 2>&1
 	$DMSETUP_PROG create error-test --table "$DMLINEAR_TABLE" || \
 		_fatal "failed to create dm linear device"
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 _dmerror_mount()
@@ -49,6 +50,7 @@ _dmerror_cleanup()
 	# fail due to EBUSY
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG remove error-test > /dev/null 2>&1
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 _dmerror_load_error_table()
diff --git a/common/dmhugedisk b/common/dmhugedisk
index 4d0406d617c8..e94423e2c5a2 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -35,6 +35,7 @@ _dmhugedisk_init()
 		_fatal "failed to create dm huge zero device"
 	$DMSETUP_PROG create huge-test --table "$DMHUGEDISK_DEV_TABLE" || \
 		_fatal "failed to create dm huge device"
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 _dmhugedisk_cleanup()
@@ -45,4 +46,5 @@ _dmhugedisk_cleanup()
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG remove huge-test > /dev/null 2>&1
 	$DMSETUP_PROG remove huge-test-zero > /dev/null 2>&1
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
diff --git a/common/dmthin b/common/dmthin
index 039d63e2397a..07e191c7d070 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -36,6 +36,7 @@ _dmthin_cleanup()
 	$DMSETUP_PROG remove $DMTHIN_POOL_NAME> /dev/null 2>&1
 	$DMSETUP_PROG remove $DMTHIN_META_NAME> /dev/null 2>&1
 	$DMSETUP_PROG remove $DMTHIN_DATA_NAME> /dev/null 2>&1
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 _dmthin_check_fs()
@@ -138,7 +139,7 @@ _dmthin_init()
 	DMTHIN_VOL_TABLE="0 $virtual_size thin $DMTHIN_POOL_DEV $pool_id"
 	$DMSETUP_PROG create $DMTHIN_VOL_NAME --table "$DMTHIN_VOL_TABLE" || \
 		_fatal "failed to create dm thin volume device"
-
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 # for internal use
-- 
2.17.0

