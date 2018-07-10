Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754127AbeGJMjA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Jul 2018 08:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CAB38A3CE
        for <fstests@vger.kernel.org>; Tue, 10 Jul 2018 12:39:00 +0000 (UTC)
Date: Tue, 10 Jul 2018 20:38:57 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/499: stop fsx from probing insert range call
Message-ID: <20180710123857.GB4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180710073305.23740-1-zlang@redhat.com>
 <20180710122415.m5ntnavstegc35oy@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710122415.m5ntnavstegc35oy@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 10, 2018 at 02:24:15PM +0200, Lukas Czerner wrote:
> On Tue, Jul 10, 2018 at 03:33:05PM +0800, Zorro Lang wrote:
> > On some old kernel which supports COLLAPSE_RANGE and ZERO_RANGE,
> > but doesn't support INSERT_RANGE, this case alway fails as:
> > 
> >    QA output created by 499
> >   +main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
> >    Silence is golden
> > 
> > fsx print one more line to break the golden image.
> > 
> > Due to this case don't need to do INSERT_RANGE operations, so use
> > -I options to prevent fsx from probing INSERT_RANGE call.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > 1) I think using -I option of fsx is better than _notrun when find the system
> > doesn't support INSERT_RANGE.
> > 
> > 2) Although PUCH_HOLE isn't needed either, when a system supports COLLAPSE_RANGE
> > and ZERO_RANGE, it supports PUCH_HOLE too. So I don't use -H option.
> 
> Hi Zorro,
> 
> there is no real dependency between fallocate modes, so it is this way for
> historical reasons and it might be different for different fs. Not that
> this matters much.
> 
> > 
> > Thanks,
> > Zorro
> > 
> >  tests/generic/499 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/499 b/tests/generic/499
> > index 99d6d308..a2eac6ab 100755
> > --- a/tests/generic/499
> > +++ b/tests/generic/499
> > @@ -50,7 +50,7 @@ ENDL
> >  
> >  victim=$SCRATCH_MNT/a
> >  touch $victim
> > -$here/ltp/fsx --replay-ops $tmp.fsxops $victim > $tmp.output || cat $tmp.output
> > +$here/ltp/fsx -I --replay-ops $tmp.fsxops $victim > $tmp.output || cat $tmp.output
> 
> The test fails (while the others does not) because we tend to redirect
> stderr as well, but we are not doing it here.
> 
> IMO the better fix would be to add 2>&1

Ah, make sense! I was thinking the case need fsx stderr output to break
the golden image. If we filter stderr too, we totally depend on checking
the return value of fsx :)

I'll send a v2.

Thanks,
Zorro

> 
> -Lukas
> 
> >  
> >  echo "Silence is golden"
> >  status=0
> > -- 
> > 2.14.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
