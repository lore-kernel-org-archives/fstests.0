Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B22D8376
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712025; cv=none; b=dm5ymjC+gL8c8cTLOn3eGSWYjD/4dnpMD42uPEaGZvZWcmKEp3nYkUmvk7OK8L5mFuQSfw+uOZ+pogSJ1TUDqCjvbKkiE9+/fVKPSDnuE2d5DfhqdqvwYbBQIgFfC6UlQrnk61aDgr3fQdnSWile2M9fIqOv4stFbIaMbx6ZbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712025; c=relaxed/simple;
	bh=//4ZtiwDlnE+L4wFdYwUHi5iWKvKzO+bp+WtHUf44g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q28ey/L2oYCahaTFMKNtId3DtxI/5xWcRTkidUKLHOVCst1Ug/QW5RruGRZJc6QnHwrzTRIIdT58+HxJc7i0yS17LZsE6ffr70npInGu9wRXgwZ0SPJydmu/5fftKYFxfyJBYyZ82Acwe6nmz7B4ZbwKEOfruADsO3eIZQOZ/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GqoLhA+5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GqoLhA+5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso10364905e9.2
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2026 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784712021; x=1785316821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oa1kuLh3pcE0ifKJPtL7e0zunU44Q1OQ3dVEAS20+M0=;
        b=GqoLhA+50iadO0Y6mOQR8mRSCv7JyI8/Y08p47DqjEcIfSMJ/j654uqALqOeLvcIHJ
         +GRKhuQIHEfJ/aEX/ap2dF/OrvpeWc1atO7vqOtRm82v3Yxvx5cUsVMuhgEut6VCooUp
         uCLf4YjD0OMfb5wn7qVMfRE/JkG4h6B/5FxXpRtipcBEP8/qQu/pjnep4SN+hBeh/0ZH
         7sOh4scVDYY9U/vZPTbfWNTjr1FnzPCvT2ytIhnz46vUn54PpA1KHuu2P0ZgXRMW+ybq
         ibJbVvCBfXGu0Jfne++cfgdEj7Uy9eJILKucKXkjhWO3zDCKK7Wc2QDRQmOk0mUNAwF7
         ccBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784712022; x=1785316822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oa1kuLh3pcE0ifKJPtL7e0zunU44Q1OQ3dVEAS20+M0=;
        b=d33Ewog3QVsXUZjmqrB7GAVedGlsuBbJM+xuQaIxzj2GkSK/yynzmRMnZFhDZBw3xt
         IDX/sZmoP2Ccx9eX3Z5Jb5iKr1F8iZBF8fN7aGG0UhhT++oxktVC49PcUTFulOKT6+h6
         DqtTXHCtThKy48UQQEm87wpMBbEO0E0VhzYUBAEEOu5BxrofAzQLQI79CtRZHNxjWcyf
         YftczZNBjTsQeGbQdcANzkTZuCWhzK6l1n/7wkz1s9N0okwr2INAtgiMNq3Ek/ZGmBsd
         E3sa27Ii9ksXXU2P0XXa71/bVzyYsdBbEi5Pksavqsj+c44mXKVxflA87VHpIMfIp4Nk
         fLAA==
X-Forwarded-Encrypted: i=1; AHgh+RoVgJ/dzhIwJEfhrBHjfD1Uwu3/mUQIABNEZ7UhGDMs0ZaENmTREyaURvNBEuckQlc9f3YWU6l8@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQitIYkZPKqIZyOJI8Vcvq1DSUDXcVbiG3kNMHvGHUnH31iop
	bEBXOM9S/Tw7WjBajVC1gz/TxSfPtr3xYdi0gAbitZZ6zrwcvht4oj6gb7nWZ572No0=
X-Gm-Gg: AR+sD11oh5ayjufvf2UqoXMuoFB97jWY8Z2J192QdrbeNDqRe2vdZyUsqk74DnAGZdt
	17iG9kXeIQFAVLvjUhA09C0A5cvzIO8JkmLTPs+AnqPVIp+WsE3TVpIBaXBVkCIY3Migxmq4b1E
	CIc7Ak4DgmnfBy8DWDH2i3gYEEncCtf0mhKFvT4T9pvUjvGn3NUaWdQg0BeuDulYh0ptdR9eDel
	gcitNtWTEGipP1ULoEQIjOd7XJZhxsGpz5+4piR6G/ThQChZ4m+IdrvkK3sMogL0RLi42KKClng
	byygFPaBItedojT3F/wW3D1zBYxWwpPO4aYgy1Xv+gW0E1rEPRqsCf00+vxIbx8Ab9KcD8nxkgc
	wYJyUYdBg8yQJTHrCQn5xIFvMl8fkEfW1iqGQormiwXiU93wpbrBeom5OmY1WRz0LfP6+5Rqxsv
	4=
X-Received: by 2002:a05:600c:1396:b0:493:b150:c607 with SMTP id 5b1f17b1804b1-4954a3f36a9mr243390715e9.12.1784712021424;
        Wed, 22 Jul 2026 02:20:21 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm4658432f8f.2.2026.07.22.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:20:20 -0700 (PDT)
From: Avinesh Kumar <avinesh.kumar@suse.com>
To: zlang@kernel.org
Cc: avinesh.kumar@suse.com,
	fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v4] common: strip attr 2.6.0 --restore safety warnings
Date: Wed, 22 Jul 2026 11:20:20 +0200
Message-ID: <20260722092020.202100-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <al_jUSscUbp9HGVv@zlang-mailbox>
References: <al_jUSscUbp9HGVv@zlang-mailbox>
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
 common/rc         | 15 +++++++++++++++
 tests/generic/062 |  9 ++-------
 4 files changed, 20 insertions(+), 10 deletions(-)

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
index 106f044a..f5673113 100644
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

