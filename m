Received: from mail-pl1-f195.google.com ([209.85.214.195]:34140 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3RqV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Nov 2018 12:46:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so2318040plz.1
        for <fstests@vger.kernel.org>; Thu, 29 Nov 2018 22:38:06 -0800 (PST)
Date: Fri, 30 Nov 2018 14:37:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/3] generic: workaround device where glibc is not
 installed
Message-ID: <20181130063759.GT3889@desktop>
References: <20181127214308.137410-1-gwendal@chromium.org>
 <20181127214308.137410-2-gwendal@chromium.org>
 <20181128033039.GQ3889@desktop>
 <20181129021003.GJ19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129021003.GJ19305@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 29, 2018 at 01:10:03PM +1100, Dave Chinner wrote:
> On Wed, Nov 28, 2018 at 11:30:39AM +0800, Eryu Guan wrote:
> > >  	export CONFIG_INCLUDED=true
> > > diff --git a/common/rc b/common/rc
> > > index be1ed68c..992cb3cc 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3686,12 +3686,6 @@ _get_block_size()
> > >  	stat -f -c %S $1
> > >  }
> > >  
> > > -get_page_size()
> > > -{
> > > -	echo $(getconf PAGE_SIZE)
> > > -}
> > > -
> > > -
> > 
> > But I think we could just use "$here/src/feature -s" to get page size in
> > get_page_size() and "$here/src/feature -w" to get bits per long. But we
> > need to add
> > 
> > _require_test_program "feature"
> 
> IMO, that is unnecessary. `feature` is test harness infrastructure,
> like common/rc and check.  If the feature binary does not build then
> the test harness is running on a broken platform. IOWs, we shouldn't
> be requiring functionality tests for core infrastructure - if the
> core infrastructure didn't build, then there's bigger problems that
> need to be fixed...

Makes sense. Then it'd be better to require it explicitly in
common/config as what we did to fsstress and xfs_io etc.

Thanks,
Eryu
