Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438403;
	b=k2JDt2DiCdrwLwiqzbzLwLap1OyBYRroX8AP6YCug+4EnXklWTJB66E9eGhhu2c0JxCz
	 Kw8kD0hFxJMnlBhHPG7OnKWnD24X9FCaFlgLMzqKh1Yb1IpRI867qABPsLzU+SQqAh01o
	 mqwZyahzrGKjYprelHfIESh96M6MwCUtRKsWrCZAwUERR1fSVMpjYDCkiARKmjFlCnhDP
	 q7zB3WdSVG6V04jS4LZixXG570uaOBtbumpUYJ//7x+KojrH2biH6wiWdXMTg0zSDfpZN
	 ihnrfTTIigvmEaNCMjRuTp1iu18Pc4SnGT3t+OIWfbVmMNeSzsgn2zPJtHcMYsVgpjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KSoziBNNM6XF3aPmL8wbAp4NVFuwfQI3B6uqYIN7o88=;
	b=4ZKcB0+E2HDlK2FcKenxR3wYl6HTCnCsx1P5X25srO3bA0cXn+prPNj7Ua37dL4jXoqb
	 BdRMxdBcG8n7k17B6hvxnH0zoZH9O4IoASLdr0q6qOlST7C6UFmASvMX8otQ4y0UT0iSC
	 9neMHcEaHmaWTwnKl5dCRr/5UbmEG6sgzSrCRhcQ8AYVF80AhBUV8cPJ+CvP+Z+sLZe2r
	 B5Aw2ZA9xf6OLRY8iQYBg8u0QPrg6VRDaR4GGZKzsWpB+HLOPCk/SBDBkn64iv7UlR2UD
	 d2mPj2zSrfn20IQO9p/l5SHgfa9btrlKCMGefJMhUVBZCvcoSPlhJhy41gvpydwwBYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+NakXby;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2B606A31D
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 09:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C2B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+NakXby
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso1378911eec.0
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793438402; x=1794043202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KSoziBNNM6XF3aPmL8wbAp4NVFuwfQI3B6uqYIN7o88=;
        b=O+NakXbyy8I2zZ37daWqm6F4kA6uC207fionLtLVvRlA64BnBkL3tzkYwsexX+bvam
         CLuZtA5lqCccaDVnwYAjkhvJkvxtu6MTMGEtyQXOl5BI13vZqcIsqqkfiunPyJaAv6nt
         HiPVNGQAemvM745Z33l6YYrJGQmYbpRnDarz8LYk7oda4MoAV3F/JMi9/4S94B8t2fRP
         gSNfOZBfT0qSsr/wan7zKp9GdiKORjJpv2TfeI/iUgJKxxixeYD8Qb6gF+SZ2K9q32mZ
         moNS4b5j3LmRwIygmNUops4sqlI117aENmJbjwhqCRKmCij+9yWfdcfP60kzzT1+Ur9q
         hPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793438402; x=1794043202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KSoziBNNM6XF3aPmL8wbAp4NVFuwfQI3B6uqYIN7o88=;
        b=S4kw9ITtILFI6SFmD4F8GPsIx4Ij0/vfUc2zit1SuGAIsIIBO33Q+BdPW8aqHcY8MG
         6dfFp1XqgoE7d8d5J6B7LuRWKml6Qqac2E5mVbwc+ev1kIa/j2yiMVyB00OBc/ky/uGB
         LHi1jv0al+zDZ31iikQx46TFfxbE1fRNoUiZRvZ/DIsM483XCNFdQedLxccCfnI2F4wY
         Nj+J0FAwuyJvs5rmQs9dyq1Sy20T/KtdxIvyKT5H+REYuirGiOXv3ICofaXlBJlSg9Ex
         BmzDzatzTA6DLNS9QUjN28qrheDeEB89zIaZOP8jxf5u8MpOTJvLrE60OLPlrv3vexbN
         6dIg==
X-Gm-Message-State: AFq9FYJ3JxVzfm5nfVxM7NT5ExU1sUOc8XUYq+AOievCby9j8UYC1KPZ
	/C+8YKFcpADTlHSmr7fe7obrJJZR4wBCJNa/4Izbfhba8j87DSldgoXuyZWqxoEV9B8=
X-Gm-Gg: AYBFou3YUmot687dRTjSqu1EkB6/iYmO8WySmorGSiqerYJwGXtjjv/FsdC8obxYS7A
	MWmF58xG4PpmZFWEC4qE/LEAdcMUx8rGfCwDB/889Jtjq5p4XmeKu4abA8ssfjEjq0UOsBZPlZR
	ubRS5el2E9hkbQYFxh3l59LZahlA9a9iluMZiS4aSUXIQs4bt86GYk0Vn41YcJVASMXxXiLvA+U
	WcsHlBX6FWsWMmVH+fKXJEHdiszg9o3C/XYgdWfD0ZqI0H49vjd/aQmkIfGh5fT+XxiPyq6hvfS
	Dp1vMZrVTs3X6Awow3tApDOfpASMNmGgvbJtP1Q+UhNLr6qgJsMxuFpFUz1W5IjqOmP4tszg58h
	aBxIS3X7WoDdAkP+ow8HRf6KhtHSG7QoKVKc/friX9uIktzyN6AzoT37BP0Z70sk1JJ8DEXwsrb
	OZlmBjFKm5bBkrxm8D0tx6KOYgNe01FgLGyNZWbCCo/fqn/QRZoXO4RUwmnD1KWnglLWawzzlRW
	NabUFOyBRErlCDOLMVlEOJRmcovDQNNPAw+NArZLh9elWmL7g0j9kXyOylLFYjyE8PFMPqQdp+C
	AZHJF7cAXIWdTI3eFqdku9x+Uwa+iRweFtI85vlXkyPSLPYtq67WieLl
X-Received: by 2002:a05:693c:835c:20b0:36a:30b:5dc0 with SMTP id 5a478bee46e88-36a423c338dmr6804353eec.24.1793438401775;
        Sat, 31 Oct 2026 02:20:01 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm13067963eec.10.2026.10.31.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:20:01 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 2/2] generic: test whiteouts on casefolded overlay layers
Date: Sat, 31 Oct 2026 09:19:48 +0000
Message-ID: <20261031091948.18985-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031091948.18985-1-dennylin0707@gmail.com>
References: <20261031091948.18985-1-dennylin0707@gmail.com>
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
---
 tests/generic/999     |  148 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |    2 +
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
