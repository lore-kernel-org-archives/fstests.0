Received: from mx1.redhat.com ([209.132.183.28]:60442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfF1ISp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Jun 2019 04:18:45 -0400
Date: Fri, 28 Jun 2019 16:24:02 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfstests: aio random write and verify stress test
Message-ID: <20190628082402.GK30864@dhcp-12-102.nay.redhat.com>
References: <20190513014904.4275-1-zlang@redhat.com>
 <CAOQ4uxh2DLXWSQiyJfJpmzTYwQL4HVGSBwTsxMn_eqLU0rx+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh2DLXWSQiyJfJpmzTYwQL4HVGSBwTsxMn_eqLU0rx+7A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 28, 2019 at 11:03:57AM +0300, Amir Goldstein wrote:
> On Mon, May 13, 2019 at 4:57 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > We found some AIO write related bugs recently, so I think a AIO
> > random write test is needed. By the new aio-aio-write-verify.c tool,
> > we can do this easily.
> >
> 
> Is it just me or does this test gets killed by OOM killer for anyone else?
> (generic/551).
> 
> It always gets killed on a 2GB RAM VM and once got killed on 8GB RAM VM.

Sorry, not only you. We've found that this case can cause OOM on low memeory
machine. I'm going to reduce the default test stress, to avoid the OOM. If
you already has a patch now, please feel free to cc me.

Thanks,
Zorro

> 
> At least I can verify that Darrick's fix is working as expected
> ("check: try to insulate the test framework from oom killer")
> 
> Thanks,
> Amir.
