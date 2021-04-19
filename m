Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDECC43460
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 22:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4ED613B4
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 22:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhDSWEl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240156AbhDSWEk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Apr 2021 18:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618869849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcv/JxxFfv/hcAp/rK2acLM8NkNxRKVwrqbjhB9YAJw=;
        b=Hbac4X/m/FlsM1HtY87aZH5cCWPnKlxeibzfUNAOtBAUXIGyT9GMYoCjKI2dkKDnGvOzvj
        O0JpFPIASmCpmiA8Q1Nvx+2DPmP5UlTvzP6fvakBHRg7iasALJj85XZ3/CCL74UDifpOKP
        scNOyTok/9vHOotGC/WKMSuHyfSPlU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7J51JQbbPueytGX2pWAYAQ-1; Mon, 19 Apr 2021 18:04:07 -0400
X-MC-Unique: 7J51JQbbPueytGX2pWAYAQ-1
Received: by mail-wr1-f69.google.com with SMTP id o14-20020a5d474e0000b029010298882dadso9726937wrs.2
        for <fstests@vger.kernel.org>; Mon, 19 Apr 2021 15:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcv/JxxFfv/hcAp/rK2acLM8NkNxRKVwrqbjhB9YAJw=;
        b=rgSj8REkqJ5/IRif7Oxz6oJHtw8wsqDwp3R8tLlhl4M+qmUIoRnoPlTKpTGloAIWy9
         Vy2JdAgCziUkEb0KNYYv36CBf6lQtkhSTMZrH9NiDlmNQEi/QWAiMPm1x524Y6MSX15n
         sHkEh96P1717a2dd1fpfJ6xJgyMeKkfs7DTlYrKRdYp3Om7sBvKdtRPW0vYDRVX14jPD
         0/0kOK5nHNasJZ/BB1YVO5dCbdq7PgrMgtNBRkNYRE1YaRrMzC2yyluD+7oM1netoMTd
         aLMcHRjKQ5Cw7QmeOzK8tJDSWktSxSQqF3uWaatU3z4yxR7vgxQpRjTBnzUUz8mEYyfl
         5K+g==
X-Gm-Message-State: AOAM532DCYVVxVjzL4QOR56MGlCzHEOVnMv/hGO3AUAyFi7FHaYuOmb5
        CJfOFSdH7MUZFJsOamAM3tRcqHRES+w1VD0zbSMY3Zjlw0nC4HqcLyL91qbtDa5CSxj/bPJTXDf
        PpNYCqF9pOr1Pug9JeQ+nwKy1OJCVSdcieOL0S4dl3gbVuIc5skZjSkot8+th4xSbJ0Gp
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr1060705wmq.121.1618869845416;
        Mon, 19 Apr 2021 15:04:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/Yea8iIkO0WVGHVzLNJoTL6Lo3LwcpB6FyrTQ6mJjqKf08To/RvSqU7uZirNRdfID6MD1Mw==
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr1060685wmq.121.1618869845206;
        Mon, 19 Apr 2021 15:04:05 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id w7sm18775566wru.87.2021.04.19.15.04.04
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:04:04 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 1/1] common/rc: Add _require_{chown,chmod}()
Date:   Tue, 20 Apr 2021 00:04:03 +0200
Message-Id: <20210419220403.70727-2-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419220403.70727-1-preichl@redhat.com>
References: <20210419220403.70727-1-preichl@redhat.com>
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
 common/rc         | 38 ++++++++++++++++++++++++++++++++++++++
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
 12 files changed, 49 insertions(+)

diff --git a/common/rc b/common/rc
index 11ff7635..9fd42254 100644
--- a/common/rc
+++ b/common/rc
@@ -2185,6 +2185,44 @@ _require_user()
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
+# Since chmod sometimes fails silently actual functionality test is done
+#
+_require_chmod()
+{
+	_require_test
+
+	local file="$TEST_DIR/chmod_testfile"
+	touch $file
+
+	# get original file mode
+	mode=`stat --format="0%a" $file`
+	# flip the user's read bit
+	let mode^=0400
+	chmod `printf '%o' "$mode"` $file
+	# check that the chmod actually flipped the bit
+	[ `stat --format="0%a" $file` == `printf '0%o' "$mode"` ] \
+		|| _notrun "chmod is not supported ${FSTYP}"
+
+	rm -f $file
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

