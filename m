Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C638C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FBF619D2
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhC3WAa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhC3WAM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Mar 2021 18:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617141611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDb6zJ9aYLRbPMfVaRhrhqS5rNBUtGGaCCaXGmtw1a0=;
        b=MBDycxKoWmCS3/uRtVSP448HpVcuAfcnXDoN3cvuSF1UrWloeWrMTyt7KfeidCTslAzb9M
        Tzg1tuo/0nn/wp7LrzDNyiHFdW/Tj6J9UFhtjvcu5S1D0KdBHwQNf8lhtVVmNCkSIlscY7
        +d3WFYQ0po6AtYoFAxEAY9lTS+ItLdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-oeZIMj3RPP2Qm3gxx6yOTg-1; Tue, 30 Mar 2021 18:00:09 -0400
X-MC-Unique: oeZIMj3RPP2Qm3gxx6yOTg-1
Received: by mail-wr1-f71.google.com with SMTP id n16so10988048wro.1
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 15:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pDb6zJ9aYLRbPMfVaRhrhqS5rNBUtGGaCCaXGmtw1a0=;
        b=hdVRFNyxqfPY2x7YXOWnjKrHWt/EwE47EOr7R0apecXSAa8c2QKfPUQ5myZ++hbnEJ
         vcTsY9bcmfFZ99e4Ei7fvTWRIJIoD+eSo7Tsp86xIv/DXCMn1crlsSkobPCbRCgHPOEP
         1dWyiIdxdXiZM70NMYc5IhZ3rc4AcDa4bL5nS3tz1BnvUs/+D79W3CzSnQnbiadAf+b+
         xA/kFH5NH8gfQUWzXkTNMuHl5v82sJlaw7pMq3891JdO/YwNoptDNQJ9UpTKleKo5LiZ
         1X6ChNqLKvWUN8DbV1gAa4hZ/2c7MiS0c7IQlDGKkvMP7y8FGwWSWboHN5EtoiAIxeEH
         UcUw==
X-Gm-Message-State: AOAM533gLZhUqlgRYRs4kNUfcNJsmIkxwMRPnhm8K2XVuCTCUWr5BfmL
        TbLYugb8ANVkDGIWjms56FiXlZKJ3uMIgGHSMPgY+GJnsGPwYSV1uigolBmhLyw8upFeb/EUK1M
        cbz9aYg490nCAi8BanzVJiJr8XDeOAHJ6/IWCajxNbc1k1MWrqTGtn+nIvLZEKB30W/NL
X-Received: by 2002:a5d:698d:: with SMTP id g13mr153528wru.2.1617141608103;
        Tue, 30 Mar 2021 15:00:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh1oSvFuK//P4+A6xxb864vMfViEezogf2V5c6s/FD78ukfmw0YSUogjn/3ApqeotcSnz0Hg==
X-Received: by 2002:a5d:698d:: with SMTP id g13mr153517wru.2.1617141607938;
        Tue, 30 Mar 2021 15:00:07 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z2sm522894wrm.0.2021.03.30.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:00:07 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
Subject: [PATCH v2 1/4] common/rc: Add _require_{chown,chmod,symlink}()
Date:   Wed, 31 Mar 2021 00:00:02 +0200
Message-Id: <20210330220005.56019-2-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330220005.56019-1-preichl@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add helper functions that ensure that test is only executed on file
systems that implement chown, chmod and symbolic links.

Fixed test are: generic/{87,88,125,126,128,193,314,317,355,597,598}

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 27 +++++++++++++++++++++++++++
 tests/generic/087 |  1 +
 tests/generic/088 |  1 +
 tests/generic/125 |  1 +
 tests/generic/126 |  1 +
 tests/generic/128 |  1 +
 tests/generic/193 |  1 +
 tests/generic/314 |  1 +
 tests/generic/317 |  1 +
 tests/generic/355 |  1 +
 tests/generic/597 |  1 +
 tests/generic/598 |  1 +
 12 files changed, 38 insertions(+)

diff --git a/common/rc b/common/rc
index 0ce3cb0d..9cdfe21c 100644
--- a/common/rc
+++ b/common/rc
@@ -2129,6 +2129,33 @@ _require_user()
     [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
 }
 
