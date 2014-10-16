Return-Path: <fstests-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37599 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaJPP3u (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 16 Oct 2014 11:29:50 -0400
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s9GFTnAb002155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Thu, 16 Oct 2014 15:29:50 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id s9GFTlBn004214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 16 Oct 2014 15:29:48 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s9GFTkqC006244
	for <fstests@vger.kernel.org>; Thu, 16 Oct 2014 15:29:46 GMT
Date: Thu, 16 Oct 2014 11:29:49 -0400
From: Dwight Engen <dwight.engen@oracle.com>
Subject: Re: [PATCH] xfs/242: fix for archs with 8k page size
Message-ID: <20141016112949.4ace4e4a@oracle.com>
In-Reply-To: <20141008043341.GH12693@dastard>
References: <20141007191259.7e5b5ee3@oracle.com>
	<20141008043341.GH12693@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, 8 Oct 2014 15:33:41 +1100
Dave Chinner <david@fromorbit.com> wrote:

> On Tue, Oct 07, 2014 at 07:12:59PM -0400, Dwight Engen wrote:
> > This test was failing on sparc64 because there is a minimum
> > granularity of PAGE_CACHE_SIZE in
> > xfs_vnodeops.c:xfs_zero_file_space(). This change follows the
> > approach taken in xfs/194 to filter the bmap output to be in terms
> > of "blocksize" which is computed from pagesize.
> 
> xfs/194 existed long before xfs/242, so it's not necessarily the
> best example to follow. You've missed various things that make the
> special hackery xfs/194 does to make it work. e.g.  clearing
> mkfs/mount options. Your change doesn't do this, so it will make it
> fail on CRC enable XFS filesystems because 4k / 8 = 512 bytes and
> that's smaller than the minimum block size support on CRC enabled
> XFS filesystems.

Hi Dave, I sure did miss that 194 was doing unset MKFS_OPTIONS. Partly
because running check '*/194' outputs:

MKFS_OPTIONS  -- -f -bsize=4096 /dev/vdiskd

but this is only for the mkfs that check itself does, and as you note
194 will redo the mkfs with its computed block size. Thats a bit
confusing :( 242 doesn't do a second mkfs, so there isn't really a need
to unset MKFS_OPTIONS.

What I thought 194 was doing, and what I made 242 do was to be page
size independent by computing the size of things and filtering the
output to be in units of some factor of a page size, which is why I put
blksize in quotes, its not the actual block size (ie we don't pass it
to mkfs). Maybe I should have used a different name for less confusion,
suggestions welcome. Doing this does make it so 242 passes with no
MKFS_OPTIONS (which will be 4k blocksize) or with MKFS_OPTIONS="-b
size=8k", and both of those with -m crc=1 also. 

> > _test_generic_punch is modified to optionally take multiple as an
> > argument, so the file under test will be twice the size on an 8k
> > machine as a 4k machine. Since the files will be different sizes,
> > we can no longer use md5sum so od -x is used instead with the byte
> > offsets converted to "blocksize" offsets.
> 
> Brian posted patches yesterday on the XFS list to fix zero range
> problems, and they remove the page size rounding from
> xfs_zero_file_space(). Hence this strange corner case behaviour is
> likely to go away real soon, and so I don't think we should change
> the test to work around it now...

That sounds good, but I'd think we want 242 to be able to pass
regardless of page size on 3.12-3.17 too?

> Would would be much more useful for you to do would with a platform
> like sparc64 is use it to test MKFS_OPTION="-b size=8k" and make all
> these extent-map-output dependent tests work properly with >4k block
> size filesystems.  ;)

This does do that for 242 :) I can look at the others also if the
approach here is okay. Thanks.

> Cheers,
> 
> Dave.

