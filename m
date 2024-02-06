Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAC134A6
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241074; cv=none; b=tQgDrMCr2wSbi9VbqjFxoOF4o449/5YT6eG+aqraSi2rRdN1pXpvBse2Ke2uxNtWHXx4bjKBGAst30W2YPKTdABbsfNtxNmL3uQkz2OaqpOa3p87ABS31+xvO1SwRWvx3SMQv0VD9d5n+Ts1NDbwzequT0qoyI2W2YC8r81XQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241074; c=relaxed/simple;
	bh=vKdCM777Ch58NMn8N1R9rtnR8SdDvkB9zxPb7F8050E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJVbSr9rytq6FoTEZ162lWjfZqTDxGpiGYdPCCofF6iyc9R2XD73CCpon1DDISqPSyBSPv/azYSE9GwuBo4uPOqxmx17X17q8lGW3ajA/SD/p3H3kGeJyC8Bf/JXn+c58kMXKF7r5RBEs5Vi8CkGuxbclvldFvvPr4ibJdhWUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tZt2imPC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tZt2imPC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tZt2imPC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tZt2imPC"
Received: from localhost.localdomain (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id CE97122123
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707241070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuwBPxNj2XQQ/IzYjwq5L1r1P5dwyZUAQJelmJyj4aA=;
	b=tZt2imPCm6QW8xWKQ2Qk9X/TED40X1O4brHmizdCR+F88q2MecVZ4WUtoGA3S2rkNzWIgA
	YtgxXg0U5jE1HZTJSwP3YuIXWF9zGu/EEWelCRO0kbmHUxAed3F4CfIJ+1i9O3sD2JuW3E
	bNIRjvDRRpot+evxcFC9uuq8Ggcej9E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707241070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuwBPxNj2XQQ/IzYjwq5L1r1P5dwyZUAQJelmJyj4aA=;
	b=tZt2imPCm6QW8xWKQ2Qk9X/TED40X1O4brHmizdCR+F88q2MecVZ4WUtoGA3S2rkNzWIgA
	YtgxXg0U5jE1HZTJSwP3YuIXWF9zGu/EEWelCRO0kbmHUxAed3F4CfIJ+1i9O3sD2JuW3E
	bNIRjvDRRpot+evxcFC9uuq8Ggcej9E=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH v2 2/2] generic/682: update and fix-up golden output
Date: Tue,  6 Feb 2024 18:36:25 +0100
Message-ID: <20240206173625.18623-3-ailiop@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240206173625.18623-1-ailiop@suse.com>
References: <20240206173625.18623-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

coreutils v9.4 introduced a change in the error output of mv under
certain errno values via commit 3cb862ce5f10 ("mv: better diagnostic for
'mv dir x' failure"), which broke the golden output.

Update golden output to match the change, and further add an output
filter to avoid having the test fail on environments that ran with an
older coreutils release, taken from commit d9323ad7a05e ("generic/245:
Filter mv error message").

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
v2: consolidate g/245 and g/682 mv filter into common/filter

 common/filter         | 14 ++++++++++++++
 tests/generic/245     | 14 +-------------
 tests/generic/682     |  2 +-
 tests/generic/682.out |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/common/filter b/common/filter
index 36d51bd957dd..e7473c9568e9 100644
--- a/common/filter
+++ b/common/filter
@@ -481,6 +481,20 @@ _filter_mv()
 	sed -e "s/^renamed //"
 }
 
+# According to the rename(2) manpage you can get either EEXIST or
+# ENOTEMPTY as an error for trying to rename a non-empty directory, so
+# just catch the error for ENOTMEMPTY and replace it with the EEXIST
+# output so that either result passes.
+#
+# Also, coreutils v9.4 modified the error message when a nonempty
+# destination directory fails to be overwritten, filter the output
+# accordingly.
+_filter_mv_output()
+{
+	sed -e "s,Directory not empty,File exists,g" \
+	    -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
+}
+
 # New stat(1) uses statx(2)
 _filter_stat()
 {
diff --git a/tests/generic/245 b/tests/generic/245
index 81ce4d4e2450..8b8e3e219255 100755
--- a/tests/generic/245
+++ b/tests/generic/245
@@ -26,18 +26,6 @@ _cleanup()
 	rm -rf $dir
 }
 
-# According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
-# error for trying to rename a non-empty directory, so just catch the error for
-# ENOTMEMPTY and replace it with the EEXIST output so that either result passes
-# Also, mv v9.4+ modified error message when a nonempty destination directory fails
-# to be overwriteen
-_filter_directory_not_empty()
-{
-	sed -e "s,Directory not empty,File exists,g" \
-	    -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
-}
- 
-
 mkdir $dir
 
 mkdir $dir/aa
@@ -46,7 +34,7 @@ touch $dir/aa/1
 mkdir $dir/ab/aa
 touch $dir/ab/aa/2
 
-mv $dir/ab/aa/ $dir 2>&1 | _filter_test_dir | _filter_directory_not_empty
+mv $dir/ab/aa/ $dir 2>&1 | _filter_test_dir | _filter_mv_output
 
 status=0
 exit $status
diff --git a/tests/generic/682 b/tests/generic/682
index a51d18338742..b70a4d02e429 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -62,7 +62,7 @@ for ((i = 0; i < dirents; i++)); do
 	name=$(printf "y%0254d" $i)
 	ln $scratchfile $stagedir/$name
 	su - "$qa_user" -c "mv $stagedir/$name $scratchdir/$name" 2>&1 | \
-		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
+		_filter_scratch | _filter_mv_output | sed -e 's/y[0-9]*/yXXX/g'
 	test "${PIPESTATUS[0]}" -ne 0 && break
 done
 repquota -upn $SCRATCH_MNT >> $seqres.full
diff --git a/tests/generic/682.out b/tests/generic/682.out
index b74708117237..db22d5f60487 100644
--- a/tests/generic/682.out
+++ b/tests/generic/682.out
@@ -1,3 +1,3 @@
 QA output created by 682
-mv: cannot move 'SCRATCH_MNT/staging/yXXX' to 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
+mv: cannot overwrite 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
 Silence is golden
-- 
2.41.0

