Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589B11CA9
	for <fstests@vger.kernel.org>; Mon,  3 Mar 2025 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035051; cv=none; b=VmQUZoa3XKH7zFHK+Tb79S6DsAPDi4eDZkwVyPicBS7yIXO9SJPPVEnKkDwL+xn2ocpBiazC4+69/q+4UWFbaXxOZ7FeTrJeyT3iLF+h404OlnKrvtUAT3Y218UY5qRYA3SeOhWkqq8JwWCvdU3gGV+rXItHaoQm8V8JvaeW1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035051; c=relaxed/simple;
	bh=b+MVbKWxtoXNfqpA+vwUYy8M77yIoG0EsLkWPi7739M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDyIbancjjb/idCyLYF2sANUbh/DTYuxnrUiLsli6v8X9v+eBYF8aYtGC0UP6aixaJIzAAX6kUyOxe0khFn3e0Vf7lBxy7q3wvuTyYt5heyTEgbyDo1bsBcrJXczbPyW+Kz2pE+YKXL8ejauhS6cD0xV5y3Kgshq9unhUMRfU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h47txtIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h47txtIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A763C4CEE9;
	Mon,  3 Mar 2025 20:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741035051;
	bh=b+MVbKWxtoXNfqpA+vwUYy8M77yIoG0EsLkWPi7739M=;
	h=From:To:Cc:Subject:Date:From;
	b=h47txtIwM/gK4urcWiixXhQgIENn1usv2mKRL5Dcs1/CeRfHu7ycl8zVFwqTUx4uv
	 dAJfUY7uIVZ/OX9TF/HSNR3kGs0Iwd2HCyVokUIWSq/HjpB8xIADKI+m5syDA987a5
	 /JNviD62eEaZ3LIRTVovjlD4Wdd5A40ETJAQ/cGjErFvmY6eAzC4nja33KNLaA+744
	 Qvuf/ZTsC2t0lwouu4KpCwcpCYbFgjE1F4pZONuV2W9KirzljFsxvLkeOJELUes9Aq
	 8jzA33W+Joy9xd5Xa7il3hKsMTxac1H4chYBxMymTAnHsppXhsDv5KKaE+Z8suGzrp
	 8jrcYD1/adiIA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] check: disable HAVE_PRIVATENS by default
Date: Tue,  4 Mar 2025 04:50:46 +0800
Message-ID: <20250303205046.667838-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have 3 ways to run a test case in _run_seq():

  if [ -n "${HAVE_PRIVATENS}" ]; then
      ./tools/run_privatens "./$seq"
      ...
  elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
      systemd-run --quiet --unit "${unit}" --scope \
             ./tools/run_setsid "./$seq" &
      ...
  else
      ./tools/run_setsid "./$seq" &
      ...
  fi

The "privatens" way brings in some regressions. We need more time
to develop and test this way, it's not time let it to be the
first default choice, so isolate the HAVE_PRIVATENS initialization
by a TRY_PRIVATENS parameter, and disable it by default.

Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
old ways. This patch can be removed after "privatens" way is stable.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

This patch aims to be talked. Refer to above commit log. This patch
is a workaround for 2 targets:
1) Avoid the regressions of lastest xfstests release.
2) Give us more time to improve the "privatens" method.

And compare with revert that commit directly, this patch trys to
give "privatens" method a chance to be enabled and tested (by
export TRY_PRIVATENS=yes).

Thanks,
Zorro

 check | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/check b/check
index ea92b0d62..33eb3e085 100755
--- a/check
+++ b/check
@@ -674,10 +674,13 @@ _stash_test_status() {
 	esac
 }
 
-# Can we run in a private pid/mount namespace?
-HAVE_PRIVATENS=
-./tools/run_privatens bash -c "exit 77"
-test $? -eq 77 && HAVE_PRIVATENS=yes
+# Don't try "privatens" by default, it's experimental for now.
+if [ "$TRY_PRIVATENS" = "yes" ];then
+	# Can we run in a private pid/mount namespace?
+	HAVE_PRIVATENS=
+	./tools/run_privatens bash -c "exit 77"
+	test $? -eq 77 && HAVE_PRIVATENS=yes
+fi
 
 # Can we run systemd scopes?
 HAVE_SYSTEMD_SCOPES=
@@ -692,15 +695,6 @@ function _adjust_oom_score() {
 }
 _adjust_oom_score -500
 
-warn_deprecated_sessionid()
-{
-	if [ -z "$WARNED_DEPRECATED_SESSIONID" ]; then
-		echo "WARNING: Running fstests without private pid/mount namespace"
-		echo "support is deprecated and will be removed in February 2026."
-		WARNED_DEPRECATED_SESSIONID=1
-	fi
-}
-
 # ...and make the tests themselves somewhat more attractive to it, so that if
 # the system runs out of memory it'll be the test that gets killed and not the
 # test framework.  The test is run in a separate process without any of our
@@ -900,8 +894,6 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	test -n "$HAVE_PRIVATENS" || warn_deprecated_sessionid
-
 	loop_status=()	# track rerun-on-failure state
 	local tc_status ix
 	local -a _list=( $list )
-- 
2.47.1

