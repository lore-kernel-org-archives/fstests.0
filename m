Received: from aserp1040.oracle.com ([141.146.126.69]:27725 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdFPSH3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Jun 2017 14:07:29 -0400
Date: Fri, 16 Jun 2017 11:07:20 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] ext4: fsmap tests
Message-ID: <20170616180720.GA10974@birch.djwong.org>
References: <20170602225220.GA5634@birch.djwong.org>
 <20170616063445.GH17436@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616063445.GH17436@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 16, 2017 at 02:34:45PM +0800, Eryu Guan wrote:
> Hi Darrick,
> 
> On Fri, Jun 02, 2017 at 03:52:20PM -0700, Darrick J. Wong wrote:
> > Test the GETFSMAP ioctl against ext4.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> I'm planning to merge this patch after merging Jeff's patch that adds
> external log dev support to ext4 (Jeff's patchset is still in its review
> cycle), if you're not in a hurry. Please let me know if you'd like to
> see ext4 fsmap tests sooner.

I'm in no rush. :)

--D

> 
> Thanks,
> Eryu
