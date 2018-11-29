Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:19786 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726929AbeK2NNs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Nov 2018 08:13:48 -0500
Date: Thu, 29 Nov 2018 13:10:03 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/3] generic: workaround device where glibc is not
 installed
Message-ID: <20181129021003.GJ19305@dastard>
References: <20181127214308.137410-1-gwendal@chromium.org>
 <20181127214308.137410-2-gwendal@chromium.org>
 <20181128033039.GQ3889@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128033039.GQ3889@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 28, 2018 at 11:30:39AM +0800, Eryu Guan wrote:
> >  	export CONFIG_INCLUDED=true
> > diff --git a/common/rc b/common/rc
> > index be1ed68c..992cb3cc 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3686,12 +3686,6 @@ _get_block_size()
> >  	stat -f -c %S $1
> >  }
> >  
> > -get_page_size()
> > -{
> > -	echo $(getconf PAGE_SIZE)
> > -}
> > -
> > -
> 
> But I think we could just use "$here/src/feature -s" to get page size in
> get_page_size() and "$here/src/feature -w" to get bits per long. But we
> need to add
> 
> _require_test_program "feature"

IMO, that is unnecessary. `feature` is test harness infrastructure,
like common/rc and check.  If the feature binary does not build then
the test harness is running on a broken platform. IOWs, we shouldn't
be requiring functionality tests for core infrastructure - if the
core infrastructure didn't build, then there's bigger problems that
need to be fixed...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
