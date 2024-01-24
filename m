Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40347A725
	for <fstests@vger.kernel.org>; Wed, 24 Jan 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112318; cv=none; b=CDCbVqBJtY1J6Uae8skGXzhLtjU9eXOjlj493DGlVbcqaWsnPy6nz6kz/7za4zwYzw0QpJVjqPDoHQMgz1pV3FcPIEPhQFO8KSjKZAP17cgGnrr2xoANqd9q6P1x5II/CNPYYGamA+9i4IHZ/ghh88zZSWPQG7Od4hpI4fwPNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112318; c=relaxed/simple;
	bh=gxrNZk8iIvXxogGnQy/wfYh59BE5AHGblMMRweEkF2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rsryZxOFMtUITt/NG0m48L6RE09r6pZJlDRw1xaiAW6pX7Dfxrfs72nxKfm8Sg/YQ9CZTrjqtiq2yDEzVaLkS9tCJ0THUaQ7qhdUC7pAXy5JkFVPDi3K9veRkoNZcV8pLN5cgbGA6OzZip1Iy2+kAOZB+65dc0cphIx90lTRApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Nf1WnoZm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Nf1WnoZm"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6029b5946f5so6085847b3.1
        for <fstests@vger.kernel.org>; Wed, 24 Jan 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706112315; x=1706717115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NiZN5L2vI708v8uAeqXBqzLI7H6F+JAbzEvl/HlMjSk=;
        b=Nf1WnoZmdBKoNV61ox/dUl/rMw95xiJ0kBVEgvWSim+0/Ct0fASfxd72rGxRl9tjW3
         mm44yKljdCNzuyeKeZJl2RvlvDJ9PqDgn4n37wjyH9oDAtHbAHIo0eaWp3FCNpNLnoMW
         fukSFpX8gLaH3Cwts0Mz1hmWIJSks5euLz01kXNXVhYpw7HzVV7eyT5DEKKzuvspn8/R
         fJ7RqR9o38hnyrR2SavbY7Ss5NKXMooSJmg9H6xmwDEti1hHW5gdN2ryaypvQOSMmqpG
         7RmKrFnh7GeKr0//goFTb7FBo+96lSA3OHDD8dAlJHSu1NgxqtvtHHHPbjKhLJbvwWdy
         eRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706112315; x=1706717115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiZN5L2vI708v8uAeqXBqzLI7H6F+JAbzEvl/HlMjSk=;
        b=ptbrVRVyuyQmzTtVT6ZyV3LQQW7ehGNf8MMJ/tuRXiKpjZO9NVKOzRrNa0ZNAQoq8d
         inFnpGJ1fi83Fn8MQAPoeNP4d1aabNKZGBGHDqctYdVEOfrTxYIN5ZEnoX9O1tSt3Uyj
         XwcOeiyJa0FxpQnZ8Ij66L50YZvwm3Z/ENYUHrrYmftwEblB5gOc7+xCJuYjOa6C/0sQ
         48jx5/sN8EOW1alxryWSmmDha22Tx7zKFTV5ODDQyWJdgiPxXIG5ivQ3ZEmqpoWKsIhS
         iEjk3SzJPmnzoC9buVL+tpAGQC/yOR1TzEFFha6Qf8kExNPNI7o6F8LEqu8W+v94x/tN
         dcdQ==
X-Gm-Message-State: AOJu0YzlD0XAts+/CuBKec25zOYpGXYtsUe6DyLDtdOL7JECqR7Rno73
	5DVpMnVLkkyEezT9/vIiTgHZxGY4eAnhHR3KQPWjrh76QIa+QW9wsJW5GD6B+Gw=
X-Google-Smtp-Source: AGHT+IGzSH8z49IgamUbf46eh/8vLXqcmsjU/9Yw2HWdL8tBPJqW21v7pSh8OT02wcyDzGIBZwvkZw==
X-Received: by 2002:a0d:e903:0:b0:600:2220:d7fe with SMTP id s3-20020a0de903000000b006002220d7femr651110ywe.13.1706112315518;
        Wed, 24 Jan 2024 08:05:15 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ey1-20020a05690c300100b005ffcb4765c9sm22369ywb.28.2024.01.24.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:05:15 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] fstests: make read-repair tests md5sum the data
Date: Wed, 24 Jan 2024 11:05:10 -0500
Message-ID: <c5d3e27fd544b2ecb1a4b374f500314c1b7b9c56.1706112305.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For validating that read repair works properly we corrupt one mirror and
then read back the physical location after we do a direct or buffered
read on the mounted file system and then unmount the file system.  The
golden output expects all a's, however with encryption this will
obviously not be the case.

However I still broke read repair, so these tests are quite valuable.
Fix them to dump the on disk values to a temporary file and then md5sum
the files, and then validate the md5sum to make sure the read repair
worked properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/140     | 15 ++++++++++++++-
 tests/btrfs/140.out | 34 ----------------------------------
 tests/btrfs/141     | 16 +++++++++++++++-
 tests/btrfs/141.out | 34 ----------------------------------
 4 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 247a7356..8e1aafa3 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -77,6 +77,13 @@ devpath=$(get_device_path ${devid})
 
 _scratch_unmount
 
+# Grab the contents of the the area so we can compare to the final part
+orig=$(mktemp)
+$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
+	 _filter_xfs_io_offset > $orig
+origcsum=$(_md5_checksum $orig)
+rm -f $orig
+
 echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
 	>> $seqres.full
 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
@@ -91,10 +98,16 @@ _btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
 _scratch_unmount
 
 # check if the repair works
+final=$(mktemp)
 $XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
-	_filter_xfs_io_offset
+	_filter_xfs_io_offset > $final
+finalcsum=$(_md5_checksum $final)
+rm -f $final
 
 _scratch_dev_pool_put
+
+[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"
+
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
index fb5aa108..58dfb24e 100644
--- a/tests/btrfs/140.out
+++ b/tests/btrfs/140.out
@@ -1,37 +1,3 @@
 QA output created by 140
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-read 512/512 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 90a90d00..41407f90 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -74,6 +74,14 @@ devid=$(get_devid ${logical_in_btrfs} 1)
 devpath=$(get_device_path ${devid})
 
 _scratch_unmount
+
+# Grab the contents of the area so we can compare to the final part
+orig=$(mktemp)
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
+	_filter_xfs_io_offset > $orig
+origcsum=$(_md5_checksum $orig)
+rm -f $orig
+
 echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
 	>> $seqres.full
 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
@@ -88,10 +96,16 @@ _btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
 _scratch_unmount
 
 # check if the repair works
+final=$(mktemp)
 $XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
-	_filter_xfs_io_offset
+	_filter_xfs_io_offset > $final
+finalcsum=$(_md5_checksum $final)
+rm -f $final
 
 _scratch_dev_pool_put
+
+[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"
+
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
index 4b8be189..d8c6940f 100644
--- a/tests/btrfs/141.out
+++ b/tests/btrfs/141.out
@@ -1,37 +1,3 @@
 QA output created by 141
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-read 512/512 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.43.0

