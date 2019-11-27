Return-Path: <SRS0=I7qB=ZT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A621C432C0
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Nov 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8A62070B
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Nov 2019 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQhmrPjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfK0Klh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:41:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36546 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0Klh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Nov 2019 05:41:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id cq11so9769131pjb.3
        for <fstests@vger.kernel.org>; Wed, 27 Nov 2019 02:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HTEsGf8OPgcTCVKi1E3aHpQPwE+KfqREcS+f19rIjwI=;
        b=pQhmrPjHBuQmEz5dDXvOhff+Tobm+pA54I3kApHfeRW/Uyid8iaK0GCVMp6dSgKmo+
         dFO1f9b6brU7L9EBguVuA9k6qU6yYsj1p3zsMU2sEFe5vyMGMEvR41J07xVnokGGsx48
         JNsw52fOt7KsEEmh0ajkN1xB2ZLG/FM3xyQrilKssRddYnzaAxGcgt684knQsHuMiyGG
         naoc5yDy+A3bq0CPU4SPyAYhSETkRqX6zfriexJinGmEeUv7/rBhBZJk3p8hwTQ6Egn2
         Ez4HyJRRRaZe4P/JkTJhpQks3tVkl65Oe6fHIiA6s+tyq2uoVeBfSD8DIZAsslwR7BjK
         B0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HTEsGf8OPgcTCVKi1E3aHpQPwE+KfqREcS+f19rIjwI=;
        b=QAOZ5K4PTgwXXBvTuRKcffIyLZKNxN+2bE1xnZdEDdPsuQ77hmRzX876bxOP02GN5Z
         aNcLO9o+DIf4NtVHuisdWfrt653h1KhOn3Vi0M81+Ica+sCAGzIpbQ1y2vn0Dx3a6JWD
         Fl7HO98PqYM/ramHg5QJZE2QSOEE2t6Mof4QjN3v8J8PG+vx7OA33Ugi2XqUsyRAsPJV
         8lloUB4IkyPQ0kP+AfVaw7QjMQa/XYDjQ41nmjCso+MxqY1q2p+oLDa8Uy5bvcGMMpfx
         6FLiC35DfhLsFqwzRMvz7Ia5AayDbtUvykoSHh7wL4uzIH4ML/5zrrhxoc83l2JuOosL
         gwDw==
X-Gm-Message-State: APjAAAVdFDR8RpRS7Fl6vz/NCBcRfduAh1Vuuf2TJ1DRYs36Ljo0lPBE
        P1Q8OVkvCkL1XH03CzUiEZJng/6jK7A=
X-Google-Smtp-Source: APXvYqzYLpHASupvgjbzSnsFP7JMlsnRxLLMpVFQCNdeHo/2tE0j/L0qThykfys1qrlMZ9kXhsF5RA==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr1842395pje.9.1574851296426;
        Wed, 27 Nov 2019 02:41:36 -0800 (PST)
Received: from lbh-vm.xmfducmkfhgejfckffvf135llh.hx.internal.cloudapp.net ([52.175.53.118])
        by smtp.gmail.com with ESMTPSA id l2sm6668149pjf.4.2019.11.27.02.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:41:35 -0800 (PST)
From:   Baihua Lu <lubaihua0331@gmail.com>
To:     fstests@vger.kernel.org, guaneryu@gmail.com,
        darrick.wong@oracle.com
Cc:     balu@microsoft.com, Lili.Deng@microsoft.com,
        Baihua Lu <lubaihua0331@gmail.com>
Subject: [PATCH] xfs/191-input-validation:Fix issue that the test takes too long
Date:   Wed, 27 Nov 2019 10:41:31 +0000
Message-Id: <20191127104131.112533-1-lubaihua0331@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After this test is passed, checking filesystems will execute. Then
xfs_logprint will be failed and xfs_repair will take a long time because
there is not really creating the file system in this test and wipefs
executes before this test. So there is no need checking filesystems.

Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
---
 tests/xfs/191-input-validation | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index b6658015..db427349 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -31,7 +31,7 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
-_require_scratch
+_require_scratch_nocheck
 _require_xfs_mkfs_validation
 
 
-- 
2.17.1

