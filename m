Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E42DC783
	for <fstests@vger.kernel.org>; Wed, 13 May 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642430; cv=none; b=eBNec2HM6hhT8wCyrQwCHCQM7blwc2TVuC8JvbxlxBYtXXYaE1EiklJvqyQ5lJRUVHm5wXsNdynl9twsfK8xOJy+AX0EhsyG3x41HnycYwAvHk7NwUlr7I/VHc4fBST1jOR7EGXZ4Lp6NGwFBMXKE+lfnEC26cVOVlhEOuOasiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642430; c=relaxed/simple;
	bh=nRDnQeZc1XtQIr+v7riRw65JtJE4m2z7Dooa6mFCXo8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PSPgTcB7vBGvvnX5ZvswbXpqZ2p7LnocOJjUcgVaX12pUmliZK0BNqQ36jr7kQVA29Ng1M8G2cdZ1H/PcTf8bUB9IbbqUFGoRv6EITRflaGfjEPKi7KGhk2END48E8Lfh25F8vp4kAj8vdlv3v9sJVpbt/nWwqvyGu+3Y6NZX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKHC/0KF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKHC/0KF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74f0e3c6so4226055b3a.0
        for <fstests@vger.kernel.org>; Tue, 12 May 2026 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778642428; x=1779247228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gl+fbFhlYRHV9uFZaKjbbT4X1sSGcksiAkjCTrWM3D0=;
        b=DKHC/0KFeVd7MS+2PG1DADoPu8N1h4woOatiZFTdHgGzF4ikKp0b1vdtBQWH+crvUj
         xlS0GjsPj5hBZO/EugK0Uq+1pJOVXQc1MCjCkV5YimJiM7EUS/wSEbu4wNYbK14JvqfO
         N4kU+tKONXzOv4Yc7ZeM/wT/ucaLaDescxUJDEZfv/NbNbEf8GZD6mDms2OelviVwPbI
         isn5SWmDw6L1QuXsCVboYakPPsgg5sPzaipMBSx2ol+RRSH6xLmvWGk/ZsEB3qjm77JV
         YwU20PHpWD1nPggPTpoer0/f4BVA2rtQPdLgQkjezVpe8lQh+E3GSJ0eDa+eg7vJAxJM
         FfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778642428; x=1779247228;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gl+fbFhlYRHV9uFZaKjbbT4X1sSGcksiAkjCTrWM3D0=;
        b=njPoZK8XWpuMr9SzJfW8HwVUHuPxHObNctXC2EKAW2s0z1+ngTNf2oOvwAL90nI5g8
         SDx19Ex6Xgg2WOsUz4kUtQBhOtwUxygpuVZ96IXjScaauu885Ryjp75lekmZCBsSW9Dk
         IX6EXg/Kf4bbm4lUllVdqoQr0Jgouj0glvqMsHxs9tw0WRy0Idd/pvkf1gXh6NQ4VwPB
         qRolXYLbrZs9pVzvipbt/Fby5GdL5f3ldk9AgHFcEXpun4/eu6AYXxTgq82VvPe2iaSM
         NkvVzszlM6EgOcFGQ0EwscvuwCY1RY/gCytnc5oZY3aieoAFpYD2od8GhMZLedZBfHDj
         wKTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NA2TxyoJVM35bSjh5Iw0SGLzfNS1ab95B9/w5c2OdRJZKNg8tp7AwhjyXMbwu8kCHVkqJXN/O@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCL9tItE8MCgI+VLlMOoj4IvazgZRKT5tkShHyQ4tL25S9AbI
	WGoVr+AZwHTD1Sm48p18shIB2g2nZeIQATyatFVyqvOjmpm4U3bmsaGP1yIk6ZSqcC5+jWgxzma
	AppIakxuJcItFoKFMyyS0hAdgAw==
X-Received: from pfbkq4.prod.google.com ([2002:a05:6a00:4b04:b0:839:4a33:c35d])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b41:b0:835:351c:f22b with SMTP id d2e1a72fcca58-83f05c34d23mr1065175b3a.35.1778642427849;
 Tue, 12 May 2026 20:20:27 -0700 (PDT)
Date: Wed, 13 May 2026 03:20:08 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513032009.2300435-1-joannechien@google.com>
Subject: [PATCH v1 1/2] f2fs/015: Fix mount syntax for disabling jquota
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

F2FS has removed the trailing "=" in the mount options for disabling
user, group, and project journaled quotas. To maintain compatibility,
update the test cases in f2fs/015 to try the new syntax first, and fall
back to the legacy syntax if the initial mount attempt fails.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/015     | 13 +++++++++----
 tests/f2fs/015.out |  6 +++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/f2fs/015 b/tests/f2fs/015
index 81ea9818..54cada4a 100755
--- a/tests/f2fs/015
+++ b/tests/f2fs/015
@@ -66,9 +66,9 @@ options=(
 	"usrjquota=ausrquota"		""			\
 	"grpjquota=agrpquota"		""			\
 	"prjjquota=aprjquota"		""			\
-	"usrjquota="			""			\
-	"grpjquota="			""			\
-	"prjjquota="			""			\
+	"usrjquota"			""			\
+	"grpjquota"			""			\
+	"prjjquota"			""			\
 	"usrjquota=ausrquota"		"extra_attr,quota,project_quota"	\
 	"grpjquota=agrpquota"		"extra_attr,quota,project_quota"	\
 	"prjjquota=aprjquota"		"extra_attr,quota,project_quota"	\
@@ -119,7 +119,12 @@ do
 	else
 		_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
 	fi
-	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+	if [[ "${options[$i]}" == *jquota ]]; then
+		_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1 || \
+			_try_scratch_mount "-o ${options[$i]}=" >> $seqres.full 2>&1
+	else
+		_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+	fi
 	echo $?
 	_scratch_unmount >> $seqres.full 2>&1
 done
diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
index cd273550..45ef9ea8 100644
--- a/tests/f2fs/015.out
+++ b/tests/f2fs/015.out
@@ -101,11 +101,11 @@ Option#98: grpjquota=agrpquota :
 32
 Option#100: prjjquota=aprjquota : 
 32
-Option#102: usrjquota= : 
+Option#102: usrjquota : 
 0
-Option#104: grpjquota= : 
+Option#104: grpjquota : 
 0
-Option#106: prjjquota= : 
+Option#106: prjjquota : 
 0
 Option#108: usrjquota=ausrquota : extra_attr,quota,project_quota
 0
-- 
2.54.0.563.g4f69b47b94-goog

