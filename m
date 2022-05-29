Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D58AC4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiE2KzQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiE2KzP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:55:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CE62CD0
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73D42B80AEB
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86610C3411C
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653821712;
        bh=B/CORKgwBIFAthqSp7grMUWozxkPkZA9k2RTpNrSXDE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fypGG++Edja+Hxis91Taq63CfHSjHs/pi1tVjaMLD3FMme8HPy4mtq4iQTFiczeA5
         NU+CdLPHdRah1RgkiTzrppFYpel3zSl3dnWZ9PbrS0UnIGRq2Hur4cEvGmmUCRq9h0
         kw1EA1m5JUJAxA+J0whLQYvwbh7y7wSGX/T9kzi7/OGHKWSnjCwBLIUTOEFWlKryQu
         2cDYFNs8zj5N5KfqTlAmZ9qZdpaRUvtdFOYh73EUyWsmPB39h+FyDyQmLXb+wRgy/3
         if5ccMdeBaKzEvyHErMoQ5lt6IzlTeWuu8G3irOD+kYgAsizjWg/xj7v7beqavwlA0
         CXbBV7crllpyw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/5] generic/591: remove redundant output from golden image
Date:   Sun, 29 May 2022 18:55:03 +0800
Message-Id: <20220529105505.667891-4-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220529105505.667891-1-zlang@kernel.org>
References: <20220529105505.667891-1-zlang@kernel.org>
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

As the output from child is unexpected and unstable. So I think we
shouldn't use it as golden image. So I add a "fflush(stdout)" to
clear the output buffer of parent process before forking a child.
Then correct the generic/591.out.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 src/splice-test.c     | 1 +
 tests/generic/591.out | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/splice-test.c b/src/splice-test.c
index 2f1ba2ba..e6ae6fca 100644
--- a/src/splice-test.c
+++ b/src/splice-test.c
@@ -143,6 +143,7 @@ int main(int argc, char *argv[])
 	printf("%s reader %s O_DIRECT\n",
 		   do_splice == do_splice1 ? "sequential" : "concurrent",
 		   (open_flags & O_DIRECT) ? "with" : "without");
+	fflush(stdout);
 
 	buffer = memalign(SECTOR_SIZE, BUFFER_SIZE);
 	if (buffer == NULL)
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

