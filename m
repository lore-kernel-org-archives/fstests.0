Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B6C433ED
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4BC6139A
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhDOJtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231531AbhDOJte (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618480151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucBprjId/JLGXlyCzWhwLvigBtrShDrHK+vmZYBr/lU=;
        b=bfGogAlFKWvrxGCon2AcSH1KuYKZi1bgGPYiZrHnLpNIMTvZW21TeKe1NtmTlvb3NrRqW1
        hERNBWrapG54T0CxGKA6VPx8ZDPwT+/vhD0h368QOoXKoE1DnZYudoz/+jfIUPCB7FsysV
        JM4B8fIh1UQpsU/LIaItTL/sF4l55+Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-zOonpWQ9PiOgfL3NDliCkA-1; Thu, 15 Apr 2021 05:49:08 -0400
X-MC-Unique: zOonpWQ9PiOgfL3NDliCkA-1
Received: by mail-wm1-f70.google.com with SMTP id l6-20020a1c25060000b029010ee60ad0fcso2702174wml.9
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucBprjId/JLGXlyCzWhwLvigBtrShDrHK+vmZYBr/lU=;
        b=bAHaBObUekF59c1T6qcj3RuRlv400jok+/X0h4+tUo6gd6+6FZTerW+qHUJDaK8Jzv
         nGTeVWf/7WHFYHakeBaZ/zjdbyD64ncbXYI/db7dJNZMHhLlPrxjyAMPzpAgr67FcWQF
         PUvB6EFiO449IbjdTycIos0y09fKEUjOutDtGWRsoDQy6+CTsKe7MFO2SaUZZiPle7mz
         n9QcbxpBZiA7GkprAnBcAcgPFunjuH6k/VZ456aPQSo+qrXqBLShgI2aeHSkr5Yg2ycc
         wQJkzn/9L7BtS5v2UjLBXHwBxuObvKvxhQ+RQy7F+M6gaZeWuPjzm7mLXkppTZY4pbGV
         UMOA==
X-Gm-Message-State: AOAM5317NAi4nrD9oCC+TLsJQElVZsQAxoGYmJ0kMb9/498OMGOaZ1VY
        h4TjVKeeZNMnSpStP9pBmSIYWiwX0/fwsFWjVdxCcA4ficmZSdVXXdiPvoS8GLVvBZjsULKH+sV
        0W25+NaRNqgHUD7f+s2gthhSHoGnmcjW6r862/5Mfawu7aD75t61fkLqYBFcZm4TYBKPu
X-Received: by 2002:a5d:4251:: with SMTP id s17mr2513084wrr.174.1618480146971;
        Thu, 15 Apr 2021 02:49:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxodVvOx/IgEokByXBMnsiyAWpfbYERUX3JlsAVary27UgVNjUQqwYJpJX8zPPv+N1Lb9seZQ==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr2513071wrr.174.1618480146822;
        Thu, 15 Apr 2021 02:49:06 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v4sm2427278wrf.36.2021.04.15.02.49.06
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:49:06 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 1/4] common/rc: Add _require_{chown,chmod}()
Date:   Thu, 15 Apr 2021 11:49:02 +0200
Message-Id: <20210415094905.61853-2-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210415094905.61853-1-preichl@redhat.com>
References: <20210415094905.61853-1-preichl@redhat.com>
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
 common/rc         | 23 +++++++++++++++++++++++
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
 12 files changed, 34 insertions(+)

diff --git a/common/rc b/common/rc
index 23f86ce6..be292aaf 100644
--- a/common/rc
+++ b/common/rc
@@ -2115,6 +2115,29 @@ _require_user()
     [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
 }
 
+# check for a chown support
+#
+_require_chown()
+{
+	rnd_uid=4242
+
+	_require_test
+
+	local file="$TEST_DIR/chown_testfile"
+	touch $file
+	chown ${rnd_uid}:${rnd_uid} $file >/dev/null 2>&1 \
+		|| _notrun "chown is not supported ${FSTYP}"
+	rm -f $file
+}
+
+
+# check for a chmod support
+#
+_require_chmod()
+{
+	_require_chown
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
index ba769d73..6602dc70 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -43,6 +43,7 @@ _require_sysctl_variable fs.protected_hardlinks
 _require_user fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
+_require_symlinks
 
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

