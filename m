Received: from mail-qk1-f194.google.com ([209.85.222.194]:34655 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbfHOPhP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 11:37:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so2228447qkk.1
        for <fstests@vger.kernel.org>; Thu, 15 Aug 2019 08:37:14 -0700 (PDT)
Date: Thu, 15 Aug 2019 11:37:12 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/2] fstests: make generic/500 xfs+ext4 only
Message-ID: <20190815153711.dwturun54gtibldz@macbook-pro-91.dhcp.thefacebook.com>
References: <20190815150033.15996-1-josef@toxicpanda.com>
 <20190815152425.GA15181@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815152425.GA15181@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 15, 2019 at 08:24:25AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 15, 2019 at 11:00:31AM -0400, Josef Bacik wrote:
> > I recently fixed some bugs in btrfs's enospc handling that made it start
> > failing generic/500.
> > 
> > The point of this test is to make the thin provisioned device run out of
> > space, which results in an EIO being seen on a device from the file
> > systems perspective.  This is fine for xfs and ext4 who's metadata is
> > being overwritten and already allocated on the thin provisioned device.
> > They get an EIO on data writes, fstrim to free up the space, and keep it
> > going.
> > 
> > Btrfs however has dynamic metadata, so the rm -rf could result in
> > metadata IO being done on the file system.  Since the thin provisioned
> > device is out of space this gives us an EIO, and we flip read only.  We
> > didn't remove the file, so the fstrim doesn't recover space anyway, so
> > we can't even fstrim and remount.
> > 
> > Make this test for ext4/xfs only, it just simply won't work right for
> > btrfs in it's current form.
> 
> How about:
> 
> test $FSTYP = "btrfs" && _notrun "btrfs doesn't work that way lol"
> 
> since afaik btrfs is the only fs that shouldn't run this test?
> Also, I think Ted was trying to kill off tests/shared/...
> 

That explains why it seemed emptier than normal.  Yeah that sounds like a fine
solution to me, I'll send a updated patch shortly.  Thanks,

Josef
