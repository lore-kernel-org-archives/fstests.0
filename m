Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D873749F4
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2026 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779958; cv=none; b=SVupY5bMc/HLDir1622pDdJDsgBfKFvZAs3L1QmmZJ6jtuy0z7V3tqhXG4lIctm8pIaxO5+/fDubj10hWDOnNXwKN/1R2ncEp82GqTiE/B9yLcWiK5osYWG+cCo43OPqLwtNT+zCREKyoEPRvNuTXDpOVcfpnvpeJ6PVzghu8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779958; c=relaxed/simple;
	bh=pr4SvlAkSg6noMLEFgyTNeAjrgvLZ23s/faGSyJGDXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4a1+kwnlsKq4sUT+iF+DnnYSe/ZzsnvVqEVItvbJOpSV243J42GSOmOzAYpySFquZiSqxfyY28kWxq6ml4JIvC6C+SyChV95IkjrCFM+/DUZZKhIY9HtCcfSamuh0c6YXqxCs/A/bfXlGXwJjVqQSHJoE2Tv5KShSu3ta4O3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2CYl/QJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2CYl/QJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceae1ed204so1963975ad.0
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 21:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784779932; x=1785384732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0aQM/769vuHKyh/k/lSh+NiKLupUcCY8oTxZt4p5jfc=;
        b=e2CYl/QJgjLVjZB7KGiAcxddoaTPNmhlp4z0uZJZJN4mT3wEMWr19fm85OsaoGv3Nm
         RwGUhAQzwJzSra97rfLKMUeZ30Kd0W/Akf9f1cwNmM17tjx6vm3PJmmiTtkkt+cAatJN
         LXm6OwCP9raCxym34a+X85Gh+lpCAWxSaF5un0epTITp9pcwaI1eVrTnPCg2+mjjxvpT
         Zvv7F1qp/c3wtv/rOCFfcLZlsytybmJOexPm3TKd04prurUm1GQ8iZQv2lgD5pLkeb6W
         O9cMAYtmQXs15mBDS5KNhKgXjeyaJorXvIX5D71h0jR/aRQwQxo10IGsayGs6vLGqM46
         qxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784779932; x=1785384732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0aQM/769vuHKyh/k/lSh+NiKLupUcCY8oTxZt4p5jfc=;
        b=ssO+AfJf226uh9qPL1+/hmqb0E+xyuMxnRG1fQ6NBQ/MalZuiohi5YlptXxJsXhfVj
         hYliENE8l2f7uaTF/ZxhIFVLPs8SVSJpK9bBjCBjt1RDQhvcEKCX0H9Y94IjaibmSq/p
         pt2aZ6wE1KfTTQHEOMn3Gh8Jpm0xxI6uQf94/NcN8dQlwax6jFnsJMGOiffI65ntIlt1
         zuIBfKzJH/6jrunnMA92prBTlcxq4cIDndF7oGO1WvtnLxtNO4Xc0QSyxwBsXEakoEBi
         TJ3Y6QPgafjpoefqplWt9aryUkrgG4Mn9RUTP8YRbYjhYd5DL33VEgcKqqqddbX64dLZ
         /hug==
X-Gm-Message-State: AOJu0YzSUmUZaiEYFc1A41s63nXn1qsdzD4C+0IXZlB/zFSc3wTYDau7
	jfNUVwX2LpEpRrg0EhABYYmGroTFiH5AL8cssNQ47ouTK1QV+c1HQUtcBxcVGsk=
X-Gm-Gg: AR+sD12yzRu2x2QKIZymlFdLwOA4vW/PI9aheX42z7F8VD2MiQ3j1GlEbeBNMiAmQS5
	fwZKPfVsa4jNkvifpADp/+STar3riNrLtfBJKbA6pTulrssCHSwqKaSykN6wkutQuNU0Kq905YR
	LfI04zn0dYdDWArgQ6GDZHgshTCvtkuJ6H05vrehGslGIZRQUj4VAmUWDepsOef6l8u77QtjizV
	ikrFrtdrLPAfMsqvmpoXfri+kUmzwtlwk+r5fB1ecx8HsYBZ8p8kYz+dYTVExnC1Rmee88dErXt
	OVtZiD6cx5NVFosOcp487Qp8r5qGC+v9qjkBf5h9kve8Fic9yWGynubythdsi1oVOpxOcL+JZ3l
	CIuwogXmF9pD/WK+QlfjVYOoWNSJEGk8p1YXIzcZ3uwSQUGjPoA9ZMWFBpA3AAvBmQtZe9DGA5h
	fb0Gb4qzJ3isZSK+6x+AKRUB2BZyneiDpXjHWwjDhr0VU=
