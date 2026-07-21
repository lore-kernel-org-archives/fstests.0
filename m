Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EC396D03
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629264; cv=none; b=AI2vTF5aFGlV6FI3+n9mzgtQPODSRkIUyxq+bbQEpiIerd7DrqTjyuqkmLsBas2VGEkk1KlKHXETWUCj4Ao7ER7FY1yytALrFzitDmurTVT0+GWsV5v7rGc51eyW6Ra51nzjoJXNPHLnBTjDoBcv/BdTtQLYZQBSXGKHMM4bNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629264; c=relaxed/simple;
	bh=qhEnRozeeoXKsvZhTSKi5/Ydqw5o8xCFzHlo5FIuysA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ31iBLN9D2ImcpKxDO11fT55Uk9PX6Gv3NNYg++vvEx+kLilwdScvTUZzwh27kyDglItii/HPunzvZ7b9YjmoCHL+tGch+7e++4rVKJO/j9rBTndIT8d0quRlFg5Qps1kxIeLFkuOKUf3PltewSss0iyaHvdb+g409BUYe3lj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OoiidgPS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OoiidgPS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495635a85d2so12614505e9.0
        for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784629261; x=1785234061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aPZsQmbB4pNx2I2MHFXLUlW8Otv0CmmgqvGOnRaQC8=;
        b=OoiidgPSsIvFlLaZr1m4g8yaN0LjO+J96DbumjSHuCUqEYWB23zm+lXvfqQ3lMEA/r
         URpMiaC9X6UJL4pifqw21exUAmT5Od4RzkWysxXU1T9n/XwnyCi8oRddyyrjXsjCkx/C
         nS12zpn+Q0pdYjfPeobkB+ElqRlWFmD8OSoMzO/JdTWJGJyyHaT6s3MnKtlID/0MS/OX
         CheXjXUDFOUNEvZpRHNeM7xeMIQL4+kwx0jgJO6Y7ZE7XMDa64/GrA18FCjLkVRxRwlg
         STiOCjWJYOKW1DvZ2hirfBYoB1WuKxqhEUKcxkbS80OFkXl+3gfPsCtRy8NV1t5lKlqt
         pAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629261; x=1785234061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1aPZsQmbB4pNx2I2MHFXLUlW8Otv0CmmgqvGOnRaQC8=;
        b=gXKZ2CXypby3Xnm9QMBhEqTaK8hcyXBaiuFIepMH7RovcUgPecR5uR8abxIxbyjv7k
         P+RCKlroHRa+OuFy1gbLrZb93DyvXcYWOhNwzGasxVU9RTlLDx4PmFR4vwGuZPhBaZH6
         NUuzZPaZ/qH7RrRoHGRK/PXU+4wRgM4epPwricceaMyMINlhTwBytXTY/EKZ4vslttF1
         LzxJix4eBjAVrKuvf0lLT7IWl/pXKek7qAjlxOp/EZkSQ52EJh5sPgyQzdBjikp34Fym
         TYZKQew4bPbB1i0xfFV7vupbGP5hRj4IS+TPTbWqKhiw2pNXPQdWmh8/UOjDU+u8BVWK
         Psbw==
X-Forwarded-Encrypted: i=1; AHgh+RqdUOnYjpRSj7mHcB/19xBMJZA3at6wXuWNiTRbVW491YOVrzL2kpNvgm8qcsrPoIwuSFOoCDJo@vger.kernel.org
X-Gm-Message-State: AOJu0YwMx09i+FZEJGwdJBjBkcUvSUL/aaSbNIgq6YNfYsK2bVctQSsl
	NN+mBa64g4KHUrDTf317ziCwKpaFrGvOL/cfaCvsBRq4WMp4wFkRkxPlhi83x2Opf5k=
X-Gm-Gg: AfdE7clC96Dp83iGBO0eYyq6I9aTImcQOyMYvQAWEihg+FJPgZPWzaSy+pxaGrL707g
	GZupkgPI1+S0n0BdhxONozXq+Os74W4vJnjYuychdzOYiz4o/KOl5SqglkOI9SrazOofRa4q50T
	MdbkXpiXfpjMxrEWoJvZvI47W262dNXy1KEWQv8XIPW3pKVoqIPMzbU/fzMb+Bc2vglaVbkOehC
	1R424sSBALca6v/eG8N6V6Ir2VWoBgNYbvReZbLuaUiMBQyKKufok7pUmqIIpBGjj99/pAk+NVO
	ZMdrinqGv5KtKms4P5LD+TKtKsJjKf7liL51BKSjoCZEmXt+LCVCXrGurngQXwTUSkUgWKtU1BN
	kPgC36DLhcc/hlggB+mH7dybJESD1Z+eVZxKqYNdKrS+g9quyKeEU8qrvH0hgzUJb
