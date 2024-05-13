Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11261514E5
	for <fstests@vger.kernel.org>; Mon, 13 May 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605995; cv=none; b=KpAODsC1Gislau05VfaHzfBDKEBAQgi4D4Mm7V/qWa3K3/NNq93gow9UH3EzhxLqTcU53q1vKk58VU1pwydlwPfTWwehpoCfMGlQ6/ITx8tqZ2wPqPzM4PSZibTOoSF5u639Iu53qSDch/1RDgpCXbhPqW9GC5DVQoL/ZuAPF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605995; c=relaxed/simple;
	bh=08cjPMqQ2q408fUkqd9NlV2UMcLQw6RzHT95Ag7J6bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQKvpX3xYZzMDcBMMumL0G1Tmi/9p7/qL/dKvs+odYviWIUsZTW2RMLCPhY63CvcOiCUvVSeW+Q43gYBbRc3sKzcbyLRDkroHdWFYS/SxXHopFPkrlG+mgxMHP3atS4PfxOiIi6lsjD/KENmmlnhELENdPPayOA7A+J31ujPvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=WBz2vqVD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="WBz2vqVD"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VdKfm6F1Rz9smL;
	Mon, 13 May 2024 15:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715605984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqo5fFyNdURRfCXugTU+U4/7gFW65nCFG8mVNWEE+Uo=;
	b=WBz2vqVDvak06jEurM2diM9kzMJ4Gq6yY0lLI/1OEWxbso62ZPOhvVMkH/QAhhZPNi5mdW
	dPpGfokBkUrQZ6a1PLyJqCkQvsYy1k4Bp1+/sWRnENjzjPpFiT80+0JxaHa1f5AllfIfu0
	3fnps8G7N90WmSyF4a+LAhbkuZqzEFxkAf+XTfUHmctibHdXsaBn+hSDlyOHm2pI9BXws1
	/R87BMWWkaubSK9g9amuWtakfPAwMufD5HvhXJUQkiKNICgbrT9SRtpWv7qlMNJmQRlcxZ
	GauEQOU+zi1mAMGa9nGmv3e/RocQsmv+ugvpa5Dcm1KUtonzh5wggOKw7vfAUw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: kernel@pankajraghav.com,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	ritesh.list@gmail.com,
	djwong@kernel.org,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 1/3] xfs/161: adapt the test case for 64k FS blocksize
Date: Mon, 13 May 2024 07:12:52 -0600
Message-Id: <20240513131254.92412-2-kernel@pankajraghav.com>
In-Reply-To: <20240513131254.92412-1-kernel@pankajraghav.com>
References: <20240513131254.92412-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

This test fails when xfs is formatted with 64k filesystem block size*.
It fails because the soft quota is not exceeded with the hardcoded 64k
pwrite, thereby, the grace time is not set. Even though soft quota is
set to 12k for uid1, it is rounded up to the nearest blocksize.

*** Report for user quotas on device /dev/sdb3
Block grace time: 7days; Inode grace time: 7days
                        Block limits                File limits
User            used    soft    hard  grace    used  soft  hard  grace
----------------------------------------------------------------------
0        --       0       0       0      0       3     0     0      0
1        --      64      64    1024      0       1     0     0      0
2        --      64       0       0      0       1     0     0      0

Adapt the pwrite to do twice the FS block size and set the soft limit
to be 1 FS block and hard limit to be 100 FS blocks. This also gets rid
of harcoded quota limit values.

* This happens even on a 64k pagesize system and it is not related to
  LBS effort.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 tests/xfs/161 | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/161 b/tests/xfs/161
index 486fa6ca..5bda7019 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -38,15 +38,23 @@ _qmount_option "usrquota"
 _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
 _scratch_mount >> $seqres.full
 
+
+blksz=$(_get_file_block_size "$SCRATCH_MNT")
+# Write more than one block to exceed the soft block quota limit via
+# xfs_quota.
+filesz=$(( 2 * $blksz))
+lim_bsoft=$blksz
+lim_bhard=$(( 100 * blksz ))
+
 # Force the block counters for uid 1 and 2 above zero
-_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
-_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
+_pwrite_byte 0x61 0 $filesz $SCRATCH_MNT/a >> $seqres.full
+_pwrite_byte 0x61 0 $filesz $SCRATCH_MNT/b >> $seqres.full
 sync
 chown 1 $SCRATCH_MNT/a
 chown 2 $SCRATCH_MNT/b
 
 # Set quota limits on uid 1 before upgrading
-$XFS_QUOTA_PROG -x -c 'limit -u bsoft=12k bhard=1m 1' $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$lim_bsoft"' bhard='"$lim_bhard"' 1' $SCRATCH_MNT
 
 # Make sure the grace period is at /some/ point in the future.  We have to
 # use bc because not all bashes can handle integer comparisons with 64-bit
@@ -71,7 +79,7 @@ _scratch_mount
 
 # Set a very generous grace period and quota limits on uid 2 after upgrading
 $XFS_QUOTA_PROG -x -c 'timer -u -b -d 2147483647' $SCRATCH_MNT
-$XFS_QUOTA_PROG -x -c 'limit -u bsoft=10000 bhard=150000 2' $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$lim_bsoft"' bhard='"$lim_bhard"' 2' $SCRATCH_MNT
 
 # Query the grace periods to see if they got set properly after the upgrade.
 repquota -upn $SCRATCH_MNT > $tmp.repquota
-- 
2.34.1

