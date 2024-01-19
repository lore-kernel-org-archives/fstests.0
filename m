Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214D1DDC3
	for <fstests@vger.kernel.org>; Fri, 19 Jan 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653819; cv=none; b=q2U/mHXNBgTaAkUWLCoIp15QqlBdWgHAfL8UfXG4l/HAjcUkmpfPC/Jt5mxq9v2l0NsrvoB1mMan0FC1wEFXcQbPlRPCa+oOXWRAVZeOI3HJQO3LdPP2I9ix7i9xfiSXCtnKhAew3ZCg4/Rfhst8BIk5DHb5JuYxXt/PdsWg2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653819; c=relaxed/simple;
	bh=qYyAnMcQuIcalrkCRnGZGPf8WtS/vGydunD+OOmYeEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bb1TmvU5dIvtn+DTx9sQpMADqlpQRdcqI1BwVfHLORbmwsMg9yzKUd2zbNTz7f+FEqadWAwtF0e1k+cZdP1XcDQoTnS0zNOzHGMbk3u6bPmTs+jL35dqCCyVCrPXYs7qyGYDkmUCYaQIH1twjLV/hMfUUH6iA9247zTUOG+VxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W-vVsyq_1705653804;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0W-vVsyq_1705653804)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 16:43:27 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: fstests@vger.kernel.org
Cc: Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 1/1] generic/682: apply 'mv' error message fitler.
Date: Fri, 19 Jan 2024 16:42:44 +0800
Message-Id: <20240119084244.56373-2-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240119084244.56373-1-mengferry@linux.alibaba.com>
References: <20240119084244.56373-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As coreutils update to 9.4+, the 'mv' command change also results in
the mismatch output of generic/682.

This case is similar to generic/245, you can refer to 'generic/245:
Filter mv error message'(commit d9323ad7a0). Now seperate this filter
as '_filter_mv_err_msg', move it into common/filter, and apply in
generic/682.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 common/filter         | 13 +++++++++++++
 tests/generic/245     |  9 ++++-----
 tests/generic/682     |  2 +-
 tests/generic/682.out |  2 +-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/common/filter b/common/filter
index 509ee950..55f3f855 100644
--- a/common/filter
+++ b/common/filter
@@ -651,5 +651,18 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
+# coreutils 9.4+ modify the error msg of command 'mv'. To be compitable with
+# various coreutils versions, we synchronize the output to the latest version.
+# coreutils change was added by this commit:
+# commit 3cb862ce5f10db392cc8e6907dd9d888acfa2a30
+# Author: Paul Eggert <eggert@cs.ucla.edu>
+# Date:   Sat Jul 22 13:39:17 2023 -0700
+#
+#    mv: better diagnostic for 'mv dir x' failure
+_filter_mv_err_msg()
+{
+        sed -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/245 b/tests/generic/245
index 81ce4d4e..4cf7c112 100755
--- a/tests/generic/245
+++ b/tests/generic/245
@@ -29,12 +29,9 @@ _cleanup()
 # According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
 # error for trying to rename a non-empty directory, so just catch the error for
 # ENOTMEMPTY and replace it with the EEXIST output so that either result passes
-# Also, mv v9.4+ modified error message when a nonempty destination directory fails
-# to be overwriteen
 _filter_directory_not_empty()
 {
-	sed -e "s,Directory not empty,File exists,g" \
-	    -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
+	sed -e "s,Directory not empty,File exists,g"
 }
  
 
@@ -46,7 +43,9 @@ touch $dir/aa/1
 mkdir $dir/ab/aa
 touch $dir/ab/aa/2
 
-mv $dir/ab/aa/ $dir 2>&1 | _filter_test_dir | _filter_directory_not_empty
+# Also, mv v9.4+ modified error message when a nonempty destination directory fails
+# to be overwriteen, now use _filter_mv_err_msg to ignore the difference
+mv $dir/ab/aa/ $dir 2>&1 | _filter_test_dir | _filter_directory_not_empty | _filter_mv_err_msg
 
 status=0
 exit $status
diff --git a/tests/generic/682 b/tests/generic/682
index b4cd0cd9..8e6c2497 100755
--- a/tests/generic/682
+++ b/tests/generic/682
@@ -62,7 +62,7 @@ for ((i = 0; i < dirents; i++)); do
 	name=$(printf "y%0254d" $i)
 	ln $scratchfile $stagedir/$name
 	su - "$qa_user" -c "mv $stagedir/$name $scratchdir/$name" 2>&1 | \
-		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
+		_filter_mv_err_msg | _filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
 	test "${PIPESTATUS[0]}" -ne 0 && break
 done
 repquota -upn $SCRATCH_MNT >> $seqres.full
diff --git a/tests/generic/682.out b/tests/generic/682.out
index b7470811..db22d5f6 100644
--- a/tests/generic/682.out
+++ b/tests/generic/682.out
@@ -1,3 +1,3 @@
 QA output created by 682
-mv: cannot move 'SCRATCH_MNT/staging/yXXX' to 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
+mv: cannot overwrite 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
 Silence is golden
-- 
2.19.1.6.gb485710b

