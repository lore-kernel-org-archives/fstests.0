Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E34446F5
	for <fstests@vger.kernel.org>; Thu, 17 Sep 2026 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628423; cv=none; b=fJt96Ot3FvnqcWf4i0hR6wmHkhOJd8YgOrkHt2ECgrd4M1Bc813VwaveTEJFUs9LSLIrBTmrGgGHVm3AqEn7DbYrKlAU0/1FT+6FVwzNu52m8qgpv0B9i8r31J6lnE/xpsgIZWtRVNfbh32fGseNSKK7XxUEgrXZAg7OQC69zsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628423; c=relaxed/simple;
	bh=jOyu3EIKSeFwHAs6+mHA49hCpziK8KdR0SzBmcGIEHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJvBeZCImLiJbJ9Jvc+oDGHVFSTLzK/t4yni/kQupkoBsUkZ8a05jotypz1HBc4aDiz1XTP3OgmFP/+o68ZmqCofl6YuKnmvxWPzsEFuVdwJ7Cfyf9bwyHVzN7MD4gU5Sc9qRiI/wW35KBKfI4xEyPHAJCDwuvFhS91XZ3JSA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=ACPDMu8e; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="ACPDMu8e"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso3584275e9.2
        for <fstests@vger.kernel.org>; Thu, 17 Sep 2026 00:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1789628411; x=1790233211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn3SWKhrOTNJm73nw3ryVFhUVB9Ddy7CV5/9j5FpmHs=;
        b=ACPDMu8emdCHiAtWfNmRYAvZY73y5r/dOql316ooCWm2LSJy1zOR8UerbG45pT3XcB
         7odoCndPt9ucRwjU/UQ4SFV3MTiGr1KTJWLwymxNsu23M3Ei/WvUzxoepQbWsWBPM+f9
         so66l0lkC4CM1bxu1sEaVw5qimNYBNZqbBmCumXG3eAJiscXlETlcryPdqVQn9wJJxCI
         x+hyhHrmHNwGzrsEcHc8SdX0/IsW0ED7/540s5L9JDrxoY/iSoOIw1MmvEZrhgCXlxuO
         vq4tMgRDDY8uUMvig/DmJBntSNfKtANkgJh/7R4LsYlI9KfUP3kI9vkMmKfzxS7gmrcn
         UWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628411; x=1790233211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn3SWKhrOTNJm73nw3ryVFhUVB9Ddy7CV5/9j5FpmHs=;
        b=i4EyXov7/VGOn2A9zLZVwxBfskWYSRtA11rEJncJypQ+CiEF5/c21Qv7ZoszH60gqv
         JoH+7iaissjfR5Ak2jz/RqQWdPXP01Q4U1PcXDYJs12OnzvSJHKhq0SuRzul0vq33PDz
         +acAK36DqmAJNgxhWv8CGjRRwtfjGVD0g/MfYUmMp7eNM39UthTLOibBghiaswBX7XBa
         fQdaeuw36h1Y/T5PqbA6xx0FIczekbTARAKtSJpyY/vhkwtHaKlfQjwSzWwd8jCK0RnW
         bqkbXILL0JXQEzzJR2VhvGyyg8WGE0yDSkZCVx8jNe27J8sV1W4uAay6BggGc2sPbF9f
         SOnw==
X-Gm-Message-State: AFuF++lEedrfIn4mCPRgkN/4VYsA3qKhwmwhUrcCSQF3gG4opfL6/2Ea
	h+gMwuegxG5sdljA6qWiP0k4SnWmmDA8IfozMWchOEsbrLGX01xhZS96hryQyiNuFziqodm+AXk
	P1Xux+P8=
X-Gm-Gg: AYBFou3Kbb+RdyVuPd4dlfIi1mK/FJe3pxxCgvArENj4c+cwP9oZUgSdINLmTl9MlCk
	cZUzzvCD7OCPE8XN7U+NuA9YrXo2cCs/321Npq/I9UQ0AVOY585+YPhyDgA6kDwJ+y2l1hyS+PR
	fDMgde/NCU4pmK6rRrasZiKytKxF53aKTKbWSM0CqaqUvxdTXQQpcYGB5dGr4yXgKdPPVhYnacD
	csVPrkh2PS8E2fnIEAuvOiEvkgJoBPUoSk+FpOU03PX9yYVvGRzuy7Va84DZqtugK+XwcUHJkZv
	ZhBvP2iuj4/S60tzqKAr38S7M4NHUK+Gqj3/3EsVbn1plPz45+Cn27V9hQja9paS+2vTxwEcuWD
	keaRwHzEOnmP1nr2ZwcMn1ZVQW+Q58YkmO/e+k3bd7DmZE4tBCzqHIbaCY5+r3wV6Jtr8ye+cs6
	FUXvX8SCrypFBfMH7b0CTWyP0Q5LwrfI6KZ8TWDnjL6XM9wCVoaWl87JK16rDh+SqtrdAgszy8U
	kP3UYn1Wp28mnGXnefB7b0Shr3ufOqQqoqGQHPbeEAj3TT9IF3ev6qhcardM3ztEeQDBX6Vxkb+
	LnVh
