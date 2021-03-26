Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08770C433E3
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6EF61A43
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Mar 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCZPlw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhCZPll (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Mar 2021 11:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616773301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBH46VgVsNuhboqNNMvhn70GP7sx1dn9/WV1tz/cZGg=;
        b=Xx7xcC8fin18ZepB1X6gu9kVEqblfq6CnvHXblddyIDUfYHASvGRJsn3zRt4FwQgNv2yQv
        ZkDVxBGG4ZTmpnRYOEUL2RabJbCzHENlduI/QIgofUKiFNoalQ5cOfcFZj9J16+FMPGPMN
        kV2IzBgeeGFSi0awktGHAulDn1A660w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-hiTIK22mN1ibluIcdBGq6A-1; Fri, 26 Mar 2021 11:41:39 -0400
X-MC-Unique: hiTIK22mN1ibluIcdBGq6A-1
Received: by mail-ej1-f69.google.com with SMTP id kx22so4257614ejc.17
        for <fstests@vger.kernel.org>; Fri, 26 Mar 2021 08:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBH46VgVsNuhboqNNMvhn70GP7sx1dn9/WV1tz/cZGg=;
        b=DrGzYWFpQSGyIs9D6GKdtexpMEQwDGAHaB/wuyuID6Kr6c4wB6Vdbyb59bTjwNKA7/
         mVsCysxYZ+pntZg60VZYovuFzVuYPPiEmUWgWoyAOh6EZO4M4eFTjd+xx2TOgSntpPGH
         xU7Uezu1WQZnCWuMWDbpuCQ5P44RkL8blWNZR+2wJtszRTPWJVuA99ghu6v7a8tIZ4t4
         eF7qjCwG1gNviJVXyaWtSOgPOi8rkqfU5YgaBuLxlsMQwlUzfiJFjGZpbl98Cth/m9nO
         3QCsFDgxGI/lwQy8l6VNatGHaWNT1G51ePBxHVix9pHenhNoeT1+ny7qx1IQZ+3/vyaZ
         OE+A==
X-Gm-Message-State: AOAM530anjvjmlWLIGwL/JnIny+JVfXBp8/Xs0kqN0zHeW3ml4gD/n68
        g/bfZ5fcVj0Ortcwfd/chYPQ1gOVPon1Q4KquTDuXt4dxFJMtr/f8EanerBI1klzBlhalpZYk0J
        xo+LBate88/fDobUuTSglu+4WYAB/VayibkBh56ZWMqQWx9d1Fiy3+7REzQDSvhnuu7rg
X-Received: by 2002:a17:906:f84b:: with SMTP id ks11mr15883459ejb.296.1616773297790;
        Fri, 26 Mar 2021 08:41:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkoBqIT9azgy3Skad/Q4EH/6tPODFSaez6ecxseQrbeux7uN3CsR8xXqGKDZB9vWDcOhtBIg==
X-Received: by 2002:a17:906:f84b:: with SMTP id ks11mr15883442ejb.296.1616773297636;
        Fri, 26 Mar 2021 08:41:37 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id p9sm4389791eds.66.2021.03.26.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:41:37 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, xzhou@redhat.com
Subject: [PATCH 2/5] g/87,88,125,126,128,193,314,317,355: Add _require_chown/chmod
Date:   Fri, 26 Mar 2021 16:41:31 +0100
Message-Id: <20210326154134.309159-3-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326154134.309159-1-preichl@redhat.com>
References: <20210326154134.309159-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/087 | 1 +
 tests/generic/088 | 1 +
 tests/generic/125 | 1 +
 tests/generic/126 | 1 +
 tests/generic/128 | 1 +
 tests/generic/193 | 1 +
 tests/generic/314 | 1 +
 tests/generic/317 | 1 +
 tests/generic/355 | 1 +
 9 files changed, 9 insertions(+)

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
-- 
2.30.2

