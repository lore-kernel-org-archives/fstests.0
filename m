Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4F227EA1
	for <fstests@vger.kernel.org>; Thu, 20 Mar 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498897; cv=none; b=Y7U1t/717zbog3FfGWO+M1shwOLzMPT+p0oeUUTjCYBqXxZt1FJG/M0A/FtwZ4lZ7eLQOMlNpYJ3LZIyn/YMGGDar9um7qEJz769CVT6mX0slMyqD3I9O5KTLCV3I2PvJFzoJK6Wd6QKciGqGeF1gT2eQSQdiIXGeIaqLBYdAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498897; c=relaxed/simple;
	bh=QLylgqn1rlCYq8sux5FFJ8u6+kyyEw712lMi4LTcBDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKJ1ghTcLAieBVa3eKiViIge0IghX4BltUgH14veBYRmbkVnMmInERcN5ujcoTCtd018kYC0iirQbMYl10T9mAezZv+z7vJ0x6kX55N6F8iIm7d4QVn336r1ymJ6e/7lQcCxa0uqe9hHpGpsA+UxsxeAPpWXHyaQyomCPyQOd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j59ocTAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j59ocTAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41795C4CEEA;
	Thu, 20 Mar 2025 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498897;
	bh=QLylgqn1rlCYq8sux5FFJ8u6+kyyEw712lMi4LTcBDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j59ocTAcDZsJN9cZc04mnYSaB79/OrNgasxgZdzxi3m2CBkqTWul2g522kNusQv3o
	 Yw0Hy4Hr/LSwtdCQ5N0KhVAPOm0o+DkGIKP7KpaTqbkirLKU9nxNcQvMTVgqcQYmrs
	 CbwG60Tpge2pvTVzmbd9yrCbn/De4ymzyNo/ge4LoJSfI+jK1CW3rqU6E6aOQoBBX9
	 CP5fEd7cggNddRRZgn6Z/tq8R/CUqcGvdyRFGeM5ErATGeNkzO6gp39HJ5EhNcsSNs
	 XkKZvc8jhCRE/YTF06oiNOzV4MUDe7Cmyoj6/IujIOxe22V5A7h+bj1kGcniECUD4t
	 Y1v+gR3nKY3IQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/2] fstests: remove privatens test way from check
Date: Fri, 21 Mar 2025 03:28:11 +0800
Message-ID: <20250320192812.782380-2-zlang@kernel.org>
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

This patch totally revert:
  ce7f796ad check: remove the deprecation of sessionid
  336784e3d check: disable HAVE_PRIVATENS by default
  949bdf8ea check: deprecate using process sessions to isolate test instances
and partially revert:
  247ab01fa check: run tests in a private pid/mount namespace

So it does:
1. Remove "run_privatens" related things from xfstests/check, due to
   check doesn't need that test way.
2. Keep run_privatens script and related changes for check-parallel.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 check     | 37 +++++++++++--------------------------
 common/rc | 12 ++----------
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/check b/check
index 33eb3e085..ba853ae85 100755
--- a/check
+++ b/check
@@ -674,14 +674,6 @@ _stash_test_status() {
 	esac
 }
 
-# Don't try "privatens" by default, it's experimental for now.
-if [ "$TRY_PRIVATENS" = "yes" ];then
-	# Can we run in a private pid/mount namespace?
-	HAVE_PRIVATENS=
-	./tools/run_privatens bash -c "exit 77"
-	test $? -eq 77 && HAVE_PRIVATENS=yes
-fi
-
 # Can we run systemd scopes?
 HAVE_SYSTEMD_SCOPES=
 systemctl reset-failed "fstests-check" &>/dev/null
@@ -699,29 +691,22 @@ _adjust_oom_score -500
 # the system runs out of memory it'll be the test that gets killed and not the
 # test framework.  The test is run in a separate process without any of our
 # functions, so we open-code adjusting the OOM score.
+#
+# If systemd is available, run the entire test script in a scope so that we can
+# kill all subprocesses of the test if it fails to clean up after itself.  This
+# is essential for ensuring that the post-test unmount succeeds.  Note that
+# systemd doesn't automatically remove transient scopes that fail to terminate
+# when systemd tells them to terminate (e.g. programs stuck in D state when
+# systemd sends SIGKILL), so we use reset-failed to tear down the scope.
+#
+# Use setsid to run the test program with a separate session id so that we
+# can pkill only the processes started by this test.
 _run_seq() {
 	local res
 	unset CHILDPID
 	unset FSTESTS_ISOL	# set by tools/run_seq_*
 
-	if [ -n "${HAVE_PRIVATENS}" ]; then
-		# If pid and mount namespaces are available, run the whole test
-		# inside them so that the test cannot access any process or
-		# /tmp contents that it does not itself create.  The ./$seq
-		# process is considered the "init" process of the pid
-		# namespace, so all subprocesses will be sent SIGKILL when it
-		# terminates.
-		./tools/run_privatens "./$seq"
-		res=$?
-	elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
-		# If systemd is available, run the entire test script in a
-		# scope so that we can kill all subprocesses of the test if it
-		# fails to clean up after itself.  This is essential for
-		# ensuring that the post-test unmount succeeds.  Note that
-		# systemd doesn't automatically remove transient scopes that
-		# fail to terminate when systemd tells them to terminate (e.g.
-		# programs stuck in D state when systemd sends SIGKILL), so we
-		# use reset-failed to tear down the scope.
+	if [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
 		local unit="$(systemd-escape "fs$seq").scope"
 		systemctl reset-failed "${unit}" &> /dev/null
 		systemd-run --quiet --unit "${unit}" --scope \
diff --git a/common/rc b/common/rc
index e51686389..55c384a63 100644
--- a/common/rc
+++ b/common/rc
@@ -33,11 +33,7 @@ _test_sync()
 # Kill only the processes started by this test.
 _pkill()
 {
-	if [ "$FSTESTS_ISOL" = "setsid" ]; then
-		pkill --session 0 "$@"
-	else
-		pkill "$@"
-	fi
+	pkill --session 0 "$@"
 }
 
 # Find only the test processes started by this test
@@ -2796,11 +2792,7 @@ _require_user_exists()
 # not, passing $SHELL in this manner works both for "su" and "su -c cmd".
 _su()
 {
-	if [ "$FSTESTS_ISOL" = "setsid" ]; then
-		su --session-command $SHELL "$@"
-	else
-		su "$@"
-	fi
+	su --session-command $SHELL "$@"
 }
 
 # check if a user exists and is able to execute commands.
-- 
2.47.1

