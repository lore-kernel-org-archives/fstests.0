Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276940;
	b=JXla45KYiECXY7E/NptJyn3IovUdgSHf4mEPiIni6TQ4lJIEkfLii8J+AjsA7ssZXI2W
	 DySbM07YwwYOlywipzjrua6fza+u2PKbYrWsdfkwwkVn0vOG3uCOD5hyOXO9+ut7tQaUW
	 eWZPl5G/5JIvxY5Usy9M/90DkuI1bUmEyBwW6K8dmnzPuryf4F9XAwuxbkM6O60zhDwqY
	 bsI3a84lKw4VLD5utJb/OEM6SMHlAhUehwpkX9UbesCvj++xkCUEHmlUVSH08/T1iS4Xu
	 pF5lWGy+YCGYXBgvlB/L2Dv8dbk3jpyLivKuApKu2jfa2TQEvQkvVYWVE0/QSVKd3zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bw9T+kO+Fc7fvvCI+c0gdroam/uAYPm40NcSNxWvcs0=;
	b=LIWx63Bf6F3i2WRgJ1YXq5G3gA5O8C34guQiS5vycXv3UZ7rruMHAMG/6GcGyS9BdAdB
	 DaBAvPRexhW83Y0V5Kvh7e9k+1rSKnr82+rIVQh5g04oxLE9/YfYCVIUqbzHmkIV7laeF
	 1NEfwIqpxuPABhGPzw/Bxf9YesVQdLh2VCKH6V7qFY/FEcOR2LApwhQ8AUW0mDFDYWN2L
	 J4FftQVH/QwW//Kk4EYdl6Xl4DxFJ+dpRZy5Hgxu87J1Kt2l/js7BLHTXIXUa8hj7kBJe
	 OKm+WuqPnSWBH34y3jOLoNT7eYDPjTeWG2EU9BnCA7QaCd6K3pYNDJE1h7AvV0SCMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=suYXzSmR;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB9606A334
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DAB9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=suYXzSmR
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so24705465e9.0
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276939; x=1793881739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bw9T+kO+Fc7fvvCI+c0gdroam/uAYPm40NcSNxWvcs0=;
        b=suYXzSmRKpRLGYCvC69cvf4xAfytKuzJXqZHmRCmU5UwqyYWPgHM51c7SlmlRfniBe
         xdGMZT6VIy1wQwzJzAzXF6Lvsg1xafF9uvI6E+nZ94m3vhaL3J1+6KngvBlpLC/67Fio
         cc20RzJhCxPDA+BZcd9mZFfq8UGu6G9IwNKlNoqCwRR1WJ0MX+odHzDoLa7Bie8n4ZHM
         UgW0yuryR8m9Mn1hZ9tBfI0KxznJg6kZMm5piGgQWiZZzyxUI+tFGa3NpQ0LClI6rnDn
         RZeK5ce7SJ/6qSHTCL+fC/QIzScWhkMmqmYLbV1SkSkXPhouK86QK25Ax/a59khk+Ajg
         VQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276939; x=1793881739;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bw9T+kO+Fc7fvvCI+c0gdroam/uAYPm40NcSNxWvcs0=;
        b=x2V+Dh8F1xSYqyRt19j3cq+yvquprbWGnRFN17ZZBIZ3togpkqK0trxZN+hdT2IIkT
         ebjx8SyMg03hAnkByOItDvu0Whs1BUgBUY8Gyrgc5JZo+wTA/JH7U3nEIgDiA96+f1in
         QYkAP3TbpmBk7MWSO0qtvFLelwU8rzRB5DuhKf8IwQ2cFFMyem+aI7pQy/E4qs1/xHUn
         DgZT5tHrZaiKB0dEoIQ2k6/V1cIwP5sQDAB5omydI0K51H8sQrSIU2cG/7gXlcOsoRVC
         rxFolUQmgXsoopAswpocdBuxHz2mZ42hxJHV6prJoYd1oZhRrKMyyZ3M8t4CsMnCHEQu
         yqxg==
X-Gm-Message-State: AFq9FYIbCDyoMk3KAMPVM50jKlYw27anyECam37Xfu7yW+7rCzH40S0r
	w0MI+NHE5YbhHLkComIEf0MPZK/VoHl4iVz1p4r6X8TFKt5yDtDxpmmJiKlk1Ppe
