Received: from sandeen.net ([63.231.237.45]:60407 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbcEWO60 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 May 2016 10:58:26 -0400
Subject: Re: [RFD] fstests needs a new maintainer
References: <20160523045350.GF26977@dastard>
 <20160523064138.GA5051@zlang.usersys.redhat.com>
 <20160523145503.GA32314@infradead.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <c2a65f4a-e083-2c52-fe2e-f26eb947accb@sandeen.net>
Date: Mon, 23 May 2016 09:58:24 -0500
MIME-Version: 1.0
In-Reply-To: <20160523145503.GA32314@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/23/16 9:55 AM, Christoph Hellwig wrote:
> On Mon, May 23, 2016 at 02:41:38PM +0800, Zorro Lang wrote:
>> Thanks for what you did for us. I'm just thinking maybe you can
>> separate fstests maintenance jobs to several different maintainers?
>> Due to fstests project become bigger and bigger, it maybe hard for
>> someone review & merge & verify all kinds of patches.
>>
>> As I know LTP have "not only one" maintainers. I think we still
>> need someone like you can make important decision for fstests.
>> But for some daily jobs, you can distribute them to others.
> 
> FYI, back when we team-maintained the xfstests-dev repo together with
> all the other xfs -dev repos it worked out fine.  But even with that
> we need someone to volunteer for doing the day to day grunt work.
> 
> While I'd be happy to help out I fear I don't have time to do the
> majority of the work at the moment either.

Team maintenance probably makes good sense; while we do want to maintain
consistency across all filesystem tests, each fs does have its own
unique requirements as well.  So perhaps one maintainer from each major
fs contributor to the test corpus would make sense; a general agreement
about review requirements for the repo as a whole and for cross-fs
tests in particular would probably be a good idea, to maintain that
consistency and avoid surprises or contention.

-Eric
