Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42D2DC76E
	for <fstests@vger.kernel.org>; Mon, 13 Oct 2025 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334063; cv=none; b=YqiyDZQL8MnZAtL/2QSJriOKpKDKhwSFh+rlYsdIF5KKbe01a2d0arloMMPphxEP7RkSF3f5o/rnKZxdS9CwjRrGFNY8MwjjQi4mO9Wm2JCO6fJZLS70kzlkrW4N+NKAP6mF3TMYyZo0tJSOPV5NGzr91Nmft1ZnW8Xvuzu8RaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334063; c=relaxed/simple;
	bh=TUuiJQIkx4zApOps7CqiBiHdmhJj+mMM/kZdcnCoeYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7ksP7E/G29K5qT6RVEAsEzVQgEgyu5Q6OW5yTU5zy4+zLHDcWpRy4mnBxsFdjD/ieRxgFZQTco89Sf28/g4dHpfNn39EViIdMgbyb8a9lpX9zuRBV9C4CFLbo+Fe46wNAoo5Ix5WTTladlyNrh/sPsszugbYroVDUz+/40JXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxUIDS3W; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxUIDS3W"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so3726374a91.2
        for <fstests@vger.kernel.org>; Sun, 12 Oct 2025 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334060; x=1760938860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLK9qO1/R6EGWIZqb2TUkVvkexP9qyEFErwjwtz/uPc=;
        b=cxUIDS3WW7f9pEf+Ezvce7Q+906+2dkdOswXK/YwP0BIlhN5oYe7Qvnx5WuC4BPv7P
         xqYll7aBKL45vGviQpb5xHUsxT3Y4tCfzFFhJBRMSl+aXbTBntxODH77CSqFo97aFHtj
         PhlrYaih4/HO9kKSYmQUT+Zb7J4iRzLubUnOrQ218KGH3fekCW4AvNFmKy9ktQpZeTP/
         SvI+R97MIxwXjo0hnTC/B67YinhhEmntQL2XxsXFvPm5MAlEAQl4xVoHKmXDYSCf4JmX
         PMcpmmKVSDMZ6BSWJIt5tRt2qS/hkA6rJakE19xrgrXKNm4H10n35S5g2o+GUS67arC/
         NS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334060; x=1760938860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLK9qO1/R6EGWIZqb2TUkVvkexP9qyEFErwjwtz/uPc=;
        b=XEu6L6O5Y/JDxmQZ0+GUOOqVrdx9TJDi2Lg5AMTzU11k7khqttUTnrOk4mys5FfR34
         7a4KzsrH9m5meR1prUqfYd66eTc6S2hQqH3i8dQPbTFEH5Uq6MbqUF8XtaJVIjhlYKLG
         k8F5i06KDE+hqR4+wIm/gH0/gMXSxL0vtwM341ZncExfy0YG+5bmTpOEqwfgupuCJYzp
         4JkME8JtQKGYdzAK946gMS1xnQ8VDlUttNf5USzGRLxpRMzBCD8KB82l/Nm9n052MHun
         dDzOzKajMTJdjGB89VYsRz6V/fbiKC+RYkxrASlzPmtYRJhzqfMrJAXTWrlNZLdY0yJ0
         H6Ig==
X-Gm-Message-State: AOJu0YwYHpP8lEQIHzZIKoEBzXRdFyyofCOOSWo2tUsqBi1JQcVDPL7H
	AOdJDHHu01R9ZCRzXaqUHJ7pwon3dEVaS525OcKtD2VlQUA8rU5M1DxbosUuHcBX
X-Gm-Gg: ASbGncvtvkrCmPpfhCmIJboMVCxN8lfkHjIa4OA12afV7ASnL/81UgsfhZDYUxKYdeR
	aj7YviBMnpr4GAgao0bckxNb+Ez1cEx7yWEmOoYi94DSssR8pU9/92P5ZjkLNTBo2+o2McWn8Dx
	MB3Hz6wRMFi9ElT4gUHPDF5fyeLSKzE+1FgG9eb5N7oG2mFmnazyb/MVUfrUYO3kSdH4IB4Gw4L
	KBkV7XOdmY0LQlNSNxGWDnOac84+vE6MjwHmL532XNxyD9ck/66bUxvxRy/JRNBNg1oM8AQnEqx
	LGG0N/JjwbJ2PokQD8h3CxPm92vd30ToNZz1cAlLsrZLhSafWsizUsoZR3mheJUeQQNAuz53kTT
	6oDaQWfrd5CqM1vFuRzWjQevQKgCV77oWKuR3AWdnuKUFWAF8XemGQUGI
