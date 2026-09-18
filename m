Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F751C341
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752764; cv=none; b=amZVR3116fSTQAe2cdG97blOQAsrUJlQrTs/XtmpLBE6qT0KBTehZWt8sE1MygaadfNM32Kjj6v3a4x1aDIudlHxi6y6AzokyVip1yQUgXOXIe7u1v2ljvU7AJt5mbB7o1sUJlLsCfVzkw5ef2rbbhGyUzj4l6w3fe3ouMpARz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752764; c=relaxed/simple;
	bh=0+8oer3cqnv1rTjwQlnyIv2UflznV8+WD9sS9cFhRoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azAoOtmKxe3hkV0NBxYtu3qfjHVKkJ8k651AS+51tZC295LfcF8uvBoJcGvhBxSrTFb8ielNiYQibHkemT/ymo+UwhjmaOgLf7m04uIRDbahIEByt7c6ckIlR1X+AVhpVhOBR3aGjh4ool/F2SjfSh6l1MKlogrKfn9K2kJ+vAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXo+v+tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXo+v+tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A271F00898;
	Fri, 18 Sep 2026 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752754;
	bh=eduYpjGzJHYsb0Bcy1EWE1b+Ppno7GQkLFA1AG/pzhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXo+v+tMnJr8cNYjBdrO3Yv9o9VxyrsN0UGQtz6P6XcFK+L14NcrvLYwqBt8yuPwh
	 6q++CBUKvZhB4FxSHwCm7T0Sd/e7hzxGUQDUAr0/rAejDxqvA9vwp+XaDyhDKYjXCy
	 2nicPujhlKpRn3jqQCzKTD+CgASSdL9dldkqmd47z8AYSuHB3QaNhJskqjczVzQHk6
	 VgP2/WjvgrVSi9yQaej3kdRV54LIE33lMSSqQjrp/djtxeWueoENh+hIs2Q+W4tHB3
	 z3bLDs4Yj/EFXU8m6ZaZSEm2oOWV1kDTPVLMeO9/kPi5xCc+j2ExdvxQC6K3+F+1sX
	 px116xbKkOC4Q==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 1/4] xfs/071: use _link_out_link instead of opencoding file picking
Date: Fri, 18 Sep 2026 19:32:06 +0200
Message-ID: <20260918173218.1254465-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918173218.1254465-1-aalbersh@kernel.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's function which handles picking the right output file based on
the .cfg.

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

