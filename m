Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C417371D02
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773844; cv=none; b=IheK+9HpZwUyat/MogfBLilpivbDxoMkyO8aGZN7uBDSXR3yzJsu/Z3/w7XtA4hjy4rTuZq8EHhuVSxrF+2plnXvki6wYZsKBWkiKm0NC4PQCvsQhvAxWZ21DVv0arjVUypiyrkCCUgJHw0zOd3my+OWTjT3zbZXEJYb05thQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773844; c=relaxed/simple;
	bh=dnJRa0RzGpb/zGVAqf0twncTg3Poml5y1fNjIs8V3ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMuubqKPpaTHrEJ2CWGBh9P2Z22OxQc7pchYbjRlF3YBOKBorldwGYpca3f3hg3xgXECvTYx4esE+e7zcLC2Z8jED8eFS+kzl4lCHe8Fr+2B3wCO9R5wnGIztLgpK+fa0q90CG5bpgwHtHYFTPQXJFJQeDM2M26TGbblFLj88dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y4HQsy3L; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y4HQsy3L"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso13574815e9.3
        for <fstests@vger.kernel.org>; Sun, 11 Oct 2026 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791773841; x=1792378641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ce1clVE6qRJfn5ktjbgwhdFyB+v1r7C+GeWcoqq4MXA=;
        b=Y4HQsy3LyX7QtsFctCWqm+HgWHs46dxxn974p0Nn6Be5/wxbuIJzy8JyrhN8Wbfn+G
         P79OstpkF17HWVvJmH1szVblPZWuJJPGhsutbmqIHcvzw4NbzmiMWRrqIYCAKyntkQpI
         dhskGXmzGkkXYAdbzFDYEhlqkC8uwDxoi0Jq7dTRyK0fKy426Fb7/p5YgKnq8AcX2lNy
         WcC+V9EO9MYi73kkcCBM7Pa/+JIQVH7OJ1Ds3BXaOXqbcXSzfuCalKXB9kUjiqdBBkGk
         wNK7BDZaUdFoSauEcdEYE74rEDhOPlgXUpcrVHKbm6G9gmdGAIJpTso1Abbki87KOd5N
         FsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773841; x=1792378641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ce1clVE6qRJfn5ktjbgwhdFyB+v1r7C+GeWcoqq4MXA=;
        b=OxeMNBxUCeHU1d68VQ5Nu1ItYC+3drgdpfS8LcMTFGOOQJg5AjGswXpXjN2a3KqDnZ
         AFppo0hhcde77JhKQpGV1N2EC+1RYzZAwYCkh4wjzv4U/PRa1Fo12qi5N7+t178G1Hb7
         ALi6je4Sg8/EnjH4FdrsKuidY3J6TMFOrCp6FqC879yRmlmpqn0XMaOraH/63LVHDgBR
         mDCnW/ZL6Ua0V457rPq9uhhFWiIikLTr+Z5/G++SYHU7bAdwO/JKuH4Lyxxdv+PdCzSO
         VXfhSyBDwFeh1v5cYfxNrIdDr7e5d3YmlnByQP3ZbCjSGhZxrGRcXIk3iabMV07KKM/J
         bDBg==
X-Gm-Message-State: AFq9FYLxL6MPHqkwsFZSQS7QJ3/HUCnMYRYRyuJDLcOUz8DzlYPlY+yM
	9BiBaNgmSlyat6xj35je6aDDhcYoSKin2A4jHid4yjfouZ3vevjOC3RF4o+AIKjSZfizBVg/2Zy
	aIXIrXy15yA==
