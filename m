Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C04689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683592; cv=none; b=ozonsjQn5TwF5LhtG4wN9fGI5fUrnd8P0NxWfdAXEJQCU3McgKUjye6J5PfoJ+FM7Nwr0kwCpj/zAzRc5XMUu6N4wXLZnyq7iAfQyv+lPERAq5R75ITw7lnkqKCKUGFhEEHkEzu3Nu1hM7+w9H7Km9/iQscUqiCcEt5Hjuo5I7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683592; c=relaxed/simple;
	bh=dZpRjShA9rqZbr/Qn2hmDvT9o3P6Kf0mQjwcs3oAvAw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdIdVP552yxXrxMMPBjnPZPc3lir8wlxpNhW0BgUycIWiirm3jrvfNFoTeBvkvi/o7PxpoYA/RLVVb5YIReOjqGlZqUimnSe1vTFOG6duT7BVrBsvSHvReUIApFRDQr/mmPKkwcJ4yUk8qXP4vL96aiaQoZBBmpPCScvkH2D9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=P3vOc5ja; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="P3vOc5ja"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7252fba4de1so481911b3a.0
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683590; x=1733288390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFhRJWPQzdgziYv2CJ1bBXezQi8XM59/tAhVcqaDgdE=;
        b=P3vOc5ja2OKALtgGu4s6wnE2O92aktfEmpGoZGDl31QVPWnOEmTWnxFCuZCyBYAa+g
         IvM/oGIRDdjno1tlgTSi4HJDx/KLkfP2a7Uuke4w9Lqct+LVE8wzP5ujunrxSpKkjaOG
         YCHLTZ0CU7IY4iA5UF11ej9aAjXrbFsmZJxwHndvLQReo40a6uQJaqEkxKjM7EyVJCs+
         eZNxV2utMRe0IcRQk6193Is2jK1ViPUwcJpideTJP713viB2Rpx4K9xGqKnVXbqSKNmF
         uwPKiUcWDbOaKpqBO/txJUp51Xr4okOw4LSLotcmayxvfS9dC7t88vE1nddPrGv1Ymt8
         LjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683590; x=1733288390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFhRJWPQzdgziYv2CJ1bBXezQi8XM59/tAhVcqaDgdE=;
        b=EGHzJxiqQg1nHxIrZiavxqgNlMeA3oHaZ2bWWBgI2yHr8N8R1oIvGuWMzkK1kodsO/
         QUATUB9qxK4ZFsO1LlkvvPfChJEZkd5O+Xx6iiG36bAcz34m93Afmdj+3NXKPiM3/t2q
         byqmoMi3gNrLHcrn2BCMAOKCsuqQRcMfR+OEJ3WnWYoc0rVxSvv+2Y62pyR3NAJ3oxOC
         EfjM6wompKLbwkC+Gv12MUeieUQgQ6R/PY4JE+gl1o++0Umb6CJRo+Gfj9t6d/KsDHmD
         RlUW053knaQAYBk5gf2wIjijhSLpr/UEoAcbswT3/1RKNjyzYkC+AUnBWsfpzz9b0IeZ
         5GKg==
X-Gm-Message-State: AOJu0YyqZBXRrZioRiGFFNpNbrB7jibv08eA1vHA0vm+/Qxg+XdRXuuG
	R5Vyxo8mqRdKRjVDvTfxoaBQe6/MPK5yjDuer98blNKepYNiTvv+Rtpfj3nlhakHAxAl58AJyIs
	T
X-Gm-Gg: ASbGncsV1M2RgHjTeZF8eAaVy+3EKk+I0hrz/e3N9RpqONXQh/5pX8KKD+OwFEn63d0
	DJPv5nBMOfF8bWqp2DiadRCB2cjj0jK7oZ6QmA7o9xRtoGuafi8XTNjG5kG/3UrfA7Lj9KzLHXy
	nt0Ji2O0SAsxe66xCIAUFdcl7128CRvhFjJ/AdVfgiiUyUGkXRXlL6q1tPY3tX4WO9WtAIukGO3
	o/prbE0tnMh3kLdgcrsSVca9+j96qbRcCKbLQOvkk1TEgQI6u0s0o6qGLH2V6/aJ9bxrAo3BR/m
	prab8nZmfQtR9Q==
