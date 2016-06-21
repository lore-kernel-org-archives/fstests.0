Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:28071 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663AbcFUXuN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 19:50:13 -0400
Date: Wed, 22 Jun 2016 09:49:50 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] generic/042: add to auto group
Message-ID: <20160621234950.GE27480@dastard>
References: <1465916890-28135-1-git-send-email-hch@lst.de>
 <1465916890-28135-3-git-send-email-hch@lst.de>
 <3280bc48-96f8-6653-933b-0154f0fa4a3e@plexistor.com>
 <20160614165125.GA32577@lst.de>
 <20160621081242.GU5140@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160621081242.GU5140@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Omer Zilberberg <omzg@plexistor.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 21, 2016 at 04:12:42PM +0800, Eryu Guan wrote:
> On Tue, Jun 14, 2016 at 06:51:25PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 14, 2016 at 06:44:40PM +0300, Omer Zilberberg wrote:
> > > 
> > > 
> > > On 06/14/2016 06:08 PM, Christoph Hellwig wrote:
> > > > This is an odd one as it's in the quick group but not the auto one.
> > > > And it actually fails on XFS for me..
> > > Please note that this was removed from 'auto' in commit:
> > > 7721b85 generic/042: remove from the 'auto' group
> > > I don't know whether the original reasons for this are still relevant...
> > > just FYI
> > 
> > I tend to disagree with the rationale, but even if we believe it it
> > should have been removed from the quick group as well.
> 
> So the question is how do we define auto group, 7721b85 removed auto
> group because "the auto group is for tests that *are* expected to
> succeed".
> 
> I searched for Dave's explainations on 'auto' group in his reviews, and
> got the following definitions:
> 
> - it should be a valid & reliable test (it's finished and have
>   deterministic output) [1]
> - it passes on current upstream kernels, if it fails, it's likely to be
>   resolved in forseeable future [2]
> - it should take no longer than 5 minutes to finish [3]
> 
> generic/042 is a valid & reliable regression test, and it finishes
> within 5 seconds for me, but it fails on current upstream kernels, and I
> don't see when it could be fixed (the test was added in Oct. 2014, it's
> not fixed in almost two years).
> 
> So removing it from 'auto' group seems fine to me, but I'm not sure
> about the 'quick' group. Is it related to auto?

Yes. The only difference between quick and auto group criteria is
the test runtime.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
