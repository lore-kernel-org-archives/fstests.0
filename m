Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BD4689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683595; cv=none; b=spVWLasAJSLWWO+16RJKK0wVCretE1DBmKMDSfd9ynLkuJH1DlbLIE1TiN34+LrunT4zxIC651Sx+jsFtYLE8oVfM1HyOSo2ke7e075iEnpdyZP1QCdJXHBi1kHgC9YMGwr8SiWF4TTYCezw9UPH0YrFoFxyExB8STBIzH0rFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683595; c=relaxed/simple;
	bh=qsDOs90tbFKMkSjFD1vivH1yiHV45TVQJboqPfYUnqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmT5F2s1Mtem61o/HBabmeSVYc8qZVn8Gba0/0j99i3lTh81jx5exxlscRwFvFPuAOTp3SJo1quiBttqK9KkrsWd+9YnZC/hHlEOPSDhWbEeY7+e81JT9Epresjrzz1WCQdvjRbqZOBfKwy2LZgdzkZymXnKDQvp0HzZW3qrwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=m9vY94EW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="m9vY94EW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso4007096a12.1
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683593; x=1733288393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yaChzPeUEEdvJppXsfSKvUUHFTUb2ECavr4EKnFcoA=;
        b=m9vY94EWpTzPNFaCSQXPr/IVMPLY7I6eZIFVEn4nGg+ggXryz1FzYvcxDSyDERzw6X
         ashuHgOonPnyoKqxDgLu4iAvkT/cjE8GEUREZUg7yQGwUzexORF62opmgTn9ft/hjTER
         7BxtMmhSmh1Uv3Lkx7DUSn55a5cYDrl/SbW84E3v2lDyaLrwYUEp38LnPzqezuSFzZ02
         N9hAdv9VdOTJsmv2KFbh+0sTXADIGSXUFlc/aTyQ0ReQXYaFkW7epoyicStdcxXlT1vT
         5sTmeGcM5n59NqyFPShddF9FXRpfiR/MS3Ruy9BPGHkdB+5e+cYLkr7O46WS/CRgYZC1
         LXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683593; x=1733288393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yaChzPeUEEdvJppXsfSKvUUHFTUb2ECavr4EKnFcoA=;
        b=f9A7Xp8RMMsoeSoJQz6YmPzuXePv3In3NuVgkIf4PA1XEuD6vk+I2PbAQiFjmepO0b
         7Z+Dg+bpiG0v7VaV1ovesxCdfNzv5rKH5dJdsPvfxIQdIF6sZw2WfMB43oU8v/euMGg9
         lY3OHGWA5X/aYGvri4Vniqc/nurvPuW3DtTzaczhlo5VGW675Jk325nOvbYTvszarZUe
         9fkTYnpWbvx2AvWjHpAreFuJSf8n8qMwQXjJz8LIlPgsZhgXMA6C1Qffu0Mi/L7Gmwm8
         E32h/e+97cpufw3k9m50XavsUCi56GoyaTrK1jecKbBv2JI/OXP/BH25rPMxIU/ONEIW
         wlYg==
X-Gm-Message-State: AOJu0YxBAZ1+hNWhOL6akHtL3kMiVVj4O0tarwv4LSJioCAPY02+qAtO
	4yCDMgDUlfZXrT6d3TcbqutXVHwcK8L7QZRvmUOS8bVkt1O9O8IgGQPSI/2P+3SKAx2LU80Z2A0
	h
X-Gm-Gg: ASbGncuT9R+oXxaCrE7ldCZ1vknKlwT0gr7gMJ1dUJtwE2F60Gi5r3ForJrJpbJUmsE
	BCYndKy2xf8P2EH6asiYS5jcdClUzp/GeJuz4PDl/dQu7Wl6TXvydrg+u1ifmVP8IiI1CV4YPvE
	4WWh6iKULw72/8oaNTU59In7/pTTAO5FgznPhn9uSry6dxwxIYBHD7AuMbvJwcSZ8FZzP07/uOP
	qwsuOU3swagarJAhVNzj8zs89xCSxDaKZ8IpgvrhpB5ck0KGSIkZZqFf9m1m+jb1Xpa1zZTjCOK
	zSF8RNSpV9SR6A==
X-Google-Smtp-Source: AGHT+IHw5xEbqQPAJBYoNNJducw7cpe9kL5Qa7E3RkSuXdyM20RYDNWTVMNyyVfhKpmi3lQkPC5lRw==
X-Received: by 2002:a05:6a20:430d:b0:1e0:d24f:743b with SMTP id adf61e73a8af0-1e0e0b10809mr2565391637.21.1732683593557;
        Tue, 26 Nov 2024 20:59:53 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e831919csm8743131b3a.21.2024.11.26.20.59.52
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:59:52 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVd-37MU
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfh-3cNp
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 28/40] filters: add a filter that accepts EIO instead of other errors
Date: Wed, 27 Nov 2024 15:51:58 +1100
Message-ID: <20241127045403.3665299-29-david@fromorbit.com>
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

Running a dm-flakey or dm-error test that loads a table that returns
EIO to all IO and then running a command that is expected to fail
with a specific error is racy.

If there is memory pressure at the same time that the table is
loaded, cached inodes can be turfed from memory and the command then
needs to read the inode it is about to act on from disk again. This
results in the inode read getting EIO and failing (e.g. xfs_io will
return a stat() error) rather than having the desired operation
fail.

This results in spurious test failures that look like this:

