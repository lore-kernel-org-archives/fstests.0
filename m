Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6BC433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 05:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06702611C0
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 05:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhDZFXi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 01:23:38 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:25543 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231575AbhDZFXf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 01:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619414574; i=@fujitsu.com;
        bh=bVRph71X/7YO1EJFk67uGxr9UwcT1zZHqbEXb/4gHas=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=DpSMvYdTUyC/qU6I04TVR8I6hzWyslf7GHBdh9FXfOvzUwwdQxU/VEThdJfRBTS/W
         6xowp1vc7E2aiVJmhmNq10gtKkuiM1+gHr6RSkapnMreUVMq83J0JsTSORE++QxFdm
         HzJ9PBT+DDM+C0FX4VRgaiEqJimwFY1UePvHZ2M3zIiWNmNo/NfJs9UiKGUb8S1fBa
         1ipqmSuED3IXmhhk0O6HnVLctL+oLPCz2kVOeFVRtZwuG3twaaMuIRxgtR3Ow7++cd
         lQBKwoSTdXV2ITCgUdh6de6lnsFUsjGSCpTTxEBAK2phfKbPvHqxAOYXc4dfnySPVf
         HUgxm6vnquLpw==
Received: from [100.112.199.60] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 37/4F-64503-D2E46806; Mon, 26 Apr 2021 05:22:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsViZ8MxVVfXry3
  BYPsFBYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN2NMyl72gladi1u/nzA2MV7i6GLk4hAQ6mSR2
  /n/EDuHsZpQ4c3MVYxcjJwebgKbEs84FzCC2iICsxP8Zq5lAbGYBdYnlk36B2cIC7hJLT55n6
  2Lk4GARUJX4+FoDJMwr4Cmx638LO4gtIaAgMeXhe7AxnAJeEi1nF7OB2EJANa8m7WWGqBeUOD
  nzCQvEeAmJgy9eMEP0Kkpc6vjGCGFXSnSuX8A4gZF/FpKWWUhaFjAyrWK0SCrKTM8oyU3MzNE
  1NDDQNTQ00jW0NNM1MjTRS6zSTdJLLdUtTy0u0TXUSywv1iuuzE3OSdHLSy3ZxAgMxpSCI9d2
  MB54/UHvEKMkB5OSKG8DY2uCEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneSz5tCUKCRanpqRVpm
  TnAyIBJS3DwKInwPnIFSvMWFyTmFmemQ6ROMRpzXL4+bxEzx+a5SxcxC7Hk5eelSonzbvcFKh
  UAKc0ozYMbBIvYS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEedtB7uHJzCuB2/cK6BQmoFP
  46lpBTilJREhJNTBdnH2Uq8f3I0vhPvGk5NuXnjnu2+M5/7Sw7q+OL793cqh+f3P/W+5n70e2
  CjPUj32U+pbKcbdKIj22c8mSM/feTnVcn/WS7dcRkeUJmx/o3tGw0vmbZami/47zyr36tS+sY
  xdKnM6x2flFKV7wOKu9VunZzllNe6vr1guFHT8is1SZ682DgMJL5kzeDXpHS6/flz5fY+0R49
  fYKSj9YaGLnHBsyPFpAtXJb3c5m2T/28u2TF73fEtJ8Smu9b4fONe7OrIe2bxD59PlB7NfMsx
  bc8MfGFU3MjYsbDr37ODn/RF7QhJv5z4uM5yjmTa161wfu7gqS8MekRsaX49f39N2UFq+7eBs
  ocR1d9kav31QYinOSDTUYi4qTgQAOfxu41MDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-287.messagelabs.com!1619414573!727445!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22033 invoked from network); 26 Apr 2021 05:22:53 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-14.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2021 05:22:53 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13Q5Mmqf018229
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 06:22:53 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 06:22:46 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 3/3] src/idmapped-mounts: Remove useless header file
Date:   Mon, 26 Apr 2021 14:23:07 +0800
Message-ID: <1619418187-19951-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When compile xfstest on old kernel, mount-idmapped.c will fail because of
missing linux/bpf.h. But this src file doesn't use bpf realted functions or macros.

So remove these useless header files in idmapped-mounts.c and mount-idmapped.c.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 2 --
 src/idmapped-mounts/mount-idmapped.c  | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 1a02953d..30f8f6e0 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -16,11 +16,9 @@
 #include <pthread.h>
 #include <sched.h>
 #include <stdbool.h>
-#include <sys/acl.h>
 #include <sys/fsuid.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <sys/sysmacros.h>
 #include <sys/xattr.h>
 #include <unistd.h>
 
diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/idmapped-mounts/mount-idmapped.c
index b3e9e27b..219104e7 100644
--- a/src/idmapped-mounts/mount-idmapped.c
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -9,11 +9,8 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <libgen.h>
 #include <limits.h>
-#include <linux/bpf.h>
 #include <linux/sched.h>
-#include <linux/seccomp.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -21,7 +18,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
-- 
2.23.0

