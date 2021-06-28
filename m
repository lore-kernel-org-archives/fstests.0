Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BDAC2B9F4
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 05:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D4D61C34
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 05:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhF1FDt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhF1FDt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 28 Jun 2021 01:03:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8750619C5;
        Mon, 28 Jun 2021 05:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624856483;
        bh=Pz9YVHAQw6WjFV8n5QDGocEIAW3CyN94r2csHUALnPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lv0ytH4RKAgsn602NG/TMMb2uUHztKvQyoFwH07WSPBNDQQ1fi6WQr8SZLKitUS86
         GcK6NlYrb/l//jNzaUWegBgR82RV59FILCEAhuKoM4Pr2/c//7pKrSX3QaECpgHvHA
         7T7lLGGFe8cO3UlbpRmFBq5D+ewFN3R7UsXWGw+uGUUdi84hTtIc1e4XtQmIX8C1gf
         tA4qvdgar7Wweh9fjh2dCfe/r6maTt8YfLntlKyDAd7iv29XrKfopvJeXtkeDCxe4D
         /0nfK1WDUr3sHoPMmBOzujM7zHU3Lb53u6fkn6Gt3TTwhwwnyEl6PC+S4vywbzzxLU
         jdmhB/ujvWzYQ==
Date:   Sun, 27 Jun 2021 22:01:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        Sun Ke <sunke32@huawei.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 73030114397b
Message-ID: <20210628050123.GA13767@locust>
References: <60d89a67.1c69fb81.86c2c.d6c4@mx.google.com>
 <20210628010240.GN2419729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628010240.GN2419729@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 28, 2021 at 11:02:40AM +1000, Dave Chinner wrote:
> On Sun, Jun 27, 2021 at 11:33:54PM +0800, Eryu Guan wrote:
> > Hi all,
> > 
> > The master branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > have just been updated. The only thing in this update is the "move test group
> > lists into test files" patchset from Darrick J. Wong, which moves each test's
> > group information into the test itself, and automatically generate the group
> > files as part of the make process. Please refer to the description quated from
> > Darrick's PR cover letter below [1].
> > 
> > This may break some old habits while using fstests, some heads up below
> ....
> > And this update probably may introduce regressions and bugs, please help report
> > and/or fix bugs if you hit any.
> 
> Yup, generic/019 is the first regression I've noticed:
> 
> generic/019 46s ... - output mismatch (see
> /home/dave/src/xfstests-dev/results//xfs/generic/019.out.bad)
> --- tests/generic/019.out   2014-04-08 09:43:28.506999723 +1000
> +++ /home/dave/src/xfstests-dev/results//xfs/generic/019.out.bad
> 2021-06-28 10:39:30.653077176 +1000
> @@ -7,3 +7,5 @@
> Force SCRATCH_DEV device failure
> Make SCRATCH_DEV device operable again
> Disallow global fail_make_request feature
> +/home/dave/src/xfstests-dev/tests/generic/019: line 56: poweron_scratch_dev: command not found
> +Disallow global fail_make_request feature
> ...
> (Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/019.out /home/dave/src/xfstests-dev/results//xfs/generic/019.out.bad'  to see the entire diff)
> 
> I suspect that _cleanup output on EXIT is now being captured to the
> $seq.out file, because I can't see how this _cleanup function ever
> worked - poweron_scratch_dev() doesn't exist and AFAICT it never
> has....

Yeah, I noticed that this test has been busted forever. :(

The test also probably needs to ulimit -c 0 so that fstests won't
complain about corefiles when fio dies after the fs goes down.

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
