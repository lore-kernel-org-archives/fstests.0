Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752407AbeBVGCO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Feb 2018 01:02:14 -0500
Date: Thu, 22 Feb 2018 14:02:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: _fail test by default when _scratch_mount fails
Message-ID: <20180222060212.GU18267@eguan.usersys.redhat.com>
References: <20180218124457.28597-1-eguan@redhat.com>
 <CAHc6FU46AetuDG42ymogfPwz2j5j60Fw=urxd14wcfyaWb+9fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU46AetuDG42ymogfPwz2j5j60Fw=urxd14wcfyaWb+9fw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J . Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 21, 2018 at 11:27:01AM +0100, Andreas Gruenbacher wrote:
> On 18 February 2018 at 13:44, Eryu Guan <eguan@redhat.com> wrote:
> > Previously _scratch_mount didn't check the mount status and most
> > tests continue to run even if the mount failed (unless test checks
> > for the mount status explicitly). This would result in running tests
> > on the underlying filesystem (usually rootfs) and implicit test
> > failures, and such failures can be annoying and are usually hard to
> > debug.
> >
> > Now _fail test by default if _scratch_mount failed and introduce
> > _try_scratch_mount for tests that need to check mount results
> > themselves. Also introduce a new _try_scratch_mount helper that does
> > scratch mount without checking mount status for tests that do the
> > check themselves.
> 
> The message above doesn't look quite right, but the patch looks good.

Ah, I'll fix that up.

> 
> Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks for review!

Eryu
