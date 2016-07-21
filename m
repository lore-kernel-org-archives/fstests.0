Received: from aserp1040.oracle.com ([141.146.126.69]:29364 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbcGUXrV (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:47:21 -0400
Subject: [PATCH 09/17] common/dmerror: fix mount option issues
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:47:13 -0700
Message-ID: <146914483353.11762.14647880235199676753.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Calling _mount doesn't work when we want to add mount options
such as realtime devices.  Since it's just a normal scratch device
mount except for the source device, just call _scratch_mount with
SCRATCH_DEV set to the dmerror device.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/dmerror |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)


diff --git a/common/dmerror b/common/dmerror
index 5ad9994..22b9ea9 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -41,14 +41,9 @@ _dmerror_init()
 	DMERROR_TABLE="0 $blk_dev_size error $dm_backing_dev 0"
 }
 
-_dmerror_mount_options()
-{
-	echo `_common_dev_mount_options $*` $DMERROR_DEV $SCRATCH_MNT
-}
-
 _dmerror_mount()
 {
-	_mount -t $FSTYP `_dmerror_mount_options $*`
+	SCRATCH_DEV=$DMERROR_DEV _scratch_mount $*
 }
 
 _dmerror_unmount()