X-Google-Smtp-Source: AGHT+IHale/kMoCEjDjftg6c7JJvs9/sTJT07ULkXW/Ljncj+bc0Mdn9ws/VjBTkV2yajYv6SeF/YA==
X-Received: by 2002:a17:90b:1b4c:b0:32e:4924:6902 with SMTP id 98e67ed59e1d1-33b511496d1mr30128320a91.3.1760334060485;
        Sun, 12 Oct 2025 22:41:00 -0700 (PDT)
Received: from citest-1.. ([49.207.231.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52968581sm7014726a91.4.2025.10.12.22.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:41:00 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH v2 2/3] btrfs/200: Make the test compatible with all supported block sizes
Date: Mon, 13 Oct 2025 05:39:43 +0000
Message-Id: <aa7dd84c98a5042f36639bc99c46302d6b22fdc0.1760332925.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
References: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test fails on 64k block size with the following error:

     At snapshot incr
     OK
     OK
    +File foo does not have 2 shared extents in the base snapshot
    +/mnt/scratch/base/foo:
    +   0: [0..255]: 26624..26879
    +File foo does not have 2 shared extents in the incr snapshot

So, basically after btrfs receive, the file /mnt/scratch/base/foo
doesn't have any shared extents in the base snapshot.
The reason is that during btrfs send, the extents are not cloned
and instead they are written.
The following condition is responsible for the above behavior

in function clone_range():

	/*
	 * Prevent cloning from a zero offset with a length matching the sector
	 * size because in some scenarios this will make the receiver fail.
	 *
	 * For example, if in the source filesystem the extent at offset 0
	 * has a length of sectorsize and it was written using direct IO, then
	 * it can never be an inline extent (even if compression is enabled).
	 * Then this extent can be cloned in the original filesystem to a non
	 * zero file offset, but it may not be possible to clone in the
	 * destination filesystem because it can be inlined due to compression
	 * on the destination filesystem (as the receiver's write operations are
	 * always done using buffered IO). The same happens when the original
	 * filesystem does not have compression enabled but the destination
	 * filesystem has.
	 */
	if (clone_root->offset == 0 &&
	    len == sctx->send_root->fs_info->sectorsize)
		return send_extent_data(sctx, dst_path, offset, len);

Since we are cloning from the first half [0 to 64k), clone_root->offset = 0
and len = 64k which is the sectorsize (sctx->send_root->fs_info->sectorsize).
Fix this by increasing the file size and offsets to 128k so that
len == sctx->send_root->fs_info->sectorsize is not true.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/200     | 8 ++++----
 tests/btrfs/200.out | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/200 b/tests/btrfs/200
index e62937a4..b53955ce 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -38,14 +38,14 @@ _scratch_mount
 # Create our first test file, which has an extent that is shared only with
 # itself and no other files. We want to verify a full send operation will
 # clone the extent.
-$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
+$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 128K 0 128K" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 128K 128K" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
 
 # Create out second test file which initially, for the first send operation,
 # only has a single extent that is not shared.
-$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
+$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 128K 0 128K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
@@ -56,7 +56,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 # Now clone the existing extent in file bar to itself at a different offset.
 # We want to verify the incremental send operation below will issue a clone
 # operation instead of a write operation.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 128K 128K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
index 306d9b24..a33b3c1e 100644
--- a/tests/btrfs/200.out
+++ b/tests/btrfs/200.out
@@ -1,12 +1,12 @@
 QA output created by 200
-wrote 65536/65536 bytes at offset 0
+wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 65536/65536 bytes at offset 65536
+linked 131072/131072 bytes at offset 131072
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 0
+wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/base
-linked 65536/65536 bytes at offset 65536
+linked 131072/131072 bytes at offset 131072
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/incr
 At subvol base
-- 
2.34.1

