Received: from aserp2120.oracle.com ([141.146.126.78]:49856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDCB1z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Apr 2019 21:27:55 -0400
Date: Tue, 2 Apr 2019 17:16:47 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/populate: decrease the step of rm file
Message-ID: <20190403001647.GJ15524@magnolia>
References: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190401111421.GD2824@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401111421.GD2824@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 01, 2019 at 07:14:21PM +0800, Eryu Guan wrote:
> On Thu, Mar 28, 2019 at 03:48:59PM +0800, Yang Xu wrote:
> >  Now that we have allocated 2*4096*64/16(32768) inodes after "Inode btree",
> >  but the step of rm file is too large to create enough free inodes in agi.
> >  So the freecount is not enough large to make free_level gt 1 and call
> >  _scratch__populate on xfs will report the following failure(such as xfs/083):
> > 
> > Failed to create fino of sufficient height!
> > 
> > By decreasing the step of rm file, xfs/083 will pass.
> > 
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> 
> I may need some help from Darrick (cc'ed) on this one :)

I'll have a look tomorrow.

--D

> Thanks,
> Eryu
> 
> > ---
> >  common/populate | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/populate b/common/populate
> > index 4fa118f0..7403dec3 100644
> > --- a/common/populate
> > +++ b/common/populate
> > @@ -271,7 +271,7 @@ _scratch_xfs_populate() {
> >  		touch "${dir}/${f}"
> >  	done
> >  
> > -	seq 0 "$((ino_per_rec + 1))" "${nr}" | while read f; do
> > +	seq 0 2 "${nr}" | while read f; do
> >  		rm -f "${dir}/${f}"
> >  	done
> >  
> > -- 
> > 2.18.1
> > 
> > 
> > 
