Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C131C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbiFARiv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiFARit (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 13:38:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381E8A32F
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 10:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E0B7B81BA2
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46C7C385B8;
        Wed,  1 Jun 2022 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654105125;
        bh=jctWtgBS19VI6w87YxfAxymckvb2S3uZ1Ie6/byYbDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eyaxjd10zx+pmKgSMbKAr+rYZr520sEB2+P3NeeydGxPvXKnfR4V6fv4KcfuA39fK
         h2YuZN5muZs1Ux958Q98BNa1Xo22V4kLvcuMyS5ARjNOB5cOxeMk1t6b5TJ9ex9HaK
         wU0ZVcH9v+ysXvoAp6yPzZFXi61DA3Ot2gDiaQmIf6uew+FEiHBWcxhxQyH0fi0c/9
         iHbGOVd1gRo4kawfd6OADWjXjE9pxv+4RyhnviXs+TnkzIgFp0IRgeZfFGFDXpsgN+
         XUr6aNJD5NKWf5uYcbMNU5nuku816UAZBBU1EQB0OHFETKUIkqnMgQk99n1QjvQTQ1
         xT5r2VWq1XGJw==
Date:   Wed, 1 Jun 2022 10:38:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/5] generic/591: remove redundant output from golden
 image
Message-ID: <YpekJZyurZuSx41C@magnolia>
References: <20220601063730.1726879-1-zlang@kernel.org>
 <20220601063730.1726879-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601063730.1726879-4-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 01, 2022 at 02:37:28PM +0800, Zorro Lang wrote:
> In generic/591.out expects below output:
>   concurrent reader with O_DIRECT
>   concurrent reader with O_DIRECT     <=== ???
>   concurrent reader without O_DIRECT
>   concurrent reader without O_DIRECT  <=== ???
>   sequential reader with O_DIRECT
>   sequential reader without O_DIRECT
> 
> The lines marked "???" are unbelievable, due to the src/splice-test.c
> only calls printf to output that message once in main function. So
> Why splice-test prints that message twice sometimes? It seems related
> with the "-r" option, due to the test lines without "-r" option only
> print one line each time running.
> 
> A stanger thing is this "double output" issue only can be triggered by
> running g/591, can't reproduce it by running splice-test manually.
> 
> By checking the code of splice-test.c, I found a "fork()" in it, and
> it'll be called if the '-r' option is specified. So I suspect the
> redundant output come from the child process. By the help of strace
> tool, I got:
> 
>   10554 execve("/root/git/xfstests/src/splice-test", ["/root/git/xfstests/src/splice-te"..., "-r", "/mnt/test/a"], 0x7ffcabc2c0a8 /* 202 vars */) = 0
>   ...
>   10554 clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f937f5d5a10) = 10555
>   ...
>   10555 read(4, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"..., 512) = 512
>   10555 write(1, "concurrent reader with O_DIRECT\n", 32) = 32
>   10555 exit_group(0)                     = ?
>   10555 +++ exited with 0 +++
>   10554 <... wait4 resumed>NULL, 0, NULL) = 10555
>   10554 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=10555, si_uid=0, si_status=0, si_utime=0, si_stime=1} ---
>   10554 unlink("/mnt/test/a")             = 0
>   10554 write(1, "concurrent reader with O_DIRECT\n", 32) = 32
>   10554 exit_group(0)                     = ?
>   10554 +++ exited with 0 +++
> 
> We can see the "concurrent reader with O_DIRECT\n" be printed by
> parent process 10554 and child process 10555 separately.
> 
> Due to the stdout redirection that fstests does cause the stream
> doesn't refer to a tty anymore, then the stdout become block
> buffered, so the '\n' doesn't help to flush that printf message,
> and the child print it again.
> 
> So use setlinebuf(stdout) to force it line buffered, to avoid the
> confused output to be golden image. Then correct the generic/591.out

Eww, so the printf ends up in the output buffer, which is then
duplicated in the forked child, so both parent and child emit the same
message?

Gross.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  src/splice-test.c     | 2 ++
>  tests/generic/591.out | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/splice-test.c b/src/splice-test.c
> index 2f1ba2ba..dc41b0f5 100644
> --- a/src/splice-test.c
> +++ b/src/splice-test.c
> @@ -140,6 +140,8 @@ int main(int argc, char *argv[])
>  		usage(argv[0]);
>  	filename = argv[optind];
>  
> +	/* force below printf line buffered */
> +	setlinebuf(stdout);
>  	printf("%s reader %s O_DIRECT\n",
>  		   do_splice == do_splice1 ? "sequential" : "concurrent",
>  		   (open_flags & O_DIRECT) ? "with" : "without");
> diff --git a/tests/generic/591.out b/tests/generic/591.out
> index d61811ee..e9fffd1d 100644
> --- a/tests/generic/591.out
> +++ b/tests/generic/591.out
> @@ -1,7 +1,5 @@
>  QA output created by 591
>  concurrent reader with O_DIRECT
> -concurrent reader with O_DIRECT
> -concurrent reader without O_DIRECT
>  concurrent reader without O_DIRECT
>  sequential reader with O_DIRECT
>  sequential reader without O_DIRECT
> -- 
> 2.31.1
> 
