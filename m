Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6C1FA4
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315629; cv=none; b=hxDc2aUWaf2YP2VSDb62TGE0u4CG+Dh6qXygLLbrdn2J1arRC0tbAC466m4RW7ioroqmYGGRrjsayzK1iw9fpVqf88qYlRqg7tOiocOSOuQytPldGLZU7L4rM/6ZtP6iltWDiSoWoaTXw4V4V0mCxXw5ZjM+4JiuV8iWOfshpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315629; c=relaxed/simple;
	bh=BremlgTX3hGc6XVcLwo7z9OMDVod3zZ9IIG0oi0ZY2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FCreSxvblJImeOBawuPvvw7nNAE1ShJ4UKZ6v5zb/CBBRIgBLMMxzeQBF/xK7udwsaWmVnbppTbcljCR4cYuG9M6U8WRKwMOUXmN9UtfXNdPSvZS+nxJGSgR1EnzcE4kczXevHateBBMhEdFItaMInftdSQ1Mcwu/VxjVBEmzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGeSmZsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGeSmZsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FDFC113CC
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 04:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715315629;
	bh=BremlgTX3hGc6XVcLwo7z9OMDVod3zZ9IIG0oi0ZY2s=;
	h=From:To:Subject:Date:From;
	b=KGeSmZsBSUVoMmA5/aatSyGSOUJilC1tM3U9hldN9LIB2ewXUCP1d1j9Llt+o/tuG
	 8bWyMwLbgIWpinu1CvvM44ucSLp0tAZlK+/UGdx32l8tc7qD5+hUwm+QXaqS4/s0VY
	 1fTnP1jB1lM0lOY89ci7MYZfeVTIBxeFc32G/Wg2WxyBcuAzQJ3UWR4RaESVrfcKfe
	 MXZlObGAUxai4kucoXt0MPV/GizrB/9sxXQvY0g0c/U9th8xnjJ5qeYKsn7m/ncD3i
	 XpKxIlJqMm5Nwc65b+D0/zKG28p3ARc0YU69Hn5F6prD6V4LMtLvGK3DZgdaG1Paso
	 ReKsTbMO6MOiA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH] common/tracing: use /sys/kernel/tracing at first
Date: Fri, 10 May 2024 12:33:39 +0800
Message-ID: <20240510043339.1238462-1-zlang@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid the dependence of debugfs, tracefs is mounted on another
place -- /sys/kernel/tracing now. But for the compatibility, the
/sys/kernel/debug/tracing is still there. So change _require_ftrace
helper, try to use the new /sys/kernel/tracing path at first, or
fallback to the old one if it's not supported.

xfs/499 uses ftrace, so call _require_ftrace in it.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/tracing | 13 +++++++++----
 tests/xfs/499  |  6 +++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/common/tracing b/common/tracing
index b3051c27..8613d044 100644
--- a/common/tracing
+++ b/common/tracing
@@ -4,11 +4,16 @@
 #
 # Routines for dealing with ftrace (or any other tracing).
 
-FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"
-
 _require_ftrace() {
-	test -d "$FTRACE_INSTANCES_DIR" || \
-		_notrun "kernel does not support ftrace"
+	if [ -d /sys/kernel/tracing/instances/ ];then
+		FTRACE_ROOT="/sys/kernel/tracing"
+		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"
+	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
+		FTRACE_ROOT="/sys/kernel/debug/tracing"
+		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
+	else
+		_notrun "The ftrace is not supported, or tracefs is not mounted"
+	fi
 }
 
 _ftrace_cleanup() {
diff --git a/tests/xfs/499 b/tests/xfs/499
index 9672f95d..883415dc 100755
--- a/tests/xfs/499
+++ b/tests/xfs/499
@@ -14,18 +14,18 @@ _begin_fstest auto quick
 _register_cleanup "_cleanup" BUS
 
 # Import common functions.
+. ./common/tracing
 
 # real QA test starts here
 _supported_fs xfs
+_require_ftrace
 _require_command "$CC_PROG" "cc"
 
 cprog=$tmp.ftrace.c
 oprog=$tmp.ftrace
 sedprog=$tmp.ftrace.sed
 
-ftrace_dir=$DEBUGFS_MNT/tracing/events/xfs
-
-test -d $ftrace_dir || _notrun "ftrace not enabled"
+ftrace_dir=$FTRACE_ROOT/events/xfs
 
 # The second argument to __print_symbolic is stringified in the tracepoint's
 # fmt file, so we look for "{ NUM, STRING }" and try to separate each of them
-- 
2.44.0