X-Received: by 2002:a17:902:d4d2:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2cfa6a546bcmr18649245ad.1.1784779932310;
        Wed, 22 Jul 2026 21:12:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:88b0:bed0:519e:b032:eee0:b431])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df09a9dsm14429656eec.19.2026.07.22.21.12.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 21:12:11 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: fstests@vger.kernel.org
Cc: linkinjeon@kernel.org,
	Yuezhang.Mo@sony.com,
	zlang@kernel.org,
	Rochan Avlur <rochan.avlur@gmail.com>
Subject: [PATCH] exfat/001: test that rename and move preserve benign secondary entries
Date: Wed, 22 Jul 2026 21:11:55 -0700
Message-ID: <20260723041155.20740-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that unrecognized benign secondary directory entries (such as
vendor extensions) survive same-directory rename, cross-directory move,
in-place rename to a shorter name, rename overwriting an existing file,
and operations on files with multiple benign entries.

exFAT spec section 8.2 [1] requires implementations to preserve benign
secondary entries they do not recognize.  This is a regression test for
kernel commit 8258ef28001a ("exfat: handle unreconized benign secondary
entries") which incorrectly freed benign entry clusters in the rename
and move paths.

[1]: https://learn.microsoft.com/en-us/windows/win32/fileio/exfat-specification#8-implementation-notes

Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
 src/Makefile                   |   3 +-
 src/exfat_inject_vendor_ext.py | 155 ++++++++++++++++++++++++++++++
 src/exfat_verify_vendor_ext.py |  62 ++++++++++++
 tests/exfat/001                | 171 +++++++++++++++++++++++++++++++++
 tests/exfat/001.out            |   6 ++
 tests/exfat/Makefile           |  23 +++++
 6 files changed, 419 insertions(+), 1 deletion(-)
 create mode 100755 src/exfat_inject_vendor_ext.py
 create mode 100755 src/exfat_verify_vendor_ext.py
 create mode 100755 tests/exfat/001
 create mode 100644 tests/exfat/001.out
 create mode 100644 tests/exfat/Makefile

diff --git a/src/Makefile b/src/Makefile
index 31ac43b2..a42cf96f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -40,7 +40,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
-	      soak_duration.awk parse-dev-tree.awk parse-free-space.py
+	      soak_duration.awk parse-dev-tree.awk parse-free-space.py \
+	      exfat_inject_vendor_ext.py exfat_verify_vendor_ext.py
 
 SUBDIRS = log-writes perf
 
diff --git a/src/exfat_inject_vendor_ext.py b/src/exfat_inject_vendor_ext.py
new file mode 100755
index 00000000..81350da8
--- /dev/null
+++ b/src/exfat_inject_vendor_ext.py
@@ -0,0 +1,155 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Inject vendor extension (0xE0) benign secondary entries into an exFAT
+# directory entry set on an unmounted filesystem image or block device.
+#
+# Usage: exfat_inject_vendor_ext.py <device> <marker> <filename> [count]
+#
+# Adds <count> (default 1) vendor_ext entries carrying <marker> into the
+# entry set of <filename>.  The marker is stored in the custom-defined
+# area so it can be verified after kernel operations.
+#
+# exFAT on-disk directory entry layout (each entry is 32 bytes):
+#
+#   Entry set for a file:
+#     [0] File entry        (type 0x85)
+#         byte 1: num_ext (number of secondary entries following)
+#         bytes 2-3: entry set checksum (covers all entries, skipping these bytes)
+#     [1] Stream extension  (type 0xC0)
+#         byte 3: name_len (filename length in Unicode characters)
+#         bytes 4-7: name_hash
+#     [2..N] Filename entries (type 0xC1, each holds up to 15 UTF-16LE chars)
+#         bytes 2-31: 15 UTF-16LE characters
+#     [N+1..] Benign secondary entries (type 0xA0-0xFF, e.g. vendor_ext 0xE0)
+#         Implementations MUST preserve these even if unrecognized (spec s8.2)
+#
+#   Vendor extension entry (type 0xE0):
+#     byte 0: 0xE0 (entry type)
+#     bytes 2-15: vendor GUID (we store our marker here)
+#     bytes 18-31: vendor-defined data (we duplicate the marker here)
+#
+#   Free/unused directory slot: all 32 bytes are 0x00 (type byte == 0x00)
+#
+
+import struct
+import sys
+
+ENTRY_SIZE = 32
+
+# exFAT directory entry type codes
+TYPE_FILE = 0x85
+TYPE_STREAM = 0xC0
+TYPE_FILENAME = 0xC1
+TYPE_VENDOR_EXT = 0xE0
+TYPE_FREE = 0x00
+
+# Offsets within specific entry types
+FILE_NUM_EXT_OFF = 1        # byte offset of num_ext in file entry
+FILE_CHECKSUM_OFF = 2       # byte offset of checksum in file entry
+STREAM_NAME_LEN_OFF = 3    # byte offset of name_len in stream entry
+FILENAME_CHARS_OFF = 2      # byte offset of first char in filename entry
+CHARS_PER_NAME_ENTRY = 15   # UTF-16LE characters per filename entry
+
+
+def find_entry_set(data, fname):
+    """Scan raw data for a FILE+STREAM+NAME entry set matching fname."""
+    pos = 0
+    while pos < len(data) - ENTRY_SIZE * 3:
+        if (data[pos] == TYPE_FILE and
+                data[pos + ENTRY_SIZE] == TYPE_STREAM and
+                data[pos + ENTRY_SIZE * 2] == TYPE_FILENAME):
+            name_len = data[pos + ENTRY_SIZE + STREAM_NAME_LEN_OFF]
+            num_name_entries = (name_len + CHARS_PER_NAME_ENTRY - 1) // \
+                CHARS_PER_NAME_ENTRY
+            chars = []
+            for ne in range(num_name_entries):
+                ne_off = pos + ENTRY_SIZE * (2 + ne)
+                for c in range(CHARS_PER_NAME_ENTRY):
+                    if len(chars) >= name_len:
+                        break
+                    ch = struct.unpack_from('<H', data,
+                                           ne_off + FILENAME_CHARS_OFF +
+                                           c * 2)[0]
+                    chars.append(chr(ch))
+            if ''.join(chars) == fname:
+                return pos
+        pos += ENTRY_SIZE
+    return -1
+
+
+def build_vendor_ext(marker_bytes, index):
+    """Build a single vendor_ext directory entry with marker payload."""
+    entry = bytearray(ENTRY_SIZE)
+    entry[0] = TYPE_VENDOR_EXT
+    tag = marker_bytes + struct.pack('B', index)
+    # Store marker in both the GUID field (bytes 2-15) and
+    # vendor-defined field (bytes 18-31)
+    entry[2:2 + min(len(tag), 14)] = tag[:14]
+    entry[18:18 + min(len(tag), 14)] = tag[:14]
+    return entry
+
+
+def update_checksum(data, file_off, num_ext):
+    """Recompute entry set checksum (skip bytes 2-3 of file entry)."""
+    es_len = ENTRY_SIZE * (1 + num_ext)
+    es_data = data[file_off:file_off + es_len]
+    chksum = 0
+    for i in range(len(es_data)):
+        if i == FILE_CHECKSUM_OFF or i == FILE_CHECKSUM_OFF + 1:
+            continue
+        chksum = (((chksum << 15) | (chksum >> 1)) + es_data[i]) & 0xFFFF
+    return chksum
+
+
+def main():
+    if len(sys.argv) < 4:
+        print("Usage: %s <device> <marker> <filename> [count]" % sys.argv[0],
+              file=sys.stderr)
+        sys.exit(1)
+
+    dev, marker_str, fname = sys.argv[1], sys.argv[2], sys.argv[3]
+    count = int(sys.argv[4]) if len(sys.argv) > 4 else 1
+    marker = marker_str.encode('ascii')
+
+    with open(dev, 'r+b') as f:
+        data = bytearray(f.read())
+
+    file_off = find_entry_set(data, fname)
+    if file_off < 0:
+        print("ERROR: could not find file '%s'" % fname, file=sys.stderr)
+        sys.exit(1)
+
+    num_ext = data[file_off + FILE_NUM_EXT_OFF]
+    es_end = file_off + ENTRY_SIZE * (1 + num_ext)
+
+    # Verify free slots exist after the entry set
+    for i in range(count):
+        slot = es_end + i * ENTRY_SIZE
+        if slot + ENTRY_SIZE > len(data) or data[slot] != TYPE_FREE:
+            print("ERROR: no free slot at offset %d for entry %d" %
+                  (slot, i), file=sys.stderr)
+            sys.exit(1)
+
+    # Write vendor_ext entries into the free slots
+    for i in range(count):
+        slot = es_end + i * ENTRY_SIZE
+        entry = build_vendor_ext(marker, i)
+        data[slot:slot + ENTRY_SIZE] = entry
+
+    # Update num_ext in the file entry and recompute checksum
+    num_ext += count
+    data[file_off + FILE_NUM_EXT_OFF] = num_ext
+
+    chksum = update_checksum(data, file_off, num_ext)
+    struct.pack_into('<H', data, file_off + FILE_CHECKSUM_OFF, chksum)
+
+    with open(dev, 'r+b') as f:
+        f.write(data)
+
+    print("Injected %d vendor_ext entries for '%s' at offset %d, num_ext=%d" %
+          (count, fname, es_end, num_ext))
+
+
+if __name__ == '__main__':
+    main()
diff --git a/src/exfat_verify_vendor_ext.py b/src/exfat_verify_vendor_ext.py
new file mode 100755
index 00000000..2d7eb048
--- /dev/null
+++ b/src/exfat_verify_vendor_ext.py
@@ -0,0 +1,62 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that vendor extension (0xE0) benign secondary entries with a
+# given marker are present in an exFAT filesystem image or block device.
+#
+# Usage: exfat_verify_vendor_ext.py <device> <marker> [count]
+#
+# Scans for a live (non-deleted) FILE entry set containing <count>
+# (default 1) vendor_ext entries with <marker>.  Prints "PASS" or "FAIL".
+#
+# See exfat_inject_vendor_ext.py for the on-disk layout description.
+
+import sys
+
+ENTRY_SIZE = 32
+
+# exFAT directory entry type codes
+TYPE_FILE = 0x85
+TYPE_VENDOR_EXT = 0xE0
+
+# Offsets within the file entry
+FILE_NUM_EXT_OFF = 1
+
+
+def main():
+    if len(sys.argv) < 3:
+        print("Usage: %s <device> <marker> [count]" % sys.argv[0],
+              file=sys.stderr)
+        sys.exit(1)
+
+    dev, marker_str = sys.argv[1], sys.argv[2]
+    expected = int(sys.argv[3]) if len(sys.argv) > 3 else 1
+    marker = marker_str.encode('ascii')
+
+    with open(dev, 'rb') as f:
+        data = f.read()
+
+    # Walk directory entries looking for a FILE entry set that contains
+    # the expected number of vendor_ext entries with our marker.
+    for i in range(0, len(data) - ENTRY_SIZE, ENTRY_SIZE):
+        if data[i] != TYPE_FILE:
+            continue
+        num_ext = data[i + FILE_NUM_EXT_OFF]
+        found = 0
+        for j in range(1, num_ext + 1):
+            off = i + j * ENTRY_SIZE
+            if off + ENTRY_SIZE > len(data):
+                break
+            if data[off] == TYPE_VENDOR_EXT and \
+                    marker in data[off:off + ENTRY_SIZE]:
+                found += 1
+        if found >= expected:
+            print("PASS")
+            sys.exit(0)
+
+    print("FAIL")
+    sys.exit(1)
+
+
+if __name__ == '__main__':
+    main()
diff --git a/tests/exfat/001 b/tests/exfat/001
new file mode 100755
index 00000000..858e9750
--- /dev/null
+++ b/tests/exfat/001
@@ -0,0 +1,171 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Rochan Avlur.  All Rights Reserved.
+#
+# FS QA Test No. exfat/001
+#
+# Verify that rename and cross-directory move do not destroy
+# unrecognized benign secondary directory entries.  exFAT spec section 8.2
+# requires implementations to preserve benign secondary entries they
+# do not recognize.
+#
+# Regression test for kernel commit 8258ef28001a
+# ("exfat: handle unreconized benign secondary entries") which added
+# cluster freeing for benign secondary entries inside
+# exfat_remove_entries(), but that function is also called by the
+# rename and move paths where freeing is incorrect.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	_unmount $loop_mnt 2>/dev/null
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
+	rm -rf $loop_mnt $img_file $tmp.*
+}
+
+_fixed_by_kernel_commit 942296784b2a \
+	"exfat: preserve benign secondary entries during rename and move"
+
+_require_test
+_require_loop
+_require_command "$PYTHON3_PROG" python3
+
+img_file=$TEST_DIR/$seq.exfat.img
+loop_mnt=$TEST_DIR/$seq.mnt
+loop_dev=""
+
+INJECT=$here/src/exfat_inject_vendor_ext.py
+VERIFY=$here/src/exfat_verify_vendor_ext.py
+MARKER="XFST_BENIGN_01"
+
+create_exfat_image()
+{
+	rm -f $img_file
+	truncate -s 10M $img_file
+	loop_dev=$(_create_loop_device $img_file)
+	_mkfs_dev $loop_dev >> $seqres.full 2>&1
+	mkdir -p $loop_mnt
+}
+
+mount_image()
+{
+	_mount $loop_dev $loop_mnt
+}
+
+unmount_image()
+{
+	_unmount $loop_mnt
+}
+
+teardown_image()
+{
+	_unmount $loop_mnt 2>/dev/null
+	_destroy_loop_device $loop_dev
+	loop_dev=""
+}
+
+verify_benign_preserved()
+{
+	local label="$1"
+	local count="${2:-1}"
+
+	result=$($PYTHON3_PROG $VERIFY $loop_dev "$MARKER" "$count" \
+		2>>$seqres.full)
+	if [ "$result" = "PASS" ]; then
+		echo "PASS: benign secondary entries preserved after $label"
+	else
+		echo "FAIL: benign secondary entries destroyed by $label"
+	fi
+}
+
+# Test 1: rename to longer name (entry set must be relocated)
+create_exfat_image
+mount_image
+echo "payload" > $loop_mnt/a
+unmount_image
+
+$PYTHON3_PROG $INJECT $loop_dev "$MARKER" a \
+	>> $seqres.full 2>&1 || _fail "inject failed for test 1"
+
+mount_image
+mv $loop_mnt/a "$loop_mnt/a_long_name_to_force_entry_set_relocation"
+unmount_image
+
+verify_benign_preserved "rename to longer name"
+teardown_image
+
+# Test 2: cross-directory move
+create_exfat_image
+mount_image
+echo "payload" > $loop_mnt/b
+unmount_image
+
+$PYTHON3_PROG $INJECT $loop_dev "$MARKER" b \
+	>> $seqres.full 2>&1 || _fail "inject failed for test 2"
+
+mount_image
+mkdir $loop_mnt/subdir
+mv $loop_mnt/b $loop_mnt/subdir/b
+unmount_image
+
+verify_benign_preserved "cross-directory move"
+teardown_image
+
+# Test 3: rename to shorter name (entry set is updated in place)
+create_exfat_image
+mount_image
+echo "payload" > "$loop_mnt/a_long_name_to_force_multiple_name_entries"
+unmount_image
+
+$PYTHON3_PROG $INJECT $loop_dev "$MARKER" \
+	a_long_name_to_force_multiple_name_entries \
+	>> $seqres.full 2>&1 || _fail "inject failed for test 3"
+
+mount_image
+mv "$loop_mnt/a_long_name_to_force_multiple_name_entries" $loop_mnt/c
+unmount_image
+
+verify_benign_preserved "rename to shorter name"
+teardown_image
+
+# Test 4: rename overwriting an existing file (source's benign entries
+#         must survive even though the target's entries are deleted)
+create_exfat_image
+mount_image
+echo "target" > $loop_mnt/dst
+echo "source" > $loop_mnt/src
+unmount_image
+
+$PYTHON3_PROG $INJECT $loop_dev "$MARKER" src \
+	>> $seqres.full 2>&1 || _fail "inject failed for test 4 (src)"
+
+mount_image
+mv $loop_mnt/src $loop_mnt/dst
+unmount_image
+
+verify_benign_preserved "rename overwriting existing file"
+teardown_image
+
+# Test 5: multiple benign entries (verifies all are copied, not just one)
+create_exfat_image
+mount_image
+echo "payload" > $loop_mnt/m
+unmount_image
+
+$PYTHON3_PROG $INJECT $loop_dev "$MARKER" m 3 \
+	>> $seqres.full 2>&1 || _fail "inject failed for test 5"
+
+mount_image
+mv $loop_mnt/m "$loop_mnt/m_longer_name_for_relocation"
+unmount_image
+
+verify_benign_preserved "rename with multiple benign entries" 3
+teardown_image
+
+# success, all done
+status=0
+exit
diff --git a/tests/exfat/001.out b/tests/exfat/001.out
new file mode 100644
index 00000000..f82ea010
--- /dev/null
+++ b/tests/exfat/001.out
@@ -0,0 +1,6 @@
+QA output created by 001
+PASS: benign secondary entries preserved after rename to longer name
+PASS: benign secondary entries preserved after cross-directory move
+PASS: benign secondary entries preserved after rename to shorter name
+PASS: benign secondary entries preserved after rename overwriting existing file
+PASS: benign secondary entries preserved after rename with multiple benign entries
diff --git a/tests/exfat/Makefile b/tests/exfat/Makefile
new file mode 100644
index 00000000..9322f797
--- /dev/null
+++ b/tests/exfat/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Rochan Avlur.  All Rights Reserved.
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+include $(TOPDIR)/include/buildgrouplist
+
+EXFAT_DIR = exfat
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(EXFAT_DIR)
+DIRT = group.list
+
+default: $(DIRT)
+
+include $(BUILDRULES)
+
+install: default
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group.list $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
-- 
2.45.2

