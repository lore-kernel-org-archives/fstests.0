Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0738947B
	for <fstests@vger.kernel.org>; Fri, 23 Jan 2026 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138896; cv=none; b=RYv/gEwdqwmMYc4x1nGckNq7KS8JhDksaKiQYjw+fnfpd0FZCJ0HtyNwjcTtFDKpodw8FjcoyiYaFRbQFHl7b43CtqmdR+kL2yiVed4kMHdLcQIq9eE1VxIDd2YcV1AeOB04iU3RQ6KRSeB+58RfFL3S7jigkPJ3ItcDDz81smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138896; c=relaxed/simple;
	bh=qbh01MubqXhPMX4pPLkdCjjb4ZNy5jAijUx13NRTNsE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AsPaZCM7zgC4eruk13I6OSK78Rhp2T7l6l5cTHAZFU+G5jO+kMjk3tLx4S+nVLSFivcr27ojikHujTruW0rv+ihLW7OoVifaMtmQ0OjkBn90JwniOfd8C8c/DyjYgtF0uDJRvQPMkobxIMMYdxClQgI5zr0NFw9SkdcEg172pOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXj06Act; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXj06Act"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a377e15716so38999945ad.3
        for <fstests@vger.kernel.org>; Thu, 22 Jan 2026 19:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769138874; x=1769743674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vu+XY7SifxPF9zfQVHIOb6NKonDohlP8TI+sekSIbTw=;
        b=nXj06ActCOhKoQPWZ+ZHirWPCuTKbI1inpcpnnAN43SHUBqynKmP73yAqpMVMqSqHe
         8s1BfXnH+ikCppiMAe4hXX2qIYtjNdq8xRDcSBA92pnRF0ovqC8BpNIH2hVsXmdNVJ/j
         rfwnd0U75IXoPqfvOf6QFR/V9J/k3Uflcxq4X29S6MuNm4NtP5D3o9XJGbwXeUo8f2KY
         77P7mPOg0t6szpxduCWvI8CTqKsZkx7qezXy0uFpieHxykeqYZT+qu1r+Xrpxb2z8tU/
         k+jbGWNrdu1oz/TZNLIWSJot7tHtbrm4KlS/2PGzlKDc51uU2+IPLZGKtg3giR6RA4CY
         kFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769138874; x=1769743674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu+XY7SifxPF9zfQVHIOb6NKonDohlP8TI+sekSIbTw=;
        b=oQSqmimPQ+VaOu9mfHnpTO9lGIY/HxEkIDsUpeMwG6LqmH/Tu3Iavvy9XFMlii2LXW
         O+/1BS+wTG8PSQFS1kpjV5JXLWBLcY5CylTb/sIn14wzXpTE4UJXErk2nYFDWyeRzI2x
         aZBdflOjOkW8gP+IpyjibVWZgs/ClhGtrl2SEUmZ7Kkvp4KkdU2UaH4UjjaT27pgQu5a
         Z7iO9dFJ+fsaMGHRWkFSddz42H6ZoDLMAUSGgpSy4OV+XRsynWoNBkjNZyc2LXBoncte
         I8L4+69Da1OCpnaqJAjwy2fifjxWPoiscc3v8mSvUKTg7AGGhCAFcvaqkAKveGmX+mKC
         eq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrxFfcf9I4Qc+/kzf6yegLrGO6JZKuxM3qlNxuu7AonkGksfqelrBWzBYI4QryOYsoXLwFTl7w@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNvkYSPMjMHQ46rvnBagMvGTeMB4GtbBTAf0nZOhEtMyI9hRi
	2Ns/YqYTOukMnvxzx9GKmehXxmsH8SjCVf58OuGUmtcVDVEEikrGiw2jPD4m3ZVDNPykDyTGQnA
	Ow6OrhOJOckvRjRUJreml5soBgQ==
X-Received: from plbli12.prod.google.com ([2002:a17:903:294c:b0:2a0:bb0f:ea50])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d511:b0:2a0:a0e1:9c5c with SMTP id d9443c01a7336-2a7fe43f366mr13655095ad.10.1769138873912;
 Thu, 22 Jan 2026 19:27:53 -0800 (PST)
Date: Fri, 23 Jan 2026 03:27:44 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123032744.1018230-1-joannechien@google.com>
Subject: [PATCH v1] f2fs/015: Test correct mkfs options for error cases
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jaegeuk Kim <jaegeuk@kernel.org>

Let's add the required mkfs options for quota mount option cases with
wrong results.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Co-developed-by: Joanne Chang <joannechien@google.com>
Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/015     | 10 +++--
 tests/f2fs/015.out | 92 +++++++++++++++++++++++++---------------------
 2 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/tests/f2fs/015 b/tests/f2fs/015