X-Gm-Gg: AYBFou0cm/96aUDDQfcJ+VR7l+ugXMtbFMqFKG/6fUrNTg82iQ+/o66XUUTrbICJf2f
	VFrnFsPGLYROhaolpwk2OZ6hbyrlctS8CUAD0n1fiZ/8gxGkbnbdjN+20k7VlDQviggo0Ftb7E1
	f5bbgGi83eGlNW39On3cjo8Krwe3huzM4B3wn9f/6OMFWymStPdZMTemGQqc8oa2nE+4019wnai
	iX+IdOi2fAOqcuFvSjbHpPJeGRMu0sMd3q9DjXBIuLKYfEy35qc2d/BG/3jEB/cYllmAqA/r2gQ
	QUKTBKeSB11xhPQVF5mxdL6nASR39wbPbpaqEjmRmA3zayN9N0K0R0YXxgaLbRPvtKcUqK9YTl+
	neXDDS5ZSDheKqcyoC2zuMS2toaUtryM5eK3lZEJwXRl+9kBu4nr2Tks/Oy2TZZRcWH/9tq8e+l
	ZhVQls3+1wYehd8u9TruXVTGydHovkNHFclHSTsGRzLosw0zPE37uOaFxklVownkF/Og2+vOfvl
	Js5jUaC6n2CoCZ1BmoL2FcTuLk5hKE5SWazQnMLVUGu1YveKxy7Vgvf0karZ/hlJzR58+WIN4nv
	fk8T8gYqMbIzXJrcc4Th6mlUwdh1SJN9XSdlQYMKo43TXEWR1t+pZUKIX8VY
X-Received: by 2002:a05:600d:604d:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4a966c3f65amr120327695e9.21.1793276938748;
        Thu, 29 Oct 2026 05:28:58 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:58 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 7/8] ext4/068: test LUFID is carried through overwrite rename and RENAME_EXCHANGE
Date: Thu, 29 Oct 2026 12:28:38 +0000
Message-ID: <20261029122842.230704-8-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
References: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two-part test for the fix in ext4_setent() that copies LUFID dirdata
payload through rename:

Test 1 (overwrite rename): create two files in a dirdata directory, set
distinct 16-byte LUFIDs on each via EXT4_IOC_SET_LUFID, then rename the
source file over the destination.  After rename the destination slot must
carry the source inode's LUFID, not the stale LUFID of the replaced inode.

Test 2 (RENAME_EXCHANGE): same setup with two files, then swap them with
renameat2 -x.  After the exchange each slot must carry the LUFID of the
inode that moved into it.

Uses all-same-byte LUFID payloads (0xAA.../0xBB...) so the expected FID
string is trivially known without parsing inode numbers.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 tests/ext4/068     | 202 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/068.out |   5 ++
 2 files changed, 207 insertions(+)
 create mode 100755 tests/ext4/068
 create mode 100644 tests/ext4/068.out

