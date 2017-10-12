Received: from mx1.redhat.com ([209.132.183.28]:24155 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdJLHZT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Oct 2017 03:25:19 -0400
Date: Thu, 12 Oct 2017 15:25:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 0/3] generalize AIO/DIO dmesg filter
Message-ID: <20171012072517.GB10593@eguan.usersys.redhat.com>
References: <1507647298-9971-1-git-send-email-idryomov@gmail.com>
 <20171012042515.GY10593@eguan.usersys.redhat.com>
 <CAOi1vP978u=bqcwN2L861Y-Uveg-MGBi+CB_oTRpDJVA05kb0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP978u=bqcwN2L861Y-Uveg-MGBi+CB_oTRpDJVA05kb0g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 12, 2017 at 09:19:21AM +0200, Ilya Dryomov wrote:
> On Thu, Oct 12, 2017 at 6:25 AM, Eryu Guan <eguan@redhat.com> wrote:
> > On Tue, Oct 10, 2017 at 04:54:55PM +0200, Ilya Dryomov wrote:
> >> With upstream commit 332391a9935d ("fs: Fix page cache inconsistency
> >> when mixing buffered and AIO DIO"), we need to whitelist dio_complete()
> >> for ext4 pretty much everywhere iomap_dio_complete() and friends are
> >> whitelisted for xfs.
> >
> > Thanks for fixing this! I agreed with Dave that we should move the
> > filter to common/filter file, but that's easy to do and I can fix it up
> > at commit time.
> 
> I already fixed it -- just waiting for more comments before reposting.

Then please repost and I'll take your v2 :)

Thanks,
Eryu

> 
> >
> > I was thinking adding this filter to _check_dmesg unconditionally, so we
> > don't have to the filter case by case. But I guess it's better to be
> > more careful, in case we miss any real bug.
> 
> Definitely!
> 
> Thanks,
> 
>                 Ilya
