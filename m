Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011504;
	b=tEq9xiw7VhzE8dNJeX3YIVpSqgK2vxfhCu2nRn4VL4sLvEuzGDMFnQcFa6rdTpoi50Bf
	 B4SkjCzxi0KAuVLcW3so1aVpYQWPR5/4S7/LWc1pmiVU7uynt0lM7kB5mRoNQGuPdM2zS
	 sepMWLQhUC0MIBtyDIQC9jQOTm1KJH4+mH6Pei1Cd7s1qGmjqCC/V83PM5KPbP9egKHiB
	 pt7qLXTbkt6Wd/uoQevCp6190OO/hPtAzYBpHpmF2W/WWb+CqowMXs1aS3SBFdz9Git58
	 If4KJmKWdHaJDmHjQeioN5c8Myv7OtUQWycxgCffB58DnwQqQoCNMGMaCOBaAvbF/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 In-Reply-To:References:From:Subject:To:Cc:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LDguwGrSBxdmZQBN3HIv1p+8YUY4bhTPUTj+F2Sw6mA=;
	b=sjNRqoVL8foWFN2uXFwOdCI0jSI70ckgZag8ZbI21Jah5De1VMD789jhi5znYKipWX6f
	 hgpSSpdoiDI5spPmCWLVYeiNreE7rviGEcP+cqUH/NBoRC/Zvg3ukeNKGoHWwz7kUZmgp
	 t1LOxqLX4AsmnTeOuKOojQpLH0mLUYEQPe+UNJx017XZtTIndZvJ+y+JEMSguWZk4wAVW
	 3Ma5y2ONoVstvqeJcHSPICHJEpG3bA3PleSEGZCbc7QhwNOd3RsV2PKue/DYnwqLR1o3Z
	 OPA8L0Zd+CbLjKHrfY6Cd/c/srSl6U86w90zuRTWFYkhxMhUcsjTeBzY095wqa+TQyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=roP2jb5z;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10150606A326
	for <fstests@vger.kernel.org>; Sat,  7 Nov 2026 00:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10150606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=roP2jb5z
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53634b8328eso10476001cf.0
        for <fstests@vger.kernel.org>; Fri, 06 Nov 2026 16:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794011503; x=1794616303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :from:references:in-reply-to:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDguwGrSBxdmZQBN3HIv1p+8YUY4bhTPUTj+F2Sw6mA=;
        b=roP2jb5zXZx4Z/cevpFgeuWFOm0sxH7qfgbxJeR6FAur2B8cbtwDwXTuiCzm4QwqPA
         ZEu8cP0oeV8areKQCinpcBpB/CAWVcnbpS34JpBvYPLmO9Oacrk32wYxbqh5VmCK7mQi
         wOr2LlLETeqqQleSzSf101J0F+wTCMwYR6KSyDN10ACm4bFVQMaNPjP5zI/IkMmB+SA4
         Keyt9706FafjyAtQmSo+RecWasLWtLKm9RnvX8RdfE4unizK/H2ixvZtW5JZDXZef8cR
         TAYL711FeVGsz0FZEbAD7ib01AhWp9pLLgkOWwoWxJBZjbk4mAvn44q74CSJWOFZN8DN
         qSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794011503; x=1794616303;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDguwGrSBxdmZQBN3HIv1p+8YUY4bhTPUTj+F2Sw6mA=;
        b=S+ihnbv0YRXKKlg4879Zcee8T17Revh1t9aFX8nJMNvCYIWVHgrgMliPdWhW0+BGCy
         Gd7blIgHk1VZkkjfcOAJxKNsX4vQp9Eew/1KtOdwQXphRgaqT8RHYIGV/4BGInSKp53o
         vBoE2ZyqVvw6d5wBCIcLGNf6/h1/KREqA4tcPPXCTENcwrYNvqIewR28yKA/enyAmc39
         /xJpGVsBsHSvn18X7827Wgsqbb3fvDpKo4TGPT0lfOUtxZeHdD81cVLwb/oF0XdIOU87
         cZp4I7wFo4jKqVnJtdfyZzQLXP/xvKj4iw2YFwLf7Xxb5CxXd39JKXSXmQXaRC6HczRl
         681Q==