X-Gm-Gg: AYBFou1Mr2lQ56aXZrtJH8GiQ1/8rsfvqvnrygz9c65VkSp3Cl2mTpg/JVgV+Rov9Ms
	R7qkyFUR9PVB8p5vUmtem9uAoJaROXQdDyMkUr4sofvIqYojY+9BT7nXCiab00rw5rCoBmScUN3
	QDOapvHwMtdtY1t/9zQgjMOIUzc/ESrm1keNHNh2mzyKlQnIquE38TqEWW8jabTxtaYWqR4DonS
	O80Awv1zSIFNk7QPpETG+11SrwH/BYUUwxcErehTB5vEY408my9+Pcr8D0QXgTEAzMUZjbNsow+
	tya+HL2xkcag/panlam9zXb8vA7hbBt+r/1Hwb384m4t6PMDTbG7i0bhoRqPFubZx78FEbW4xkf
	2pjAXQR36sCIzzm8SxerO0V2ldCWS/QHqgu65oB8xN7zZ83oSyMqRQYv9VGtLDLc52mSkCyhD8W
	1mjlbAPX6HqArpQOPXl9Hv4f0WGTsWNjF5FfpX9ryu+6ildTIYsR+ugWXkIRKw
X-Received: by 2002:a05:600c:3f0f:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a18e4cd231mr153062705e9.22.1791773841251;
        Sun, 11 Oct 2026 19:57:21 -0700 (PDT)
Received: from localhost.com ([240e:304:4be4:0:8ce8:cc4e:be82:2880])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dd5sm38792205ad.55.2026.10.11.19.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:57:19 -0700 (PDT)
From: lan@suse.com
To: fstests@vger.kernel.org
Cc: An Long <lan@suse.com>
Subject: [PATCH] generic/095: ignore EBUSY for job5 on NFS
Date: Mon, 12 Oct 2026 10:57:07 +0800
Message-ID: <20261012025707.16720-1-lan@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: An Long <lan@suse.com>

On NFS, the buffered read in job5 occasionally fails with EBUSY:

  fio: io_u error on file <dir>/file2: Device or resource busy: read ...

This most likely happens because the client has to invalidate its page
cache before reading a file that other jobs may have modified, and that
cannot complete while those jobs keep mixing direct, buffered and mmap
writes on the same files.

Make this error ignorable for job5 reads only, and only when testing
NFS, so that unexpected errors from other jobs or other filesystems are
still reported. Since ignore_error given on the fio command line applies
to all jobs, move it into the job file, where it can be overridden per
job. Behaviour for other filesystems and jobs is unchanged.

Signed-off-by: An Long <lan@suse.com>
---
 tests/generic/095 | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 828274fd..53afb1de 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -25,12 +25,25 @@ numjobs=$((5 * LOAD_FACTOR))
 fio_config=$tmp.fio
 fio_out=$tmp.fio.out
 blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+
+# There's a known EIO failure to report collisions between directio and buffered
+# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
+# at here.
+#
+# On NFS, the buffered read in job5 may fail with EBUSY, most likely because
+# the client has to invalidate its page cache before reading a stale file, as
+# the file may have been modified by other jobs doing writes, and that cannot
+# complete while those jobs are mixing direct, buffered and mmap I/O on the same
+# files. Ignore EBUSY on reads for job5 on NFS.
+job5_ignore_error=",EIO"
+[ "$FSTYP" = "nfs" ] && job5_ignore_error="EBUSY,EIO"
 cat >$fio_config <<EOF
 [global]
 bs=8k
 iodepth=$iodepth
 iodepth_batch=$iodepth_batch
 randrepeat=1
+ignore_error=,EIO
 size=1m
 directory=$SCRATCH_MNT
 numjobs=$numjobs
@@ -57,6 +70,7 @@ direct=1
 rw=randwrite
 filename=file1:file2
 [job5]
+ignore_error=$job5_ignore_error
 bs=1k
 ioengine=sync
 rw=randread
@@ -86,10 +100,7 @@ echo 'bs=$pagesize' >> $fio_config
 
 _require_fio $fio_config
 
-# There's a known EIO failure to report collisions between directio and buffered
-# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
-# at here.
-$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
+$FIO_PROG $fio_config --output=$fio_out
 cat $fio_out >> $seqres.full
 echo "Silence is golden"
 
-- 
2.51.0

