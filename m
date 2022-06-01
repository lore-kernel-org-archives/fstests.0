Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01EAC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 06:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbiFAGhl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345648AbiFAGhk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 02:37:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E74DF79
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 23:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30968B81827
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29650C3411A
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654065456;
        bh=7ZwwBeBoQ8i9WwB/MCItoIKBx+f6kl3iSU1HXJLrIjA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ce7I8mqDY6dtk3+0/Q3dzvi8mXc4r0qAaDmUnKcj5dd9bPzcF2dbkoc/Jkvbu3vOh
         wUaCZPjJEJ/EVsoVamXZjuYFJMQ/xXq9Yj/x6vM6C3CWS4vhkfUj2n2r/0fqaQQeWS
         +SVwWNV3ONsvNNGfAgYOBMk+y9Ch5134hgO5lDZxGtVWYxPLjvDmYKujx7Ak2G7tg5
         n8aW2FXul8gbbuFCDREvOK7WEZTDeOpiNUYFNJL7H6pRrDvx73PGLwHv+rvK0NACVf
         7/B9JRPkCvwmXxFh52zmatp+h68LEG49TKXc2LNhFcd5e4qUjIdREXq8VPZEDVoFcU
         Jazs7vtnqr51g==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 3/5] generic/591: remove redundant output from golden image
Date:   Wed,  1 Jun 2022 14:37:28 +0800
Message-Id: <20220601063730.1726879-4-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601063730.1726879-1-zlang@kernel.org>
References: <20220601063730.1726879-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In generic/591.out expects below output:
  concurrent reader with O_DIRECT
  concurrent reader with O_DIRECT     <=== ???
  concurrent reader without O_DIRECT
  concurrent reader without O_DIRECT  <=== ???
  sequential reader with O_DIRECT
  sequential reader without O_DIRECT

The lines marked "???" are unbelievable, due to the src/splice-test.c
only calls printf to output that message once in main function. So
Why splice-test prints that message twice sometimes? It seems related
with the "-r" option, due to the test lines without "-r" option only
print one line each time running.

A stanger thing is this "double output" issue only can be triggered by
running g/591, can't reproduce it by running splice-test manually.

By checking the code of splice-test.c, I found a "fork()" in it, and
it'll be called if the '-r' option is specified. So I suspect the
redundant output come from the child process. By the help of strace
tool, I got:

  10554 execve("/root/git/xfstests/src/splice-test", ["/root/git/xfstests/src/splice-te"..., "-r", "/mnt/test/a"], 0x7ffcabc2c0a8 /* 202 vars */) = 0
  ...
  10554 clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f937f5d5a10) = 10555
  ...
  10555 read(4, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"..., 512) = 512
  10555 write(1, "concurrent reader with O_DIRECT\n", 32) = 32
  10555 exit_group(0)                     = ?
  10555 +++ exited with 0 +++
  10554 <... wait4 resumed>NULL, 0, NULL) = 10555
  10554 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=10555, si_uid=0, si_status=0, si_utime=0, si_stime=1} ---
  10554 unlink("/mnt/test/a")             = 0
  10554 write(1, "concurrent reader with O_DIRECT\n", 32) = 32
  10554 exit_group(0)                     = ?
  10554 +++ exited with 0 +++

We can see the "concurrent reader with O_DIRECT\n" be printed by
parent process 10554 and child process 10555 separately.

Due to the stdout redirection that fstests does cause the stream
doesn't refer to a tty anymore, then the stdout become block
buffered, so the '\n' doesn't help to flush that printf message,
and the child print it again.

So use setlinebuf(stdout) to force it line buffered, to avoid the
confused output to be golden image. Then correct the generic/591.out

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 src/splice-test.c     | 2 ++
 tests/generic/591.out | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/splice-test.c b/src/splice-test.c
index 2f1ba2ba..dc41b0f5 100644
--- a/src/splice-test.c
+++ b/src/splice-test.c
@@ -140,6 +140,8 @@ int main(int argc, char *argv[])
 		usage(argv[0]);
 	filename = argv[optind];
 
+	/* force below printf line buffered */
+	setlinebuf(stdout);
 	printf("%s reader %s O_DIRECT\n",
 		   do_splice == do_splice1 ? "sequential" : "concurrent",
 		   (open_flags & O_DIRECT) ? "with" : "without");
diff --git a/tests/generic/591.out b/tests/generic/591.out
index d61811ee..e9fffd1d 100644
--- a/tests/generic/591.out
+++ b/tests/generic/591.out
@@ -1,7 +1,5 @@
 QA output created by 591
 concurrent reader with O_DIRECT
-concurrent reader with O_DIRECT
-concurrent reader without O_DIRECT
 concurrent reader without O_DIRECT
 sequential reader with O_DIRECT
 sequential reader without O_DIRECT
-- 
2.31.1

