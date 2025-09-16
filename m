Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7144148FE6
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036659; cv=none; b=k6kkolj2fc41WYcWuV69Y3XGhZoERs5+0Lporwybx2ueXjmWySzIBgimnRJrA7DtU7pzW9zjW1Y4PAz5XJFu7q327Pi1bafwxxQOAVPMTRCuHFNYpS2O4RYLabLuv8UK7rs+aaEBdFhXtIWniwhcz/xqqCk6clu9tVAsto1Jy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036659; c=relaxed/simple;
	bh=/SHF8T1BS5Yuf5s5KbolLu+jnbm5+flf3+dWSrjb4YM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J155BJozB/5yM1F67f0nIFKAdGHb/EaME2NoqZHACU3Gr0b+mauDz3DzFGg48C1KBFGY3qCIdRYqPaz8UGtDQZ5zALENl+AA3ru0c7905EgLDSFe54YHbW33RmD5h9y5rlO/ZUCk6vEKV27H+xGuvyZC4pPzlPy1XruboY/phOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHqy2ddn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHqy2ddn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267dff524d1so5030465ad.3
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036657; x=1758641457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8tSDZS9meM+e6Erxqg3+0lZ4IPQ+QLv8Njp3Yg3YWg=;
        b=HHqy2ddnDndwTsOqJ9xqsHHoUseXV1UuKaSLExSU26jcu9ZF80Zxtkhc8pqtmS5El/
         PhM59T3magRKzIPD/ICdKQwp41dRsglKa7Ool0nHJCF127027eokgqmPIab6FGlYYgS+
         KEylPKevmVDKEK041BLXpeSaUMvIYYgKp5t4WBMuQY9eATpCWjetA5/Hx6FV7kPL3zwg
         z/uJzxZw0xiK66OalF5+esie7sJxq0WQHkJjXid/yolc92XdSevjQSn6qB00A3D93DhP
         3D+5Yb6SgkdnkaxEI/oWW+97paDNOwoYeMJ/mWSLy93gOObH7sd+HIMHVaJ9LKNJONcZ
         Dx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036657; x=1758641457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8tSDZS9meM+e6Erxqg3+0lZ4IPQ+QLv8Njp3Yg3YWg=;
        b=rZ6TU52X2lLO9SZ9ZxRRlN5JIAyKX74Oakao/4qPEhPQIDVMpreY7XCXAhHs1uzNLf
         DvDqRJhjK5zVmMiUyYIyBoRRBVJezXL9HjJT4GQj5GxL8aR7Kzk8YziQpCfPjMN70Ve5
         qYgTXeKEFYuKUmXVw4EAH8qNAYIDPeUkfD1PGSi7v2hoQQnt6HlNw6YOHZAKBLiDeeeo
         eiqrVkSbv1JAWbx/bWkfwq1xzgww/FQxngCa+0+nEaSeYczAU0DOYwvc1ICZqhGlDcGk
         JSPu/eMT2lxjWRjT1FMmIZqF8szri/6Zc2meKT3+fn4bdgKEIgW2uY8WL7FFqa5Q4Qe+
         gVqQ==
X-Gm-Message-State: AOJu0YzHfe71Oq/OBAi3zOl0BV9gsFo6gxE9WM/m7iQrnSD84qmU4V06
	FC7/c70I2smcqtHNRR77L2GabAFZFSdEgIaz6jEi4XaExiLHtMFekJ7xRnWYeA==
X-Gm-Gg: ASbGncsDJYz939DkS0C8QMzAO9Eyj3SRGGomXDL3rXl/J25LQmCYwa2HqxC6so6WatM
	gF12/IsSAB6ZCmozk6//RMy+jLp6FIo/Nr6hxGIQqtM8o0KLsYFVnkPpkBFICExclgQZFkGlkVZ
	KgCX9HcQIWTwwKJGp6a9KQrjwUBAVvPW3V/R20w7V4oQnfupfzUJxxxABPN73eiEsMH4+THhQyV
	vZQZ1td7OcUsDrIbtY8tdyCvRlAeD+Nm0FwhvUg+hSOMpihs/1XN+pePaiQb5X9YNBs5rLbzOkE
	JL/GZIHtqxcdJuVEUAcZWqThWsktTLJXajpdcOJs0SwhnWTnGH2jtwlVeAM9ckopXR3QFqFIg0O
	3GtsCBf9pk5X7uEBYI9P6FX7pzGw=
X-Google-Smtp-Source: AGHT+IGiu/eXW0BLonejX1Hv7k0QYGVKrGhLgm0msqaOyGK+XI/6A5T075ui//VQegUxY6V+c6tajQ==
X-Received: by 2002:a17:903:41c4:b0:262:f626:d516 with SMTP id d9443c01a7336-262f626d6b0mr159399155ad.20.1758036656790;
        Tue, 16 Sep 2025 08:30:56 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-262df893ec5sm92596345ad.46.2025.09.16.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:30:56 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH 1/4] generic/371: Fix the test to be compatible block sizes upto 64k
Date: Tue, 16 Sep 2025 15:30:09 +0000
Message-Id: <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
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

When this test was ran with btrfs with 64k sector/block size, it
failed with

     QA output created by 371
     Silence is golden
    +fallocate: No space left on device
    +pwrite: No space left on device
    +fallocate: No space left on device
    +pwrite: No space left on device
    +pwrite: No space left on device
    ...

This is what is going on:

Let us see the following set of operations:

--- With 4k sector size ---
$ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
$ mount /dev/loop0 /mnt1/scratch/
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M  1.5M  175M   1% /mnt1/scratch

$ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
wrote 83886080/83886080 bytes at offset 0
80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)

$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M  1.5M  175M   1% /mnt1/scratch

$ sync
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M   82M   95M  47% /mnt1/scratch

$ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
wrote 83886080/83886080 bytes at offset 0
80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)

$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M  137M   40M  78% /mnt1/scratch

$ sync
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M  162M   15M  92% /mnt1/scratch

Now let us repeat with 64k sector size
--- With 64k sector size ---
$ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
$ mount /dev/loop0 /mnt1/scratch/
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M   24M  175M  12% /mnt1/scratch

$ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
wrote 83886080/83886080 bytes at offset 0
80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
$
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M   24M  175M  12% /mnt1/scratch

$ sync
$ df -h /dev/loop0
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop0      256M  104M   95M  53% /mnt1/scratch

$ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
pwrite: No space left on device

Now, we can see that with 64k node size, 256M is not sufficient
to hold 2 files worth 80M. For 64k, we can also see that the initial
space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
because of higher node size, more metadata space is getting used.
This test requires the size of the filesystem to be at least capable
to hold 2 80M files.
Fix this by increasing the fs size from 256M to 330M.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/371 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/371 b/tests/generic/371
index b312c450..95af308e 100755
--- a/tests/generic/371
+++ b/tests/generic/371
@@ -19,7 +19,7 @@ _require_scratch
 _require_xfs_io_command "falloc"
 test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
 
-_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 
 # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
-- 
2.34.1