X-Received: by 2002:a05:600c:4e0a:b0:49e:8238:6feb with SMTP id 5b1f17b1804b1-49eb73088c2mr62510255e9.14.1789628411026;
        Thu, 17 Sep 2026 00:00:11 -0700 (PDT)
Received: from x1-carbon.home (192-164-82-97.hdsl.highway.telekom.at. [192.164.82.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbbd83e39sm76941375e9.4.2026.09.17.00.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:00:10 -0700 (PDT)
From: Moritz Tanner <moritz.tanner@linbit.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Moritz Tanner <moritz.tanner@linbit.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic: test bdev freeze count leak on nested thaw
Date: Thu, 17 Sep 2026 08:59:38 +0200
Message-ID: <20260917065938.51819-1-moritz.tanner@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kernel v6.8, a nested thaw that drops its freeze reference
while other freezers remain returns -EINVAL although it succeeded.
bdev_thaw() then keeps bd_fsfreeze_count elevated, and since
device-mapper's unlock_fs() ignores the error, a dm suspend/resume
cycle on a filesystem frozen with FIFREEZE leaks the count. After
unfreezing and unmounting, the block device can never be mounted
again:

    dm-1: Can't mount, blockdev is frozen

Add a regression test that freezes a filesystem on a dm-linear
device, runs a dm suspend/resume cycle inside the freeze, unfreezes
and remounts. On buggy kernels the final mount fails with EBUSY.

Suggested-by: Christoph Hellwig <hch@lst.de>
Lore: https://lore.kernel.org/linux-fsdevel/20260821085451.65206-1-moritz.tanner@linbit.com/
Signed-off-by: Moritz Tanner <moritz.tanner@linbit.com>
---
 tests/generic/802     | 69 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/802.out |  2 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/generic/802
 create mode 100644 tests/generic/802.out

diff --git a/tests/generic/802 b/tests/generic/802
new file mode 100755
index 00000000..d3b84200
--- /dev/null
+++ b/tests/generic/802
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 LINBIT HA-Solutions GmbH.  All Rights Reserved.
+#
+# FS QA Test 802
+#
+# Test that a device-mapper suspend/resume cycle on a filesystem that is
+# already frozen by userspace does not leak a block device freeze reference.
+#
+# On buggy kernels thaw_super() returns -EINVAL for a nested thaw although
+# it dropped its freeze reference, so bdev_thaw() leaves bd_fsfreeze_count
+# elevated. Once the filesystem is unmounted, the block device can never
+# be mounted again:
+#
+#     dm-1: Can't mount, blockdev is frozen
+#
+. ./common/preamble
+_begin_fstest auto quick freeze mount
+
+_fixed_by_kernel_commit fe967191e585 \
+	"fs: don't return -EINVAL for successful nested thaw"
+
+# Override the default cleanup function.
+_cleanup()
+{
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	$DMSETUP_PROG resume $lvdev >> $seqres.full 2>&1
+	_unmount -q $SCRATCH_MNT
+	_dmsetup_remove $node
+	cd /
+	rm -f $tmp.*
+}
+
+_require_scratch
+_require_dm_target linear
+_require_freeze
+
+echo "Silence is golden"
+
+size=$((256 * 1024 * 1024))
+size_in_sector=$((size / 512))
+_scratch_mkfs_sized $size >> $seqres.full 2>&1
+
+node=$seq-test
+lvdev=/dev/mapper/$node
+table="0 $size_in_sector linear $SCRATCH_DEV 0"
+_dmsetup_create $node --table "$table" || \
+	_fail "failed to create dm device"
+
+_mount $lvdev $SCRATCH_MNT || _fail "failed to mount dm device"
+
+# Freeze the filesystem from userspace first, then nest a block device
+# initiated freeze/thaw cycle inside it via dm suspend/resume.
+xfs_freeze -f $SCRATCH_MNT || _fail "failed to freeze filesystem"
+$DMSETUP_PROG suspend $lvdev >> $seqres.full 2>&1 || \
+	_fail "failed to suspend dm device"
+$DMSETUP_PROG resume $lvdev >> $seqres.full 2>&1 || \
+	_fail "failed to resume dm device"
+xfs_freeze -u $SCRATCH_MNT || _fail "failed to unfreeze filesystem"
+
+# On buggy kernels the resume leaked a block device freeze reference,
+# and the device cannot be mounted again once unmounted.
+_unmount $SCRATCH_MNT
+_mount $lvdev $SCRATCH_MNT || \
+	_fail "failed to mount dm device after nested freeze/thaw"
+_unmount $SCRATCH_MNT
+
+status=0
+exit
diff --git a/tests/generic/802.out b/tests/generic/802.out
new file mode 100644
index 00000000..a69c0539
--- /dev/null
+++ b/tests/generic/802.out
@@ -0,0 +1,2 @@
+QA output created by 802
+Silence is golden
-- 
2.55.0

