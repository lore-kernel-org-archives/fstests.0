Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438F2862B2
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983806; cv=none; b=bzLWGRsvwAs1Y6GXY/rwJmvd37za+C60pmKvNqjav1AkL0THwrpg50pUSGwZs7pV+EVVSwzdr5qO3pSkNvqENIn0Ga8w0Mjcq1+J3mv1tZy5HTeW/K0F0XZi25KHYV1jKFtgiEenMD36JC5dWM2rWdARZ3sJ6mrhp+rP/yDPWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983806; c=relaxed/simple;
	bh=Xm/doimVczAwR/kkRicPqTJwW4WBjiQuzy9+4ku1lAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oODafWfxLYhWrfTtoKvdojPsVWQlpb9zs9r48Yo5yvG0c0vPKajr676v1ShG/Cvs7YgQHo5mM7UessLx7TXPzSWrig94OnsUkVB3QVLv2g/JzmfK0rCJm/XO9lxDqLuLcKobW8NqCEVFzlptTmeE/mXlTcjPKLr9N5xoolxi1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ3fEEIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ3fEEIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5926BC4CED6;
	Wed, 19 Feb 2025 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739983805;
	bh=Xm/doimVczAwR/kkRicPqTJwW4WBjiQuzy9+4ku1lAc=;
	h=From:Date:Subject:To:Cc:From;
	b=PJ3fEEImbUoOh4pO7NYyLrJxIzzEpS8ulhIx4//Nf4qyqT0MO1F17r32Mkdr0m7dw
	 p2MHTxF6XdzZfSyxPl78NzPFGAr8j8dBh5NhFcQWkYh4aRk0psRYkDOoFJ0ShOORIW
	 7BVAKJvN0Sa1HjBO3HZozUtAn5AdWfJEFUpizMfpNqDfF89BMJwTVPbuvPPa7uZgQe
	 EBPt56z52RoSZX6DX4NU7g5lc7Fn4QCnLoVuics7WQSyVkplMlmPf50eARKnpFok+9
	 tjGOcHXCUPKbCPWHZlG79EXYwRQQ13QYn79WPWGCmlI3tgNbS7y4wc0KUINSWZXgkV
	 X/7NihEwY/z4w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Feb 2025 11:50:03 -0500
Subject: [PATCH fstests] generic/126: run it inside its own subdirectory
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-generic126-v1-1-018e4e60c811@kernel.org>
X-B4-Tracking: v=1; b=H4sIALoLtmcC/x3MPQqAMAxA4auUzBba+O9VxEFrqlmqNCKC9O4Wx
 zd87wWhyCQwqBci3Sx8hBy2UOD2OWykec0NaLA2aHu9UcjCWWy07+xSGkRXLS1kcEby/PyzEbx
 cJJfAlNIHXdZCymUAAAA=
X-Change-ID: 20250219-generic126-f81b3022c4b7
To: fstests@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Xm/doimVczAwR/kkRicPqTJwW4WBjiQuzy9+4ku1lAc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBntgu9BddNYb76WkMdntUKOyv8/W3137CWROlTa
 63tNPJiGYWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7YLvQAKCRAADmhBGVaC
 FZY/D/99GpUKsEOq+t4g6ZmZCHpyfBlC4y9N9ZpvQjmUUPAkq+lLtPWP+bGyhTeRhFxL7kJUSdn
 qRfOGT53PDrVsbxdmyYCB+yrGx7UrUohwSxqf+5Azz/iG1YPklhYiZVGm7PVw2yEiile3ne1mgb
 c+RIOOTeXaN/G6AcPzWp3D80iGs5mDM/oSYrQ1j4pL7gzydufhfMKYuGb2zdtB1N+jK6XB27+Uq
 uiJpdjQL7q3UVzF7QAu1ctKiT1yDKc5ElAU9M2gs3YuTPj6NyUHUYbwFwVfFEtzLHmxUKlfU6v9
 RRmYKku/x+j5nDtmpzq4CCqiGj61Sp5Jvx/fl0Oc9LDMtRhmaLROz9Yrnje3kESxiOXHaWpeCwE
 rLRf4MthWpqGmQ93Y7PsIYKM52iEdPI0h7OX/AUdUi+MF54iGVdaIXTuoOifq9D2f+JfiYxs9I+
 1QHrQjflNwwEJFN/o5xf6BRrZ8ug+STLOphH9aibynUskb2ELkSczaJgUEow+dTelmM2ZfA+r8j
 fZatoGTgDXyiswOBLWevneABwX1ZnG2MdbWbAGcgyI/adxJFcVqkddP8zArygMP2QLn8fnIMRLZ
 8M71t0OiF6W11FIkNMa67d5LvwqCzL1YzgCq9Ur2jkN+5QHePkL2lpTuk117zTFrJqvaJcdJSfs
 K3FSLLVu9IavF7A==
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
 tests/generic/126 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/generic/126 b/tests/generic/126
index 142d2bb97db706bafd2152856ef0993c5c273441..fe0d6db1b6bd85d4942333fdf04d23a63c4052ec 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -23,7 +23,13 @@ _require_chown
 
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
@@ -46,7 +52,8 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
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

