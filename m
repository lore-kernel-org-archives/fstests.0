Received: from mx2.suse.de ([195.135.220.15]:44030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbcKCLtr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Nov 2016 07:49:47 -0400
Date: Thu, 3 Nov 2016 12:49:45 +0100
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] common: add CephFS support
Message-ID: <20161103124945.04536a62@suse.de>
In-Reply-To: <20161102221755.GH14023@dastard>
References: <20161102090054.6394-1-ddiss@suse.de>
        <20161102221755.GH14023@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Joao Eduardo Luis <joao@suse.de>
List-ID: <fstests@vger.kernel.org>

On Thu, 3 Nov 2016 09:17:55 +1100, Dave Chinner wrote:

> On Wed, Nov 02, 2016 at 10:00:54AM +0100, David Disseldorp wrote:
> > From: Joao Eduardo Luis <joao@suse.de>
> > 
> > Add basic CephFS support. No new CephFS specific tests are included,
> > just basic enablement, with ./check now accepting a -ceph parameter.  
> 
> We don't add command line parameters to specify the filesystem
> anymore if we can avoid it (they are legacy options, really).
> Specifying FSTYP=ceph in the environment or config file should be
> sufficient to do they right thing - does this work for ceph?

Yes, seems to work okay for me.

> 
> > @@ -1499,6 +1508,15 @@ _require_scratch_nocheck()
> >  			_notrun "this test requires a valid \$SCRATCH_MNT"
> >  		fi
> >  		;;
> > +        ceph)
> > +		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> > +		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> > +			_notrun "this test requires a valid \$SCRATCH_DEV"
> > +		fi
> > +		if [ ! -d "$SCRATCH_MNT" ]; then
> > +			_notrun "this test requires a valid \$SCRATCH_MNT"
> > +		fi
> > +		;;  
> 
> This is the same check as for nfs*). Can you make those common?

Sure, will fix and resend. Thanks for the feedback Dave.

Cheers, David
