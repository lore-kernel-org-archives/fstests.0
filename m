Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D607EC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 30 May 2022 00:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiE3ApD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 20:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiE3Ao4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 20:44:56 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF7911D307
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 17:44:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id CA9FD110017C;
        Mon, 30 May 2022 10:44:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvTWe-000PbB-LN; Mon, 30 May 2022 10:44:52 +1000
Date:   Mon, 30 May 2022 10:44:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/591: remove redundant output from golden
 image
Message-ID: <20220530004452.GN3923443@dread.disaster.area>
References: <20220529105505.667891-1-zlang@kernel.org>
 <20220529105505.667891-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529105505.667891-4-zlang@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62941387
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=tK_n96lkyaOIOCjKO80A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 29, 2022 at 06:55:03PM +0800, Zorro Lang wrote:
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

Huh. I wonder....

> diff --git a/src/splice-test.c b/src/splice-test.c
> index 2f1ba2ba..e6ae6fca 100644
> --- a/src/splice-test.c
> +++ b/src/splice-test.c
> @@ -143,6 +143,7 @@ int main(int argc, char *argv[])
>  	printf("%s reader %s O_DIRECT\n",
>  		   do_splice == do_splice1 ? "sequential" : "concurrent",
>  		   (open_flags & O_DIRECT) ? "with" : "without");
> +	fflush(stdout);

Yeah, ok, stdout output is usually line buffered.  That printf()
statement has a "\n" on the end of it, so it should be flushing
immediately, and that's what you are seeing when it is run from the
command line.

Hmmmm. I wonder if the redirect to an output file (or pipe) is
changing the buffering mode because stdout no longer points to a
tty?

# src/xfstests-dev/src/splice-test -r /mnt/test/a
concurrent reader with O_DIRECT
# src/xfstests-dev/src/splice-test -r /mnt/test/a | less
concurrent reader with O_DIRECT
concurrent reader with O_DIRECT
#

Yup.

# man setbuf
....
	Normally all files are block buffered.  If a stream refers
	to a terminal (as stdout normally does), it is line
	buffered.   The standard  error  stream stderr is always
	unbuffered by default.

Yeah, so the stdout redirection that fstests does is exactly what is
changing the behaviour.

Ok, so the correct way to fix this is to add:

	setlinebuf(stdout);

before any printf() output to ensure that it is correctly line
buffered no matter what the output redirection does with stdout.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
