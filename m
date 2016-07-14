Received: from mx1.redhat.com ([209.132.183.28]:60885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbcGNMNW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:13:22 -0400
Date: Thu, 14 Jul 2016 20:13:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 4/4] xfstests: filename handling - fix early wildcard
 expansion
Message-ID: <20160714121319.GC2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-5-git-send-email-jtulak@redhat.com>
 <20160713122859.GV2432@eguan.usersys.redhat.com>
 <CACj3i70SBt=4pF3EFdTFnhYE6JPtS78dpBNqk0PntTpnX8z1aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACj3i70SBt=4pF3EFdTFnhYE6JPtS78dpBNqk0PntTpnX8z1aQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, "Chinner, Dave" <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 14, 2016 at 10:56:51AM +0200, Jan Tulak wrote:
> On Wed, Jul 13, 2016 at 2:28 PM, Eryu Guan <eguan@redhat.com> wrote:
> > On Mon, Jul 11, 2016 at 11:26:09AM +0200, Jan Tulak wrote:
> >> Add quotation marks around the wildcarded name.
> >
> > This makes no difference for me, the original code is working well. Did
> > I miss anything?
> >
> > [root@dhcp-66-86-11 xfstests]# bname=999
> > [root@dhcp-66-86-11 xfstests]# find tests/xfs -name "$bname*"
> > tests/xfs/999-test-case
> > tests/xfs/999-test-case.out
> > [root@dhcp-66-86-11 xfstests]# find tests/xfs -name $bname*
> > tests/xfs/999-test-case
> > tests/xfs/999-test-case.out
> >
> 
> Hmmm. The move of the code alone was not enough to fix an issue I had,
> but now I can't remember when it happened, no matter what. :( I'm
> beginning to think I might forget to save the file after moving the
> code. In which case...
> 
> So either drop it and if it appears again, then I will resubmit, or
> keep it there "just to be sure". I'm OK with both these options, so
> whatever is more in line with your idea of a clean repo. :-)

I'd prefer to drop it for now, and fix it when we know what the exact
issue is :)

Thanks,
Eryu