X-Gm-Message-State: APuU4Z9/sLyvNM87r9nCKTSGXJP0947lyNnQrwZxrwIkLkx0GmlUaZu1
	MWuEjTj5/PPellu5nH4JMcqDoNqDSq9c5u/CrV6DMIrME5fSc0ke9q3nRjgIPCmrWXlWc3u+7F7
	WZO8fIThmuw==
X-Gm-Gg: AYBFou0R2YZn3hzha92TW4Y/FGyt/Ftw6ngIbU2SxtGCeuLb4rddjGVKy6AX5X3fL6n
	M9DpnlScf86l2o2vtewopGGmdeRtOiPU9DLTis7Y64rYWYR7nfd4LyIzkqwGpphHy40Lykq2SWz
	YZ6rHQB3eyeP6UlTRPzXQqn1/MiiFdICIKCftAW9vKgwKp1YSxEU4UgRrneol4h5R+ut5WBrP01
	xOtO4bgwg5HmH4XBbO9dAl+JMbloT+lHxSOm6wALoHjgZ6KPcxIZkOhBTZxcRPgNS74V5YxnI9R
	VKHi1B4Gpa7EgPD+XdQnQCs9zWZb0Kn+1dyo1XRe41q9F2F6vP6bPBfh7Pg2EMDRfFC6bwy0jYa
	61hv6E73dCKedghWL7ZSrSpUZXpWRx8Ix8pZFcycQ8+DaXx3RJT/MjBanvwKVEqJzJKERYiX6v5
	U3BXAEkDLOgfrmWyKePUvFQrQzZ8kWsF1LWaRi5BKaHE7Gqu1FDGSUlGqTWZMdxlphG1bdrzHgd
	YXGq295IlGGN5BilfpmpU6VvrwY3UBzQXFNKUCxG7Rab66N4HOkr4qunHaMlMV1OAlDvvKeGEXX
	soMkMi3V+6qnbT7GIf/IRa+vSKyv3khchx/LjFNT0ElHVA==
X-Received: by 2002:a05:622a:2485:b0:53f:a444:dc7c with SMTP id d75a77b69052e-54e156631cemr63284951cf.56.1794011502798;
        Fri, 06 Nov 2026 16:31:42 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26835bf8sm32811911cf.19.2026.11.06.16.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:31:42 -0800 (PST)
Date: Sat, 07 Nov 2026 00:31:41 +0000
Message-ID: <946b46fbf1c555a47a8a9304f2ee31af.josef@toxicpanda.com>
In-Reply-To: <773faf2a275e0a51bd38cf68f492856c.josef@toxicpanda.com>
References: <773faf2a275e0a51bd38cf68f492856c.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH fstests v2] overlay: test that syncfs and unmount persist all
 changes
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
    Amir Goldstein <amir73il@gmail.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-unionfs@vger.kernel.org
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

overlayfs is about to stop syncing the whole upper filesystem on syncfs(2)
and unmount.  With fsync=relaxed it only writes the upper inodes that were
modified through the overlay, so it has to know about all of them.

Modify an overlay in many ways: new files and directories, data and
metadata copy up, stores through a shared mapping, sendfile, copy_range,
an O_TMPFILE, a short and a long symlink, hard links, renames, whiteouts,
a file written before the inode caches are dropped.  Then sync or unmount
the overlay, shut down the base filesystem without flushing its log, cycle
the mounts and check that nothing has changed.

Do that with the default mount options, with every fsync mode that syncs
and with redirect_dir=on,metacopy=on.  Options that the kernel does not
know are skipped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1: https://lore.kernel.org/r/773faf2a275e0a51bd38cf68f492856c.josef@toxicpanda.com

