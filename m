Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79813C9D9
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683252; cv=none; b=AJHJI0UQhXE1fIQ/1g741dvNR9aOCGdILwEgVSQqcOT6zlRLndnNg8lNBvxnAlaZaiIRVQM5zMbCdnr8f7GqxM6N2l+Ch8vLTdxpmEz5CgvVsc1Y4OXeOO+mVz9OR6J/mCHlUKDuaT4kppr1lgMYslpTFgoFY0dfeKvawVvjIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683252; c=relaxed/simple;
	bh=KTI25EQFWJbOCEvtnqjR61YxGCSAt5F7+1DCcN5IaH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8CHMtw48DCG6lWP8Y8LqI3Rz5txRHGdunlrPP1Tibr9t3D98yrH4Pgzgsa+TE1t/udXoS0D7yypHKt0Aes54yyHeBTocGlXf6FLNjkNL6rkzdvgw2Z/959XBCHJ94lDdnITYDd98ubY/ObtWEdaeuNjnIFyfLlrQ6z7BU6KykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=t2m2hSyf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="t2m2hSyf"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71d4e043dd9so1442711a34.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683250; x=1733288050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRi8p2vG65siHZi4g0d6yn8UFaizrYqtdSaScXwCU00=;
        b=t2m2hSyf5oX4DuIC4uoEUA2H2PlqJnofR54mUYQLGziHqiTzshHkaoW2k8h1Ffzj68
         9jzsVyYTblcrex/9ooJIDIJCMHFY2NGK+i5o1EmatzN0jRJPpqyZptp8FeUlp+GTEcu1
         T4BX1R5fqqW7wqmuLmlDSHc1s+UuvKUauAzlctXFrrnFHvFtl58bByzGcyCjTAJx9DfU
         3BrUbuNtC2KBmlNVSfzI0IePz9tW1LimUekz1bB6YrENLN85N4a2G59/tXJ03xm4yD3e
         Zs3UdrDVqOU00otvjWKGT6wspwXuOuN9CiVM0vJZPsd/7EuX/OGsjX5QG6pxER1UV5uU
         XGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683250; x=1733288050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRi8p2vG65siHZi4g0d6yn8UFaizrYqtdSaScXwCU00=;
        b=YZOw3U4Y3SSN4EH3H7vRmTWkTbJAHGJ79OvYjYfrlVTzs5k/jnaVOgDSy/duJZa3tx
         b2y8px/pcnus0dSFabVAVfliZXc+kIcjJRt9nBcYe8SVjnzAkOMeHkGGeHcJZTtl6mFl
         9mz39pNGkypEbB2DdIQQUkeG1cE2onIAQL3g4PhYV3aD6etf7CP3BegcrQ2D3QwNi6/Q
         hIkFQBefL8qQcmngkgdLZSaLxGOYDHDk3FZpEqxevjxA8YYUzkizRozkRW03R62fbC+4
         KwGhKMPL2xJLOv4mdIP+w8jOgSssPogPxtBQZPGQJg2fOCuCLvxRjfHVkeIOQR/4AHoS
         RyMw==
X-Gm-Message-State: AOJu0YzktxUYLOoAUMnLmhGsU7ioOTnzTHAlhBQvFNpJcvdLzqV/eyJg
	X3GRiSTk5tFnUa9d/W3/HFc1O3Sb8/yzjf2mik5LpYVolvzD0UjUtM4Hu3lvy+jhARp0X+91D9t
	F
X-Gm-Gg: ASbGncs2XawFa/f8LF0C7HOz0IBB++BdDz8BY+XgMbSk8YHT2rRWK3Embp2D7LKo4oQ
	0c0wtELVps7VFyk2bHo1FnBMTHMOobqmNbdDJzYb35lkEHBFUr6R8MxcbGDUGAk5NMwK9GAG7g5
	b6XNoLqXAJ1f3JXhZgSln+a0E/I7d3xvSkl5nqV++pvq/lxxEyKvgygJw6chwU0WtkH9SZ79iXO
	UniW7Q8JcDtshQKImJwMkS7hC3L3sw95LDUBvkcvLxo3G2uZ/3nTxXsP9SjFdI+M7eiWr9pydgC
	+JkeMI6dy7tWPqFLNPy/S/Kb
