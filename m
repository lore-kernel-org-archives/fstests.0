Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379B80046
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315395; cv=none; b=mLP7lj/1mVWEH6TrI9OJpvHtLsV29KoYiUVLtojFm51CT3rd9Zle5a09HxlriUSZH1Y2EGrCZw5Pa0YB/zPGPPb/5lJ9QkC6kTvh7f4YnQDLjA19jlnFqtkqe1C6VMTFcQOO0diUGyG6q/kjiKRZeDAgpk1bqoZYvbRWqFoR9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315395; c=relaxed/simple;
	bh=r9nBBZzO84CW4PBODHwnVB8Opm9ooHzcMy+73fA2sro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dY7FqaKZHs+lCOdPDFBhqXgwZc5KsD4WCOaj91my0yxQft9tNGLgCvePS16NMgOpb5forts0tSmmHeWNR8Q/YtDNb9Owyejzxc8qEBkwPVBI2Q6swSIaprnfz/gpSlJlB26pGdeny4/dYkhRRqvrJjwNbsdpMGLw6KlTH8//W7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQjLocLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQjLocLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981ADC113CC;
	Fri, 10 May 2024 04:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715315394;
	bh=r9nBBZzO84CW4PBODHwnVB8Opm9ooHzcMy+73fA2sro=;
	h=From:To:Cc:Subject:Date:From;
	b=gQjLocLkxxZNiDZpW9K+hBZJ2I6TbFdvmH1Nscr/eP5OWoV0ebd63oMoyMS3z8wX9
	 dDdFHh9BTsUyOb3AFRDbkP3bqQwrGU4G8QW6PjtgXXCFexsldmAueEHstdC8cEAcj9
	 JzOIuZiV5MkFvjHDvuOwIPq28jor7ZCLxJLnN2VV6TzDGvGR8Z/rMt2+/jmkkZyyIy
	 tjG2RDRDeVMr0GMVl8lgmqTbLitxu28iTUzZzifUOiDMs2ixJhQ8epeIFsltAWsgF5
	 wb7FQa6h3ORaatmVWOGGvOs2g04ttnc3upVifwBlgXm1iuxDGtMpomK+XFpRy7PJTQ
	 Xmm8Wg+phP0ng==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] fstests: fix _require_debugfs and call it properly
Date: Fri, 10 May 2024 12:29:45 +0800
Message-ID: <20240510042945.1237711-1-zlang@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old _require_debugfs helper doesn't work now, fix it to check
a system supports debugfs. And then call this helper in cases which
need $DEBUGFS_MNT.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

V2 remove the changes on xfs/499, will do it in another patch.

Thanks,
Zorro

 common/rc       | 10 ++++++++--
 tests/btrfs/150 |  1 +
 tests/ceph/001  |  2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 56f1afb6..6f0bdf60 100644
--- a/common/rc
+++ b/common/rc
@@ -2978,8 +2978,14 @@ _require_sparse_files()
 
 _require_debugfs()
 {
-    #boot_params always present in debugfs
-    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
+	local type
+
+	if [ -d "$DEBUGFS_MNT" ];then
+		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
+		[ "$type" = "debugfs" ] && return 0
+	fi
+
+	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
 }
 
 #
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index a02bdafc..fd386d92 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
 . ./common/fail_make_request
 
 _supported_fs btrfs
+_require_debugfs
 _require_scratch
 _require_fail_make_request
 _require_scratch_dev_pool 2
diff --git a/tests/ceph/001 b/tests/ceph/001
index 060c4c45..79a5f58a 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
 
 # real QA test starts here
 _supported_fs ceph
-
+_require_debugfs
 _require_xfs_io_command "copy_range"
 _exclude_test_mount_option "test_dummy_encryption"
 _require_attrs
-- 
2.44.0

