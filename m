Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D9C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 09:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376632AbiDUJDB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 05:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387191AbiDUJCd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 05:02:33 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A7F921E0A
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 01:59:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8A12E53467A;
        Thu, 21 Apr 2022 18:59:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nhSf8-002iym-RN; Thu, 21 Apr 2022 18:59:42 +1000
Date:   Thu, 21 Apr 2022 18:59:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421085942.GR1609613@dread.disaster.area>
References: <20220419131423.2367795-1-brauner@kernel.org>
 <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62611d00
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=QtIOoxgJbs-XxfUEB_cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 01:41:20PM +0800, Zorro Lang wrote:
> On Wed, Apr 20, 2022 at 07:52:22PM +0200, Christian Brauner wrote:
> > Add a regression test for commit 705191b03d50 ("fs: fix acl translation").
> > This tests whether setting POSIX ACLs on a tmpfs mounted in a
> > non-initial user and mount namespace works as expected.
> > 
> > Note, once again the idmapped mount testsuite is grossly misnamed at
> > this point. It has morphed into a full-blown generic vfs feature
> > testsuite.

Yup, and that's really important because this is the exact purpose
for which fstests exists: to cover every aspect of filesystem and
VFS functionality that needs test coverage.

> Hi,
> 
> Good to know that, the idmapped-mounts things already been extended to 15k+
> lines[1] code, it's even much more than the unionmount-testsuite[2]. So I
> think it's time to think about shifting it from fstests/src to be an independent
> testsuit,

Please don't do that. That will mean the testing most fs developers
will get -zero- idmapped-mount test coverage and that's a major
issue. The kernel code that it covers is non trivial, has deep hooks
into every filesystem and these tests ensure that we filesystem
developers don't accidentally break it. It *needs* to be a part of
every filesystem developer's test environment, and we already have
that by having it integrated into fstests.

This is what we want - we want fstests to be the place that fs
developers add new tests to cover new functionality, and so all
filesystems get coverage of that functionality as part of the
development process.

This is exactly what we've spent the last 20 years building xfstests
into - it's gone from a filesystem specific tests suite to
supporting a dozen different filesystems and covers heaps of VFS
functionality as well.

As such, I think the last thing we want to be doing is telling
people to "take their code elsewhere". It sends the wrong message -
we want people to incorporate their complex test code into fstests
because that benefits every developer who uses fstests in their
daily workflow. The more test coverage we get, the better, and the
more test code we get integrated into fstests the better off we will
be.

> we can learn what 35c7a37928fd ("overlay: run unionmount testsuite test
> cases") did, maintain idmapped-mounts testsuite outside, then let fstests to be a
> wrapper to run it.

The unionmount tests suite was never a part of fstests like the
idmapped tests suite is. Very few developers know it exists, let
alone install it. Even fewer run it because it's part of the overlay
tests and almost nobody except overlay developers run overlay
testing...


-Dave.
-- 
Dave Chinner
david@fromorbit.com
