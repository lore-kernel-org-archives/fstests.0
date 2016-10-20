Received: from mail-lf0-f65.google.com ([209.85.215.65]:33460 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbcJTS1F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Oct 2016 14:27:05 -0400
Received: by mail-lf0-f65.google.com with SMTP id l131so1433307lfl.0
        for <fstests@vger.kernel.org>; Thu, 20 Oct 2016 11:27:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161020142508.GJ27776@eguan.usersys.redhat.com>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
 <1476615222-7804-3-git-send-email-amir73il@gmail.com> <20161016214608.GC14023@dastard>
 <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com> <20161020142508.GJ27776@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Oct 2016 21:27:03 +0300
Message-ID: <CAOQ4uxhXEkaQLfzNV-oTaOa-p-w6UQgbNXuNGcq1LGkVq48vdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fstests: run xfs_io as multi threaded for 'quick' tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 20, 2016 at 5:25 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Oct 17, 2016 at 10:01:19AM +0300, Amir Goldstein wrote:

...

>
> I'm still having concerns about losing test coverage by enabling "-i" by
> default. How about adding an command line option to disable it?

I could take the easy way and add a command line option to satisfy
concerns, but we all know that 99% of the time, nobody is going to use it,
so we will be just silencing out concerns instead of addressing them.

> So at
> least we could have a way to turn it off. Or is it completely impossible
> to lose any test coverage?

I would not argue that it is completely impossible to loose test coverage
but I would argue that there is low probability of loosing *interesting* test
coverage.

Here is the argument I am making:
A file reference leak can be anywhere, (e.g in EXDEV error path of clone
file range ioctl) so we SHOULD have -i test coverage for as many APIs
as possible with as many arguments as possible.
OTOH, the difference between slowpath and fastpath of fdget()/fdput()
for single/multi threaded process is quite invariant to the specific API,
so I do not see the value in test coverage of fastpath to all APIs.

Anyway, I'd be happy to add a command line option or env var if that is
the preference of folks, but then I would really appreciate a suggestion
for option name or var name, because it is going to be quite hard to
find an intuitive name for this test variant.

Thanks,
Amir.
