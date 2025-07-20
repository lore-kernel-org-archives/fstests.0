Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DC19F130
	for <fstests@vger.kernel.org>; Sun, 20 Jul 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752984006; cv=none; b=H89hKBZEBdMKDuQaRN/DbaKOPWedOYk9w0yxQlIXa7Bb6CQCv3smYJqNIN/mgcq86SpNXR+pM/FMxZTbVrN3q/AdyQXpaBfKqchNKruGvSDOY84MBA/5gcF2QTd2u0Qp8YC6IzHYZtifCJVH7vtd2F+zrwY4ozDL5+DRJkIF0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752984006; c=relaxed/simple;
	bh=Z3pacpl1JrnIJvBONbc8OyMi7/KlaJZfUZcu2lvBAto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKbGIv1//hJy4N6wYtvbQGg5uQ4EJzmnqH8L1cubrXncA2aitjH1FtjVzKtQYxr41QV5uUY5HHM2ag4HkrCTEGHzXlGO1AsFanxmoNRic//NHUP8Zm0S8ZHV3EXihaXIVsBZ/ttiVtDOGI/ayvG6aBlloUQMN9zAPI9/bxiq4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dd038/Jw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dd038/Jw"
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56K3xoYY017324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 23:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752983991; bh=6jgPqUBNPym+CiT7fTGRN8lj1FW8dhLGKiJkXx+azfg=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=dd038/JwPygu6aT+yMn1qKASn0THGdSLJbh2cbccrfW6yOFqFQq4r42eIIB6XXnE7
	 aX8FH1WepIPP71SRPWQ6jsR9Lr9gDmCUpOtGuveBCHVSrZa66Q7dY0uZn2wY0Qwrk6
	 iM19eB/jantNI0TM587Sca1bk3OSClF/CmAUEYhrJ43zIzv24J4q8sPGA4+PxMjb4c
	 +ikSRRmFXSJjwDprdg/n2FZ2tlb//S3Z3JHHhSwJCsN+55YFvqR1Yi8EmS97oF9deE
	 FT4lA5Q5tM94cVRQ4YsD1whIqYpehXgOYrLVTIUlKcR57p6lZVtSwxCt/rOuPSYfF9
	 RiB+aXOo3OItQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DEFD32E00D5; Sat, 19 Jul 2025 23:59:49 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2] ext4/028: require that the scratch file system has the extent feature enabled
Date: Sat, 19 Jul 2025 23:59:44 -0400
Message-ID: <20250720035944.745656-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the file system configuration has journalling enabled, but doesn't
have the extent feature enabled (e.g., when testing the ext3
configuration) the test will fail since _scratch_populate_cached
creates files with extents enabled.  So add a check to skip the test
in that case.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
v2:
  * use $DUMPE2FS_PROG instead of dumpe2fs
  * collect Reviewed-by tag

 common/ext4    | 23 +++++++++++++++++------
 tests/ext4/028 |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/ext4 b/common/ext4
index f88fa5324..a2ce456d4 100644
--- a/common/ext4
+++ b/common/ext4
@@ -165,15 +165,26 @@ _ext4_mdrestore()
 	return $res
 }
 
-# this test requires the ext4 kernel support crc feature on scratch device
+# this test requires the ext4 kernel supports a particular feature
+# on the scratch device
 #
+_require_scratch_ext4_feature_enabled()
+{
+    if [ -z "$1" ]; then
+        echo "Usage: _require_scratch_ext4_feature feature"
+        _exit 1
+    fi
+    _scratch_mkfs_ext4 >/dev/null 2>&1
+    $DUMPE2FS_PROG -h $SCRATCH_DEV 2> /dev/null | grep -q "$1" || \
+	_notrun "$1 not enabled by this filesystem"
+    _try_scratch_mount >/dev/null 2>&1 \
+	|| _notrun "Kernel doesn't support $1 feature"
+    _scratch_unmount
+}
+
 _require_scratch_ext4_crc()
 {
-	_scratch_mkfs_ext4 >/dev/null 2>&1
-	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
-	_try_scratch_mount >/dev/null 2>&1 \
-	   || _notrun "Kernel doesn't support metadata_csum feature"
-	_scratch_unmount
+    _require_scratch_ext4_feature_enabled "metadata_csum"
 }
 
 # Check whether the specified feature whether it is supported by
diff --git a/tests/ext4/028 b/tests/ext4/028
index 1b8855098..254074f08 100755
--- a/tests/ext4/028
+++ b/tests/ext4/028
@@ -24,6 +24,7 @@ _exclude_fs ext2
 _exclude_fs ext3
 
 _require_scratch
+_require_scratch_ext4_feature_enabled "extent"
 _require_populate_commands
 _require_xfs_io_command "fsmap"
 
-- 
2.47.2

