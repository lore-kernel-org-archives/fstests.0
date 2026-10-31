Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484992;
	b=cGy4d7Mu7EniGZnt1nsUz+51r9Coi73Q9173pWXQdaz0ovPH0dayNv+ejRTKlBMPKrNW
	 Ub4xq7b+gI/rlOre35trlzKom9cj0674htxhmn/q8VEdTtjJkKqqkrtp7WG+o1OwD3w/M
	 E/yHDiD/yYfrBWxX9D/TtgvZQSr1IKbcTuEFrz3kIJGX/NlC8rUoItDCOqE2/IVV8yMz7
	 oMrGlZXvPbTmaaP5c/7+HwglQxZhhJEJ710bq8n24er5qaZlpWWzUXD6AijFddD0ywgMS
	 KAJqrZB09rrXhCopULKqes9GsW/FLQDlQZME60/CSBcSQIQ4pWKX5wffOauWlBp0PeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GJoYtmlEWC341A7cBgsZ3mQTJ4svk+sity18hk+Hva4=;
	b=nvx4KXBxtAD0CRPUerS7LhRCnLyGY2QMIxvhBPLRhkgYV+RzQ/dOb9pzgrM92lO2wVcR
	 cAIl0cIQ64ACFjP6p+Yq/lcAPO3LSgCcxu3gsr7vI3zBppAkQWIkckFgwPSfgmBNZoTTU
	 sgBGwBUSrqctaCBu8QrlCPWqBWnPZrdFMEP9yIQhcKrkTjYGVFVprjX7w8dscDigoG3p/
	 bpg5WaHq2TE9Vvc76lnUV8wdB1vyk5isKr5lg+GExigGV67qt8TVpdjO9/2XZ9Kp9mwGP
	 rxp+8FwVI2Epjl5nhYcwHIW0PqmragnizWDTgxAQdMTUoSGtD7AI78mdLe0O3X5Y41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="whiuqm/Y";
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA7606A31C
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 22:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77FA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=whiuqm/Y
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so1140562eec.0
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484992; x=1794089792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJoYtmlEWC341A7cBgsZ3mQTJ4svk+sity18hk+Hva4=;
        b=whiuqm/YkHfoW8R6vyQa6KtR7/1csiE5NsVLv4902gK+bI6LIm2slClM/fSgoFdzWs
         phl6MgOt6N74gPSd2/liYnWgjX+EqCr+VAQbXGWpdtBco6rh4aLuR1MdiAjEDnbq2fAf
         Tth0E4FzGJqGSDOfXIu4zs/TYjDKH9a/FvuD7z7YSzaKzSBScLabq9GooBP/CHMuUdIK
         X2dwK/zgRbNNS3NZRFmXkNut5ks033hXxU3FlmfOrLoeXPXGrgAIf0Fio+10NUa49Leg
         men5sW4+ECj438096SL9nnIYGriOgoaJADP7cP6u8/LSY/N7VYkQXxbiqa8Tdlh+zRwC
         VfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484992; x=1794089792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJoYtmlEWC341A7cBgsZ3mQTJ4svk+sity18hk+Hva4=;
        b=JbYzbMvenzbkmBhmiVBvozyPTA6s8SB5DIPatwNkgSNjFt+uLvJZoHTYRtgMI14Pct
         XGvjH4JVdPVLuz1Nuv6yHHgbLc4KnR+I7mP6X7DUulXVKZtnyhYpyaCOLjoQ/fSnHpE+
         wJLHY/2I3dNfKrbIrp5T2Gg+V+A2JdN7lWhfCrqSILXaUSggdHHyvdwmsQWizHOFyNn9
         ISUp9VTQZ36nHLTuRi+BpjZ9qtDAgMIie4FDot/VhQPNE8v9f5/7asT1FXHBMn25hog/
         eP2311yfTQUhP/ZLaSvTCBG/0IDjchYUQYQiiPETQssFfYTlLYqqypO/Xt0XIpHZ+fZK
         mnfw==
X-Gm-Message-State: AFq9FYJ+QOhyCdhZ7pURVIIkAl8VLJFLSYEkRkt7P099VD4X98N8VRbI
	DtSwkJAx9z/SNCZvSl4hnelof/ah3+M+Kmnm3nU1hwOjSa3jSrZ13tlGixt8iYX08bI=
