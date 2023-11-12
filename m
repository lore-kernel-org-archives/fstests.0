Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A46FA3
	for <fstests@vger.kernel.org>; Sun, 12 Nov 2023 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIFJKDtw"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DA30C5;
	Sun, 12 Nov 2023 00:02:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40859dee28cso28066225e9.0;
        Sun, 12 Nov 2023 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699776168; x=1700380968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4D7nsH3EJdfsu9/ysqFllp1Fim7BA5laHaE5lvR2Wc=;
        b=FIFJKDtw2FNMg2a7m8VAT8Pcgjbi8rVuZ3FPyLcAQAj2rgTThe4eV76KOyrNVR9qYG
         3RFE4Dbwv9sXh37rCF3iomxEjCmlVRgADm+54rgXhNyMyoe5xx+8wt6uROKpCH1JDOzR
         gmUBxHRHzT73r2cNthOrQfQn/tdow6ZyFB9YbFs/SFWVpdl+/4qPiM+aHYL0+UtM9Zni
         bNAXbbYLb2ncEe3zVoleBvzIl6FKWYJA2GL/q3Ndgd8iyzJkUzbK8iF5rj70lkLdZA+j
         gmjs9RIYDjXq4Z9FCpFoXsEptb7FtKRvLuvGxZkLsE6qdSpkSXzez1HHNqGhHQnmH6dC
         WwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699776168; x=1700380968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4D7nsH3EJdfsu9/ysqFllp1Fim7BA5laHaE5lvR2Wc=;
        b=GKUhJQb+cu7YyJBKMi6OQ/Ufsc9vnCgU/pnFr1LTvLYleD8PaqByOvOTM4ojrmtzRR
         kfpRdxHJTS+Ml+tHXxbTZIoTNS0oapJvWF1q3+6AgGzfgSw8p8BQnup3WcfQIrq3Fgz7
         j4dObTW8aV/dsF8tXoHmmbXWymi7WnXO/QWtIq48cZJ/fg/cmTETcpFk6/PR8LTqgsf8
         GM9gqffcLWboxIYhvQJjNAgeqeAd7YE5fx73LOKbf/O1OdJ6iFV+6CaiD3SEHMg09JDe
         jT5Ep4iPZMnwKldbZtKm8HF44iN3rglH72c0MJgtkeKwFit6mOvS6XvKhr9/KBtEJqC9
         cG+g==
X-Gm-Message-State: AOJu0YxVkywQcyzEX6JOsBZkJQ7EBFHKp0fcbhWSfvdw7GVHveBXhwpW
	ohdiCBTjXXsCBBLc/3VKPznRYyEBkvQ=
X-Google-Smtp-Source: AGHT+IG98lxP8PKJiG7/ZP92U5RxnEUeyCbwhfBJlj8uAw6KOLQOsuydxstn0XY5c+9A+UTHnbWJcw==
X-Received: by 2002:a05:600c:a02:b0:407:5b54:bb0c with SMTP id z2-20020a05600c0a0200b004075b54bb0cmr3326889wmp.19.1699776167470;
        Sun, 12 Nov 2023 00:02:47 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004030e8ff964sm10226403wms.34.2023.11.12.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 00:02:46 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Alexander Larsson <alexl@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] overlay/026: Fix test expectation for newer kernels
Date: Sun, 12 Nov 2023 10:02:42 +0200
Message-Id: <20231112080242.1492842-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Larsson <alexl@redhat.com>

We now support xattr of overlayfs.* xattrs, so check that either
both set and get work, or neither.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Zorro,

This test is failing since overlayfs merge for v6.7-rc1, because it
encodes an expectation that set/get of private overlay.* xattrs
should fail.

This expectation is no longer correct for new kernel, so Alex has
fixed the test to expect consistent behavior of set/get of private
overlay.* xattrs.

We have some new tests for features merged for v6.7-rc1, but this fix
has higher priority, so sending it early.

Thanks,
Amir.


 tests/overlay/026     | 35 +++++++++++++++++++++++++----------
 tests/overlay/026.out |  2 --
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tests/overlay/026 b/tests/overlay/026
index 77030d20..f71b3f13 100755
--- a/tests/overlay/026
+++ b/tests/overlay/026
@@ -57,21 +57,36 @@ $SETFATTR_PROG -n "trusted.overlayfsrz" -v "n" \
 _getfattr --absolute-names -n "trusted.overlayfsrz" \
   $SCRATCH_MNT/testf0 2>&1 | _filter_scratch
 
-# {s,g}etfattr of "trusted.overlay.xxx" should fail.
+# {s,g}etfattr of "trusted.overlay.xxx" fail on older kernels
 # The errno returned varies among kernel versions,
-#            v4.3/7   v4.8-rc1    v4.8       v4.10
-# setfattr  not perm  not perm   not perm   not supp
-# getfattr  no attr   no attr    not perm   not supp
+#            v4.3/7   v4.8-rc1    v4.8       v4.10     v6.7
+# setfattr  not perm  not perm   not perm   not supp  ok
+# getfattr  no attr   no attr    not perm   not supp  ok
 #
-# Consider "Operation not {supported,permitted}" pass.
+# Consider both "Operation not {supported,permitted}" and
+# "No such attribute" as pass for getattr to support all kernel
+# version. However, the setfattr result must match getattr.
 #
-$SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
-  $SCRATCH_MNT/testf1 2>&1 | _filter_scratch | \
-  sed -e 's/permitted/supported/g'
 
-_getfattr --absolute-names -n "trusted.overlay.fsz" \
+getres=$(_getfattr --absolute-names -n "trusted.overlay.fsz" \
+  $SCRATCH_MNT/testf1 2>&1 | _filter_scratch)
+
+supported=n
+if [[ "$getres" =~ "No such attribute" ]]; then
+    supported=y
+else
+   [[ "$getres" =~ Operation\ not\ (supported|permitted) ]] || echo unexpected getattr result: $getres
+fi
+
+setres=$($SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
   $SCRATCH_MNT/testf1 2>&1 | _filter_scratch | \
-  sed -e 's/permitted/supported/g'
+  sed -e 's/permitted/supported/g')
+
+if [ $supported == 'y' ]; then
+    [[ "$setres" == "" ]] || echo unexpected setattr result: $setres
+else
+    [[ "$setres" =~ "Operation not supported" ]] || echo unexpected setattr result: $setres
+fi
 
 # success, all done
 status=0
diff --git a/tests/overlay/026.out b/tests/overlay/026.out
index c4572d67..53030009 100644
--- a/tests/overlay/026.out
+++ b/tests/overlay/026.out
@@ -2,5 +2,3 @@ QA output created by 026
 # file: SCRATCH_MNT/testf0
 trusted.overlayfsrz="n"
 
-setfattr: SCRATCH_MNT/testf1: Operation not supported
-SCRATCH_MNT/testf1: trusted.overlay.fsz: Operation not supported
-- 
2.34.1

