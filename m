Received: from mail-wr0-f195.google.com ([209.85.128.195]:35593 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHXMtI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Aug 2017 08:49:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id n53so1562071wrb.2
        for <fstests@vger.kernel.org>; Thu, 24 Aug 2017 05:49:08 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m130sm3166651wma.27.2017.08.24.05.49.06
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 05:49:06 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] generic/108: tolerate old lvm utility versions
Date: Thu, 24 Aug 2017 14:48:26 +0200
Message-Id: <1503578906-11387-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

lvm utility in Ubuntu 14.04 LTS treats -l 100%FREE as a hard number and
not as an approximate upper limit.  With ~5G scratch partition and ~128M
scsi_debug device, vg_108 is 1279+31=1310 extents long, but only 31*2=62
can be allocated with -i 2:

  # lvm lvcreate -i 2 -I 4m -l 100%FREE -n lv_108 vg_108
  Insufficient suitable allocatable extents for logical volume lv_108: 1248 more required

Set the size to allocate to 100M.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 tests/generic/108 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/108 b/tests/generic/108
index 1525dfb64a47..0caec7d02d72 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -74,7 +74,7 @@ $LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
-yes | $LVM_PROG lvcreate -i 2 -I 4m -l 100%FREE -n $lvname $vgname \
+yes | $LVM_PROG lvcreate -i 2 -I 4m -L 100m -n $lvname $vgname \
 	>>$seqres.full 2>&1
 # wait for lv creation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
-- 
2.4.3

