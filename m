Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58726290
	for <fstests@vger.kernel.org>; Mon,  8 Dec 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765177125; cv=none; b=noKpOnzdzPl/I/1o890aaiDyGeeWfwaMMBsEE50OqIXokrP6cJkiZq9ao8GOZQS5u4RHz1uE5r26SmbaA9bV4pzJFW6auxEMbAsOSfhDnOnBNq+rIx8TV1ANmS46H4LECwuHMWwUkko96veguEdLBZcR+SsDxh0KmIgCC6n7RpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765177125; c=relaxed/simple;
	bh=ieKrIgEtNqQ3YTHK+GruyteXMaL+agKxdOGGZEczaNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4KprXNVTCKXCyLv0qgTicgFC4v6jmJuI01IIO78+sya8A2nEGIKNNVQSEtcq/9uBdK6PzRwys0CTkJlMJAF0uyy2kI8nxWW12S3af4ga01vwNFczEaf7Z4ax06rKnV6HhQBGPWC5R+TnQZDFT3slaB137X+53F6n71HPaLwqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gGrSwklf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gGrSwklf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso2131185f8f.1
        for <fstests@vger.kernel.org>; Sun, 07 Dec 2025 22:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765177122; x=1765781922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlwFHkB70ycxa7hk9am0TK0PSJjwUc7CdofuXet6SVI=;
        b=gGrSwklfBF1lhh87wgX2KQbws7nhKPXoXRzWTGq7MtlpksSSICDYfjiReJzpKXiGW6
         a+CrRpQfA/917NcpsP7Zl5ytigoBHPsfVyze5lcGXkPK+6418JxRCGI3WycAY8nMAY/x
         aBHxWvx6t5pLhXrtq6wMpI+VOwNcF0aU0yPcw+LZ3khs8hWiAh/WaDicxs3XpRe8n22L
         VJSGUPMig4vDqOwQdARwSo4HqbnNNeiViguaLaTY4a2BqiEDGHmvDmJu1CqAemqmSsXf
         1usrXGzvRxg+6F6nLPDygYJ/QPA33YqdWdwlxpWJ9QjtXf36GX3VJlirqqUdYUXdGHPD
         yrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765177122; x=1765781922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlwFHkB70ycxa7hk9am0TK0PSJjwUc7CdofuXet6SVI=;
        b=JExyRCnjNFuYLMTlaCf1JnHspK2RVpFBeT/Pk4+gSBcfleHbxES2ZqXU7keNdCkgkF
         dKwLawnSJ9EIpSOGaDEEC4lh9Rjl2R0h83DRjDI+rxCC4PCiAd67U4FHoZ2rBKn4rS5A
         oWYK8qtxUxXeFwUHm9+71qHeSplYfxB1q1BIyoAUe0acS26eIN604GjRuY6Up1a1KttT
         ymFH5nyr01tprq5OedrfyGAJlP6LAQkVqWHANrWrCHpyMoZhGmTk8++bE5uxVzC4kJOK
         wmGGQALvSoZ2zvQdrmGufKRqa3XlYW5U6y/gSLih1SdNQ9L+4lUPAXatTN6G4neVEU2x
         wY3w==
X-Gm-Message-State: AOJu0YxIq7i9QUp+eiye2cdMo28OFcD6fBYIpYTgwcpjmNlWNo98KOxb
	P9Iiu1tgQ6H5NOMmZtXXekvs1kyJL4F8PfEG/1jEfReaFRrVgrWTGeogBkQgg6p/eVmJRHFca88
	atFpu
X-Gm-Gg: ASbGncuIDxY7c4fRE02+nEJMfqYK9KIKXbJWz8XO6qFBwCVNfRp4b2zapE5fDdw3h/g
	eU77Nak+JR0A5QtBODwzHZ/rBxAtrEFcL3yB1FiKNCLsy5U9HVB097yUK4GDJh+Co5Tiskj4nqk
	Eemjo9pwZGbq5DGBEHKig265ch+vmcn7EnG3j7X4sw+jL+15q+I9c2+qxnLEsnW9dae8V02NzLa
	w9V5IGMViSzKuGZ5JCKzImP6/HmCnbbnBj2MoHELmXeu4/Sw4sUo1tzV9DdGNELQpEWmfIAAbZO
	NHcaL5vnBWTv3TBm16pLh4GNfmp9Pze19KIFZVW4jdP0VS+531epPJ2Vwk8e19XWLJEJyAJ2uY2
	mVwXlK4AkAdr4CX9lcwb5OGos1p9c6mr4HzHEruqD1XB4/93dvUOUqMWJJQKqETJBpd1mCcAicQ
	LijQk/6GZWb2r8sZD0eNMr
X-Google-Smtp-Source: AGHT+IFjqtTAiebv7YLHwYZsg1Wir4kHA+DpQgzGh8yBvs546KXmJKyuoDXHrxBgpZdxeNhu3TMrRg==
X-Received: by 2002:a05:6000:220c:b0:429:d40e:fa40 with SMTP id ffacd0b85a97d-42f89f54ademr7676829f8f.45.1765177121688;
        Sun, 07 Dec 2025 22:58:41 -0800 (PST)
Received: from localhost.localdomain ([2605:52c0:2:27d1:8ca3:89ff:fe18:2252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm55341281c88.9.2025.12.07.22.58.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 22:58:40 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: l@damenly.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	zlang@redhat.com,
	Su Yue <glass.su@suse.com>
Subject: [PATCH v2] generic: use _qmount_option and _qmount
Date: Mon,  8 Dec 2025 14:58:29 +0800
Message-ID: <20251208065829.35613-1-glass.su@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit touches generic tests call `_scratch_mount -o usrquota`
then chmod 777, quotacheck and quotaon. They can be simpilfied
to _qmount_option and _qmount. _qmount already calls quotacheck,
quota and chmod ugo+rwx. The conversions can save a few lines.

Signed-off-by: Su Yue <glass.su@suse.com>
---
Changelog:
v2:
  Only convert the tests calling chmod 777.
---
 tests/generic/231 | 6 ++----
 tests/generic/232 | 6 ++----
 tests/generic/233 | 6 ++----
 tests/generic/270 | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tests/generic/231 b/tests/generic/231
index ce7e62ea1886..02910523d0b5 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -47,10 +47,8 @@ _require_quota
 _require_user
 
 _scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 
 if ! _fsx 1; then
 	_scratch_unmount 2>/dev/null
diff --git a/tests/generic/232 b/tests/generic/232
index c903a5619045..21375809d299 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -44,10 +44,8 @@ _require_scratch
 _require_quota
 
 _scratch_mkfs > $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 
 _fsstress
 _check_quota_usage
diff --git a/tests/generic/233 b/tests/generic/233
index 3fc1b63abb24..4606f3bde2ab 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -59,10 +59,8 @@ _require_quota
 _require_user
 
 _scratch_mkfs > $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
 
 _fsstress
diff --git a/tests/generic/270 b/tests/generic/270
index c3d5127a0b51..9ac829a7379f 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
 _require_attrs security
 
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 
 if ! _workout; then
 	_scratch_unmount 2>/dev/null
-- 
2.50.1 (Apple Git-155)