diff --git a/tests/ext4/068 b/tests/ext4/068
new file mode 100755
index 00000000..650920f3
--- /dev/null
+++ b/tests/ext4/068
@@ -0,0 +1,202 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 The Lustre Collective. All Rights Reserved.
+# Author: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
+#
+# FS QA Test ext4/068
+#
+# Test that the LUFID dirdata extension is correctly carried through rename.
+#
+# When a file with a LUFID is renamed over another file that also has a LUFID
+# (overwrite rename), the destination directory entry must end up with the
+# source inode's LUFID, not the stale LUFID of the destination inode that was
+# replaced.
+#
+# Also tests RENAME_EXCHANGE (cross-rename): each file's LUFID must follow its
+# inode to the new slot.
+
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions
+. ./common/filter
+. ./common/ext4
+. ./common/renameat2
+
+_exclude_fs ext2
+_exclude_fs ext3
+
+_require_scratch_nocheck
+_require_command "$SET_LUFID_PROG"
+_require_renameat2 exchange
+
+# Check if dirdata feature is supported (required for LUFID IOCTL)
+_require_scratch_dirdata()
+{
+	if test ! -f /sys/fs/ext4/features/dirdata ; then
+		_notrun "dirdata feature not supported by kernel (required for LUFID)"
+	fi
+
+	if ! $MKFS_EXT4_PROG -O dirdata -n $SCRATCH_DEV &>>$seqres.full ; then
+		_notrun "mkfs.ext4 does not support dirdata feature"
+	fi
+
+	if ! _scratch_mkfs -O dirdata &>>$seqres.full ; then
+		_notrun "failed to create filesystem with dirdata"
+	fi
+	if ! _try_scratch_mount &>>$seqres.full ; then
+		_notrun "kernel cannot mount filesystem with dirdata"
+	fi
+	_scratch_unmount
+}
+
+_require_scratch_dirdata
+
+# _get_entry_fid DIR ENTRYNAME
+#
+# Print the fid= value for the named entry inside DIR, as shown by
+# "debugfs ls -lD".  DIR must be a path relative to the filesystem root
+# (e.g. "rename_test/subdir").  Returns 1 if the entry or its fid is not found.
+_get_entry_fid()
+{
+	local dir=$1
+	local entry=$2
+	local dir_name
+
+	# debugfs cd takes a path; basename handles nested dirs
+	dir_name=$(basename "$dir")
+
+	# Flush dirty filesystem buffers before reading the raw device via debugfs.
+	sync
+	echo 3 > /proc/sys/vm/drop_caches
+
+	local fid
+	fid=$({
+		echo "cd $dir_name"
+		echo "ls -lD ."
+		echo "quit"
+	} | debugfs $SCRATCH_DEV 2>/dev/null | \
+		grep -E " ${entry}$" | grep -o "fid=[^ ]*" | sed 's/^fid=//')
+
+	if [ -z "$fid" ]; then
+		return 1
+	fi
+	echo "$fid"
+}
+
+# Create a filesystem with the dirdata feature
+_scratch_mkfs -O dirdata &>>$seqres.full
+_scratch_mount
+
+# -----------------------------------------------------------------------
+# Test 1: overwrite rename — LUFID follows the source inode
+# -----------------------------------------------------------------------
+echo "Test 1: overwrite rename copies LUFID from source to destination slot"
+
+mkdir -p $SCRATCH_MNT/rename_test
+
+echo "src" > $SCRATCH_MNT/rename_test/src_file
+echo "dst" > $SCRATCH_MNT/rename_test/dst_file
+
+# Use three 16-byte FIDs per entry to verify multi-FID LUFID handling.
+# src carries FIDs 0xAA×16, 0xCC×16, 0xEE×16 (48 bytes total payload).
+# dst carries FIDs 0xBB×16, 0xDD×16, 0x11×16 (48 bytes total payload).
+src_lufid=$'\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee'
+dst_lufid=$'\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11'
+src_fid_expected='[0xaaaaaaaaaaaaaaaa:0xaaaaaaaa:0xaaaaaaaa],[0xcccccccccccccccc:0xcccccccc:0xcccccccc],[0xeeeeeeeeeeeeeeee:0xeeeeeeee:0xeeeeeeee]'
+dst_fid_expected='[0xbbbbbbbbbbbbbbbb:0xbbbbbbbb:0xbbbbbbbb],[0xdddddddddddddddd:0xdddddddd:0xdddddddd],[0x1111111111111111:0x11111111:0x11111111]'
+
+set_lufid $SCRATCH_MNT/rename_test src_file "$src_lufid" >>$seqres.full 2>&1 || \
+	{ echo "FAIL: could not set LUFID on src_file"; status=1; exit; }
+
+set_lufid $SCRATCH_MNT/rename_test dst_file "$dst_lufid" >>$seqres.full 2>&1 || \
+	{ echo "FAIL: could not set LUFID on dst_file"; status=1; exit; }
+
+# Overwrite rename: src_file → dst_file
+mv $SCRATCH_MNT/rename_test/src_file $SCRATCH_MNT/rename_test/dst_file
+
+if [ -e $SCRATCH_MNT/rename_test/src_file ]; then
+	echo "FAIL: src_file still exists after rename"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+# After rename the dst_file slot must carry src's LUFID
+fid=$(_get_entry_fid rename_test dst_file)
+if [ $? -ne 0 ] || [ -z "$fid" ]; then
+	echo "FAIL: no fid found for dst_file after rename"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+if [ "$fid" != "$src_fid_expected" ]; then
+	echo "FAIL: dst_file has wrong LUFID after overwrite rename"
+	echo "  expected: $src_fid_expected"
+	echo "  got:      $fid"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+echo "PASS: dst_file carries src inode's LUFID after overwrite rename"
+
+# -----------------------------------------------------------------------
+# Test 2: RENAME_EXCHANGE — each LUFID follows its inode to the new slot
+# -----------------------------------------------------------------------
+echo "Test 2: RENAME_EXCHANGE swaps LUFIDs along with inodes"
+
+mkdir -p $SCRATCH_MNT/xrename_test
+
+echo "aaa" > $SCRATCH_MNT/xrename_test/file_a
+echo "bbb" > $SCRATCH_MNT/xrename_test/file_b
+
+a_lufid=$'\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee\xee'
+b_lufid=$'\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11\x11'
+a_fid_expected='[0xaaaaaaaaaaaaaaaa:0xaaaaaaaa:0xaaaaaaaa],[0xcccccccccccccccc:0xcccccccc:0xcccccccc],[0xeeeeeeeeeeeeeeee:0xeeeeeeee:0xeeeeeeee]'
+b_fid_expected='[0xbbbbbbbbbbbbbbbb:0xbbbbbbbb:0xbbbbbbbb],[0xdddddddddddddddd:0xdddddddd:0xdddddddd],[0x1111111111111111:0x11111111:0x11111111]'
+
+set_lufid $SCRATCH_MNT/xrename_test file_a "$a_lufid" >>$seqres.full 2>&1 || \
+	{ echo "FAIL: could not set LUFID on file_a"; status=1; exit; }
+
+set_lufid $SCRATCH_MNT/xrename_test file_b "$b_lufid" >>$seqres.full 2>&1 || \
+	{ echo "FAIL: could not set LUFID on file_b"; status=1; exit; }
+
+# Cross-rename: exchange file_a and file_b
+$here/src/renameat2 -x \
+	$SCRATCH_MNT/xrename_test/file_a \
+	$SCRATCH_MNT/xrename_test/file_b >>$seqres.full 2>&1 || \
+	{ echo "FAIL: renameat2 -x failed"; status=1; exit; }
+
+# After exchange: the slot named file_a must carry b's LUFID (b's inode is now there)
+# and the slot named file_b must carry a's LUFID.
+fid_a=$(_get_entry_fid xrename_test file_a)
+if [ $? -ne 0 ] || [ -z "$fid_a" ]; then
+	echo "FAIL: no fid found for file_a after exchange"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+fid_b=$(_get_entry_fid xrename_test file_b)
+if [ $? -ne 0 ] || [ -z "$fid_b" ]; then
+	echo "FAIL: no fid found for file_b after exchange"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+if [ "$fid_a" != "$b_fid_expected" ]; then
+	echo "FAIL: file_a slot has wrong LUFID after exchange"
+	echo "  expected (b's LUFID): $b_fid_expected"
+	echo "  got:                  $fid_a"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+if [ "$fid_b" != "$a_fid_expected" ]; then
+	echo "FAIL: file_b slot has wrong LUFID after exchange"
+	echo "  expected (a's LUFID): $a_fid_expected"
+	echo "  got:                  $fid_b"
+	_scratch_unmount; _check_scratch_fs; status=1; exit
+fi
+
+echo "PASS: LUFIDs correctly swapped after RENAME_EXCHANGE"
+
+# Cleanup and verify filesystem
+_scratch_unmount
+_check_scratch_fs
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/068.out b/tests/ext4/068.out
new file mode 100644
index 00000000..ceb00698
--- /dev/null
+++ b/tests/ext4/068.out
@@ -0,0 +1,5 @@
+QA output created by 068
+Test 1: overwrite rename copies LUFID from source to destination slot
+PASS: dst_file carries src inode's LUFID after overwrite rename
+Test 2: RENAME_EXCHANGE swaps LUFIDs along with inodes
+PASS: LUFIDs correctly swapped after RENAME_EXCHANGE
-- 
2.52.0

