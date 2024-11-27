Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581064689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683575; cv=none; b=HeW620hBodK5E1v3xoybOmDkmP9Md5jZicMUakBxI0gjhOY6jcmcRDt8oDRm3wmAhhDfjHsUB9IfUplC5tlBxQ9xXSzXR9t7Rv/9Qp1jbKzwabNgtyrvAefXwdyasYVIIpkwjVRFNo94osC3IdzD2QDIYatQ1Rc2Dtsfi8x5Ms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683575; c=relaxed/simple;
	bh=DaCViSDIr7o1A1Ht2B1KOho7iAv1rY1kA+Ru9raJy0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqLleLvSVtO+ivZaNxkOYfdDkxbdAnOkVy78tB2V48vHuwFolYeDwQfZt523s11nzGVb0gKCehReEEhcWoOPv5JZtv4NYAUJzdYQTMX1jwuOhthIE6Va3T8gfvKcdtOaXjapnCdiAWqOdZsnrB3t3EBN2IQdWLCymeg7ZSb5Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MdowxnAM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MdowxnAM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2129fd7b1a5so46171625ad.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683573; x=1733288373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP1rPRAm2d8Rm2qsU6tCPjcunzd1eoaQlBXhUvC0uGo=;
        b=MdowxnAMPNAVAe19mIUUEWXF6yAxW/hvvbXMsHByiUg1ZuzFxhpaC0Ul1rWWsSWEm2
         NcUFu9Kd7nFe8A6ma41r0Udj0joKFo27GnvQ6HCJWbjYhr2YOIPZ0N+ErDH8lOdY9sKc
         RMfKJOG3RV6Z5AInSTuacSO3STw5JIxtEtOhJEQPnaCHGmlsHoO1B3sM/GnDIMEVRYxo
         6V026/ah5/757psgFUkiI0g6YsaXJ7Y8n4nyfqjQWRdQO7KiALp5190eWTL9fmdn8XAm
         ZDANNssCWqFFdrXbzIkkT2Y7E3pyfniXAwPDtngqIku4j013Do0FRlWQZyZMoXjP3kmY
         bUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683573; x=1733288373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP1rPRAm2d8Rm2qsU6tCPjcunzd1eoaQlBXhUvC0uGo=;
        b=C077HB4g3rEpLNlb6aQzKkrmhWnjYWGVLBv1m3zNtxdE01bIJ0hmOGiPVauCc991vJ
         C2YkLsC2sojihgd8UDZu5LxS6j8Eymhw72/YLA+w+vnVCjYE2kPyFUx3Lzoa2yfuMHQl
         vAq8s66Yh2qm48epN4QnKZ/4kMJS1GRmgW364H8WM/15u9tywjiP/RIq20zKc7M6l3Cd
         Q4wbONR0Gil8t8wA8mhQ0ELWruRvmMcIpK4Q5M64Jf/Wu4+2gz3l7nKIbzd4YQEamnqb
         mHsbjq44PUER6Ku8+rWqSkpsx9Otj7+791bvH1A6EQcBN3ScB2HwopHcxdVqnMuz3+hD
         xE2w==
X-Gm-Message-State: AOJu0Yx+WNA3QyO3VDKJeaMAxo6cwf9CrymRgRyov8QdTU8ZhjjGm7zU
	V9nGeI25v/SDl32KDOuFXP1f3p2muYEtfdvtmVl9j4rHSpV8v9ZxW5DjCNNf0ZmBy9pm4GKz6+S
	W
X-Gm-Gg: ASbGncuyprk3LI/E3pStTaAnLMPiFAM8CO8AzEk+arzkCmRX5Gy0ueh9FOtiJKvxxtP
	EOWO1pK6yOIRmtwkv8skkP7Ghd2fGqU9su+vtOwXFW91vEzmqE8bXlK9nt48vdG7mGhMYRkJ1Oo
	/Hfp3AO98pcb25xT3UXB4p0UM7PXa8d5fXXyqz6AKu2W5OHNPWZr8zgK6LMYMK8nYaLhcuMcsid
	F370y6OePS0NQ7HywblwFnsxXNDM/qW52Wonrq7HTc3nLlXqVo5eJEkUlXV3jv6vro3xJ3wHHOC
	b4cC+EOCWWcYhg==
X-Google-Smtp-Source: AGHT+IHmJRpO5vNi8gCCjg4XFLPyOpKMhfn5fUx+AwFBNdU9uQGayWRSQBvFCyq0Yk8HRKRltjmESQ==
X-Received: by 2002:a17:903:22d0:b0:212:5ee0:1249 with SMTP id d9443c01a7336-21501e5c253mr24772515ad.40.1732683572635;
        Tue, 26 Nov 2024 20:59:32 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc131f3sm91428235ad.200.2024.11.26.20.59.31
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:32 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUn-1EQT
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQef-1k3T
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 15/40] fstests: mark tests that are unreliable when run in parallel
Date: Wed, 27 Nov 2024 15:51:45 +1100
Message-ID: <20241127045403.3665299-16-david@fromorbit.com>
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

