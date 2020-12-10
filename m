Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FDC4361B
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Dec 2020 03:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9598D2332A
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Dec 2020 03:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLJDAn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:00:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64672 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727885AbgLJDAm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2020 22:00:42 -0500
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="102248487"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Dec 2020 10:59:55 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0AD864CE600D
        for <fstests@vger.kernel.org>; Thu, 10 Dec 2020 10:59:55 +0800 (CST)
Received: from RHEL74GA.g08.fujitsu.local (10.167.220.75) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 10 Dec 2020 10:59:54 +0800
From:   Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Subject: [PATCH] src/t_enospc.c: Fix an error for the loop initialization declaration
Date:   Wed, 9 Dec 2020 21:59:54 -0500
Message-ID: <1607569194-25989-1-git-send-email-zhufy.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.75]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 0AD864CE600D.AAFEC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: zhufy.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I compiled xfstests using the gcc(version 4.8.5), the following error occurred:
t_enospc.c: In function 'enospc_test':
t_enospc.c:88:2: error: 'for' loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < size; i++) {
  ^

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 src/t_enospc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/t_enospc.c b/src/t_enospc.c
index d06c676..4070ea5 100644
--- a/src/t_enospc.c
+++ b/src/t_enospc.c
@@ -44,6 +44,7 @@ void handle_sigbus(int sig)
 
 void enospc_test(int id)
 {
+	int i;
 	int fd;
 	char fpath[255] = {0};
 	char *addr;
@@ -85,7 +86,7 @@ void enospc_test(int id)
 	addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
 	assert(addr != MAP_FAILED);
 
-	for (int i = 0; i < size; i++) {
+	for (i = 0; i < size; i++) {
 		addr[i] = 0xAB;
 	}
 
@@ -104,10 +105,11 @@ void *spawn_test_thread(void *arg)
 
 void _run_test(int threads)
 {
+	int i;
 	pthread_t tid[threads];
 
 	pthread_barrier_init(&bar, NULL, threads+1);
-	for (int i = 0; i < threads; i++) {
+	for (i = 0; i < threads; i++) {
 		struct thread_s *thread_info = (struct thread_s *) malloc(sizeof(struct thread_s));
 		thread_info->id = i;
 		assert(pthread_create(&tid[i], NULL, spawn_test_thread, thread_info) == 0);
@@ -115,7 +117,7 @@ void _run_test(int threads)
 
 	pthread_barrier_wait(&bar);
 
-	for (int i = 0; i <threads; i++) {
+	for (i = 0; i < threads; i++) {
 		assert(pthread_join(tid[i], NULL) == 0);
 	}
 
-- 
1.8.3.1



