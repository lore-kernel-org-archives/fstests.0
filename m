Received: from aserp1040.oracle.com ([141.146.126.69]:45899 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939750AbdD1SbA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Apr 2017 14:31:00 -0400
Date: Fri, 28 Apr 2017 11:29:38 -0700
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH v2] fstests: regression test for btrfs buffered read's
 repair
Message-ID: <20170428182937.GA8398@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <1493230172-8951-1-git-send-email-bo.li.liu@oracle.com>
 <CAL3q7H7Q6BuOLYTi5AD529x+N02-z5B6MuRxLuUvRVPNDE1Obw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7Q6BuOLYTi5AD529x+N02-z5B6MuRxLuUvRVPNDE1Obw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@gmail.com>
Cc: fstests@vger.kernel.org, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 28, 2017 at 10:52:12AM +0100, Filipe Manana wrote:
> On Wed, Apr 26, 2017 at 7:09 PM, Liu Bo <bo.li.liu@oracle.com> wrote:
> > This case tests whether buffered read can repair the bad copy if we
> > have a good copy.
> >
> > Commit 20a7db8ab3f2 ("btrfs: add dummy callback for readpage_io_failed
> > and drop checks") introduced the regression.
> >
> > The upstream fix is
> >         Btrfs: bring back repair during read
> 
> Same issue as reported for the other new test (btrfs/140), the test
> fails on a kernel with the mentioned patch. Seems like it does wrong
> assumptions somewhere (I haven't investigated, just run the test):

Thanks for running the test, what I've missed is that chunk start offset depends
on disk size, so I'll add a filesystem size limit to mkfs.

Thanks,

-liubo

