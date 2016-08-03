Received: from aserp1040.oracle.com ([141.146.126.69]:39794 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcHCWvD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2016 18:51:03 -0400
Date: Wed, 3 Aug 2016 15:50:04 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v2 09/17] common/dmerror: fix mount option issues
Message-ID: <20160803225004.GB25565@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914483353.11762.14647880235199676753.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914483353.11762.14647880235199676753.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Calling _mount doesn't work when we want to add mount options
such as realtime devices.  Since it's just a normal scratch device
mount except for the source device, just call _scratch_mount with
SCRATCH_DEV set to the dmerror device.

v2: Use the standard _scratch_options for mounting.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/dmerror |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/common/dmerror b/common/dmerror
index 5ad9994..d05c4c8 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -41,14 +41,10 @@ _dmerror_init()
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
+	_scratch_options mount
+	$MOUNT_PROG -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
 }
 
 _dmerror_unmount()
