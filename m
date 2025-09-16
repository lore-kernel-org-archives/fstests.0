Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222D2D374D
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036693; cv=none; b=O8EeDXw3E5e5XE7h4Cj5s3WlelqZbJkJNIf5br6Pgik/JFxquLcKXTAy5MP0Ue5MGbOmpI3Q3KFVB3CEliJBrZrI/myJc4OeqHxg6yziacpSSZSWi5eaeUUTIXMWnj8svyE0LqEyHQ5CnWAq5Q8JESEXo1y3oPBP35Y32NyY7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036693; c=relaxed/simple;
	bh=zaZoU0Qso1Szx/vlyuH+85wTOC7wyjLM4UAotYIF1es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dplch5EftxyuSGJKku0iw0JtKDTA0SeheT7XuDehMGu8pvooMZDe9Sv7uaqF79J7+yiayX+XqhYcUQ0lniAUbIizYe5oqxaUxZSf6UfVVafiVJJMCt9H9sIY/+qm+RbGbv4UWA8UXnvkyUQu8oI9p8Nm6fIAHPHE8mNLFPwpi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h68U44oF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h68U44oF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267a5aeb9f1so13813345ad.1
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036691; x=1758641491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIxJg5ZvqXF1bRYs87RyyTt4kjjoPjsGftdBYdeWjyQ=;
        b=h68U44oF/WdC8HhNIKcy27EPm1nQ4Z7+HfJuiMh3If+3Ae3rX2wxw4zLwqWG5bW4Ja
         yN9U0lM9GXFbzaBJJlK8U4mL+7D3iHzfSgTOXCc9cPln2yCmDweeiPoUx8lsjIVtdpbV
         ydgDjowc/isN/TpgDtCK3ItynqVqs8254ad46u58frPztojajdvxekidEMMOkRYgY+FF
         EBbv1wpEyOaD0P0gPTr70+8L0OfKBGDog472UWUy+ncmGAStjAooV3x4teT2v17KQyJ0
         9sK8TOAe9zALmZVOytPuYDYDYlD7SijdztUCVzklIq8w3F8OJFhCdNPlFazg5nXUDptb
         /4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036691; x=1758641491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIxJg5ZvqXF1bRYs87RyyTt4kjjoPjsGftdBYdeWjyQ=;
        b=I43E4tH2HOTDpmuQEssKXzNb+yAdLRnf1FiADIGgalD2/G5rSFUzjmO96wa5zcitYm
         ErnoUF/jl9YMczLnAss9eWk3y11kd1hLepHbw8k/h1rM/Tk368M7e5eb1vTHNnNsGht9
         G4gapqfYMpvKsFMRkPMlcKj/QHcsG4B57adkGxVSJZ1vHXhw1Zxtf1fHAd/gKFPb0A/O
         /xelTDFRLdibPi/R7h9SrW2Pi2OnEoAo9GELIakWQnFPtS6R1ArndQ+/KWj3wzeetawf
         RYhHQIXGc+yOrJiHm1mZ+FsDtK1o6jPZuzs73DgLGUnhlXNf0oJ+0tlZbA/gPM8rr1yc
         BbqQ==
X-Gm-Message-State: AOJu0YyNgtnJpDl9P/c+8jsPSe6mgQPMLPaBsKblC6BYJhDkmqBRvEee
	3D0XSMhP8GO9BFA95YHExDKUksSphlcTW+imq0Tehc3nVmEw4n1nZLGhIPuNxA==
X-Gm-Gg: ASbGncvFYWO/20euyZqVC8yte5V81uOYteux2Ndd15LtSoTnQRWfeTw6SaSG1ilpb0w
	UqySL7d3hDqKmFmwheA9X1dy2pF3CRTdi1J8D+bRCN2Od5oNocwMd7NByAc9P/2nUCbian4RjeK
	10SfDHEdzAq89JV2L57N2N740v+KwU9qjnYBjf0MXun6yGHNIZHHHLjCqP6/o1x1Nm7nlVvDYiL
	qOzeRPuTi6/8mx+3sDlQjl+7pPgeW2obqL/RtGODOgwPfscwTZPrjqo2CQvSxlhBCSHl0j22CfP
	dmZ7l8mLfm2TsZ1N1GtCHkrjDC18s03i6QELOz4Dpo3d4604kDqqUzekJqJos0g/Yc7C8Yv6z03
	eH0mtDZYDIfbLLOnd3DR08ox8aT4=
X-Google-Smtp-Source: AGHT+IFUGE2o0g2t+JDzAz/9GyPXcdUUikY6+HSfFUW1u57B1KMsYrc9xle2pFzVPPa5WGZBtjyZzw==
X-Received: by 2002:a17:903:ac5:b0:248:6d1a:4304 with SMTP id d9443c01a7336-25d26864a11mr187408325ad.38.1758036691204;
        Tue, 16 Sep 2025 08:31:31 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-262df893ec5sm92596345ad.46.2025.09.16.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:31:30 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH 3/4] btrfs/200: Make the test compatible with all supported block sizes
Date: Tue, 16 Sep 2025 15:30:11 +0000
Message-Id: <c93a0f1885721e7bc2800094fafb7fd7bd2c607b.1758036285.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
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

