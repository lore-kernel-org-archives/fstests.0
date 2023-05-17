Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34768C77B75
	for <linux-fstests@archiver.kernel.org>; Wed, 17 May 2023 12:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjEQME7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 May 2023 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjEQMDg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2023 08:03:36 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD75BB2
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 05:01:19 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6238b15d298so1696866d6.0
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684324878; x=1686916878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgKRUYIEl6qhTcOtIMjzYualpWxpADTtKbuzMYRUPJ0=;
        b=W5AWQJyU0htdy3USYmU5gosw37GTjZlcfS4e0SpFk0DphVhiz0rgdCHHpynLjOJAbb
         DY+YKyLgZuJ5H3siWDT8YMV2xkJrs4+wZPqOfY/m/RqGuCDTE3mOUxGum9lutfIk16B8
         023huhOiMrB3+QmAygFsrwKLeiDz5ImeooXIKsZKPRFeqbuau6R5eotaeIJroUw4eCTw
         EmnGeDpG4Vs2OSDqHsLSUViMMKqicXzqvuxRnqYMZoWLLG37QFTnMdlb5yR1Q/hjemUW
         wPHS/IrBTbFGLgK5TKNAUQEGPpJcQ+ahQoG93NVymLy1572pvOApUnnEKjY9h7hXeoCE
         4NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684324878; x=1686916878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgKRUYIEl6qhTcOtIMjzYualpWxpADTtKbuzMYRUPJ0=;
        b=bR71ipE06Zbe0pZrmELqyig50DNTrdOvZH1HUfmOfx9sQCCOO4GL1ETqDXgNZJK5Xv
         ijiXfhTJcNqPJPA1dpMc90tA4SRypC5fazNVYglOngKJcCc14ukCqepe2stEUWLc6/7k
         jT2VtjITqwbyOmd/09UIIZ3aSxUOnXUTU2bwbpWfjhb75a/pkSAHVanBn7INbeDpdN/W
         1qyir26Jnp7HmRsU2R7vBQV2QG5lEcHShYuQDICZ4IEMtyHxQmv88cFtD5q3FmIXt2qJ
         2031UaryOubd3hYOGdPnDer1poVCj57J1Xv93F3naGoJFIGcMdM5jBeKz2aECpCaWFcO
         bkTA==
X-Gm-Message-State: AC+VfDwOvJuT+o2Yu3uarJ7iQF9LBIcAbzHiuO+S3VtsM57ujjSzVALZ
        0hEfX2vlAt0Ffrhjs1cpNFFy+MT/xTonRg==
X-Google-Smtp-Source: ACHHUZ6W+C+57KHulX5LzIf5LAXm8YBskl2PHRjaMBp0BiJM+0igRMG0l3l1I+02sB7JEu3stUS+Eg==
X-Received: by 2002:a05:6214:27e1:b0:621:8b5:229a with SMTP id jt1-20020a05621427e100b0062108b5229amr53262888qvb.2.1684324878519;
        Wed, 17 May 2023 05:01:18 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id c3-20020a0cf2c3000000b0061c7431810esm5415254qvm.141.2023.05.17.05.01.18
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:01:18 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] common/{filter,quota}, xfs/1{06,52}: fix grep pattern
Date:   Wed, 17 May 2023 20:01:11 +0800
Message-Id: <20230517120111.2231544-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Newer(3.9) grep is complaining about these unnecessary
backslashes before # and -, and breaking the golden output.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v2:
   Apply Zorro's suggestion, removing all backslashes.

 common/filter | 2 +-
 common/quota  | 2 +-
 tests/xfs/106 | 4 ++--
 tests/xfs/152 | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/filter b/common/filter
index 3e3fea7e..f10ba78a 100644
--- a/common/filter
+++ b/common/filter
@@ -293,7 +293,7 @@ _filter_project_quota()
 	# until the GETNEXTQUOTA ioctl came into use.  Filter it out.
 	# But if you specify a name for ID 0, that means you want to
 	# deal with it by yourself, this function won't filter it out.
-	_filter_quota | grep -v "^\#0 \|^(null) "
+	_filter_quota | grep -v "^#0 \|^(null) "
 }
 
 # Account for different "ln" failure messages
diff --git a/common/quota b/common/quota
index 96b8d044..6b529bf4 100644
--- a/common/quota
+++ b/common/quota
@@ -191,7 +191,7 @@ _scratch_enable_pquota()
 _require_setquota_project()
 {
 	setquota --help 2>&1 | \
-		grep -q "\-P, \-\-project[[:space:]]*set limits for project"
+		grep -q -- "-P, --project[[:space:]]*set limits for project"
 	if [ "$?" -ne 0 ];then
 		_notrun "setquota doesn't support project quota (-P)"
 	fi
diff --git a/tests/xfs/106 b/tests/xfs/106
index fc2281af..388873bd 100755
--- a/tests/xfs/106
+++ b/tests/xfs/106
@@ -59,13 +59,13 @@ clean_files()
 
 filter_quot()
 {
-	_filter_quota | grep -v "root \|\#0 " \
+	_filter_quota | grep -v "root \|#0 " \
 		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
 }
 
 filter_report()
 {
-	_filter_quota | grep -v "^root \|^\#0 " \
+	_filter_quota | grep -v "^root \|^#0 " \
 		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
 }
 
diff --git a/tests/xfs/152 b/tests/xfs/152
index dd33801d..325a05c1 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -98,13 +98,13 @@ clean_files()
 
 filter_quot()
 {
-	_filter_quota | grep -v "root \|\#0 " \
+	_filter_quota | grep -v "root \|#0 " \
 		| sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
 }
 
 filter_report()
 {
-	_filter_quota | grep -v "^root \|^\#0 " \
+	_filter_quota | grep -v "^root \|^#0 " \
 		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
 }
 
-- 
2.31.1

