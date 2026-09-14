Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311F41D239
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380518; cv=none; b=Oar4dJReNYGQ0RHrQeXOYQpwd4NDzm/CxdYQNaUXeKuPGqwEYjgyrGVMIVb6dGune0+n3s2lqQN+AFo5+epPD7lv8MfyyQlswiQtVAxy96UVqrhTOo4dcCB5q39KO/+vBVSOdADrumD5oogSwR9er/FQ/eZZ9DGCl52UBhnE08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380518; c=relaxed/simple;
	bh=Vn5SM3iIAQTmu8sUIMw9mRBm48UPeubHk2u1XWc7q3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPG7yMTr7eFlEfTeS4B1DmyJRY9mKfOsKR3dJkLFmMvaTwGTSFhouRuBe20lTt0rkH7YJoZzZweAMPfnz/vQWMLEZ1L/An0gZFm0JLDm0XguZyBEkiExh5qDMa68/vh1PBmqeC7WyOmaOIxXu2kas7GQRO4FST4rxKr7mskKqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hC6S7vmS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hC6S7vmS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3104430f8f.1
        for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789380515; x=1789985315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mueyJH6jKrLKyFHlry3q5pCHpBw5xJU1ZO67WrC/x5w=;
        b=hC6S7vmS6nmW1in/u265/9TfpftCF6rH2849I5BC4sK/m7JSWU1zxIJZjj0vmD0ZJO
         3fWGc8xDfTVrEAwsi2+0lMTyebAk5yAJhafBuFJ0CR6EU8gN678/TOHQtB4YwXUx9abD
         Dh/efUAsOb17AVAxvShhnSCCCLmBfVgNOpLisNpdq/BXGOTiYSKX3HTFkW2ra22Z+Ueh
         +Ct87cPe0xUvn+qAY5sPX1JMU+ESviVFKscWKXpOZJ8oZrxapCQfHrsDRhwdKINCp8Km
         X7h26nR/jZ00zhylB1S3khygN9skx099tLGlJl+fd0o7k++5lDJWMHb7WXOzEhsbeL1j
         FyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380515; x=1789985315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mueyJH6jKrLKyFHlry3q5pCHpBw5xJU1ZO67WrC/x5w=;
        b=a5GCuvEYTDl8s2cPijSizWEhPKhYoqAhs3fZqDERNBT9RQgpJugAkJYuVeE1oC4krR
         e2XZeutwgW21/UB/YlUlnr7U/JuJTNnuw1eVu7VFOnV2hDoLgexhXz0BgE0aUGpIVQTc
         K7cPz7+a+98/NicnpB/NbrI1B0tIjbEye8TSD4C3OQjfrYOd02vGp8IRowBIvwppXlmp
         x//nMGNING/tTYb/t+wNRdu9rwn9Vo0KHJAuSDnFpprk67SkXcHjxFySBJMu76G5QKrE
         pMaeaOmRsK45SqESU+5kAgckQtly7gft6Jgbb0cgYHplCIaDV4V7IgOl7nsunwIWObib
         fl/g==
X-Forwarded-Encrypted: i=1; AKwUvBxQZy0WfhRCuRYIA51mlS5KFux8fO2nzbUy6flrUYf3Su3KAMosBaBeoLTLQK/WbdphW6CEfC6u@vger.kernel.org
X-Gm-Message-State: AFuF++nQMC2JF63/UTtRO0zuAzBezAWAbgXt962Zw8pcWSJPpfrF/ttI
	+so8r4g3wF0/tR6hIGVRJgVltHuIDiabShWeVx/HQho3D8wqzQRRtF4VlhvXVESTBA6hbjltQ6K
	ZG1hEku0=
X-Gm-Gg: AYBFou3xsGnoRLwtceAtiZwR0RCXkLqNLxOxUFIwNkGs9ykE1bodUrcHSLbhQcXQZY9
	OzMwyeJ/cSRf/9JDJe9HtcfQFBbazRwA6trXsyAZB8QTXLXPqYz3p+3I1CKJ4ECP/GLRXr+R7KK
	1+1fxmDY5vd3peCqxCzZGYvUp78fG974s/5Oj64BkOKL7fnXCB/iQEEDfo1IYeVleo82ON2NIUa
	5RmJc7oZWtioaG0AQkA8ceaFBvv4TjUwBZEYUlvmeoT35gJ9OkuH7Etutc3N5ifU95BquiTVUkf
	Fbj2/gLXC6IvD5GPHCrC78KYCE1xGIY4KCtNGiI3Zj+js7TvdEi9np1490BCcHEt0drB2mI/OYK
	1/MaraoauUWqJZ1Us+wvXIfAKr77ykQK4EyypkxSAzR6X3rUf7otw2TLFQujm7ZORVC03xj28N9
	WdI8eocVF2gFvHAkyl1rH1YWjBXcy35/G2WBzo2TwlQDmtxi/6Y5Xf/DBO
X-Received: by 2002:a05:6000:2685:b0:484:4880:449d with SMTP id ffacd0b85a97d-48702aceed7mr2467071f8f.3.1789380515102;
        Mon, 14 Sep 2026 03:08:35 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f0403125sm22836283f8f.8.2026.09.14.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:08:34 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: zlang@kernel.org
Cc: avinesh.kumar@suse.com,
	djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v5] common: strip attr 2.6.0 --restore safety warnings
Date: Mon, 14 Sep 2026 12:08:34 +0200
Message-ID: <20260914100834.117301-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ame8dTuRy-A_NjGV@zlang-mailbox>
References: <ame8dTuRy-A_NjGV@zlang-mailbox>
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

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 common/overlay    |  2 +-
 common/populate   |  4 ++--
 common/rc         | 14 ++++++++++++++
 tests/generic/062 |  9 ++-------
 4 files changed, 19 insertions(+), 10 deletions(-)

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
index 8add0eed..ccbc02b8 100644
--- a/common/rc
+++ b/common/rc
@@ -132,6 +132,20 @@ _test_fsxattr_xflag()
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
+	$SETFATTR_PROG "$@" --restore="$restore_from" 2>&1 | \
+		sed -e '/--restore=.*unsafe.*without/d'
+	return ${PIPESTATUS[0]}
+}
+
 # This test requires extsize support on the  filesystem
 _require_scratch_extsize()
 {
diff --git a/tests/generic/062 b/tests/generic/062
index ddf0a478..845d62f2 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -30,12 +30,7 @@ getfattr()
 
 setfattr()
 {
-    # attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
-    # -P/--physical is unsafe because it can traverse symlinks. Older attr does
-    # not accept -P, so just filter the warning to stay version-agnostic.
-    $SETFATTR_PROG $@ 2>&1 | \
-        sed -e '/^Warning: option --restore=file is unsafe without option/d' | \
-        _filter_scratch
+    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
 }
 
 _create_test_bed()
@@ -191,7 +186,7 @@ _create_test_bed
 _extend_test_bed
 
 echo "*** restore everything"
-setfattr -h --restore=$tmp.backup1
+_setfattr_restore "$tmp.backup1" -h 2>&1 | _filter_scratch
 _backup $tmp.backup2
 
 echo "AFTER RESTORE" >>$seqres.full
-- 
2.55.0

