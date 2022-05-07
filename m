Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D1C433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbiEGPFF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiEGPFE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 11:05:04 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D88D13F31
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1651935672; i=@fujitsu.com;
        bh=8dv+8/uLnpp+zGcDFFETfM6GEOp8z6ORUz1+cmg1Hig=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=I2iwouOhK2tE5tuOOxX3g+f5MhQTSnDX4RJakvhmFfdNa7emv/v8vKdqsNPE1+LK8
         5OKiXujWkd4azpmCWo3IBZ5iMN8EJSwYQlnArR19ffYfN3QTL9gnBrJYfH0872LixM
         CFa9PTuAiSHqY1gMmJooPEXJCVZItR/xeM6xO/8J+vqeHy5fT0xVTs2Gyu+4MR0Ws5
         IeJU2iPLIGrGZzVMSVH2tgiH+8+Rj278e9qGKoHNhxVp7rWifa/5VzbA1SOxM4GuqV
         WsT5qLL3GwnxTojVluOAde0uPYw7jXHW42WPCNlZzOZgbY47pmP+SrzLhQO1ZdCzSB
         afqaaUFnjNdLg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8ORqLujsyz
  JYM9LHovXhz8xWpxu2cvuwOSxaVUnm8fnTXIBTFGsmXlJ+RUJrBl7589kKTjJXvFpxSzmBsYj
  bF2MXBxCAlsYJY4dXs8C4Sxgklj28hI7hLObUeLU4/tAZZwcbAKaEs86FzB3MXJwiAhISOxaF
  AYSZhZwkpiz7hQTiC0s4CPRtOUWmM0ioCKx5sl+sFZeAQ+J2ctPsYDYEgIKElMevmeGiAtKnJ
  z5hAVijoTEwRcvmCFqFCUudXxjhLArJGbNamOCsNUkrp7bxDyBkX8WkvZZSNoXMDKtYrRNKsp
  MzyjJTczM0TU0MNA1NDTVNTPRNTbRS6zSTdRLLdVNTs0rKUoEyuollhfrpRYX6xVX5ibnpOjl
  pZZsYgQGa0qxg9IOxrN9P/UOMUpyMCmJ8rbYlCYJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuAN6
  ChLEhIsSk1PrUjLzAFGDkxagoNHSYTXphQozVtckJhbnJkOkTrFqCglzptUB5QQAElklObBtc
  Gi9RKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4jINt5MvNK4Ka/AlrMBLT4Y0ApyOKSRIS
  UVAOTxBaxp9/3vMjSSH+UX/7T8+TxU6sUXGzj9nSHdE9J22DLlB/79+HpQzrvHaddXXySUTq1
  aua8qRlLjq31MEx0uqRqYsURH3W1ynHDnryV/CmK6oKV//RfBal5JfSXTt17Nke7+vdtr75Fk
  64/eHezN69ztvAhGeUtaqszRa7ekFbTvKe76ZmS6SwJjRlGKju52kyYpHg2Kl64w8N9SO+M8T
  vZ5XMXNxg0tAb/vx99en3y/qov4jZOTxIWHj7z4cODqJsTFcP36d/YdMDm3E7nwu97VvyZdvO
  MyIWtiZ0e8W/b5oZ61okuWvT5s9Jk+XmxPU41p1qPMDdfml6ftCZgO8/tNL0m1a57+78XVYde
  U2Ipzkg01GIuKk4EAFV+C/NRAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-545.messagelabs.com!1651935671!376961!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4395 invoked from network); 7 May 2022 15:01:12 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-2.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 May 2022 15:01:12 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id B06D910018B;
        Sat,  7 May 2022 16:01:11 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A1841100184;
        Sat,  7 May 2022 16:01:11 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 7 May 2022 16:00:49 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <brauner@kernel.org>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v5 1/3] idmapped-mounts: Reset errno to zero before run_test
Date:   Sun, 8 May 2022 00:01:25 +0800
Message-ID: <1651939287-2714-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If we run case on old kernel that doesn't support mount_setattr and
then fail on our own function before call is_setgid/is_setuid function
to reset errno, run_test will print "Function not implement" error.

We also check whether system support user namespace, so reset errno to
zero after userns check.

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index ce3f73be..2e94bf71 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14232,6 +14232,8 @@ int main(int argc, char *argv[])
 		exit(EXIT_SUCCESS);
 	}
 	t_has_userns = sys_has_userns();
+	/* don't copy ENOSYS errno to child process on older kernel */
+	errno = 0;
 
 	stash_overflowuid();
 	stash_overflowgid();
-- 
2.27.0

