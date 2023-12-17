Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BBB47A51
	for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtK6Y4O6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3aa0321b5so4907875ad.2
        for <fstests@vger.kernel.org>; Sun, 17 Dec 2023 09:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702833892; x=1703438692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pS2BFKTQwbsZbgqVvqs7ajm9hhi1MLPVSLMKKQM8j8=;
        b=PtK6Y4O6yx1CDZ9Lu3U96HecbqnOA7QBkTnBt2Qs50F1Z0CiPjnzLB/mtleOfdBe91
         k7mHq6XXKd+SlPueS7ipEY7IXElU4pWg8w4L+UUfN/ud7i7O9WrvIudmnFx5SAAiWuh0
         o0ntGWnoIaGc7patVsLd1KPuF81diXwFTgWzCjsLdWsX7yHO8HY6RZqMg532oIHnR5IB
         pdqFo/YewfbVUeOdpu0R+uNstnnpOnHLHKV+uwDH5vf5KI2eLGuCIPG/405ZVYC2WPKb
         zzCCIk91naNdP+U3x0BPeKKenXXqv8iXEvj/r8YXqrD+1ri+VQGQMGGXC9+TYkBikZ6c
         xuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702833892; x=1703438692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pS2BFKTQwbsZbgqVvqs7ajm9hhi1MLPVSLMKKQM8j8=;
        b=VZlqeWEUmG8IktcEyzYeawZeLc6pfeopjCEzV4/1ooAv514q1q66l1+0lOnlSssRg5
         Vog/uHvWTn2flK5hSQbysLIbtUOVacxnetuqz8rcHhnxhHUBqenCgxlNBcnwudoemc81
         DLmh/lg0HLXYviG16rAlwOG4QiI/ABivCOwPpTz7r7whaYG5SDHilWL/rk4i26d5fBgJ
         yxa1G1fDdYzCVlH0S4GJVj0VJpPgB5F3OEDRXCJFRzFwGLo58+jHn6ux32qBWcV47Gbg
         hIGtMQDco5bDMQtnrWOAKtmCJdC1lRqZoqxP/oGDs2CH/4nWmBfxNBfGGTRSrx29ckwq
         h9Tw==
X-Gm-Message-State: AOJu0Yzt1YGDkiOK+G76LBXfIRo9wtzNi9BpquwhKH0xLcBXSfgbEALc
	71Z8u34lS/8g+D/ywzDYlMBl9sYVD1RORlgP
X-Google-Smtp-Source: AGHT+IE9KPjJze9peur7aMpoT8UYgAJ3pn3smNHWydurHZDrJGqNV5indBoz+LKP5v/s75BZYM0fFA==
X-Received: by 2002:a17:903:187:b0:1cc:449b:689e with SMTP id z7-20020a170903018700b001cc449b689emr19459623plg.20.1702833891756;
        Sun, 17 Dec 2023 09:24:51 -0800 (PST)
Received: from dell-laptop.lan ([180.190.183.136])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001cfb6a7e41bsm17363232plg.151.2023.12.17.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:24:51 -0800 (PST)
From: Alexander Patrakov <patrakov@gmail.com>
To: fstests@vger.kernel.org
Cc: Alexander Patrakov <patrakov@gmail.com>
Subject: [PATCH] generic/129: add a safeguard against media wearout
Date: Mon, 18 Dec 2023 01:24:44 +0800
Message-ID: <20231217172444.250309-1-patrakov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAN_LGv38+54CQrSb=Xod2-g5Tge2ViTT1jpMu25UGN144AEqgg@mail.gmail.com>
References: <CAN_LGv38+54CQrSb=Xod2-g5Tge2ViTT1jpMu25UGN144AEqgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_require_sparse_files is implemented as a list of filesystems known not to
support sparse files, and so misses some cases.

If sparse files do not really work (as it is the case with CIFS and a
Windows Server 2022), this test writes to the disk all the zeros that
would normally be free due to sparse files. This amounts to many
terabytes and presents a significant media wearout concern.

Mitigate this by doing a small-scale test first and checking if the
resulting file ends up being not sufficiently sparse.

Signed-off-by: Alexander Patrakov <patrakov@gmail.com>
---
 src/looptest.c    | 9 +++++++--
 tests/generic/129 | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/looptest.c b/src/looptest.c
index 7194a97d..2e620a60 100644
--- a/src/looptest.c
+++ b/src/looptest.c
@@ -56,6 +56,7 @@ enum {
     FLAG_FLUSH      = 64,
     FLAG_DELETE     = 128,
     FLAG_DIRECT     = 256,
+    FLAG_LEAVE      = 512,
 };
 
 void
@@ -74,6 +75,7 @@ usage(char *argv0)
         "              -s           = sequential\n"
         "              -f           = flush\n"
         "              -D           = direct-IO\n"
+        "              -L           = skip the final truncation\n"
 	"              -h           = usage\n",
             argv0);
 }
@@ -94,7 +96,7 @@ main(int argc, char *argv[])
     char                *buf            = NULL;
     int64_t 		seek_to 	= 0;
         
-    while ((c = getopt(argc, argv, "i:orwb:svthfFDd?")) != EOF) {
+    while ((c = getopt(argc, argv, "i:orwb:svthfFDLd?")) != EOF) {
 	switch (c) {
 	    case 'i':
 		count = atoi(optarg);
@@ -126,6 +128,9 @@ main(int argc, char *argv[])
             case 'D':
                 flags |= FLAG_DIRECT;
                 break;
+            case 'L':
+                flags |= FLAG_LEAVE;
+                break;
             case 'd':
                 flags |= FLAG_DELETE;
                 break;
@@ -230,7 +235,7 @@ main(int argc, char *argv[])
             }
         }
         
-        if (flags & FLAG_TRUNCATE) {
+        if ((flags & FLAG_TRUNCATE) && !((flags & FLAG_LEAVE) && (i == count - 1))) {
             if (flags & FLAG_VERBOSE)
                 printf("seek 0\n");
 
diff --git a/tests/generic/129 b/tests/generic/129
index 3d3a42a2..d1149b65 100755
--- a/tests/generic/129
+++ b/tests/generic/129
@@ -29,6 +29,14 @@ _scratch_mount "-o nosuid"
 
 mkdir $SCRATCH_MNT/looptest
 
+# looptest2, if the missing sparse file support is not detected, writes more
+# than 4 TB to the device. There was a complaint about media wearout, so do a
+# small-scale test first.
+$here/src/looptest -i 10 -L -t -r -w -s -b 102400 $SCRATCH_MNT/looptest/looptest0.tst
+resulting_file_size_kb=$( du -sk $SCRATCH_MNT/looptest/looptest0.tst | cut -f 1 )
+rm -f $SCRATCH_MNT/looptest/looptest0.tst
+[ $resulting_file_size_kb -gt 256 ] && _notrun "Test skipped due to media wearout concerns - sparse files do not work"
+
 $here/src/looptest -i 100000 -r -w -b 8192 -s $SCRATCH_MNT/looptest/looptest1.tst
 $here/src/looptest -i 10000 -t -r -w -s -b 102400 $SCRATCH_MNT/looptest/looptest2.tst
 $here/src/looptest -i 50000 -r -w -b 256 -s $SCRATCH_MNT/looptest/looptest3.tst
-- 
2.43.0

