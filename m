Received: from mail-pf0-f193.google.com ([209.85.192.193]:35747 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1CgH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 22:36:07 -0400
Date: Sat, 28 Apr 2018 10:36:03 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] btrfs: Add test that checks rmdir(2) can delete a
 subvolume
Message-ID: <20180428023603.GQ11384@desktop>
References: <a7ba61de-3bbc-92fd-68db-2521f4bc8545@jp.fujitsu.com>
 <20180427162635.GF21272@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427162635.GF21272@twin.jikos.cz>
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>, fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 06:26:35PM +0200, David Sterba wrote:
> On Fri, Apr 27, 2018 at 05:02:45PM +0900, Misono Tomohiro wrote:
> > Add btrfs test that checks "rmdir" or "rm -r" command can delete a
> > subvolume like an ordinary drectory.
> > 
> > This behavior has been restricted long time but becomes allowed by
> > following patch in the kernel:
> >   btrfs: Allow rmdir(2) to delete an empty subvolume
> 
> AFAICS this test will fail on older kernels, eg. stable versions, but
> this is not a bug that needs to be fixed by backporting patches. The
> usual way is to use the expunges, but as this is a feature coverage, I
> think the test should detect if the kernel has the feature at all.
> Similar to the fallocate modes etc.

Agreed, if the change is treated as a behavior change not a bug on old
kernels, we probably need a way to detect the case and _notrun if kernel
doesn't support it.

> 
> For the test itself, the scenarios look sufficient, so
> Reviewed-by: David Sterba <dsterba@suse.com>

Thanks for the review!

Eryu
