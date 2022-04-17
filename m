Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E7CC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Apr 2022 17:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiDQRnK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiDQRnK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 13:43:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C262ED6F
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so16256439wrh.11
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSa78drSzm6KpbK46mMi5jkh3oVF8i6BsUFWxwRiicQ=;
        b=JAaRwRkOsEy/qSY+TIpwIjo7n3UjDR+tJ/TnzvOXCbl8chGrvGdcXRNj/pnM2c91xS
         n7klnBV8S8YNn+e9JpVMQpCa6kIZKGEFmCvg6f83qoPZq1+CQA8TrhydbO+sfVD3VYLE
         2wshIFCXAq6QwcAI8UVQ6SY++hUCDnYvySIuDxSW5fTtcwouzfXcQLFKOBxKFfNK1m7G
         OajjUhqJLkMinksRbMfqzF1IVq78rYtcyeU0WYMx3HTGymKdgvmWMAFULkTapeHPyC4a
         X9QuiVO/R/ETNsYs3FlO9NKLd3fLaW3G9ib3XC4hnXhU9mb7VFwvS4oTBcONOEYZZP7C
         zllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSa78drSzm6KpbK46mMi5jkh3oVF8i6BsUFWxwRiicQ=;
        b=rBes1dNujSHYsElPdWPUrIbApDAmgwfbk8XkH4P+6geeiEryjjUGjeWA6cELDa9H9E
         QsvlY+Zfpf0v55XgrNmyzegJPi/VyD2Hm5nSNU1leWsE6mgajtAOcORifo1DtDk+RrVP
         IEaJluUlQBUd7LAoMpICKSb7RHMJnc9DxZkT/PW5JeebxTyTZ9fwAHVBvzbPZ9H0fDHM
         y7PR5fJgMNaxKGvBMIXx9OzMpLdulGsEEeiNYOXKMlAfgUU5c9e7lvZIFar1inUFAzUe
         +fyQiG/WY7O20YMBrg5nKtLgmR7go9PdrFgZ+e5BC1+6LPtAl/NMmJUBxMJKqvzq/Jwt
         8fxw==
X-Gm-Message-State: AOAM531f3uPBDaEqUyBdnE29Q75IpvgBukQEGJZXjGVwGpJxpJGU8Ai9
        LbujhAuy1XDyfSFuloZnN7EoprVUYPM=
X-Google-Smtp-Source: ABdhPJzEuJjYXxo3WiSRuLid2Ij7pN5QZyNG+weTYJoUegKOwZ78jx/ZE+HLV1gFq4Cf8UtF/zR/ag==
X-Received: by 2002:adf:de81:0:b0:207:a65c:d895 with SMTP id w1-20020adfde81000000b00207a65cd895mr5919147wrl.647.1650217232660;
        Sun, 17 Apr 2022 10:40:32 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm9108564wrg.70.2022.04.17.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:40:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH 1/3] common: support black listing fs in _supported_fs()
Date:   Sun, 17 Apr 2022 20:40:21 +0300
Message-Id: <20220417174023.3244263-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417174023.3244263-1-amir73il@gmail.com>
References: <20220417174023.3244263-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For example:
_supported_fs ^xfs

There is no need to specify "generic" when using a block list
"all other fs are supported" is implied.

Converted some generic tests that open code this condition without
emitting a meaningful reason.

More generic test like generic/186,187 could use a block list, but
were not converted because they emit some meaningful reason:
  _notrun "Can't fragment free space on btrfs."

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc         | 30 ++++++++++++++++++++----------
 tests/generic/500 |  3 +--
 tests/generic/631 |  3 +--
 tests/generic/679 |  3 +--
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/common/rc b/common/rc
index 17629801..1d37dcbd 100644
--- a/common/rc
+++ b/common/rc
@@ -1572,19 +1572,29 @@ _fail()
 
 # tests whether $FSTYP is one of the supported filesystems for a test
 #
-_supported_fs()
+_check_supported_fs()
 {
-    local f
+	local res=1
+	local f
 
-    for f
-    do
-	if [ "$f" = "$FSTYP" -o "$f" = "generic" ]
-	then
-	    return
-	fi
-    done
+	for f; do
+		# ^FS means black listed fs
+		if [ "$f" = "^$FSTYP" ]; then
+			return 1
+		elif [ "$f" = "generic" ] || [[ "$f" == "^"* ]]; then
+			# ^FS implies "generic ^FS"
+			res=0
+		elif [ "$f" = "$FSTYP" ]; then
+			return 0
+		fi
+	done
+	return $res
+}
 
-    _notrun "not suitable for this filesystem type: $FSTYP"
+_supported_fs()
+{
+	_check_supported_fs $* || \
+		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
 # check if a FS on a device is mounted
diff --git a/tests/generic/500 b/tests/generic/500
index 0be59934..bc84d219 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -35,7 +35,6 @@ _cleanup()
 . ./common/dmthin
 
 # real QA test starts here
-_supported_fs generic
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
@@ -43,7 +42,7 @@ _require_dm_target thin-pool
 # and since we've filled the thinp device it'll return EIO, which will make
 # btrfs flip read only, making it fail this test when it just won't work right
 # for us in the first place.
-test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
+_supported_fs ^btrfs
 
 # Require underlying device support discard
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/generic/631 b/tests/generic/631
index 4996bce7..219f7a05 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -36,10 +36,9 @@ _cleanup()
 . ./common/attr
 
 # real QA test starts here
-_supported_fs generic
 _require_scratch
 _require_attrs trusted
-test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
+_supported_fs ^overlay
 _require_extra_fs overlay
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/generic/679 b/tests/generic/679
index 440f0c08..c32d42b9 100755
--- a/tests/generic/679
+++ b/tests/generic/679
@@ -17,7 +17,6 @@ _begin_fstest auto quick prealloc
 
 # real QA test starts here
 
-_supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fiemap"
@@ -26,7 +25,7 @@ _require_xfs_io_command "fiemap"
 #
 #   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/
 #
-[ $FSTYP == "xfs" ] && _notrun "test not valid for xfs"
+_supported_fs ^xfs
 
 rm -f $seqres.full
 
-- 
2.35.1