index 6a7a582c..81ea9818 100755
--- a/tests/f2fs/015
+++ b/tests/f2fs/015
@@ -59,15 +59,19 @@ options=(
 	"usrquota"			""			\
 	"grpquota"			""			\
 	"prjquota"			""			\
-	"usrjquota=ausrquota"		""			\
-	"grpjquota=agrpquota"		""			\
-	"prjjquota=aprjquota"		""			\
+	"prjquota"			"extra_attr,quota,project_quota"	\
 	"jqfmt=vfsold"			""			\
 	"jqfmt=vfsv0"			""			\
 	"jqfmt=vfsv1"			""			\
+	"usrjquota=ausrquota"		""			\
+	"grpjquota=agrpquota"		""			\
+	"prjjquota=aprjquota"		""			\
 	"usrjquota="			""			\
 	"grpjquota="			""			\
 	"prjjquota="			""			\
+	"usrjquota=ausrquota"		"extra_attr,quota,project_quota"	\
+	"grpjquota=agrpquota"		"extra_attr,quota,project_quota"	\
+	"prjjquota=aprjquota"		"extra_attr,quota,project_quota"	\
 	"quota"				""			\
 	"noquota"			""			\
 	"alloc_mode=reuse"		""			\
diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
index 3df29436..cd273550 100644
--- a/tests/f2fs/015.out
+++ b/tests/f2fs/015.out
@@ -87,87 +87,95 @@ Option#84: grpquota :
 0
 Option#86: prjquota : 
 32
-Option#88: usrjquota=ausrquota : 
+Option#88: prjquota : extra_attr,quota,project_quota
+0
+Option#90: jqfmt=vfsold : 
+0
+Option#92: jqfmt=vfsv0 : 
+0
+Option#94: jqfmt=vfsv1 : 
+0
+Option#96: usrjquota=ausrquota : 
 32
-Option#90: grpjquota=agrpquota : 
+Option#98: grpjquota=agrpquota : 
 32
-Option#92: prjjquota=aprjquota : 
+Option#100: prjjquota=aprjquota : 
 32
-Option#94: jqfmt=vfsold : 
+Option#102: usrjquota= : 
 0
-Option#96: jqfmt=vfsv0 : 
+Option#104: grpjquota= : 
 0
-Option#98: jqfmt=vfsv1 : 
+Option#106: prjjquota= : 
 0
-Option#100: usrjquota= : 
+Option#108: usrjquota=ausrquota : extra_attr,quota,project_quota
 0
-Option#102: grpjquota= : 
+Option#110: grpjquota=agrpquota : extra_attr,quota,project_quota
 0
-Option#104: prjjquota= : 
+Option#112: prjjquota=aprjquota : extra_attr,quota,project_quota
 0
-Option#106: quota : 
+Option#114: quota : 
 0
-Option#108: noquota : 
+Option#116: noquota : 
 0
-Option#110: alloc_mode=reuse : 
+Option#118: alloc_mode=reuse : 
 0
-Option#112: alloc_mode=default : 
+Option#120: alloc_mode=default : 
 0
-Option#114: fsync_mode=posix : 
+Option#122: fsync_mode=posix : 
 0
-Option#116: fsync_mode=strict : 
+Option#124: fsync_mode=strict : 
 0
-Option#118: fsync_mode=nobarrier : 
+Option#126: fsync_mode=nobarrier : 
 0
-Option#120: test_dummy_encryption : 
+Option#128: test_dummy_encryption : 
 32
-Option#122: test_dummy_encryption=v1 : 
+Option#130: test_dummy_encryption=v1 : 
 32
-Option#124: test_dummy_encryption=v2 : 
+Option#132: test_dummy_encryption=v2 : 
 32
-Option#126: checkpoint=enable : 
+Option#134: checkpoint=enable : 
 0
-Option#128: checkpoint=disable : 
+Option#136: checkpoint=disable : 
 0
-Option#130: checkpoint=disable:32768 : 
+Option#138: checkpoint=disable:32768 : 
 0
-Option#132: checkpoint=disable:50% : 
+Option#140: checkpoint=disable:50% : 
 0
-Option#134: checkpoint_merge : 
+Option#142: checkpoint_merge : 
 0
-Option#136: nocheckpoint_merge : 
+Option#144: nocheckpoint_merge : 
 0
-Option#138: compress_algorithm=lzo : 
+Option#146: compress_algorithm=lzo : 
 0
-Option#140: inlinecrypt : 
+Option#148: inlinecrypt : 
 0
-Option#142: atgc : 
+Option#150: atgc : 
 0
-Option#144: discard_unit=block : 
+Option#152: discard_unit=block : 
 0
-Option#146: discard_unit=segment : 
+Option#154: discard_unit=segment : 
 0
-Option#148: discard_unit=section : 
+Option#156: discard_unit=section : 
 0
-Option#150: memory=normal : 
+Option#158: memory=normal : 
 0
-Option#152: memory=low : 
+Option#160: memory=low : 
 0
-Option#154: age_extent_cache : 
+Option#162: age_extent_cache : 
 0
-Option#156: errors=panic : 
+Option#164: errors=panic : 
 0
-Option#158: errors=continue : 
+Option#166: errors=continue : 
 0
-Option#160: errors=remount-ro : 
+Option#168: errors=remount-ro : 
 0
-Option#162: nat_bits : 
+Option#170: nat_bits : 
 0
-Option#164: atgc,mode=lfs : 
+Option#172: atgc,mode=lfs : 
 32
-Option#166: ro,flush_merge : 
+Option#174: ro,flush_merge : 
 32
-Option#168: rw : ro
+Option#176: rw : ro
 0
-Option#170: norecovery,ro : 
+Option#178: norecovery,ro : 
 0
-- 
2.52.0.457.g6b5491de43-goog

