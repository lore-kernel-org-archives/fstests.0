Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B591227E84
	for <fstests@vger.kernel.org>; Thu, 20 Mar 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498900; cv=none; b=CH3mmJZibRaPkADF4kDe6N8bayxaJd3DDbg5866iCixFziZd03iO2qV0Fh1iYvzdPMaJZclO5kFrmrLtzcwwQtCRO2IsmTjuYeT7NRjxU1WG23sG47qF+Y8MhYbLA3AF9tNb7idjsMB7KVREW4QAsoa/nXEe0nl0dHP8OEMIh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498900; c=relaxed/simple;
	bh=MHaCCaeiKNzAp1sC/jZFZpfoD+eNhLqNkW7aNO9VP9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXZQwWecYltgjg1B3qNC0//2rZhAFRP8PrRFg2weqJDfl/IJgUrw8A/3HYKVu1tvkvypXSnNosVAS8EnQFLxuEsLiGEtmka/+tFUeBEE6kS4thSkzpfKuZEngiPZtJl/uP28yD1TPQY0ijpQrlUV71FrWNTpuiWSn4sElwqh+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irdzN03T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irdzN03T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA1C4CEEE;
	Thu, 20 Mar 2025 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498898;
	bh=MHaCCaeiKNzAp1sC/jZFZpfoD+eNhLqNkW7aNO9VP9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irdzN03TwT/IsTC95Q4hqO/5BrJyoQG46uFD5mGF6BpuBaGIjQ/zBLOGBw0viGsDA
	 bA05MxL8UVAuFD3MrKG+CVD35FrLVUzzQXtmqFjvHWiuWLbN1der/B9K1azaRgDUia
	 t4WOCQ50gIsF8XwlBBQVoXfIzQesbnhcd3KmjU6tTsNCoASe0oNDdVmi6KIB+STUgN
	 kVaRd2Ia3id3ivudRVSx9rk1EQty0tGrQFio6Gwfk7SPktndP/+uBzzVi9KZ4mjrSS
	 0ooyLhsyLfjLa8iMdpnziHvE02hzkDSULZtGJhVRJnyK+tSGGNY31mwZseAx8BgXdW
	 WEHEgfCfjpY9g==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/2] fstests: remove run_setsid test way from check
Date: Fri, 21 Mar 2025 03:28:12 +0800
Message-ID: <20250320192812.782380-3-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320192812.782380-1-zlang@kernel.org>
References: <20250320192812.782380-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch partially revert most of the 88d60f434 ("common: fix pkill
by running test program in a separate session"), it does:
1. Remove run_setsid script
2. Remove all run_setsid related things from check
3. Keep the change in _scratch_xfs_stress_scrub_cleanup() which is a
   bug fix for xfs_scrub test.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 check            | 39 ++++++---------------------------------
 common/rc        |  4 ++--
 tools/Makefile   |  1 -
 tools/run_setsid | 22 ----------------------
 4 files changed, 8 insertions(+), 58 deletions(-)
 delete mode 100755 tools/run_setsid

diff --git a/check b/check
index ba853ae85..32890470a 100755
--- a/check
+++ b/check
@@ -698,46 +698,19 @@ _adjust_oom_score -500
 # systemd doesn't automatically remove transient scopes that fail to terminate
 # when systemd tells them to terminate (e.g. programs stuck in D state when
 # systemd sends SIGKILL), so we use reset-failed to tear down the scope.
-#
-# Use setsid to run the test program with a separate session id so that we
-# can pkill only the processes started by this test.
 _run_seq() {
+	local cmd=(bash -c "test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq")
 	local res
-	unset CHILDPID
-	unset FSTESTS_ISOL	# set by tools/run_seq_*
 
 	if [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
 		local unit="$(systemd-escape "fs$seq").scope"
 		systemctl reset-failed "${unit}" &> /dev/null
-		systemd-run --quiet --unit "${unit}" --scope \
-			./tools/run_setsid "./$seq" &
-		CHILDPID=$!
-		wait
+		systemd-run --quiet --unit "${unit}" --scope "${cmd[@]}"
 		res=$?
-		unset CHILDPID
 		systemctl stop "${unit}" &> /dev/null
+		return "${res}"
 	else
-		# bash won't run the SIGINT trap handler while there are
-		# foreground children in a separate session, so we must run
-		# the test in the background and wait for it.
-		./tools/run_setsid "./$seq" &
-		CHILDPID=$!
-		wait
-		res=$?
-		unset CHILDPID
-	fi
-
-	return $res
-}
-
-_kill_seq() {
-	if [ -n "$CHILDPID" ]; then
-		# SIGPIPE will kill all the children (including fsstress)
-		# without bash logging fatal signal termination messages to the
-		# console
-		pkill -PIPE --session "$CHILDPID"
-		wait
-		unset CHILDPID
+		"${cmd[@]}"
 	fi
 }
 
@@ -746,9 +719,9 @@ _prepare_test_list
 fstests_start_time="$(date +"%F %T")"
 
 if $OPTIONS_HAVE_SECTIONS; then
-	trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
+	trap "_summary; exit \$status" 0 1 2 3 15
 else
-	trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
+	trap "_wrapup; exit \$status" 0 1 2 3 15
 fi
 
 function run_section()
diff --git a/common/rc b/common/rc
index 55c384a63..fa0f02ac4 100644
--- a/common/rc
+++ b/common/rc
@@ -33,7 +33,7 @@ _test_sync()
 # Kill only the processes started by this test.
 _pkill()
 {
-	pkill --session 0 "$@"
+	pkill "$@"
 }
 
 # Find only the test processes started by this test
@@ -2792,7 +2792,7 @@ _require_user_exists()
 # not, passing $SHELL in this manner works both for "su" and "su -c cmd".
 _su()
 {
-	su --session-command $SHELL "$@"
+	su "$@"
 }
 
 # check if a user exists and is able to execute commands.
diff --git a/tools/Makefile b/tools/Makefile
index 2d502884f..af7adc2a6 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -7,7 +7,6 @@ include $(TOPDIR)/include/builddefs
 
 TOOLS_DIR = tools
 helpers=\
-	run_setsid \
 	run_privatens
 
 include $(BUILDRULES)
diff --git a/tools/run_setsid b/tools/run_setsid
deleted file mode 100755
index 5938f80e6..000000000
--- a/tools/run_setsid
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/bash
-
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2025 Oracle.  All Rights Reserved.
-#
-# Try starting things in a new process session so that test processes have
-# something with which to filter only their own subprocesses.
-
-if [ -n "${FSTESTS_ISOL}" ]; then
-	# Allow the test to become a target of the oom killer
-	oom_knob="/proc/self/oom_score_adj"
-	test -w "${oom_knob}" && echo 250 > "${oom_knob}"
-
-	exec "$@"
-fi
-
-if [ -z "$1" ] || [ "$1" = "--help" ]; then
-	echo "Usage: $0 command [args...]"
-	exit 1
-fi
-
-FSTESTS_ISOL=setsid exec setsid "$0" "$@"
-- 
2.47.1

