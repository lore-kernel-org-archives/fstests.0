Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:39945 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbbEYWej (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 May 2015 18:34:39 -0400
Date: Tue, 26 May 2015 08:34:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2] fstests: add a test for fallocate+truncate
Message-ID: <20150525223436.GW4316@dastard>
References: <1432130999-3956-1-git-send-email-jbacik@fb.com>
 <20150521062910.GC1140@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521062910.GC1140@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 21, 2015 at 02:29:10PM +0800, Eryu Guan wrote:
> On Wed, May 20, 2015 at 10:09:59AM -0400, Josef Bacik wrote:
> > There was some confused about what the fs was supposed to do when you truncate
> > at i_size with preallocated space past i_size.  We decided on the following
> > things
> > 
> > 1) truncate(i_size) will trim all blocks past i_size.
> > 2) truncate(x) where x > i_size will not trim all blocks past i_size.
> > 
> > This test is to make sure we're all acting sanely.  Thanks,
> > 
> > Signed-off-by: Josef Bacik <jbacik@fb.com>
> > ---
> > V1->V2:
> > -changed the test number
> > -fixed up minor comments from Eryu.
.....
> > index 927a91a..a801af4 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -90,6 +90,7 @@
> >  085 auto freeze mount
> >  086 auto prealloc preallocrw quick
> >  088 perms auto quick
> > +087 auto quick prealloc
> 
> out-of-order seq here. Otherwise looks good to me.

I'll fix that on merge.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
