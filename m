Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF541ADC86
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987881; cv=none; b=u2ymcglBSD+S7hS+D8vpnxbhddetdwNUkewIJ2qz7RW6o/nVggkt0BJ3QRpB6+ykL+LyjoDVO1e8KqP6/IouYjm50lopeoRKR15LkXh22FbGXGje/zrAxlPbGsqosK5UfxVFUbBYlt5z89UW3KMeFMY/PyMST7x5Z2LQk0Qbopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987881; c=relaxed/simple;
	bh=c00HKnlVqSMZ7aMDORE+Rn9gVS9NkQVWhe2HyzXK81s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jdzZqQ69FYf1zdTG1rqXn4vdvhhRAsZOJAcOhkrBYLnDiRDoDVBPmiv857infd+fi5ISVsxF1gxs/y7wfPEsufadFNhCYbj1CFTDVM/MwLnee/0JZPtzCF5NdlVrIpZNADouYvMUzbbmOxMutiD0tQSXqE67AB8dTeFF8pscawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcevmwve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcevmwve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D848C4CEE0;
	Wed, 19 Feb 2025 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987881;
	bh=c00HKnlVqSMZ7aMDORE+Rn9gVS9NkQVWhe2HyzXK81s=;
	h=From:Date:Subject:To:Cc:From;
	b=bcevmwveaw1Jo6HC/THbaPYmnmDWvIKr56sSmT8MMk88olqFRrjYphcBSVbmkDfTA
	 MJNU4rEbDWSoMwVxsBGZr3biYiECssrkIQJD1I+rLgxCR+nGs1Sc56b5ElszbQJO8J
	 pasaRWMvUcmgCIpIIJ9oajNn5iJkFjpns8rFV7ijxL5XiloRF9NXfMKmF74NdCZzMX
	 v0s3aoKclr2jIfbltIAknFYoG8i3gAYBZ+03S8t3/ZIyzUDEAqiFYcDoXxpS+dd/nj
	 mbiAY7lXW8gJD0z7w7Xze13Jei22VVvZtNp4PhFFxKTfZHBEX7OQHlmDwAYGBZw7SJ
	 wARhBjsJvs/QA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Feb 2025 12:57:55 -0500
Subject: [PATCH fstests v2] generic/126: run it inside its own subdirectory
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-generic126-v2-1-e7537f6c9607@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKIbtmcC/22NQQ7CIBBFr9LMWgwz1oquvIfpwuJAiQYMQxpN0
 7tLWLt8+XnvryCcAwtcuhUyL0FCihVo14Gd79GzCo/KQJqOmvCsPMdqWKRBOYPTQRPZfjpBFd6
 ZXfi02A2cFJYiMNZhDlJS/raTBdv8r7egQqXRcM+Dtgbx+uQc+bVP2cO4bdsPW1IlDa4AAAA=
X-Change-ID: 20250219-generic126-f81b3022c4b7
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c00HKnlVqSMZ7aMDORE+Rn9gVS9NkQVWhe2HyzXK81s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnthul0zXQqG4pQ1i/FIldpOkHtgRt9uZ9zC8PI
 0L2gRDttqKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7YbpQAKCRAADmhBGVaC
 FS6aD/sELPWiEDJ32oaCkpmNrxjR6u0lTljc4Fnffx7voMvmQPFn2AGUj+Anq9nycYefLFvw6YM
 J6eT9RZdUVbFP4e5+yrZuQZ1sWmzbTffYALxs4X+xfoI/L+txST3pRK4/EZ6LUjmRVCCyGx5yQ+
 D0j4FIoC9icRu6/ar7DJbP7hfJO2T8QFH45BGYoJyBHMAkgN9d0hv647pLliGH7h9+ndzwCRy8r
 i8WIG/PjBjg+kXi0lrmDdzFsuQw8VWaOg9zuxzOv2ehE0NEl2dZ127jggZ7/o1oS94tQlEdu7rn
 qaw+yER8en2gDaxhhvAtOiE8DOGmZXMe/UjqhxgD+sMtR1kF7gGYehSz010Dzuh81iJJj6KPG9m
 2+O1U+Q6PrKqxSCrTou265SBwtADMS8pB1EfABksKBrk0GljuyA/3ff9MVbIp3gLJiXxH/B9L75
 PTuoadkivr+RuiF1YTTEjuNgGautknosiXGpjMKFo4Z1B9ExY5s+zNHi6e6IAf4H+IlTM6n3hvw
 UiNGK9gS7DTSc5kZW12ECrfQcTGhcbeehPI9SRHJes8pOzJGWKlMvxa81TaOfT7h2OVWkT6NEY8
 sPpZWRL2iXUMfPvdFwRK5grWiscG8rhdzovWoFTOubQY6ZikTNEwdwZdgYNxTfMZmvfvyiojNmv
 6BGQCVF1R1yS48A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I had been seeing some failures in generic/126 when running on NFS under
kdevops.

The problem turned out to be that kdevops makes the root of the NFS
export mode 01777 by default (i.e. with the sticky bit set). This causes
some of these permission tests to fail because the open() is called with
the O_CREAT bit set.

Make the outcome of this test not depend on the permissions on
$TEST_DIR. Create a new directory to do these tests in, and clean it up
when done.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add commands to _cleanup() to clean up test directory (Thanks Darrick!)
- Link to v1: https://lore.kernel.org/r/20250219-generic126-v1-1-018e4e60c811@kernel.org
---
 tests/generic/126 | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/generic/126 b/tests/generic/126
index 142d2bb97db706bafd2152856ef0993c5c273441..1f17492ed2a395ed3798c71243f3098558a157dc 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -13,6 +13,7 @@ _begin_fstest perms auto quick
 _cleanup()
 {
     cd /
+    test -n "$testdir" && rm -rf "$testdir"
 }
 
 # Import common functions.
@@ -23,7 +24,13 @@ _require_chown
 
 QA_FS_PERMS=$here/src/fs_perms
 
-cd $TEST_DIR
+testdir="$TEST_DIR/generic-126.$$"
+
+mkdir $testdir
+chown 0:0 $testdir
+chmod 0755 $testdir
+cd $testdir
+
 cp $here/src/testx ./testx.file
 
 # file_perm owner_uid owner_gid tester_uid tester_gid perm_to_test expected_result pass=1
@@ -46,7 +53,8 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
 $QA_FS_PERMS 040 99 99 99 500 r 1
 $QA_FS_PERMS 400 99 99 200 99 r 1
 
-rm -f ./testx.file
+cd /
+rm -rf $testdir
 
 status=0
 exit

---
base-commit: 8467552f09e1672a02712653b532a84bd46ea10e
change-id: 20250219-generic126-f81b3022c4b7

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

