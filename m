Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9CC6FD18
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 08:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjDYIVs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Apr 2023 04:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDYIVr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Apr 2023 04:21:47 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22D49E8
        for <fstests@vger.kernel.org>; Tue, 25 Apr 2023 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682410903; i=@fujitsu.com;
        bh=0PZ/bd23+iBoNa7oYHerf75Et9f49uLP8hO/LgUuBFw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=LpBc986rlv7RgGDuOSjsbhvXT1XBPBhOxlw5nXq+9IBgmo8Yaz+dLD27RBXooJqG+
         Bg57KJK27f8IEX3K6k2G3ZkWJLND71dT6P16Hm1w8lfwktkZ9n80Fn/ZUhCva36TIL
         1klGlrVjkrho4FzEDAFU6dGNjqTFVQpWUUjMj075FKVmiMxxQC7cirMPnLMUrD6+bG
         HsCn198UGvwv+CsmiL7uSwXucLTmpHSPDbydhbJF1UWmToS8xg/CjsM9mcilpGmWFh
         KqQiaWtUVoHJFZviwsbkO0okHvkyL61h6FxHpdgXUlrqfYeiEmyJQE3U/lPYwPrO/B
         i47Cky9jIhf1A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsViZ8ORqDut1z3
  FYPIyG4vXhz8xWpxu2ctucf7wAkaL9qeTGB1YPDat6mTz2PnQ0uPzJrkA5ijWzLyk/IoE1oxr
  m5YxFuwTqljb84a1gfEafxcjF4eQwBZGicete1ghnBVMEq8OXWaCcPYxSizYvJKxi5GTg01AU
  +JZ5wJmEFtEQFbi/4zVTCA2s0CdRNvSbywgtrBAoMSVxdfBalgEVCVeHvoI1ssr4CnRdWMKWL
  2EgILElIfvwWo4BVwlzrTOBesVEnCROH+phxWiXlDi5MwnLBDzJSQOvnjBDNGrJNHWeoUVwq6
  UaP3wiwXCVpO4em4T8wRGwVlI2mchaV/AyLSK0bw4tagstUjX0FIvqSgzPaMkNzEzRy+xSjdR
  L7VUNy+/qCRD11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMw3FOK037vYPy686/eIUZJDiYlUV6uM
  LcUIb6k/JTKjMTijPii0pzU4kOMMhwcShK8XD3uKUKCRanpqRVpmTnA2INJS3DwKInwhrQCpX
  mLCxJzizPTIVKnGHU5Nu3rOsAsxJKXn5cqJc77uBuoSACkKKM0D24ELA1cYpSVEuZlZGBgEOI
  pSC3KzSxBlX/FKM7BqCTMK9UJNIUnM68EbtMroCOYgI7Yxe0CckRJIkJKqoFp4iuTW2Uuj4Sa
  Uqd1M83f/OrwgRyH6yv9r55Na7h/leHe5XP3Lmbt3TFLSkF/waqeD/EC8z3uJYTfF+O6qX3z8
  0qLNWHMF+9InPa3YDguc+rJ1NOVconRvAoPGR+bH404e/HRClZeFfPUBI7bnWuEY2SOtT7kUd
  qvsGb775xvTdMuqDv90xS76Pz/1gIv3qMJeZPzylPcVzI1vLy/Tm3PfJdX3VdvLHx9uPS90zH
  9t88XXzrAW9XSevli9RSRiHlrKpy5D7gzFIlP3pp17VVq3IWc+kle7M8jJ+W+efG6Lkn8xPoF
  IXLLu0+dEhCoPHNvGvee5OiY7A1a0ctz+auElD+Yz3Dx+RsS/DGywlRrihJLcUaioRZzUXEiA
  CSXcnF+AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-745.messagelabs.com!1682410902!401783!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17147 invoked from network); 25 Apr 2023 08:21:42 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2023 08:21:42 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id DB40F10019D;
        Tue, 25 Apr 2023 09:21:41 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id CE24A10019C;
        Tue, 25 Apr 2023 09:21:41 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 09:21:39 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <hsiangkao@linux.alibaba.com>, <brauner@kernel.org>,
        <ZiyangZhang@linux.alibaba.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] src: Don't include <sys/mount.h> and <linux/mount.h> together
Date:   Tue, 25 Apr 2023 16:21:30 +0800
Message-ID: <1682410890-19102-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
References: <7b567ffd-772d-11ee-957c-9621f3a581ff@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
in addition to <linux/mount.h>.

Usually we should use glibc header instead of kernel header.
But now mount.h is a special case because both new glibc header and
kernel header all define "struct mount_attr'. They also define MS* macro.

Since we have some syscall wrapper in vfs/missing.h, we can use <linux.mount.h> directly
instead of <sys/mount.h> for detached_mounts_propagation.c.

For utils.c, it doesn't use the macro or function in <sys/mount.h>, so
remove it directly.

In fact, newer glibc(2.37-1)[1] has sloved conflict problem between <sys/mount.h> and <linux/mount.h>.
In the future(maybe ten years), we can remove this kernel header and use glibc header.

[1]https://sourceware.org/git/?p=glibc.git;a=commit;h=774058d72942249f71d74e7f2b639f77184160a6

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/detached_mounts_propagation.c | 5 ++---
 src/vfs/utils.c                   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
index 17db2c02..dd11f7be 100644
--- a/src/detached_mounts_propagation.c
+++ b/src/detached_mounts_propagation.c
@@ -20,7 +20,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -127,7 +126,7 @@ int main(int argc, char *argv[])
 	if (ret < 0)
 		exit_log("%m - Failed to create new mount namespace");
 
-	ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
+	ret = sys_mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
 	if (ret < 0)
 		exit_log("%m - Failed to make base_dir shared mountpoint");
 
@@ -174,7 +173,7 @@ int main(int argc, char *argv[])
 		}
 		close(fd_tree);
 
-		ret = umount2(target, MNT_DETACH);
+		ret = sys_umount2(target, MNT_DETACH);
 		if (ret < 0) {
 			fprintf(stderr, "%m - Failed to unmount %s", target);
 			exit_code = EXIT_FAILURE;
diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index 9e67ac37..0ab5de15 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -10,7 +10,6 @@
 #include <stdlib.h>
 #include <sys/eventfd.h>
 #include <sys/fsuid.h>
-#include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-- 
2.39.1

