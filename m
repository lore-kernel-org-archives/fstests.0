Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977491;
	b=N+g+MHNDq02k/omxRxS3ya6IUQdfsmXelLZxeoWZhN0aMLuXudxrPOrfPewPKbLp8+vb
	 wsUTA8pVvJA75ghk1IgSWq6iQfvh3fCJOiXNcmRp0HTBAHzuj1HvzOtwNoUtU6zz0iCyp
	 SsQsS+w5CqJFbAaakRWoZXGZWZMxsg2/drijARTcAiKo+99LseScPyoRmBZOsFvahzN31
	 bAxiWaeb1e6m0BkG7ZIczN1RaGaYqUrCWxy+1m5XlPa2Fv0SfB80K/BhCCmGt7RGDGHxV
	 5ruJLDzbJXWClzCs8zAaL3u+6vMzAcQK2u7yNnBCUUBUxlD4yeqt3STOoE2GajxgSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=osUGiBYO++jmzwgjV1q+vpCIJklcqDLlUevv7q/8lJ8=;
	b=efjX5p7lCD5tzlj+ISKH4nPn53K74Gbs3hCD/QbpXeSM8bn/HZ9ZKg0lCllxJJIuSRGc
	 3fNPiTa8ein17eVrkAyM9qEmsrbBaV8mxvKEgP7R5e3/gB8JlOYrZ8Lskc5VwL/brwG7m
	 gYtXHrtAVRwhpelXTekpByw9nuUx8DDgeM5iWUj6Y0Q9gPUACxtTNbph3A+8o2QitWgin
	 Ko3boJsuWMopixhz9IbXJGQwEGqn1TfAc0CSrMHhhWwDgxLJMhIsfJJ3zhZ15UY6iAqDn
	 ENHcdYiCD7MYOqBepwfrHE3YJR/N46LlTxHDUlvDbE5ZxnatfW5gY/HsCSkNWmfj8qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hronv365;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A6606A326
	for <fstests@vger.kernel.org>; Fri,  6 Nov 2026 15:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 831A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hronv365
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ea0c05c92so8497676d6.0
        for <fstests@vger.kernel.org>; Fri, 06 Nov 2026 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793977489; x=1794582289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osUGiBYO++jmzwgjV1q+vpCIJklcqDLlUevv7q/8lJ8=;
        b=hronv365PmnuJpTpgwn77mWjRX8H7rQhSPym5savjx6/KsmnzUwbuYxONptwC/P+4a
         v1qK4Lg4hjYSI+K2LMXQe8jQVn0gFLQn9asKETbMvivRMIDOelMVbSfv09ATleY8Jsxg
         WpeS5eVSN5b4bMoLY59ll4kGJ9cZ7/nRVzMwIoTVAx9Xf+jIfkytCNdCoFRj8XZVe5+1
         6DNRW2thk1MON+r8CBaNCEH8cdRadcYK6NBVvxo8Wn3y7ZMW6C4ZWFx06UfHwWTQYTsb
         gxtKoE/sMQaBCZ94565uA1SGfxtMcWLiGEqXfYdlGfUXwUH3nJ1jXUtMa2RGOFMYRCZj
         73gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977489; x=1794582289;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osUGiBYO++jmzwgjV1q+vpCIJklcqDLlUevv7q/8lJ8=;
        b=NeiGu4OjozOgA9O9NWi4nOQKssKgglovRMJlCnd4bRxlt18POLsLQiDeGYGdAODDoK
         cXojiOrCuFXlKDzl4ioyOCWYhYUa9AZkiu+qXepgz06I2BBud9PV7Z0NY49O/86YgH5D
         PaHyAsbKbydrxJG86Y494LircTizMRXATR9EkO3ZU0XJfyeYeL61n0CTLVG16wQdI/T5
         GOISWIPDCEgkwXWxopkR13fshZ0r6PtOxuvrzhdp8rcwJ78GNXFH9dyKsH/kSOQySh3t
         NdfH2omjMLosXN5ykdJQ2kR78oorsC7ueTHPKMlzaaEy7XDRGGzlSwxxCyBDZUcMSs+6
         zCbg==
