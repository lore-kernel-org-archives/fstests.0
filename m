Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D80153583
	for <fstests@vger.kernel.org>; Mon,  6 May 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007697; cv=none; b=h/ovv/O0rMVvTOV2Z4lehBYNEsFHzjtz99cABC4r+JxFGSafbJFhsOWt11mPE0sBJCHP46E/wik0CY2KUVlY69Hx3f38LFmf8KUkAwkDI/No+U9S+y4gSB4sOfp2lUXZO5ia0/I/eAc4wKmj+x2y6kVwMN7pfCZlwaUECoHTq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007697; c=relaxed/simple;
	bh=pyVga/tGoRiom70L3weUVuJjhdPXbIwuHY7iF/S8AWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+On4Sd0bccmaHM3CjgrAH5QM8YeE/INWTrQ3K1c0w/BHhViLTpDjhaWb761ZcQdcPd6jJYslQTyz2ExFgyXEE8YQ5tSCFSF13AJxwI7gpaSo0Ulgs5MKv88VxK2wRGKR8qcZVuKW6jOpQGG9pauuTQkCzkPDeXjDtqwpcOelNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=xY0PYcNA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="xY0PYcNA"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VY4P21mRGz9sbY;
	Mon,  6 May 2024 17:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715007686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw+jWdtRd8U7QJmF22ttCKm76KVLrDcwvD6Ap8URlF4=;
	b=xY0PYcNALN+6umn2ZxFlK2+8MBIAoNnqMJs2Ger7u5bWwUzqkUPyKeFy0eZaXxcMi7Ohgm
	X3HpyMOWC+DPXGSDM3HHbv70f4gmLp5i7kPhR09Ncjk4SgNnQrj7PYRL6ybTTlwIvlcxYG
	BJe2SChKHftxOV8xWk9wT+ZT7agZ21gCxTN5v1smHvQKGWSAPtAfpmszC1ufvOnuDaF1PU
	6myn6/rY0aZ8dfCW9om66NAYb5RjU6d7UsCznEHdrvrkh0ZIaRytHWYsMKkWAzLrMC6Tlf
	fzNPPzj0aQmC1XjeUydGluyYsRwUhmkl0b/ENq6oWsts831kIs6tJ1u2MjowsQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	kernel@pankajraghav.com,
	ritesh.list@gmail.com,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Date: Mon,  6 May 2024 17:01:17 +0200
Message-Id: <20240506150119.184097-2-kernel@pankajraghav.com>
In-Reply-To: <20240506150119.184097-1-kernel@pankajraghav.com>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
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

Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.

Cap the blksz to be at least 64k to retain the same behaviour as before
for smaller filesystem blocksizes.

* This happens even on a 64k pagesize system and it is not related to
  LBS effort.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 tests/xfs/161 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/161 b/tests/xfs/161
index 486fa6ca..94290f18 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -38,9 +38,15 @@ _qmount_option "usrquota"
 _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
 _scratch_mount >> $seqres.full
 
+min_blksz=65536
+file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
+# Write more than one block to exceed the soft block quota limit.
+blksz=$(( 2 * $file_blksz))
+
+blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
 # Force the block counters for uid 1 and 2 above zero
-_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
-_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
+_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
+_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
 sync
 chown 1 $SCRATCH_MNT/a
 chown 2 $SCRATCH_MNT/b
-- 
2.34.1