X-Received: by 2002:a05:600c:c83:b0:495:40f0:e77 with SMTP id 5b1f17b1804b1-4954a3d59c8mr199333125e9.5.1784629261069;
        Tue, 21 Jul 2026 03:21:01 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565487eeasm59187205e9.13.2026.07.21.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:21:00 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: zlang@kernel.org
Cc: avinesh.kumar@suse.com,
	djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v3] common: strip attr 2.6.0 --restore safety warnings
Date: Tue, 21 Jul 2026 12:20:59 +0200
Message-ID: <20260721102059.93453-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <alpihbK3XQn3I5vR@zlang-mailbox>
References: <alpihbK3XQn3I5vR@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avinesh Kumar <avinesh.kumar@suse.com>

attr 2.6.0 (CVE-2026-54371 hardening) makes "setfattr --restore" print a
warning to stderr when options -P and -h are not given, claiming it may
traverse or dereference symlinks in the dump's pathnames [0]. This warning
leaks into test output and breaks generic/062 and xfs/083 (via
_scratch_populate).

Add a _setfattr_restore helper that takes the restore source as its first
argument, filters out just the expected warning line, and preserves any
other (unexpected) stderr. Convert the callers in common/populate,
common/overlay and generic/062 to use it.

[0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 common/overlay    |  2 +-
 common/populate   |  4 ++--
 common/rc         | 15 +++++++++++++++
 tests/generic/062 |  2 +-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/common/overlay b/common/overlay
index d32f3219..8e89d6e4 100644
--- a/common/overlay
+++ b/common/overlay
@@ -494,7 +494,7 @@ _overlay_trusted_to_user()
 	local dir=$1
 
 	for file in `find $dir`; do
-		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | $SETFATTR_PROG --restore=-
+		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | _setfattr_restore -
 		for xattr in `_getfattr --absolute-names -d -m '^trusted.overlay.' $file  | tail -n +2 | cut -d= -f1`; do
 			$SETFATTR_PROG -x $xattr $file;
 		done
diff --git a/common/populate b/common/populate
index 1c0dd03e..f3672c1a 100644
--- a/common/populate
+++ b/common/populate
@@ -151,7 +151,7 @@ __populate_create_attr() {
 		echo "# file: ${name}";
 		seq --format "user.%08g=\"abcdefgh\"" 0 "${nr}"
 		echo
-	) | setfattr --restore -
+	) | _setfattr_restore -
 
 	test -z "${missing}" && return
 	seq 1 2 "${nr}" | while read d; do
@@ -200,7 +200,7 @@ __populate_xfs_create_btree_attr() {
 			seq --format "user.%08g=\"abcdefgh\"" "${nr}" "$((nr + incr + 1))"
 			echo "user.v$(printf "%.08d" "$nr")=\"${bigval}\""
 			echo
-		) | setfattr --restore -
+		) | _setfattr_restore -
 	done
 
 	# ... and in the second loop we delete all the remote attrs to
diff --git a/common/rc b/common/rc
index 79189e7e..38b77bef 100644
--- a/common/rc
+++ b/common/rc
@@ -132,6 +132,21 @@ _test_fsxattr_xflag()
 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
 }
 
+# Restore xattrs from a getfattr-style dump given as $1 (a dump file, or "-"
+# for stdin); any extra setfattr options follow.  attr 2.6.0 (CVE-2026-54371)
+# makes --restore warn unless both -P and -h are given, so filter out just
+# those warning lines, keep other unexpected stderr.
+_setfattr_restore()
+{
+	local restore_from="$1"
+	shift
+
+	$SETFATTR_PROG "$@" --restore="$restore_from" 2> $tmp.setfattr
+	local ret=$?
+	sed -e '/--restore=.*unsafe.*without/d' "$tmp.setfattr" 1>&2
+	return $ret
+}
+
 # This test requires extsize support on the  filesystem
 _require_scratch_extsize()
 {
diff --git a/tests/generic/062 b/tests/generic/062
index 89659040..845d62f2 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -186,7 +186,7 @@ _create_test_bed
 _extend_test_bed
 
 echo "*** restore everything"
-setfattr -h --restore=$tmp.backup1
+_setfattr_restore "$tmp.backup1" -h 2>&1 | _filter_scratch
 _backup $tmp.backup2
 
 echo "AFTER RESTORE" >>$seqres.full
-- 
2.55.0

