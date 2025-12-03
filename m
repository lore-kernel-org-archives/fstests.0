Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897D2FDC4F
	for <fstests@vger.kernel.org>; Wed,  3 Dec 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790320; cv=none; b=HyoYMQDFl6i9kOrkYc8vuBU/WOaOyR7nWDymM8jQrVagk9iYJ5o13U2fsD13qZFyu1N9+asH6n1Sc1iT3xXqNO+JkUCMwq6YnIXkZ5G6bU2QpuamWo3CNmr/MpeXYgrzItZ2gUuqwj3Xc0oTje3kSWxUixzGC6SQ57/wJq0KLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790320; c=relaxed/simple;
	bh=JQ73DsR3vSrwlgoERKzmcSkW9Qw/PCxxhEFOlNAOaEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dygoraa+1JV7XXW/0cqM7b/PYJTbfKBA2mvyR11PayJmDPPMKR2cfihT6snW5PkI8CwwzwmrMxMivM2wdk18iRJNUnhfH7zWnSU6OWqeNaGOjGFTTxIPr1iRSETS0QleYkyBMyqv+jDYMTRD8VGrJ1/8Z/gvVdWRHKpQnIJKTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZySEC99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZySEC99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B29AC4CEF5;
	Wed,  3 Dec 2025 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790319;
	bh=JQ73DsR3vSrwlgoERKzmcSkW9Qw/PCxxhEFOlNAOaEM=;
	h=From:To:Cc:Subject:Date:From;
	b=mZySEC99H7CU+jjMAeqEnydP7UxQHV96VkVIt8mur31YCqfGemquRT76yDTGmdJim
	 n0WEDSQAzy9n1QpHLEgb26MUWcoorPi+vFDAoeXh2LURtMrGMykHmFuwBSCMG8CXwG
	 5itnzPoPQow6dfw+qHsRzsIEE36UsNkt9I7xfuLORvzUZYdA0LjVc2bqp63jr4fH5l
	 JtTPGH+dC0IQ+x3eoeQewOiae+nDmdNNDv7ZGZ4rq17BA8h5gH55XKvbuuvxjDH7YB
	 rE6Sn1p4ORI8mvvVMHLrETatp427Mzmh2TVEvS4MbhcwMSLOFRMxglGyTYaotVm6cU
	 vyEdJ2iRR3zvQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] common/quota: fix to wait for all inodes been evicted in _check_quota_usage()
Date: Thu,  4 Dec 2025 03:31:47 +0800
Message-ID: <20251203193147.3320893-1-chao@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/233  3s ... - output mismatch (see /share/git/fstests/results//generic/233.out.bad)
    --- tests/generic/233.out   2025-01-12 21:57:40.259440359 +0800
    +++ /share/git/fstests/results//generic/233.out.bad 2025-12-04 03:02:26.000000000 +0800
    @@ -4,4 +4,12 @@

     seed = S
     Comparing user usage
    +4c4
    +< #1000     --   31476   32000   32000            994  1000  1000
    +---
    +> #1000     --   31476   32000   32000            944  1000  1000
    ...
    (Run 'diff -u /share/git/fstests/tests/generic/233.out /share/git/fstests/results//generic/233.out.bad'  to see the entire diff)
Ran: generic/233
Failures: generic/233
Failed 1 of 1 tests

Sometimes, generic/233 will fail due to it founds inode count is mismatched
in between in-memory one and on-disk one.

The reason is cgroup v2 implementation requires to increase inode reference,
and then attach it to thread related cgroup writeback structure, once it
needs to switch once write owner changes of target inode, a kernel thread
will process it and then release inode reference via evict_inode().

So, sync & drop_cache may not guarantee all inodes being evicted, as cgroup
has one more refernece on inodes during the time.

If inode has not been evicted, dquot inode reference will not be release, it
will lead to inode quota mismatch.

Let's add a delay to wait for cgroup switching completion before quota check.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/quota | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/quota b/common/quota
index a51386b1..de7e84e8 100644
--- a/common/quota
+++ b/common/quota
@@ -333,6 +333,9 @@ _check_quota_usage()
 	# XXX: really need an ioctl instead of this big hammer
 	echo 3 > /proc/sys/vm/drop_caches
 
+	# wait for inode_switch_wbs_wor_fn() to release inodes
+	sleep 3
+
 	VFS_QUOTA=0
 	case $FSTYP in
 	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
-- 
2.49.0