X-Google-Smtp-Source: AGHT+IG16g1MBsQaPlUmXvXe7cT86nNIZT3CKlwcZI+DAw4ge4AV2lJLQPuRwHrTbSXREpiAC/TWQQ==
X-Received: by 2002:a05:6a00:22d6:b0:71e:4296:2e with SMTP id d2e1a72fcca58-72530034bb8mr2037605b3a.11.1732683589723;
        Tue, 26 Nov 2024 20:59:49 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de55862esm9345505b3a.155.2024.11.26.20.59.48
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:49 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVR-2hBd
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfT-3CD4
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 25/40] fstests: scale some tests for high CPU count sanity
Date: Wed, 27 Nov 2024 15:51:55 +1100
Message-ID: <20241127045403.3665299-26-david@fromorbit.com>
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

Several tests use lots of processes to stress the filesystem. many
of them haven't really considered what this means for running the
test on high CPU machines (e.g. >32p) and the potential contention
and performance issues this might trigger.

Some of these tests simply need to increase the size of the journal.
Some need to run on filesystems with high inherent concurrency (e.g.
larger AG count). Some need more efficient/faster file creation. And
so on.

This commit is a collection of those sorts of changes to improve
runtimes on high CPU count machines.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/aio-dio-regress/aio-last-ref-held-by-io.c | 5 ++++-
 tests/generic/251                             | 5 ++++-
 tests/generic/323                             | 7 +++++--
 tests/generic/530                             | 2 +-
 tests/generic/531                             | 8 +++++++-
 tests/xfs/013                                 | 4 ++--
 tests/xfs/076                                 | 6 +++---
 tests/xfs/176                                 | 6 +++---
 tests/xfs/297                                 | 4 +++-
 tests/xfs/501                                 | 2 +-
 tests/xfs/502                                 | 2 +-
 11 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/src/aio-dio-regress/aio-last-ref-held-by-io.c b/src/aio-dio-regress/aio-last-ref-held-by-io.c
