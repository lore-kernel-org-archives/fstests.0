Received: from verein.lst.de ([213.95.11.211]:46511 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbcFNQv1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 12:51:27 -0400
Date: Tue, 14 Jun 2016 18:51:25 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] generic/042: add to auto group
Message-ID: <20160614165125.GA32577@lst.de>
References: <1465916890-28135-1-git-send-email-hch@lst.de> <1465916890-28135-3-git-send-email-hch@lst.de> <3280bc48-96f8-6653-933b-0154f0fa4a3e@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3280bc48-96f8-6653-933b-0154f0fa4a3e@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 06:44:40PM +0300, Omer Zilberberg wrote:
> 
> 
> On 06/14/2016 06:08 PM, Christoph Hellwig wrote:
> > This is an odd one as it's in the quick group but not the auto one.
> > And it actually fails on XFS for me..
> Please note that this was removed from 'auto' in commit:
> 7721b85 generic/042: remove from the 'auto' group
> I don't know whether the original reasons for this are still relevant...
> just FYI

I tend to disagree with the rationale, but even if we believe it it
should have been removed from the quick group as well.
