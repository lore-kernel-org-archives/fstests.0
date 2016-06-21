Received: from mx1.redhat.com ([209.132.183.28]:42030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbcFUIX2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 04:23:28 -0400
Date: Tue, 21 Jun 2016 16:12:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] generic/042: add to auto group
Message-ID: <20160621081242.GU5140@eguan.usersys.redhat.com>
References: <1465916890-28135-1-git-send-email-hch@lst.de>
 <1465916890-28135-3-git-send-email-hch@lst.de>
 <3280bc48-96f8-6653-933b-0154f0fa4a3e@plexistor.com>
 <20160614165125.GA32577@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160614165125.GA32577@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Omer Zilberberg <omzg@plexistor.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 06:51:25PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 14, 2016 at 06:44:40PM +0300, Omer Zilberberg wrote:
> > 
> > 
> > On 06/14/2016 06:08 PM, Christoph Hellwig wrote:
> > > This is an odd one as it's in the quick group but not the auto one.
> > > And it actually fails on XFS for me..
> > Please note that this was removed from 'auto' in commit:
> > 7721b85 generic/042: remove from the 'auto' group
> > I don't know whether the original reasons for this are still relevant...
> > just FYI
> 
> I tend to disagree with the rationale, but even if we believe it it
> should have been removed from the quick group as well.

So the question is how do we define auto group, 7721b85 removed auto
group because "the auto group is for tests that *are* expected to
succeed".

I searched for Dave's explainations on 'auto' group in his reviews, and
got the following definitions:

- it should be a valid & reliable test (it's finished and have
  deterministic output) [1]
- it passes on current upstream kernels, if it fails, it's likely to be
  resolved in forseeable future [2]
- it should take no longer than 5 minutes to finish [3]

generic/042 is a valid & reliable regression test, and it finishes
within 5 seconds for me, but it fails on current upstream kernels, and I
don't see when it could be fixed (the test was added in Oct. 2014, it's
not fixed in almost two years).

So removing it from 'auto' group seems fine to me, but I'm not sure
about the 'quick' group. Is it related to auto?

Thanks,
Eryu

[1] http://www.spinics.net/lists/fstests/msg00938.html
[2] http://www.spinics.net/lists/fstests/msg01548.html
[3] http://www.spinics.net/lists/fstests/msg01719.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
