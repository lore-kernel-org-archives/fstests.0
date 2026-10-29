Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276941;
	b=W8rH16t5MqU36edbmegbklqhpSVb09+/7AAXbgMivMk/5CQ9t4ZQ5zsRGgXvSh/oXjwo
	 AXJE4wZJhK0+WHG/X3drJ5mWcXgGjoCsXGi3T+EYyzv3BRFNHxi76dkkJToFQZsQA3oXk
	 DlIeY1X+E4cQxlzq2L9Yy/EwqaiXBc+/0tfccUyb1/ezrbrCg4NeNGSUB79fkLrhe0Vyj
	 ivzKlpn+Lr44ieCDJ4EOTK0EWZ+kzFGn5PmamYgeoKsc57DjbqqT3vaQL8WXZUU2JPTps
	 /qfy2wCUxrRZSBoBLQtJpH4RFiUsJoUvORVErKxpbzS/jLn5wz8yXuDK0ktLrOS/STQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4OGFr7kDHZY+j8TMyBgS5H6nx5zjbqSGG4iF4apesuk=;
	b=Kn2bow0GGEJ3Kwt8sdHggJd9kK1ae2GUzL1KtEdo+YCf0gtQtTpA2RCsfpeSMjMg0cCY
	 omH+YK9UtmLf090DBnRKssiObzjP0FE4kluha+R9XiOKWj/n1pEtvTdgemi4pP5KFmydi
	 qSwq+gQuIF2ZKntpkjBuLTaZX3bHK4Th6cdjKhY3q5iG6iRsXrQXoO3ZajCjrnQJJ6tN8
	 2/95oAOTFfw1UMZ8202fbg/S2NNbEHJYVcD6xUny/OXoTYurT3M48snE0Fg8xoEP/eEKL
	 foEnu11cJ5iIq5aPZEBB9jQTK0Lh17aCc4x+TMIcAMG8spnA/uRbcb3GsKW1sMJG8jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Skodb+wg;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38766606A322
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38766606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Skodb+wg
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so17054845e9.3
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276940; x=1793881740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OGFr7kDHZY+j8TMyBgS5H6nx5zjbqSGG4iF4apesuk=;
        b=Skodb+wgQoWoPeNWPw+LErtBDhy5tIGuvjoxoSdDqSdPMX5yGO8NzP4KO2pOR3jvtW
         9Mj9Mq/yoVpubpJdTmVbFeKXUp92US7YtqegxMy8yACFeoOaQaw1gra+B9vBa7SxnDa5
         b6acl5WvsQI8H6xUcJlsb81N8ktGcOrFaEGeNt6JGcibZ3cI/uSVdJb1ni3JsxaijNn4
         YSa9H4uRXiKxSFjhgS0ZIAXlzPtukLuVx0IQK7rEtcyDiGxpFyq+6pwew8o4AG/9OmPe
         5GNIywnQPckRgrr0xVBoYAZv/UaKgH7SbCEbjURiJ3XxfkVhlAR0rNu4L0+JUG3ptitM
         rKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276940; x=1793881740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OGFr7kDHZY+j8TMyBgS5H6nx5zjbqSGG4iF4apesuk=;
        b=CVUWIV+O9toGkc23k9VsLQSlxCque5m2FFK3Ta1KG9Fz9TcQt3Ar4HsTn1r74GtLoe
         II8lECjijHaS0Y87OTdkrvlRACMpgmIGzItF1sXegsdG7jpwQxf5eCj3HXANWAQSSEqL
         n0veQ2c3cQidtY3Yjko1oVd1xjX1FOSoehfTMpgQWQAkruBDBFg3x3WhV7aPzUOPjeJS
         fN+wCppGgas0A0Rvqsw9PpPEhQJreFywDJ74mR3PrQWOgWf8F55dxxPFCpyuaK6i6oKZ
         7AzwryFb0ccw2oB3HzEMNtXcBdP27PBa1HYmngx0pKMB1TeaTrhA2D48KP9Fu95tbf+q
         vt5w==
X-Gm-Message-State: AFq9FYLBsXTI8PTLDVQmxaAISwhwOltvuw0JEWg2YWKJfd2lgpb9XE5U
	MetvRlHmszaXH8B3yNYA0Qf7+mZkui/aiu+7a5/Tkf7MJGa+sw/q5LDkB2ZiwMVu