index a70f2a9b7..7106e30a9 100644
--- a/src/aio-dio-regress/aio-last-ref-held-by-io.c
+++ b/src/aio-dio-regress/aio-last-ref-held-by-io.c
@@ -85,11 +85,14 @@ aio_test_thread(void *data)
 	/*
 	 * Problems have been easier to trigger when spreading the
 	 * workload over the available CPUs.
+	 *
+	 * If CPU hotplug is active, this can randomly fail so dump the error
+	 * to stderror so it can be filtered out easily by the caller.
 	 */
 	CPU_ZERO(&cpuset);
 	CPU_SET(mycpu, &cpuset);
 	if (sched_setaffinity(mytid, sizeof(cpuset), &cpuset)) {
-		printf("FAILED to set thread %d to run on cpu %ld\n",
+		fprintf(stderr, "FAILED to set thread %d to run on cpu %ld\n",
 		       mytid, mycpu);
 	}
 
diff --git a/tests/generic/251 b/tests/generic/251
index b432fb119..98986469e 100755
--- a/tests/generic/251
+++ b/tests/generic/251
@@ -175,9 +175,12 @@ nproc=20
 # Copy $here to the scratch fs and make coipes of the replica.  The fstests
 # output (and hence $seqres.full) could be in $here, so we need to snapshot
 # $here before computing file checksums.
+#
+# $here/* as the files to copy so we avoid any .git directory that might be
+# much, much larger than the rest of the fstests source tree we are copying.
 content=$SCRATCH_MNT/orig
 mkdir -p $content
-cp -axT $here/ $content/
+cp -ax $here/* $content/
 
 mkdir -p $tmp
 
diff --git a/tests/generic/323 b/tests/generic/323
index 457253fee..2dde04d06 100755
--- a/tests/generic/323
+++ b/tests/generic/323
@@ -23,12 +23,15 @@ _require_aiodio aio-last-ref-held-by-io
 testfile=$TEST_DIR/aio-testfile
 $XFS_IO_PROG -ftc "pwrite 0 10m" $testfile | _filter_xfs_io
 
-$AIO_TEST 0 100 $testfile
+# This can emit cpu affinity setting failures that aren't considered test
+# failures but cause golden image failures. Redirect the test output to
+# $seqres.full so that it is captured but doesn't directly cause test failures.
+$AIO_TEST 0 100 $testfile 2>> $seqres.full
 if [ $? -ne 0 ]; then
 	exit $status
 fi
 
-$AIO_TEST 1 100 $testfile
+$AIO_TEST 1 100 $testfile 2>> $seqres.full
 if [ $? -ne 0 ]; then
 	exit $status
 fi
diff --git a/tests/generic/530 b/tests/generic/530
index 2e47c3e0c..18256b870 100755
--- a/tests/generic/530
+++ b/tests/generic/530
@@ -22,7 +22,7 @@ _require_scratch_shutdown
 _require_metadata_journaling
 _require_test_program "t_open_tmpfiles"
 
-_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
 _scratch_mount
 
 # Set ULIMIT_NOFILE to min(file-max / 2, 50000 files per LOAD_FACTOR)
diff --git a/tests/generic/531 b/tests/generic/531
index 0e3564fd4..ed6c3f911 100755
--- a/tests/generic/531
+++ b/tests/generic/531
@@ -21,7 +21,13 @@ _require_scratch
 _require_xfs_io_command "-T"
 _require_test_program "t_open_tmpfiles"
 
-_scratch_mkfs >> $seqres.full 2>&1
+# On high CPU count machines, this runs a -lot- of create and unlink
+# concurrency. Set the filesytsem up to handle this.
+if [ $FSTYP = "xfs" ]; then
+	_scratch_mkfs "-d agcount=32" >> $seqres.full 2>&1
+else
+	_scratch_mkfs >> $seqres.full 2>&1
+fi
 _scratch_mount
 
 # Try to load up all the CPUs, two threads per CPU.
diff --git a/tests/xfs/013 b/tests/xfs/013
index fd3d8c64c..5a92ef084 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -28,7 +28,7 @@ _create()
 	mkdir -p $dir
 	for i in $(seq 0 $count)
 	do
-		touch $dir/$i 2>&1 | filter_enospc
+		echo -n > $dir/$i 2>&1 | filter_enospc
 	done
 }
 
@@ -42,7 +42,7 @@ _rand_replace()
 	do
 		file=$((RANDOM % count))
 		rm -f $dir/$file
-		touch $dir/$file 2>&1 | filter_enospc
+		echo -n > $dir/$file 2>&1 | filter_enospc
 	done
 }
 
diff --git a/tests/xfs/076 b/tests/xfs/076
index 840617ccb..e315a067c 100755
--- a/tests/xfs/076
+++ b/tests/xfs/076
@@ -47,10 +47,10 @@ _alloc_inodes()
 	dir=$1
 
 	i=0
-	while [ true ]; do
-		touch $dir/$i 2>> $seqres.full || break
+	( while [ true ]; do
+		echo -n > $dir/$i || break
 		i=$((i + 1))
-	done
+	done ) >> $seqres.full 2>&1
 }
 
 
diff --git a/tests/xfs/176 b/tests/xfs/176
index 8e5951ec1..1aa8cde38 100755
--- a/tests/xfs/176
+++ b/tests/xfs/176
@@ -68,10 +68,10 @@ _alloc_inodes()
 	dir=$1
 
 	i=0
-	while [ true ]; do
-		echo -n > $dir/$i >> $seqres.full 2>&1 || break
+	( while [ true ]; do
+		echo -n > $dir/$i || break
 		i=$((i + 1))
-	done
+	done ) >> $seqres.full 2>&1
 }
 
 # Find a sparse inode cluster after logend_agno/logend_agino.
diff --git a/tests/xfs/297 b/tests/xfs/297
index f9cd2ff12..af6af601a 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -34,7 +34,9 @@ _scratch_mount
 STRESS_DIR="$SCRATCH_MNT/testdir"
 mkdir -p $STRESS_DIR
 
-_run_fsstress_bg -d $STRESS_DIR -n 1000 -p 1000 $FSSTRESS_AVOID
+# turn off sync as this can lead to near deadlock conditions due to every
+# fsstress process lockstepping against freeze on large CPU count machines
+_run_fsstress_bg -d $STRESS_DIR -f sync=0 -n 1000 -p 1000 $FSSTRESS_AVOID
 
 # Freeze/unfreeze file system randomly
 echo "Start freeze/unfreeze randomly" | tee -a $seqres.full
diff --git a/tests/xfs/501 b/tests/xfs/501
index 1da4cbf92..678c51b52 100755
--- a/tests/xfs/501
+++ b/tests/xfs/501
@@ -33,7 +33,7 @@ _require_xfs_sysfs debug/log_recovery_delay
 _require_scratch
 _require_test_program "t_open_tmpfiles"
 
-_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
 _scratch_mount
 
 # Set ULIMIT_NOFILE to min(file-max / 2, 30000 files per LOAD_FACTOR)
diff --git a/tests/xfs/502 b/tests/xfs/502
index 52b8e95a2..10b0017f6 100755
--- a/tests/xfs/502
+++ b/tests/xfs/502
@@ -23,7 +23,7 @@ _require_xfs_io_error_injection "iunlink_fallback"
 _require_scratch
 _require_test_program "t_open_tmpfiles"
 
-_scratch_mkfs | _filter_mkfs 2> $tmp.mkfs > /dev/null
+_scratch_mkfs "-l size=256m" | _filter_mkfs 2> $tmp.mkfs > /dev/null
 cat $tmp.mkfs >> $seqres.full
 . $tmp.mkfs
 
-- 
2.45.2