+# check for a chown support
+#
+_require_chown()
+{
+	if [ "$FSTYP" = "exfat" ]; then
+		_notrun "chown is not supported on $FSTYP"
+	fi
+}
+
+# check for a chmod support
+#
+_require_chmod()
+{
+	if [ "$FSTYP" = "exfat" ]; then
+		_notrun "chmod is not supported on $FSTYP"
+	fi
+}
+
+# check for a symbolic links support
+#
+_require_symlink()
+{
+	if [ "$FSTYP" = "exfat" ]; then
+		_notrun "symbolic links are not supported on $FSTYP"
+	fi
+}
+
 # check for a group on the machine, fsgqa as default
 #
 _require_group()
diff --git a/tests/generic/087 b/tests/generic/087
index 1f30dbf4..c3576117 100755
--- a/tests/generic/087
+++ b/tests/generic/087
@@ -37,6 +37,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _require_test
+_require_chown
 
 QA_FS_PERMS=$here/src/fs_perms
 
diff --git a/tests/generic/088 b/tests/generic/088
index 9388a083..ad99bd7e 100755
--- a/tests/generic/088
+++ b/tests/generic/088
@@ -29,6 +29,7 @@ _filter()
 # real QA test starts here
 _supported_fs generic
 _require_test
+_require_chown
 
 path=$TEST_DIR/t_access
 $here/src/t_access_root $path | tee $seqres.full | _filter
diff --git a/tests/generic/125 b/tests/generic/125
index e84248d3..8c8f5cd7 100755
--- a/tests/generic/125
+++ b/tests/generic/125
@@ -25,6 +25,7 @@ _supported_fs generic
 _require_test
 _require_user
 _require_odirect
+_require_chmod
 
 TESTDIR=$TEST_DIR/ftrunc
 TESTFILE=$TESTDIR/ftrunc.tmp
diff --git a/tests/generic/126 b/tests/generic/126
index ac25d294..636ca00d 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -27,6 +27,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _require_test
+_require_chown
 
 QA_FS_PERMS=$here/src/fs_perms
 
diff --git a/tests/generic/128 b/tests/generic/128
index b3e49eff..c1eae77a 100755
--- a/tests/generic/128
+++ b/tests/generic/128
@@ -24,6 +24,7 @@ _supported_fs generic
 
 _require_scratch
 _require_user
+_require_chmod
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount "-o nosuid"
diff --git a/tests/generic/193 b/tests/generic/193
index 3125efdd..fd0ebbf6 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -56,6 +56,7 @@ _supported_fs generic
 
 _require_test
 _require_user
+_require_chown
 
 test_root=$TEST_DIR/$seq.$$.root
 test_user=$TEST_DIR/$seq.$$.user
diff --git a/tests/generic/314 b/tests/generic/314
index 03df81ce..540f0feb 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -29,6 +29,7 @@ _cleanup()
 _supported_fs generic
 _require_test
 _require_user
+_require_chown
 
 rm -rf $TEST_DIR/$seq-dir
 
diff --git a/tests/generic/317 b/tests/generic/317
index 29c37a57..289dfabe 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -45,6 +45,7 @@ _require_scratch
 _require_user
 _require_ugid_map
 _require_userns
+_require_chown
 qa_user_id=`id -u $qa_user`
 
 _filter_output()
diff --git a/tests/generic/355 b/tests/generic/355
index 161dd042..74fba0f9 100755
--- a/tests/generic/355
+++ b/tests/generic/355
@@ -32,6 +32,7 @@ _supported_fs generic
 _require_test
 _require_user
 _require_odirect
+_require_chown
 
 testfile=$TEST_DIR/$seq.test
 rm -f $testfile
diff --git a/tests/generic/597 b/tests/generic/597
index ba769d73..f596406c 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -43,6 +43,7 @@ _require_sysctl_variable fs.protected_hardlinks
 _require_user fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
+_require_symlink
 
 OWNER=fsgqa2
 OTHER=fsgqa
diff --git a/tests/generic/598 b/tests/generic/598
index 6b765275..230c3ac7 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -43,6 +43,7 @@ _require_sysctl_variable fs.protected_fifos
 _require_user fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
+_require_chmod
 
 USER1=fsgqa2
 USER2=fsgqa
-- 
2.30.2