Add a group named "unreliable_in_parallel" to mark tests that
do not give reliable results when multiple tests are run in
parallel. Generally this happens with tests that are reliant on
caching in some way, such as generating specific file layouts using
buffered IO or expecting inodes to be cached in memory. These are
perturbed by other tests running sync(), generating memory pressure,
dropping caches, etc.

Hence whether these tests pass or fail is wholly dependent on what
tests are running at the same time, and hence randomly fail when
nothing has actually gone wrong. Hence they are unreliable as
regression tests when running tests in parallel, so we add them to
the "unreliable_in_parallel" group and a parallel check can exclude
this group.

As tests are updated to be robust against external interference,
they can be removed from the unreliable_in_parallel group.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 doc/group-names.txt | 1 +
 tests/generic/336   | 7 ++++++-
 tests/generic/561   | 8 +++++++-
 tests/xfs/177       | 8 ++++++--
 tests/xfs/232       | 6 +++++-
 tests/xfs/237       | 8 +++++++-
 tests/xfs/243       | 7 +++++--
 tests/xfs/300       | 8 ++++++--
 tests/xfs/440       | 6 +++++-
 tests/xfs/527       | 5 ++++-
 tests/xfs/631       | 7 ++++++-
 tests/xfs/802       | 7 ++++++-
 12 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index ed886caac..f5bf79a56 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -138,6 +138,7 @@ trim			FITRIM ioctl
 udf			UDF functionality tests
 union			tests from the unionmount test suite
 unlink			O_TMPFILE unlinked files
+unreliable_in_parallel	randomly fail when run in parallel with other tests
 unshare			fallocate FALLOC_FL_UNSHARE_RANGE
 v2log			XFS v2 log format tests
 verity			fsverity
diff --git a/tests/generic/336 b/tests/generic/336
index 06391a93f..c874997e4 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -9,8 +9,13 @@
 # file F2 from directory B into directory C, fsync inode F1, power fail and
 # remount the filesystem, file F2 exists and is located only in directory C.
 #
+
+# unreliable_in_parallel: external sync operations can change what is synced to
+# the log before the flakey device drops writes. hence post-remount file
+# contents can be different to what the test expects.
+
 . ./common/preamble
-_begin_fstest auto quick metadata log
+_begin_fstest auto quick metadata log unreliable_in_parallel
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/561 b/tests/generic/561
index 3e931b1a7..602c235bc 100755
--- a/tests/generic/561
+++ b/tests/generic/561
@@ -7,8 +7,14 @@
 # Dedup & random I/O race test, do multi-threads fsstress and dedupe on
 # same directory/files
 #
+
+# unreliable_in_parallel: duperemove is buggy. It can get stuck in endless
+# fiemap mapping loops, and this seems to happen a *lot* when the system is
+# under heavy load. when they do this, they don't die when they are supposed to
+# and so have to be manually killed to end the test.
+
 . ./common/preamble
-_begin_fstest auto stress dedupe
+_begin_fstest auto stress dedupe unreliable_in_parallel
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/177 b/tests/xfs/177
index 773049524..22719ba1c 100755
--- a/tests/xfs/177
+++ b/tests/xfs/177
@@ -21,9 +21,13 @@
 # Regrettably, there is no way to poke /only/ XFS inode reclamation directly,
 # so we're stuck with setting xfssyncd_centisecs to a low value and sleeping
 # while watching the internal inode cache counters.
-#
+
+# unreliable_in_parallel: cache residency is affected by external drop caches
+# operations. Hence counting inodes "in cache" often does not reflect what the
+# test has actually done.
+
 . ./common/preamble
