Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD797C25B0E
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 12:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiHPMSr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiHPMSI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 08:18:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3A1928B
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 05:15:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso1283729pjk.0
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qFlOSE8muSL8lB2XG6PD6Us7y+WhsZ6TvAUomePO+iM=;
        b=edQXNJQTqjtkW7iU6lEOkls8S8CBMTlddMvFLLlCRLZMaSQz+E4wdG5a9VgF42GFrW
         Bqmc3DQDz97o87i25I0A7OQMYlfzu0Xbp6mAGuf3k09ZuiLkKsmplZVNEZDd6x8fE2B3
         eV7Lp2QCe4DpNzkgXinN54OYV6sAhn532AgzzTppGjBbKRaYD2geOCXT3Ki7bojnY241
         mTB8nXEmsQr/G7Jj9Bw4i9x1o22PfunwYptN/DKzUm9PNxrJ580AmGM91nzhmMTZX24O
         /v1Jfo70LtACbYFEjBPQOfks9zIDYuThXp8ylAXEQl2UkWOsU+cyMMIx61T0QojhRkr2
         oxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qFlOSE8muSL8lB2XG6PD6Us7y+WhsZ6TvAUomePO+iM=;
        b=myf2z8xDsIClppVPU036C0+OdElJOV9XBAXARQrGN3xl8WJ/6HdnI5LAw1H9wFoyG6
         1+lB+qPczBX0aVBYGHIJ6vgyqeCmj4aNOLOVJjX6udyo5Yu1pEcbBML8GgvKAirfuQKN
         KLMlc3tgOeljpXSfZB8EsVxni9ny4CBGS+q2hfML2/6CRKEi760I0OI11N++Hxo8gWxq
         BtI9DO1+pV4+dSkHeO82f1fyM6FvdhZB31CnXF5uORpbcHa6bDKowpWawsXhKu02FbPn
         T8seb37+BbtM6pwQkWmgtdl9Ye3xHiGlE6wxZCmwTnMHW0tL0hzmiDvabQGdvUU0O3NZ
         p1bQ==
X-Gm-Message-State: ACgBeo0o/QBUqsY35MaX+1eDNPmwoSouWoub8dTKLcEjabVA3ICK/or8
        99Mxi/YXBg2iL/yCkv8Lc3FrYYZYZm8Jgc0t
X-Google-Smtp-Source: AA6agR4b+Qh1G9rsZ3G2I/NHA+7n21EsZuNkMX3maybuIIkDneHR10S5qMiB+rvzr3kTvo6rXj0yDg==
X-Received: by 2002:a17:903:41c3:b0:16f:3180:a3c9 with SMTP id u3-20020a17090341c300b0016f3180a3c9mr21807678ple.90.1660652158214;
        Tue, 16 Aug 2022 05:15:58 -0700 (PDT)
Received: from damenlys-MBP.lan ([103.117.102.23])
        by smtp.gmail.com with ESMTPSA id n64-20020a622743000000b005344048a497sm6227909pfn.140.2022.08.16.05.15.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Aug 2022 05:15:57 -0700 (PDT)
From:   Su Yue <glass@fydeos.io>
To:     fstests@vger.kernel.org
Cc:     l@damenly.su, brauner@kernel.org, Su Yue <glass@fydeos.io>
Subject: [PATCH] vfs/idmapped-mounts: fix unhandled EOVERFLOW in setattr_fix_968219708108
Date:   Tue, 16 Aug 2022 20:15:51 +0800
Message-Id: <20220816121551.88407-1-glass@fydeos.io>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since kernel commit b27c82e12965 ("attr: port attribute changes to new
types"), errno should be EOVERFLOW instead of EINVAL if fchownat(2)
called with {g,u}id whose mapping are not in fs/mount idmappings.

The errno EOVERFLOW causes failure of generic/656:
========================================================================
generic/656 3s ... [failed, exit status 1]- output mismatch (see /root/xfstests-dev/results//generic/656.out.bad)
    --- tests/generic/656.out   2022-01-03 14:18:41.049999153 +0800
    +++ /root/xfstests-dev/results//generic/656.out.bad 2022-08-16 20:09:41.679999992 +0800
    @@ -1,2 +1,4 @@
     QA output created by 656
     Silence is golden
    +idmapped-mounts.c: 7371: setattr_fix_968219708108 - Value too large for defined data type - failure: errno
    +vfstest.c: 1882: run_test - Success - failure: test that setattr works correctly
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/656.out /root/xfstests-dev/results//generic/656.out.bad'  to see the entire diff)
Ran: generic/656
Failures: generic/656
========================================================================

As Christian Brauner explained:
"
- EINVAL should only be reported because the target {g,u}id_t has no
  mapping in the caller's idmapping, i.e. doesn't yield a valid k{g,u}id_t.
- EOVERFLOW should be reported because the target k{g,u}id_t doesn't
  have a mapping in the filesystem idmapping or mount idmapping. IOW,
  the filesystem cannot represent the intended value. The mount's
  idmapping is on a par with the filesystem idmapping and thus a failure
  to represent a vfs{g,u}id_t in the filesystem should yield EOVERFLOW.
"

EOVERFLOW is another reasonable errno so handle it after fchownat(2)
failed.

Link:https://lore.kernel.org/fstests/20220816103040.gtgg2w75tzpejas5@wittgenstein/T/#t
Signed-off-by: Su Yue <glass@fydeos.io>
---
 src/vfs/idmapped-mounts.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 63297d5fa43d..50550dd0ca13 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -7364,10 +7364,11 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
 		/*
 		 * The {g,u}id 0 is not mapped in this idmapped mount so this
 		 * needs to fail with EINVAL.
+		 * errno should be EOVERFLOW after kernel commit b27c82e12965.
 		 */
 		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
 			die("failure: change ownership");
-		if (errno != EINVAL)
+		if (errno != EINVAL && errno != EOVERFLOW)
 			die("failure: errno");
 
 		/*
@@ -7454,10 +7455,11 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
 		/*
 		 * The {g,u}id 0 is not mapped in this idmapped mount so this
 		 * needs to fail with EINVAL.
+		 * errno should be EOVERFLOW after kernel commit b27c82e12965.
 		 */
 		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
 			die("failure: change ownership");
-		if (errno != EINVAL)
+		if (errno != EINVAL && errno != EOVERFLOW)
 			die("failure: errno");
 
 		/*
-- 
2.37.1

