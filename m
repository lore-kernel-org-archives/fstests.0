Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:47103 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753736AbaFJXbX (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 10 Jun 2014 19:31:23 -0400
Date: Wed, 11 Jun 2014 09:31:06 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfstests: create a test for xfs log grant head leak
 detection
Message-ID: <20140610233106.GJ9508@dastard>
References: <1402060483-22195-1-git-send-email-bfoster@redhat.com>
 <20140610012149.GH4453@dastard>
 <20140610111750.GA46344@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140610111750.GA46344@bfoster.bfoster>
Sender: xfstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 10, 2014 at 07:17:50AM -0400, Brian Foster wrote:
> On Tue, Jun 10, 2014 at 11:21:49AM +1000, Dave Chinner wrote:
> > On Fri, Jun 06, 2014 at 09:14:43AM -0400, Brian Foster wrote:
> > > +# real QA test starts here
> > > +_supported_fs xfs
> > > +_supported_os Linux
> > > +
> > > +_require_scratch
> > > +_require_freeze
> > > +
> > > +if [ ! -e /sys/fs/xfs ]
> > > +then
> > > +	_notrun "no kernel support for XFS sysfs attributes"
> > > +fi
> > 
> > _requires_xfs_sysfs
> > 
> 
> I was mulling this over as I think we'll probably end up in a situation
> where a test that depends on sysfs bits will need to check for a
> specific attribute file. E.g., some new test comes along using a new
> attribute file. Checking for /sys/fs/xfs is not sufficient for that test
> once we release a version that so far only exports the log bits.
> 
> I think we could handle that by supporting a parameter to
> _requires_xfs_sysfs that specifies the sub-attribute that must exist
> (similar to what we have for xfs_io commands). We don't need that at the
> moment, but that's good enough for me to create the requires func.

Yup, passing the name and/or sub-path of the paramter set required
sounds fine to me. it would become:

_requires_xfs_sysfs log

in this case, because the presence of the /sys/fs/xfs/<dev>/log
directory would be suficinet to indicate the test should run, yes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