X-Gm-Message-State: APuU4Z8BpX+qpFW3n+hn0HIC11W3iqQywtxbf9dQ9ytQwkWaN6PF4Jx6
	pR/o3aQGT/zyyatJWjUIeGIaWpCuYwFUer5Cn2QQgoigmerXB7s5u/+uiVNmS/vqcGfAipv0n+N
	fEI5uB54=
X-Gm-Gg: AYBFou0cRMG33nSyuBWjtF+pjIkDFYW/4+72uTOWj6sStXkT1iXbUnFdyMdE4kg2zZt
	ZcXQFoZ2+g+6tD6yFRFgCt+wr9lgHsdEKvBhTEatJsflSO0AL0OgMdEmpupfPpq/hgmRNjL8WEB
	IbJtLuonC9jkYBcWRuOIlQSECvgJ96tVDzkFBTWghsQu38AB6kn7CViAiTr8SCsHblQWe32jUEr
	iN97bmxL21gYw8xuzPfIP+azhbAru6cqRRaVv2oFQgsSXdtPmdFb/OUwqRy09fnltdvjZqKHB7Z
	8ql6Xcg9hcYUfQ2oR6wqtRWa/4+J6lzfXgrwoKYL5DW0Uh33JsDNNigEtRG1nFEx0jvGGWiUx+f
	qPzoEiVKqzWC4WuxA2JW0AW8B1oXpP6iLKFzpcMTIdIlzV8EydkGbjmHUy722i+z+ZBbO2n+aUP
	To4ijxyZbD7wkUm3zfuh/HFbyjY577E5P2k2wQyWqW/x0d+HvdbVx8Yi+VmXbGfF5UxPn9xbagW
	gVFAeMCvBPY4eq4rktnJJ9LDgeUimnycfJd6ITNs9PpcVVuYdoRqv2XHAnK7b/3rPFzoOtPwY/2
	lV71vQk6ihaR8wzAmuTMw03W0FiiWGXI7OIYjhlFJKHK5Q==
X-Received: by 2002:a05:622a:2592:b0:533:3a14:6a2e with SMTP id d75a77b69052e-54e130945c1mr42726921cf.17.1793977489385;
        Fri, 06 Nov 2026 07:04:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54edd55b971sm9255121cf.10.2026.11.06.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:04:48 -0800 (PST)
Date: Fri, 06 Nov 2026 15:04:47 +0000
Message-ID: <773faf2a275e0a51bd38cf68f492856c.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH fstests] overlay: test that syncfs and unmount persist all
 changes
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
    Amir Goldstein <amir73il@gmail.com>,
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
an O_TMPFILE, links, renames, whiteouts, a file written before the inode
caches are dropped.  Then sync or unmount the overlay, shut down the base
filesystem without flushing its log, cycle the mounts and check that
nothing has changed.

Do that with the default mount options, with every fsync mode that syncs
and with redirect_dir=on,metacopy=on.  Options that the kernel does not
know are skipped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
This is for "ovl: only sync what was written through the overlay" [1], Amir
suggested a test like this in his review.

It passes without the series on ext4 and xfs, there it skips fsync=relaxed
and fsync=on, and it passes with the series. With the series and the
function that marks the overlay inode dirty turned into a no-op it fails in
the default, fsync=relaxed and metacopy rounds, the file data is gone.

[1] https://lore.kernel.org/r/20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com

 tests/overlay/118     | 180 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/118.out |   2 +
 2 files changed, 182 insertions(+)
 create mode 100755 tests/overlay/118
 create mode 100644 tests/overlay/118.out

diff --git a/tests/overlay/118 b/tests/overlay/118
new file mode 100755
index 00000000..796f6d7b
--- /dev/null
+++ b/tests/overlay/118
@@ -0,0 +1,180 @@
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