generic/331       - output mismatch (see /mnt/xfs/runner-41/results-2024-11-20-10:57:31/xfs/generic/331.out.bad)
    --- tests/generic/331.out   2022-12-21 15:53:25.487044098 +1100
    +++ /mnt/xfs/runner-41/results-2024-11-20-10:57:31/xfs/generic/331.out.bad  2024-11-20 11:02:12.123572607 +1100
    @@ -5,7 +5,8 @@
     1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-331/file1
     1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-331/file2
     CoW and unmount
    -fdatasync: Input/output error
    +/mnt/xfs/runner-41/scratch/test-331/file2: Input/output error
    +stat: Input/output error
     Compare files
    ...

Add a new "flakey EIO filter" that will catch -any- EIO error from
the command and change it to the error we expected to see.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/filter     | 9 +++++++++
 tests/btrfs/160   | 3 ++-
 tests/generic/252 | 3 ++-
 tests/generic/329 | 3 ++-
 tests/generic/331 | 5 +++--
 tests/generic/484 | 3 ++-
 tests/generic/743 | 4 +++-
 tests/xfs/237     | 3 ++-
 tests/xfs/240     | 5 +++--
 9 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/common/filter b/common/filter
index 6a509d8b5..7e02ded37 100644
--- a/common/filter
+++ b/common/filter
@@ -662,5 +662,14 @@ _filter_trailing_whitespace()
 	sed -E -e "s/\s+$//"
 }
 
+# Catch -any- EIO error regardless of it's source and replace it with the
+# supplied error message.
+_filter_flakey_EIO()
+{
+	local message="$*"
+
+	sed -e "s#.*: Input\/output error#$message#"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/160 b/tests/btrfs/160
index 04ed1f176..c4a01d330 100755
--- a/tests/btrfs/160
+++ b/tests/btrfs/160
@@ -66,7 +66,8 @@ _dmerror_load_working_table
 
 # open again and call fsync
 echo "The following fsync should fail with EIO:"
-$XFS_IO_PROG -c fsync $testfile
+$XFS_IO_PROG -c fsync $testfile |& \
+		_filter_flakey_EIO "fsync: Input/output error"
 echo "done"
 
 # close file
diff --git a/tests/generic/252 b/tests/generic/252
index ddf950e34..2ad0524c2 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -66,7 +66,8 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 _scratch_sync
 _dmerror_load_error_table
-$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 |& \
+		_filter_flakey_EIO "write missed bytes expect 8388608 got 0"
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/generic/329 b/tests/generic/329
index e4300f92c..96a5ad54c 100755
--- a/tests/generic/329
+++ b/tests/generic/329
@@ -59,7 +59,8 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 _scratch_sync
 _dmerror_load_error_table
-$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 |& \
+		_filter_flakey_EIO "write missed bytes expect 8388608 got 0"
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/generic/331 b/tests/generic/331
index fe12ec4eb..704bb1283 100755
--- a/tests/generic/331
+++ b/tests/generic/331
@@ -59,8 +59,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 _scratch_sync
 _dmerror_load_error_table
-$AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
-$XFS_IO_PROG -c "fdatasync" $testdir/file2
+$AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full 2>&1
+$XFS_IO_PROG -c "fdatasync" $testdir/file2 |& \
+		_filter_flakey_EIO "fdatasync: Input/output error"
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/generic/484 b/tests/generic/484
index 09c2c5598..ec50735a5 100755
--- a/tests/generic/484
+++ b/tests/generic/484
@@ -54,7 +54,8 @@ $XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
 _dmerror_load_error_table
 
 # rewrite the data and call fdatasync
-$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile
+$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile |& \
+		_filter_flakey_EIO "fdatasync: Input/output error"
 
 # heal the device error
 _dmerror_load_working_table
diff --git a/tests/generic/743 b/tests/generic/743
index 228ba764e..efdeec82d 100755
--- a/tests/generic/743
+++ b/tests/generic/743
@@ -21,6 +21,7 @@ _cleanup()
 }
 
 # Import common functions.
+. ./common/filter
 . ./common/dmerror
 
 _fixed_by_kernel_commit 631426ba1d45 \
@@ -55,7 +56,8 @@ _dmerror_mount
 stat "$SCRATCH_MNT/a" >> $seqres.full
 echo read with IO errors
 _dmerror_load_error_table
-$TIMEOUT_PROG -s KILL 10s $XFS_IO_PROG -c "mmap -r 0 $filesz" -c "madvise -R 0 $filesz" "$SCRATCH_MNT/a"
+$TIMEOUT_PROG -s KILL 10s $XFS_IO_PROG -c "mmap -r 0 $filesz" -c "madvise -R 0 $filesz" "$SCRATCH_MNT/a" |& \
+		_filter_flakey_EIO "madvise: Bad address"
 _dmerror_load_working_table
 
 # success, all done
diff --git a/tests/xfs/237 b/tests/xfs/237
index 91f56d6c1..eb5dc5d2f 100755
--- a/tests/xfs/237
+++ b/tests/xfs/237
@@ -68,7 +68,8 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 _scratch_sync
 _dmerror_load_error_table
-$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
+$AIO_TEST -a $alignment -f DIRECT -b $bufsize $TEST_DIR/moo $testdir/file2 |& \
+		_filter_flakey_EIO "write missed bytes expect 8388608 got 0"
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/xfs/240 b/tests/xfs/240
index e95cf3f5d..8916828a8 100755
--- a/tests/xfs/240
+++ b/tests/xfs/240
@@ -64,8 +64,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 $bufsize 1" $testdir/file2 >> $seqres.full
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $TEST_DIR/moo >> $seqres.full
 _scratch_sync
 _dmerror_load_error_table
-$AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full
-$XFS_IO_PROG -c "fdatasync" $testdir/file2
+$AIO_TEST -b $bufsize $TEST_DIR/moo $testdir/file2 >> $seqres.full 2>&1
+$XFS_IO_PROG -c "fdatasync" $testdir/file2 |& \
+		_filter_flakey_EIO "fdatasync: Input/output error"
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
-- 
2.45.2

