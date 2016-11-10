Received: from mx1.redhat.com ([209.132.183.28]:35010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbcKJDYh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 9 Nov 2016 22:24:37 -0500
Date: Thu, 10 Nov 2016 11:24:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by
 incorrect metadata reserve
Message-ID: <20161110032434.GB27776@eguan.usersys.redhat.com>
References: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
 <20161108105826.GN27776@eguan.usersys.redhat.com>
 <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
 <20161109094341.GY27776@eguan.usersys.redhat.com>
 <6ae5fc6d-afbb-c284-190e-a0d2625cff25@cn.fujitsu.com>
 <20161110021944.GW28177@dastard>
 <c2e2eb35-e87a-90f7-9746-946a0995549a@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e2eb35-e87a-90f7-9746-946a0995549a@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: Dave Chinner <david@fromorbit.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 10, 2016 at 10:42:36AM +0800, Qu Wenruo wrote:
> 
> 
> At 11/10/2016 10:19 AM, Dave Chinner wrote:
> > On Thu, Nov 10, 2016 at 08:34:20AM +0800, Qu Wenruo wrote:
> > > At 11/09/2016 05:43 PM, Eryu Guan wrote:
> > > > On Wed, Nov 09, 2016 at 08:24:38AM +0800, Qu Wenruo wrote:
> > > > > At 11/08/2016 06:58 PM, Eryu Guan wrote:
> > > > > > On Tue, Nov 08, 2016 at 05:15:15PM +0800, Qu Wenruo wrote:
> > > > We should use helpers and not open-code when helpers are available. So
> > > > we should really use _scratch_mkfs_sized here.
> > > > 
> > > > And "-n 64k" is only to make bug easier to reproduce, but I don't think
> > > > it's necessary. In my testings, 50%-75% runs hit the ENOSPC failure on
> > > > my x86_64 test vm, even I removed the "-n 64k" mkfs option from the
> > > > test.
> > > > 
> > > > So I'd say remove "-n 64k" and test whatever mkfs options user
> > > > specified.
> > > 
> > > I really don't like the idea to allow user to override any mount
> > > option to reduce the possibility.
> > 
> > That's not the point. Overriding mount options reduces test coverage
> > because it limits the test to only the exact configuration that
> > reproduced the bug that was seen. If a user is testing a specific
> > configuration, then we really want to run the test on that config.
> > 
> > > And further more, this testcase is not a generic test, but a
> > > regression/pinpoint test to expose one specific bug.
> > 
> > If you want to make sure that the bug doesn't return, then you need
> > to run the /entire test suite/ with the configuration that exposes
> > the problem. You wouldn't be suggesting this specific set of mount
> > options if users weren't using that configuration. Hence you really
> > need to run the entire test suite with that configuration to make
> > sure you haven't broken those user's systems....
> > 
> > And, yes, I test lots of different XFS configurations in their
> > entirity every day on every change I make or review, so I'm not
> > suggesting that you should do anything I don't already do.
> 
> OK, most of your points makes sense.
> I'll update the case.
> 
> And I want to make it clear, doesn it mean, newly submitted test case
> shouldn't specify any mkfs/mount option?

My understanding is that if test needs a extremely rare configuration to
hit a bug, then it should specify mkfs/mount options, e.g. xfs/297 tests
a bug in XFS only in very specific configuration:

_scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1

But if the bug can be reproduced by a commonly tested configuration,
e.g. btrfs with compress enabled, we should keep test coverage as large
as possible, not limit it to a certain config.

The purpose is to not lose any test coverage if possible, unless you
have a good reason to do so.

> 
> Another concern is, I'm not sure if there is anyone really runs all btrfs
> mount and mkfs options on the entire test suite.
> (The same is for developers who submits generic test cases)

It's not realistic to run full matrix of conbinations of mkfs and mount
options, but the commonly used configurations should be tested.

I think this also depends, if you care about a certain configuration, or
a distro provides full support to a certain configuration and you work
for the company behind it, as a developer or tester you should really
test it. e.g. (as a negative example) I rarely test ext4 with
"data=journal" mount option, because Red Hat doesn't support this
configuration :)

Thanks,
Eryu

> 
> Or there won't be so many generic or even btrfs specific test cases causing
> false alert or exposing new bugs of btrfs.
> 
> Although this is problem of btrfs. :(
> 
> Thanks,
> Qu
> 
> > 
> > Cheers,
> > 
> > Dave.
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
