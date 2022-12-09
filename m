Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA5C4332F
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Dec 2022 09:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLIJ3P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIJ3O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2022 04:29:14 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0B45A3D
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 01:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1670578150; i=@fujitsu.com;
        bh=AKYN9pHPTRqEfW9cPoDZBJ3ZiXYnLI8oGS2NYsugnYo=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=qZpjmvU8wBrU21xQNubfcaJKUmG5ppxl1HUyDRz6cEisDzA7vEpDnckv1mvnJ25Cq
         O0C6QotsZ2tojmQa0Dxk8bUwTPp727VvjL3hzYQOzrJHd7bBy7JgEiiKz4MtiLrRuf
         6lNOCtP7MvQ7xyZELSro362VTFdSkFFb50Pwa3aPNpCYdgkXwVtMMFA6jWbZAqcJHS
         jmnfwIBZq9F95OVBvqJdqPxA4hycmU7HCbZqOjEi2ezwE6c4xzK0vgQ+FRYV+xZqGf
         ijW/CgysMgV3BLjazonBUjDjVd6WdFNA1b+/Co0ZuBLCrV2f2KBYF9oI3/QibE0JQs
         qe+gofrYzFc4w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRWlGSWpSXmKPExsViZ8OxWffZ/0n
  JBn8XC1ucbtnL7sDo8XmTXABjFGtmXlJ+RQJrxsYjNxgLmlgrdjZcZG9gXMjSxcjFISRwnlFi
  zpcjUM5BJoknkxuAHE4gZw+jxJ3txiA2m4COxIUFf1lBbBEBWYn/M1YzgdjMQPau5wvYQGxhA
  XeJjsl9zCA2i4CKxIZf3UD1HBy8Ai4Si9r9QcISAgoSUx6+ByvhFRCUODnzCQvEGAmJgy9eMI
  OUSwgoSczsjocor5CYNauNCcJWk7h6bhPzBEb+WUi6ZyHpXsDItIrRtDi1qCy1SNdML6koMz2
  jJDcxM0cvsUo3US+1VLc8tbhE11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMwCFOK2Qt2MM5c9kfv
  EKMkB5OSKG/gi0nJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4D/4EygkWpaanVqRl5gAjAiYtw
  cGjJML79AtQmre4IDG3ODMdInWKUZdjbcOBvcxCLHn5ealS4rxr/gAVCYAUZZTmwY2AReclRl
  kpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8PL+BpvBk5pXAbXoFdAQT0BErv0wEOaIkESEl1cA
  k6X6fJ4JD3OCk80Hz6o0XZxS39FlEKF/j4GOaqzLHJ2TG/V1iBcWbF7TnXlnc5c2x7k/m2oMa
  n+6f/7pMgz+/RHZW/L0nmWphiYGxeVPdOg88yVhdUqEmFvk+ZnLy+knFZvt3zH/c+qDhsdjKE
  K3EG+FLFv7cbjE7t961Wze8/ML64NzIxe8/FQdz/3zazh7vZb+tUDT2DZP/DxbhSYtSKiIZv+
  +Z+9FcdvkqEX/ulmTZ33bvGW+4G8vvSMvMuLYuYEvWkXMnD/VPLG3fnvzkgoJrBHPpy027/7/
  sKLlz6W3TBJVXP0S+lutNV/LafSvyZ5z0hD6xaVeiZs772r2pv+ttlailoPD1tTUWWhZKLMUZ
  iYZazEXFiQD7wXLpSQMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-16.tower-585.messagelabs.com!1670578150!131627!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30572 invoked from network); 9 Dec 2022 09:29:10 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-16.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Dec 2022 09:29:10 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id E2F2F155
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 09:29:09 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id D614F73
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 09:29:09 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 9 Dec 2022 09:29:07 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH 1/2] ignore src/fake-dump-rootino and tests/xfs/216.out
Date:   Fri, 9 Dec 2022 09:28:49 +0000
Message-ID: <1670578130-13-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1. The executable binary in src/ should be in ignore file.
2. tests/xfs/216.out is a symlink generated at runtime, also should
   be ignored.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index ad9f45437..a1107003a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,6 +80,7 @@ tags
 /src/e4compact
 /src/ext4_resize
 /src/fault
+/src/fake-dump-rootino
 /src/feature
 /src/fiemap-tester
 /src/fill
@@ -205,6 +206,7 @@ tags
 /tests/xfs/033.out
 /tests/xfs/071.out
 /tests/xfs/096.out
+/tests/xfs/216.out
 
 # cscope files
 cscope.*
-- 
2.38.1

