Received: from mx1.redhat.com ([209.132.183.28]:56362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754667AbdHYH6o (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 25 Aug 2017 03:58:44 -0400
Date: Fri, 25 Aug 2017 15:58:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/108: tolerate old lvm utility versions
Message-ID: <20170825075842.GS31418@eguan.usersys.redhat.com>
References: <1503578906-11387-1-git-send-email-idryomov@gmail.com>
 <20170825053113.GR31418@eguan.usersys.redhat.com>
 <CAOi1vP9F6rmEuZ-EBKGsdmw4-WfS-9ovhHS9tC2oD3Drb0dcAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9F6rmEuZ-EBKGsdmw4-WfS-9ovhHS9tC2oD3Drb0dcAA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 25, 2017 at 08:29:06AM +0200, Ilya Dryomov wrote:
> On Fri, Aug 25, 2017 at 7:31 AM, Eryu Guan <eguan@redhat.com> wrote:
> > On Thu, Aug 24, 2017 at 02:48:26PM +0200, Ilya Dryomov wrote:
> >> lvm utility in Ubuntu 14.04 LTS treats -l 100%FREE as a hard number and
> >> not as an approximate upper limit.  With ~5G scratch partition and ~128M
> >
> > I just looked for an Ubuntu 14.04 LTS box and confirmed lvcreate does
> > support '-l 100%FREE'. Even on distributions as old as RHEL6 support
> > this usage too. Perpahs there were other things went wrong in your test
> > environment?
> 
> The syntax is supported, but the semantics are different.  Compare
> lvcreate(8) man pages on Ubuntu 14.04 LTS and something more recent:
> 
> "When expressed as a percentage, the number is treated as an
> approximate upper  limit  for the total  number  of  physical  extents
> to be allocated (including extents used by any mirrors, for example)."
> 
> In the example I gave, '-l 100%FREE' translates to 1310 PEs on Trusty
> vs ~60 PEs on a recent Fedora.

Ah, I got what you mean now. It seems a behavior change introduced by
lvm2 commit 4b6e3b5e5ea6 ("allocation: Allow approximate allocation when
specifying size in percent").

Then this patch looks fine to me (I probably will update the commit log
a bit to mention this lvm behavior change). Thanks!

Eryu