X-Gm-Gg: AYBFou3VLHjsKYdVFgD4mfritlcWqwGWK0LcN+7IfEPwKqh/qoFxF36sEhe/2gJEW3y
	ISYwepPX0z3kQOMTcqxeviR1TtThO4kd3Z3JVxDyOC/4DGc3ebovUgAwtjC8uY5kNEE/Sc+GW59
	DlGMiF4Y74Lc3dAmEU9GQxlVu2KyuoBKtpz+iRBZ0BDxlfq8sUnRd9xKmf1rcWYrzlJfLKQRwlO
	MTS2RBk+vjgfPKI29BbbxFnu7UYAXP5ArXoaEIyMA1Z3Sd53CaYJTKGKUi8N7mU6Dg+uIO7dQou
	upOhBQx874ozM9x6ho8pbRIyE1Sd5nDoibaqGg+yOHrRwHsjuoeMGQjpbuwCZU7fQwhRJGYTI4J
	+5wXOCGtDeA07A2GWeWEEIdkhhyB8Norl/Iu+moW0+n/U33+BD5reBEkUH+OIEqcbYs10LLNIuf
	82IpL+K+ba7LT+yP1+aOALDwvWbDgD7szi+9ShobkEyl/hXe4Q71Dxvdv0JonI4wPnBXC7mDZ69
	ygAyaDZVTEb1ynFVCluVA8H/o9a4Qwui3hXc19sCjORRVr6DHitcFDL4VWWX2DbN5aN7jCmk5f4
	l+ZA3gQ4OGGUNL6k1V7QIzUeO+Nv5d/11QsmvizJVZPtXpIwmoAz0Kt9RQph3Q==
X-Received: by 2002:a05:600c:314f:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4a965be619dmr112126955e9.7.1793276939523;
        Thu, 29 Oct 2026 05:28:59 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:59 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 8/8] ext4/069: test LUFID in inline_data directory entries
Date: Thu, 29 Oct 2026 12:28:39 +0000
Message-ID: <20261029122842.230704-9-ablagodarenko@thelustrecollective.com>
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
Content-Transfer-Encoding: 8bit

From: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Verify that a LUFID set via EXT4_IOC_SET_LUFID on an entry in an
inline_data directory is correctly stored on disk.

The test formats a filesystem with -O dirdata,inline_data, creates a
directory with two entries (small enough to remain inline), sets a LUFID
on one entry, and confirms the fid= field is present in the raw
directory data via debugfs.

The require guard probes the combined dirdata+inline_data mount so that
a kernel that accepts each feature individually but rejects the
combination emits [not run] rather than FAIL.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 tests/ext4/069     | 164 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/069.out |   7 ++
 2 files changed, 171 insertions(+)
 create mode 100755 tests/ext4/069
 create mode 100644 tests/ext4/069.out

