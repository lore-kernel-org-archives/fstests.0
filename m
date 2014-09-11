Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61051 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756445AbaIKUCc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Sep 2014 16:02:32 -0400
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s8BJwehN017007
	for <fstests@vger.kernel.org>; Thu, 11 Sep 2014 13:02:32 -0700
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1pb43v9ewa-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <fstests@vger.kernel.org>; Thu, 11 Sep 2014 13:02:32 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] btrfs: use _nocheck for btrfs/011 and btrfs/012
Date: Thu, 11 Sep 2014 16:02:28 -0400
Message-ID: <1410465748-1226-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

These two tests blow up on the scratch test, but 011 leaves the devices in a
state where the first scratch dev is no longer part of any file system and 012
leaves the scratch dev as an ext4 file system.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 tests/btrfs/011 | 2 +-
 tests/btrfs/012 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index faa0402..0207057 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -61,7 +61,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _need_to_be_root
 _supported_fs btrfs
-_require_scratch
+_require_scratch_nocheck
 _require_scratch_dev_pool 4
 _require_command $BTRFS_SHOW_SUPER_PROG btrfs-show-super
 
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index f7e5da5..407acbc 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -52,7 +52,7 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs btrfs
 _supported_os Linux
-_require_scratch
+_require_scratch_nocheck
 
 BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
 MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
-- 
1.8.3.1

