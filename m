Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1389C48BC2
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 01:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54A9619C5
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 01:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhF1BFJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Jun 2021 21:05:09 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45046 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231706AbhF1BFJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Jun 2021 21:05:09 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4F8CC862F22;
        Mon, 28 Jun 2021 11:02:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lxffc-000CJU-HG; Mon, 28 Jun 2021 11:02:40 +1000
Date:   Mon, 28 Jun 2021 11:02:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, Sun Ke <sunke32@huawei.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 73030114397b
Message-ID: <20210628010240.GN2419729@dread.disaster.area>
References: <60d89a67.1c69fb81.86c2c.d6c4@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d89a67.1c69fb81.86c2c.d6c4@mx.google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=S5nUKQIJ7Y0Z2E3RqXMA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 27, 2021 at 11:33:54PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. The only thing in this update is the "move test group
> lists into test files" patchset from Darrick J. Wong, which moves each test's
> group information into the test itself, and automatically generate the group
> files as part of the make process. Please refer to the description quated from
> Darrick's PR cover letter below [1].
> 
> This may break some old habits while using fstests, some heads up below
....
> And this update probably may introduce regressions and bugs, please help report
> and/or fix bugs if you hit any.

Yup, generic/019 is the first regression I've noticed:

generic/019 46s ... - output mismatch (see
/home/dave/src/xfstests-dev/results//xfs/generic/019.out.bad)
--- tests/generic/019.out   2014-04-08 09:43:28.506999723 +1000
+++ /home/dave/src/xfstests-dev/results//xfs/generic/019.out.bad
2021-06-28 10:39:30.653077176 +1000
@@ -7,3 +7,5 @@
Force SCRATCH_DEV device failure
Make SCRATCH_DEV device operable again
Disallow global fail_make_request feature
+/home/dave/src/xfstests-dev/tests/generic/019: line 56: poweron_scratch_dev: command not found
+Disallow global fail_make_request feature
...
(Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/019.out /home/dave/src/xfstests-dev/results//xfs/generic/019.out.bad'  to see the entire diff)

I suspect that _cleanup output on EXIT is now being captured to the
$seq.out file, because I can't see how this _cleanup function ever
worked - poweron_scratch_dev() doesn't exist and AFAICT it never
has....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