-_begin_fstest auto ioctl
+_begin_fstest auto ioctl unreliable_in_parallel
 
 _cleanup()
 {
diff --git a/tests/xfs/232 b/tests/xfs/232
index 0eea2c098..f0f3916e7 100755
--- a/tests/xfs/232
+++ b/tests/xfs/232
@@ -12,8 +12,12 @@
 # - Wait for the reclaim to run.
 # - Write more and see how bad fragmentation is.
 #
+
+# unreliable_in_parallel: external sync operations affect what happens while
+# the test is waiting for COW expiration.
+
 . ./common/preamble
-_begin_fstest auto quick clone fiemap prealloc
+_begin_fstest auto quick clone fiemap prealloc unreliable_in_parallel
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/237 b/tests/xfs/237
index f172aaf59..91f56d6c1 100755
--- a/tests/xfs/237
+++ b/tests/xfs/237
@@ -6,8 +6,14 @@
 #
 # Test AIO DIO CoW behavior when the write temporarily fails.
 #
+
+# unreliable_in_parallel: external drop caches can co-incide with the error
+# table being loaded, so the test being run fails with EIO trying to load the
+# inode from disk instead of whatever operation it is supposed to fail on when
+# the inode is already cached in memory.
+
 . ./common/preamble
-_begin_fstest auto quick clone eio
+_begin_fstest auto quick clone eio unreliable_in_parallel
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/243 b/tests/xfs/243
index 964e94e1d..f9cc2d50f 100755
--- a/tests/xfs/243
+++ b/tests/xfs/243
@@ -15,9 +15,12 @@
 #     5. delalloc
 #   - CoW across the halfway mark, starting with the unwritten extent.
 #   - Check that the files are now different where we say they're different.
-#
+
+# unreliable_in_parallel: external sync can affect the layout of the files being
+# created, results in unreliable detection of delalloc extents.
+
 . ./common/preamble
-_begin_fstest auto quick clone punch prealloc
+_begin_fstest auto quick clone punch prealloc unreliable_in_parallel
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/300 b/tests/xfs/300
index 3f0dbb9ac..c4c3b1ab8 100755
--- a/tests/xfs/300
+++ b/tests/xfs/300
@@ -5,9 +5,13 @@
 # FS QA Test No. 300
 #
 # Test xfs_fsr / exchangerange management of di_forkoff w/ selinux
-#
+
+# unreliable_in_parallel: file layout appears to be perturbed by load related
+# timing issues. Not 100% sure, but the backwards write does not reliably
+# fragment the source file under heavy external load
+
 . ./common/preamble
-_begin_fstest auto fsr
+_begin_fstest auto fsr unreliable_in_parallel
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/440 b/tests/xfs/440
index 0cc679aeb..c0b6756ba 100755
--- a/tests/xfs/440
+++ b/tests/xfs/440
@@ -8,8 +8,12 @@
 # a file that has CoW reservations and no dirty pages.  The reservations
 # should shift over to the new owner, but they do not.
 #
+
+# unreliable_in_parallel: external sync(1) and/or drop caches can reclaim inodes
+# and free post-eof space, resulting in lower than expected block counts.
+
 . ./common/preamble
-_begin_fstest auto quick clone quota
+_begin_fstest auto quick clone quota unreliable_in_parallel
 
 # Import common functions.
 . ./common/reflink
diff --git a/tests/xfs/527 b/tests/xfs/527
index 2ef428c25..0d06b128c 100755
--- a/tests/xfs/527
+++ b/tests/xfs/527
@@ -14,8 +14,11 @@
 # xfs: fix incorrect root dquot corruption error when switching group/project
 # quota types
 
+# unreliable_in_parallel: dmesg check can pick up corruptions from other tests.
+# Need to filter corruption reports by short scratch dev name.
+
 . ./common/preamble
-_begin_fstest auto quick quota
+_begin_fstest auto quick quota unreliable_in_parallel
 
 # Import common functions.
 . ./common/quota
diff --git a/tests/xfs/631 b/tests/xfs/631
index 4d79b821f..319995f81 100755
--- a/tests/xfs/631
+++ b/tests/xfs/631
@@ -7,8 +7,13 @@
 # Post-EOF preallocation defeat test for direct I/O with extent size hints.
 #
 
+# unreliable_in_parallel: external cache drops can result in the extent size
+# being truncated as the inode is evicted from cache between writes. This can
+# increase the number of extents significantly beyond what would be expected
+# from the extent size hint.
+
 . ./common/preamble
-_begin_fstest auto quick prealloc rw
+_begin_fstest auto quick prealloc rw unreliable_in_parallel
 
 . ./common/filter
 
diff --git a/tests/xfs/802 b/tests/xfs/802
index ea09817fd..fc4767acb 100755
--- a/tests/xfs/802
+++ b/tests/xfs/802
@@ -8,8 +8,13 @@
 # filesystem, and that we can read the health reports after the fact.  IOWs,
 # this is basic testing for the systemd background services.
 #
+
+# unreliable_in_parallel: this appears to try to run scrub services on all
+# mounted filesystems - that's aproblem when there are a hundred other test
+# filesystems mounted running other tests...
+
 . ./common/preamble
-_begin_fstest auto scrub
+_begin_fstest auto scrub unreliable_in_parallel
 
 _cleanup()
 {
-- 
2.45.2