diff --git a/tests/ext4/069 b/tests/ext4/069
new file mode 100755
index 00000000..b8b3e459
--- /dev/null
+++ b/tests/ext4/069
@@ -0,0 +1,164 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 The Lustre Collective. All Rights Reserved.
+# Author: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
+#
+# FS QA Test ext4/069
+#
+# Regression test for inline directory + dirdata LUFID loss.
+#
+# ext4_add_dirent_to_inline() was passing NULL instead of dfid to
+# ext4_insert_dentry_data(), silently dropping the LUFID for every entry
+# created while the directory fits in the inode's inline-data area.
+#
+# The test creates a directory small enough to stay inline, sets a LUFID
+# on one of its entries, and verifies the LUFID is present on disk via
+# debugfs.  Without the fix, debugfs reports no fid= field and the test
+# fails.
+
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+. ./common/ext4
+
+_exclude_fs ext2
+_exclude_fs ext3
+
+_require_scratch_nocheck
+_require_command "$SET_LUFID_PROG"
+
+_require_scratch_dirdata()
+{
+	if test ! -f /sys/fs/ext4/features/dirdata ; then
+		_notrun "dirdata feature not supported by kernel"
+	fi
+	if ! $MKFS_EXT4_PROG -O dirdata -n $SCRATCH_DEV &>>$seqres.full ; then
+		_notrun "mkfs.ext4 does not support dirdata feature"
+	fi
+	if ! _scratch_mkfs -O dirdata,inline_data &>>$seqres.full ; then
+		_notrun "failed to create filesystem with dirdata+inline_data"
+	fi
+	if ! _try_scratch_mount &>>$seqres.full ; then
+		_notrun "kernel cannot mount filesystem with dirdata+inline_data"
+	fi
+	_scratch_unmount
+}
+
+_require_scratch_ext4_feature "inline_data"
+_require_scratch_dirdata
+
+# ---- helpers ----------------------------------------------------------------
+
+_u32_to_le_hex()
+{
+	local v=$1
+	local h
+	h=$(printf '%08x' "$((v & 0xffffffff))")
+	printf '%s%s%s%s' "${h:6:2}" "${h:4:2}" "${h:2:2}" "${h:0:2}"
+}
+
+_build_default_expected_fid()
+{
+	local path=$1
+	local inode version ino_lo ver_lo ver_hi seq_hex oid_hex ver_hex
+
+	inode=$(stat -c '%i' "$path") || return 1
+	version=$(debugfs -R "stat <${inode}>" $SCRATCH_DEV 2>/dev/null | \
+		sed -n 's/.*Generation:[[:space:]]*\([0-9xa-fA-F]\+\).*/\1/p' | head -1)
+	[ -z "$version" ] && return 1
+
+	ino_lo=$((inode & 0xffffffff))
+	ver_lo=$((version & 0xffffffff))
+	ver_hi=$(((version >> 32) & 0xffffffff))
+
+	# ext4 inode numbers are 32-bit so f_seq fits in 8 hex chars; avoid a
+	# 16-char $((16#...)) that would overflow for values >= 0x8000000000.
+	seq_hex="$(_u32_to_le_hex "$ino_lo")"
+	oid_hex="$(_u32_to_le_hex "$ver_lo")"
+	ver_hex="$(_u32_to_le_hex "$ver_hi")"
+
+	printf '[0x%x:0x%x:0x%x]' "$((16#$seq_hex))" "$((16#$oid_hex))" \
+		"$((16#$ver_hex))"
+}
+
+# Confirm the directory inode carries the Inline_Data flag.
+_check_inline()
+{
+	local dir=$1
+	local inode flags
+
+	inode=$(stat -c '%i' "$dir")
+	flags=$(debugfs -R "stat <${inode}>" $SCRATCH_DEV 2>/dev/null | \
+		sed -n 's/^.*Flags: \([0-9a-fx]*\).*$/\1/p')
+	# EXT4_INLINE_DATA_FL = 0x10000000
+	if (( (16#${flags#0x}) & 0x10000000 )); then
+		return 0
+	fi
+	return 1
+}
+
+# ---- test -------------------------------------------------------------------
+
+echo "== Create dirdata + inline_data filesystem =="
+_scratch_mkfs -O dirdata,inline_data &>>$seqres.full
+_scratch_mount
+
+TESTDIR=$SCRATCH_MNT/inline_dir
+mkdir "$TESTDIR"
+
+# Two entries keep the directory comfortably within the inline-data area
+# (~160 bytes available in a 256-byte inode) so ext4 does not convert it
+# to an on-disk block before we set the LUFID.
+echo "content" > "$TESTDIR/file_a"
+echo "content" > "$TESTDIR/file_b"
+
+sync
+
+echo "== Verify directory is inline =="
+if ! _check_inline "$TESTDIR"; then
+	echo "SKIP: directory was not kept inline (inode too small or inline_data inactive)"
+	_scratch_unmount
+	status=0
+	exit
+fi
+echo "  inline_dir: inline data confirmed"
+
+echo "== Set LUFID on file_a (inline directory entry) =="
+$SET_LUFID_PROG "$SCRATCH_MNT/inline_dir" file_a >>$seqres.full
+if [ $? -ne 0 ]; then
+	echo "FAIL: set_lufid returned error"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+expected=$(_build_default_expected_fid "$TESTDIR/file_a")
+if [ -z "$expected" ]; then
+	echo "FAIL: could not compute expected LUFID"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+sync
+
+echo "== Verify LUFID stored in inline directory entry =="
+# _dump_dir_structure reads from the raw block device via debugfs and
+# reports the fid= field written by ext4_dirdata_set().  Before the fix,
+# ext4_add_dirent_to_inline() passed NULL instead of dfid, so no fid=
+# field was written and this check would fail.
+if ! _dump_dir_structure "$TESTDIR" file_a "$expected"; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+_scratch_unmount
+_check_scratch_fs
+
+status=0
+exit
diff --git a/tests/ext4/069.out b/tests/ext4/069.out
new file mode 100644
index 00000000..2c8c4d9f
--- /dev/null
+++ b/tests/ext4/069.out
@@ -0,0 +1,7 @@
+QA output created by 069
+== Create dirdata + inline_data filesystem ==
+== Verify directory is inline ==
+  inline_dir: inline data confirmed
+== Set LUFID on file_a (inline directory entry) ==
+== Verify LUFID stored in inline directory entry ==
+  Directory structure of inline_dir: OK (dirdata verified)
-- 
2.52.0