v1->v2:
- Added a symlink that's too long to be stored in the inode. (Christian)

This is for "ovl: only sync what was written through the overlay" [1], Amir
suggested a test like this in his review.

It passes without the series on ext4 and xfs, there it skips fsync=relaxed
and fsync=on, and it passes with the series. With the series and the
function that marks the overlay inode dirty turned into a no-op it fails in
the default, fsync=relaxed and metacopy rounds, the file data is gone.

[1] https://lore.kernel.org/r/20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com

 tests/overlay/118     | 182 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/118.out |   2 +
 2 files changed, 184 insertions(+)
 create mode 100755 tests/overlay/118
 create mode 100644 tests/overlay/118.out

diff --git a/tests/overlay/118 b/tests/overlay/118
new file mode 100755
index 00000000..f9c98eff
--- /dev/null
+++ b/tests/overlay/118
@@ -0,0 +1,182 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Josef Bacik.  All Rights Reserved.
+#
+# FS QA Test 118
+#
+# Test that syncfs(2) on an overlay, and unmounting one, persist everything
+# that was modified through it.
+#
+# overlayfs used to sync the whole upper filesystem for that.  With
+# fsync=relaxed it only writes the upper inodes that were modified through this
+# overlay, so it has to know about all of them.
+#
+# Modify the overlay in every way we can think of, sync it, shut down the base
+# filesystem without flushing its log, cycle the mounts and check that nothing
+# has changed.
+#
+. ./common/preamble
+_begin_fstest auto quick shutdown copyup whiteout mmap redirect metacopy
+
+. ./common/attr
+
+_require_scratch
+_require_scratch_shutdown
+_require_metadata_journaling $SCRATCH_DEV
+_require_xfs_io_command "syncfs"
+_require_xfs_io_command "sendfile"
+_require_xfs_io_command "copy_range"
+_require_xfs_io_command "-T"
+_require_xfs_io_command "flink"
+_require_attrs
+_require_chown
+_require_mknod
+# These never sync
+_exclude_scratch_mount_option "volatile" "fsync=off"
+
+lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
+
+create_lower()
+{
+	local f
+
+	# This leaves the base filesystem mounted
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	mkdir -p $lowerdir/dir $lowerdir/rmdir $lowerdir/mvdir
+	for f in append truncate mmap chmod chown chown_append xattr link \
+		 rename remove dir/append rmdir/file mvdir/file; do
+		$XFS_IO_PROG -f -c "pwrite -S 0x6c 0 256k" $lowerdir/$f \
+			>> $seqres.full
+	done
+
+	# These were not written through the overlay, so it does not have to
+	# sync them.
+	$XFS_IO_PROG -c "syncfs" $OVL_BASE_SCRATCH_MNT
+}
+
+modify()
+{
+	local m=$SCRATCH_MNT
+
+	# New files and directories
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 1m" $m/new >> $seqres.full
+	mkdir $m/newdir
+	$XFS_IO_PROG -f -c "pwrite -S 0x62 0 64k" $m/newdir/new >> $seqres.full
+	$XFS_IO_PROG -f -c "pwrite -S 0x63 0 64k" $m/dir/new >> $seqres.full
+	ln -s new $m/symlink
+	# Too long to be stored in the inode
+	ln -s $(printf 'a%.0s' $(seq 1000)) $m/longsymlink
+	mkfifo $m/fifo
+
+	# Copy up, then change the data
+	$XFS_IO_PROG -c "pwrite -S 0x64 256k 64k" $m/append >> $seqres.full
+	$XFS_IO_PROG -c "pwrite -S 0x65 256k 64k" $m/dir/append >> $seqres.full
+	$XFS_IO_PROG -c "truncate 4k" $m/truncate
+
+	# Stores through a shared mapping, also after a syncfs, no msync
+	$XFS_IO_PROG -c "mmap -rw 0 256k" -c "mwrite -S 0x66 0 64k" \
+		-c "syncfs" -c "mwrite -S 0x67 64k 64k" $m/mmap >> $seqres.full
+
+	# The other ways to write data
+	$XFS_IO_PROG -f -c "sendfile -i $m/link 0 256k" $m/sendfile \
+		>> $seqres.full
+	$XFS_IO_PROG -f -c "copy_range -l 256k $m/link" $m/copy_range
+	$XFS_IO_PROG -T -c "pwrite -S 0x69 0 64k" -c "flink $m/tmpfile" $m \
+		>> $seqres.full
+
+	# Copy up, then change the metadata
+	chmod 640 $m/chmod
+	chown 1234:1234 $m/chown
+	$SETFATTR_PROG -n user.test -v value $m/xattr
+
+	# With metacopy=on the first one only copies up the metadata
+	chown 1234:1234 $m/chown_append
+	$XFS_IO_PROG -c "pwrite -S 0x6a 256k 64k" $m/chown_append \
+		>> $seqres.full
+
+	# Names
+	ln $m/link $m/link2
+	mv $m/rename $m/renamed
+	# Without redirect_dir=on mv gets EXDEV and copies the directory
+	mv $m/mvdir $m/mvdir2
+	rm $m/remove
+	rm -r $m/rmdir
+
+	# An overlay inode that nobody holds on to
+	$XFS_IO_PROG -f -c "pwrite -S 0x68 0 1m" $m/evicted >> $seqres.full
+	echo 2 > /proc/sys/vm/drop_caches
+}
+
+# No inode numbers, no timestamps, and no sizes and link counts of directories
+snapshot()
+{
+	local f
+
+	cd $SCRATCH_MNT
+	find . | LC_ALL=C sort | while read -r f; do
+		if [ -L "$f" ]; then
+			echo "$f $(stat -c '%F %u:%g' "$f") $(readlink "$f")"
+		elif [ -f "$f" ]; then
+			echo "$f $(stat -c '%F %a %u:%g %h %s' "$f")" \
+			     "$(md5sum < "$f")"
+		else
+			echo "$f $(stat -c '%F %a %u:%g' "$f")"
+		fi
+	done
+	_getfattr --absolute-names -n user.test xattr 2>&1
+	cd - > /dev/null
+}
+
+# <syncfs|umount> [mount options]
+do_test()
+{
+	local how=$1
+	shift
+	local label="$how${*:+ $*}"
+
+	echo "=== $label" >> $seqres.full
+
+	create_lower
+	if [ $# -eq 0 ]; then
+		_scratch_mount
+	elif ! _try_scratch_mount $* >> $seqres.full 2>&1; then
+		# Not every kernel knows every option
+		echo "cannot mount" >> $seqres.full
+		_unmount $OVL_BASE_SCRATCH_MNT
+		return
+	fi
+
+	modify
+	snapshot > $tmp.before
+
+	if [ $how = syncfs ]; then
+		$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT
+		_scratch_shutdown | tee -a $seqres.full
+		_scratch_unmount
+	else
+		# Only the overlay, the base filesystem stays mounted
+		_unmount $SCRATCH_MNT
+		_scratch_shutdown | tee -a $seqres.full
+		_unmount $OVL_BASE_SCRATCH_MNT
+	fi
+
+	_scratch_mount $*
+	snapshot > $tmp.after
+	cat $tmp.after >> $seqres.full
+	diff -u $tmp.before $tmp.after | sed -e "s/^/$label: /"
+	_scratch_unmount
+}
+
+for how in syncfs umount; do
+	do_test $how
+	for mode in relaxed on strict; do
+		do_test $how -o fsync=$mode
+	done
+	do_test $how -o redirect_dir=on,metacopy=on
+done
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/overlay/118.out b/tests/overlay/118.out
new file mode 100644
index 00000000..3daed864
--- /dev/null
+++ b/tests/overlay/118.out
@@ -0,0 +1,2 @@
+QA output created by 118
+Silence is golden
-- 
2.55.0