X-Gm-Gg: AYBFou1XFf2MlqzYqqHe2sXMDhPwLe3ivrgXd0Y+TGHHL1CfC4sT0yI/m+/MFGNGgg4
	kGJKvDJsrekcwNkh5D97vo3olcT4b3qiG/DK5laV3USa3Kg0X3J2je/vOaLKbz+QOxiziAt+wLd
	Ll2HIKSIDV8OJQLXLoKogyjEgfdk/Vc+yf/KVEkFNWgRUqZOFQ1lRyEWuo9dwFS9WHFYzyRanwH
	+RVJP5tCtYzovCyp7hlB+bQypsOvMmmbdj6j1EkVbe0h50T6YN9PnozaiCMRFAkmj8zwt9YyECe
	GdYTg5Q0UW3lf7Y1N4W5y3tlsN2VcSm9nHkM5c0yt3jsAwsTuOwuUa/99+EKTRZlDspAnvFPa3i
	oCubiTWJz44ehv1t1mliKoUIMdkRkd6lVOIIClmc5ttuLJZAzuVOHvDWRRbGBXyIF8lmN2F6Yxr
	0pgvKtG4IvQ0LAK5/uOAS2jb6NCfbQDMCToXefAePtXzYtDpLgWbBPegjgylK1wrnpH+b1gfs15
	XZMfSeNpcVqZbNdZrzLu3kLcHIceojI7h8DSFgxe0XjWlNydBDUSmQNpmRnnDWCxCEVrvfHpuND
	OlyOu3G31YPpVP7C3wk6cMvd+NCRe7C64/tY4OBrvtH5TKjd6IziJ9cFSXHQJqIAKZ41w8S0LE3
	meg==
X-Received: by 2002:a05:693c:88c8:20b0:369:f2d6:4108 with SMTP id 5a478bee46e88-36a42401233mr9001958eec.10.1793484991459;
        Sat, 31 Oct 2026 15:16:31 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm24037242eec.22.2026.10.31.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:16:30 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 2/2] generic: test whiteouts on casefolded overlay layers
Date: Sat, 31 Oct 2026 22:16:18 +0000
Message-ID: <20261031221618.153-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031221618.153-1-dennylin0707@gmail.com>
References: <20261031221618.153-1-dennylin0707@gmail.com>
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

Whiteout creation in casefolded directories can fail when removing
names that exist in a lower layer.

Exercise unlink and rmdir for lower-only names, a copied-up file and a
merged directory, including lookups with different ASCII case. Also
recursively remove a populated lower directory. Check that removed names
stay hidden after recreation and a mount cycle, while the surviving file
and the lower layer remain unchanged.

This covers "ovl: fix whiteout creation in casefolded directories" from
the casefold fixes series linked below.

Regular-file lookup and copy-up also need the separate "ovl: check the
casefold flag of directories only" fix, included in the tested overlayfs
ovl-fixes baseline at 1d27da7de3f7.

