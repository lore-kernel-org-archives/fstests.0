Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAB481231
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333126; cv=none; b=eAUYA0r8qf1m4qYOA8mJdf7pRhtu+OgQa2eZuHgahWiq4NWZNfcXRWaMSwgp/Y9dRQGrB0GyqNe7FQhfiGBUt5niBW5yXbEbvAklnLMSUbZ76FiXlBE7hd0wmo7g3pSKhDYWOfdFYwrmuzNyupyYzw5yZ0Js+iWrV9UBXtZ5AVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333126; c=relaxed/simple;
	bh=t9XxqTT4YkCYzQkb+YNejxh9qKQUgA3lucESDnrtj4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb8qMAK+QiMRezSSTLroYCuIByavn93xVYSMY92CUXFbZBrspHOc0Zh8t9Xc1BOmQevUFzqqtTQUGK3VCs1f/YRRlPi2vB1FCrrmBupfDxWx44CmZY2gux7saD0exxgy5lkfxMre6Bs5HBTcmfoVg7LdJnr74GJOpmXCbb1VC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2pZPBSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2pZPBSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E691F00893;
	Fri, 25 Sep 2026 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333120;
	bh=7jQDuEETB9OgW2W43+xHGhN9D+NgvEuYo8bbj/MMGZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2pZPBSQ++iMf2oHAXPSO7v7JFSPln+NMrzGSjAXWiYkBKs56/kl1hpRl7p15KDmh
	 E9Fn7sls8PVviUB4+GLe5nkovagIAJ3BMw6ZBXYSDRfTYjXHkuqLScRip1eabAknA0
	 sxzlRKAXaJyR5jMf6kYm6f8cAYzVRlCOXrW+Ez0cTpFFsBEfBZssuTyJCq279JjPJE
	 XEfS2nVOhFFt2z/Ic5Ga1/nmCySUF7fER1sUc3yRg8eIT6ugF+PCs1sz5EuBVGK1Qp
	 Y3p32VvQg6Eus7ez0zXEsnU9rcjw6BWkd9PLAsNsWY1HJMyDKcITkOUETfEY8T6Mh9
	 Jg5nw5jZJfJpQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] xfs/071: use _link_out_link instead of opencoding file picking
Date: Fri, 25 Sep 2026 12:45:09 +0200
Message-ID: <20260925104514.664260-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925104514.664260-1-aalbersh@kernel.org>
References: <20260925104514.664260-1-aalbersh@kernel.org>
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

