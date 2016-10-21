Received: from mx1.redhat.com ([209.132.183.28]:52228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933769AbcJUPYL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Oct 2016 11:24:11 -0400
Date: Fri, 21 Oct 2016 23:24:08 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 3/3] fstests: run xfs_io as multi threaded for 'quick'
 tests
Message-ID: <20161021152408.GO27776@eguan.usersys.redhat.com>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
 <1476615222-7804-3-git-send-email-amir73il@gmail.com>
 <20161016214608.GC14023@dastard>
 <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com>
 <20161020142508.GJ27776@eguan.usersys.redhat.com>
 <CAOQ4uxhXEkaQLfzNV-oTaOa-p-w6UQgbNXuNGcq1LGkVq48vdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhXEkaQLfzNV-oTaOa-p-w6UQgbNXuNGcq1LGkVq48vdQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 20, 2016 at 09:27:03PM +0300, Amir Goldstein wrote:
> On Thu, Oct 20, 2016 at 5:25 PM, Eryu Guan <eguan@redhat.com> wrote:
> > On Mon, Oct 17, 2016 at 10:01:19AM +0300, Amir Goldstein wrote:
> 
> ...
> 
> >
> > I'm still having concerns about losing test coverage by enabling "-i" by
> > default. How about adding an command line option to disable it?
> 
> I could take the easy way and add a command line option to satisfy
> concerns, but we all know that 99% of the time, nobody is going to use it,
> so we will be just silencing out concerns instead of addressing them.
> 
> > So at
> > least we could have a way to turn it off. Or is it completely impossible
> > to lose any test coverage?
> 
> I would not argue that it is completely impossible to loose test coverage
> but I would argue that there is low probability of loosing *interesting* test
> coverage.
> 
> Here is the argument I am making:
> A file reference leak can be anywhere, (e.g in EXDEV error path of clone
> file range ioctl) so we SHOULD have -i test coverage for as many APIs
> as possible with as many arguments as possible.
> OTOH, the difference between slowpath and fastpath of fdget()/fdput()
> for single/multi threaded process is quite invariant to the specific API,
> so I do not see the value in test coverage of fastpath to all APIs.

Then I'll take it as it is, and we can always add a new option to turn
it off when we find it necessary :) Thanks!

Eryu