Link: https://lore.kernel.org/linux-unionfs/20261030113201.2921633-1-amir73il@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/999     |  148 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |    2 ++
 2 files changed, 150 insertions(+)

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 0000000..75e13b5
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,148 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Hungyu Lin.  All Rights Reserved.
+#
+# FS QA Test 999
+#
+# Check removal of files and directories from casefolded overlay layers,
+# including copied-up files, merged directories and recursive removal.
+#
+. ./common/preamble
+_begin_fstest auto quick dir casefold
+
+_cleanup()
+{
+	cd /
+	[ -n "$merge" ] && _unmount "$merge" 2>/dev/null
+	rm -f $tmp.*
+}
+
+. ./common/filter
+. ./common/casefold
+
+_exclude_fs overlay
+_require_extra_fs overlay
+_require_scratch
+_require_scratch_casefold
+_fixed_by_kernel_commit xxxxxxxxxxxx "ovl: fix whiteout creation in casefolded directories"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"ovl: check the casefold flag of directories only"
+
+mount_overlay()
+{
+	_mount -t overlay overlay "$merge" \
+		-o lowerdir="$lower",upperdir="$upper",workdir="$work"
+}
+
+check_absent()
+{
+	local name=$1
+	local ret
+
+	stat "$merge/$name" > $tmp.stat 2>&1
+	ret=$?
+	echo "stat $merge/$name: exit $ret" >> $seqres.full
+	cat $tmp.stat >> $seqres.full
+	[ "$ret" -ne 0 ] || _fail "$name: expected ENOENT, stat succeeded"
+	grep -q ': No such file or directory$' $tmp.stat || \
+		_fail "$name: expected ENOENT, got $(cat $tmp.stat)"
+}
+
+check_view()
+{
+	local phase=$1
+	local name
+
+	echo "Checking merged view $phase" >> $seqres.full
+	for name in lowerfile anotherfile copyfile lowerdir mergeddir tree upperonly; do
+		check_absent "$name"
+		check_absent "$(printf '%s' "$name" | tr a-z A-Z)"
+	done
+	cmp $tmp.data "$merge/keep" >> $seqres.full 2>&1 || \
+		_fail "$merge/keep: not readable with expected contents $phase"
+	ls -1 "$merge" > $tmp.names || _fail "cannot list $merge $phase"
+	printf 'keep\n' > $tmp.expected
+	diff -u $tmp.expected $tmp.names >> $seqres.full 2>&1 || \
+		_fail "$merge: expected only keep $phase (directory listing in $seqres.full)"
+}
+
+_scratch_mkfs_casefold >> $seqres.full 2>&1 || \
+	_fail "cannot format the casefold scratch filesystem"
+_scratch_mount_casefold || _fail "cannot mount the casefold scratch filesystem"
+root=$SCRATCH_MNT/ovl
+lower=$root/lower
+upper=$root/upper
+work=$root/work
+merge=$root/merge
+mkdir "$root" || _fail "cannot create $root"
+_casefold_set_attr "$root" >> $seqres.full 2>&1 || \
+	_notrun "cannot enable casefold on the scratch filesystem"
+mkdir "$lower" "$upper" "$work" "$merge" || \
+	_fail "cannot create overlay directories"
+
+printf 'lower data\n' > $tmp.data
+printf 'upper data\n' > $tmp.upper
+for name in lowerfile anotherfile copyfile keep; do
+	cp $tmp.data "$lower/$name" || _fail "cannot create lower $name"
+done
+mkdir "$lower/lowerdir" "$lower/mergeddir" "$lower/tree" "$upper/mergeddir" || \
+	_fail "cannot prepare lower and merged directories"
+for name in one two; do
+	cp $tmp.data "$lower/tree/$name" || _fail "cannot create lower tree/$name"
+done
+cp $tmp.upper "$upper/upperonly" || _fail "cannot create upper-only file"
+mount_overlay >> $seqres.full 2>&1 || \
+	_notrun "overlayfs does not support casefold enabled layers"
+
+# Copy up through the overlay, without changing the backing layers directly.
+cat $tmp.upper > "$merge/copyfile" || _fail "copy-up write failed"
+cmp $tmp.upper "$upper/copyfile" >> $seqres.full 2>&1 || \
+	_fail "copyfile was not copied up with the expected data"
+
+# The first removal is a control that does not need a lower whiteout.
+rm "$merge/upperonly" || \
+	_fail "cannot remove upper-only file"
+rm "$merge/lowerfile" || \
+	_fail "cannot remove lower-only file"
+rm "$merge/ANOTHERFILE" || \
+	_fail "cannot remove another lower-only file using different case"
+rm "$merge/COPYFILE" || \
+	_fail "cannot remove copied-up file using different case"
+rmdir "$merge/LOWERDIR" || \
+	_fail "cannot remove lower-only directory using different case"
+rmdir "$merge/mergeddir" || \
+	_fail "cannot remove merged directory"
+# Removing the children leaves whiteouts in the copied-up directory.
+rm -r "$merge/TREE" || _fail "cannot recursively remove lower directory"
+check_view "after removal"
+
+cat $tmp.upper > "$merge/LOWERFILE" || _fail "cannot recreate removed name"
+cmp $tmp.upper "$merge/lowerfile" >> $seqres.full 2>&1 || \
+	_fail "recreated name is not accessible with different case"
+rm "$merge/lowerfile" || \
+	_fail "cannot remove recreated name"
+check_view "after recreating and removing a name"
+
+_unmount "$merge" || _fail "cannot unmount overlay"
+mount_overlay >> $seqres.full 2>&1 || _fail "cannot remount overlay"
+check_view "after remount"
+_unmount "$merge" || _fail "cannot unmount overlay"
+merge=
+
+for name in lowerfile anotherfile copyfile keep; do
+	cmp $tmp.data "$lower/$name" >> $seqres.full 2>&1 || \
+		_fail "$lower/$name: not readable with expected contents"
+done
+for name in lowerdir mergeddir tree; do
+	[ -d "$lower/$name" ] || {
+		stat "$lower/$name" >> $seqres.full 2>&1
+		_fail "$lower/$name: expected the lower directory to remain"
+	}
+done
+for name in one two; do
+	cmp $tmp.data "$lower/tree/$name" >> $seqres.full 2>&1 || \
+		_fail "$lower/tree/$name: not readable with expected contents"
+done
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 0000000..3b276ca
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
