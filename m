Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57342901D
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155999; cv=none; b=N1DwJ1uHEDS82hbZGiZhIgEhaL6Cy3v9TO8+cHE/dgmc9JKo92nIJ403bdrycwYEJmyS3lCcni814akkx1qeGuF3O6b64SkpWPgt9nGIup2v4LuKiDHAX1ehXAkfpCIsLQesaZjiL4LtNg4kS14RthHELB2VXQtFUwW7f5rnESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155999; c=relaxed/simple;
	bh=t9XxqTT4YkCYzQkb+YNejxh9qKQUgA3lucESDnrtj4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQX/oPNgE0MP+3Z5eFGNu3FHjOWBwPCCsqiPGGsu83qlKo3cEUJ/bLiTJkSrtmg/+PqxQ0BoejsFcGb9QQOGlHrjcaFg9CBV+QTbiiyQNF3S0XRhZhsYYZECfnqeWPUsAw1u2llc4nRuC2Vleu1hkmEHj1U6v3rRutkYnu5L5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1NBx5jy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1NBx5jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC491F00893;
	Wed, 23 Sep 2026 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155997;
	bh=7jQDuEETB9OgW2W43+xHGhN9D+NgvEuYo8bbj/MMGZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1NBx5jy5v7fjyjrpyxCIjN7TKZnUEjtzMdgwsOapEfuopMG1mBpJxm3322Jfh4lH
	 CO5iKmgawwOe/O3y7DYfukFr9bRypMwydWmBPZeZO7pVxbMppQmO3lNsUji/q0HjZY
	 WvtUu+YzoM/Qgzm/Wf4kYwtgDLZ1bfEJbWIUBnZAd/IGUztZQHNNFmeU3ZEAzp+te7
	 YTQ4ZHvZ3i6VxDYwYfuBoaCiWqnAkMNDZI8ajqykRc3/IcKwETsvsX7OaYDsMHiAAN
	 3eO0Cy/Iq2WqI/rUcaipAwNfMApzJdxphgj8hUEOW0vpRUGhHin6YnLszfiGzizfnU
	 G6RQf9tKL7WcA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/4] xfs/071: use _link_out_link instead of opencoding file picking
Date: Wed, 23 Sep 2026 11:32:52 +0200
Message-ID: <20260923093259.16199-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923093259.16199-1-aalbersh@kernel.org>
References: <20260923093259.16199-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's function which handles picking the right output file based on
the .cfg.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/071                             | 7 +++----
 tests/xfs/071.cfg                         | 1 +
 tests/xfs/{071.out.64 => 071.out.default} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 tests/xfs/071.cfg
 rename tests/xfs/{071.out.64 => 071.out.default} (100%)

diff --git a/tests/xfs/071 b/tests/xfs/071
index c4722f67181a..47874e505c01 100755
--- a/tests/xfs/071
+++ b/tests/xfs/071
@@ -5,7 +5,6 @@
 # FS QA Test No. 071
 #
 # Exercise IO at large file offsets.
-seqfull=$0
 . ./common/preamble
 _begin_fstest rw auto
 
@@ -22,11 +21,11 @@ _cleanup()
 
 bitsperlong=`$here/src/feature -w`
 # link correct .out file
-rm -f $seqfull.out
+seqfull=$0
 if [ "$bitsperlong" -eq 32 ]; then
-	ln -s $seq.out.32 $seqfull.out
+	_link_out_file "32"
 else
-	ln -s $seq.out.64 $seqfull.out
+	_link_out_file ""
 fi
 
 _filter_io()
diff --git a/tests/xfs/071.cfg b/tests/xfs/071.cfg
new file mode 100644
index 000000000000..e806b07bc08b
--- /dev/null
+++ b/tests/xfs/071.cfg
@@ -0,0 +1 @@
+32: 32
diff --git a/tests/xfs/071.out.64 b/tests/xfs/071.out.default
similarity index 100%
rename from tests/xfs/071.out.64
rename to tests/xfs/071.out.default
-- 
2.54.0