X-Google-Smtp-Source: AGHT+IHhD9ISIaquTIAqsav7Fd8jdTNsmdsLbq+UjAadfDWoX2SFPG5njJGcAqE2wEggp8CTXWnusA==
X-Received: by 2002:a05:6830:4113:b0:718:1163:ef8f with SMTP id 46e09a7af769-71d65c7e396mr1462173a34.2.1732683250425;
        Tue, 26 Nov 2024 20:54:10 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3e09acsm8171837a12.67.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUS-0GJQ
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQeE-0kBl
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 10/40] fstests: fix DM device creation/removal vs udev races
Date: Wed, 27 Nov 2024 15:51:40 +1100
Message-ID: <20241127045403.3665299-11-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

When there is load on the system, newly created DM devices don't
seem to be created consistently. When a new device is created,
it is supposed to be created as /dev/dm-X, and then a udev rule
creates the symlink from /dev/mapper/<dev name> to /dev/dm-X.

Unfortunately, a lot of the tests that use dynamically created dm
devices (dmerror, dmflakey) are not being created with this device
node structure. This is resulting in getting the wrong short device
name for the block device and hence we can't find the filesystem
sysfs attribute directory for the filesystem on that block device.

For example, with added debug to check what device name was being
passed around and resolved:

eneric/489       - output mismatch (see /mnt/xfs/runner-10/results/xfs/generic/489.out.bad)
    --- tests/generic/489.out   2022-12-21 15:53:25.503043574 +1100
    +++ /mnt/xfs/runner-10/results/xfs/generic/489.out.bad      2024-10-24 10:27:29.767196340 +1100
    @@ -1,4 +1,10 @@
     QA output created by 489
    +./common/rc: line 4955: /sys/fs/xfs/flakey-test.489/error/fail_at_unmount: No such file or directory
    +dev: /dev/mapper/flakey-test.489
    +resolved dev: /dev/mapper/flakey-test.489
    +brw-rw----. 1 root disk 251, 5 Oct 24 10:27 /dev/mapper/flakey-test.489
    +./common/rc: line 4955: /sys/fs/xfs/flakey-test.489/error/metadata/EIO/max_retries: No such file or directory
    +./common/rc: line 4955: /sys/fs/xfs/flakey-test.489/error/metadata/EIO/retry_timeout_seconds: No such file or directory
    ...
    (Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/489.out /mnt/xfs/runner-10/results/xfs/generic/489.out.bad'  to see the entire diff)

Here we see that the block device node is actually at
/dev/mapper/flakey-test.489, not a link to a /dev/dm-X device node.

This implies that the udev rule to create the /dev/dm-X node and
the symlink to it at /dev/mapper/flakey-test.489 has not run, and
something else created the device node.

That looks like a bug in _dmsetup_create(). It creates the new DM
device, then runs 'dmsetup mknodes', then waits for udev to settle.
This means the mknodes command - which makes sure the dm device
nodes exist - is racing with udev to create the device nodes. They
don't use the same rules to create nodes, so we end up with this
broken situation.

'dmsetup mknodes' is considered legacy functionality, intended for
systems that have no udev capability. For systems that have udev
enabled (i.e. all modern distros), mknodes should not be run because
it creates a different device node structure to what udev creates
and can race with udev as we see here.

Fix it by removing the 'dmsetup mknodes' as it is unnecessary to
create the correct device node layout the rest of the system is
expecting to see.

Additionally,_dmsetup_remove() calls 'dmsetup mknodes' and that can
also race with udev and cause issues. Hence we need to remove that
call from the remove operation as well.

Further, 'dmsetup remove' is also subject to races with udev which
results in device remove failing.  This problem is documented in the
dmsetup man page and suggests the use of the "--retry" option. This
means dmsetup will retry several times over a few seconds before
failing the removal.

This reduces the remove failure rate substantially,
but it can still occasionally fail when the system is under heavy
load and udev processing is very slow. This is fixable, but requires
fstests udev infrastructure changes as it requires udevadm
functionality that is relatively new. Hence that will be done as
a separate fix.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 391370fd5..a601e2c80 100644
--- a/common/rc
+++ b/common/rc
@@ -5162,8 +5162,8 @@ _require_label_get_max()
 _dmsetup_remove()
 {
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
-	$DMSETUP_PROG remove "$@" >>$seqres.full 2>&1
-	$DMSETUP_PROG mknodes >/dev/null 2>&1
+	$DMSETUP_PROG remove --retry "$@" >>$seqres.full 2>&1
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
 }
 
 _dmsetup_create()
@@ -5174,7 +5174,6 @@ _dmsetup_create()
 	# device open won't also fail.
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG create "$@" >>$seqres.full 2>&1 || return 1
-	$DMSETUP_PROG mknodes >/dev/null 2>&1
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
 }
 
-- 
2.45.2

