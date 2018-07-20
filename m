Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730691AbeGTC6M (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jul 2018 22:58:12 -0400
Date: Fri, 20 Jul 2018 10:12:13 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: xfstests can't be installed by running make install
Message-ID: <20180720021213.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180717033214.GJ2830@desktop>
 <87muupipos.fsf@mid.deneb.enyo.de>
 <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <87601dhyga.fsf@mid.deneb.enyo.de>
 <20180718083126.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <87pnzlexrm.fsf@mid.deneb.enyo.de>
 <20180718101205.GT4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <874lgv9oy6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lgv9oy6.fsf@mid.deneb.enyo.de>
Sender: fstests-owner@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
Cc: guaneryu@gmail.com, david@fromorbit.com, fstests@vger.kernel.org, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 19, 2018 at 06:21:05PM +0200, Florian Weimer wrote:
> * Zorro Lang:
> 
> > I was trying to change all these things to [:digit:], [:lower:], [:upper:],
> > [:alpha:] and [:alnum:]. But there're many, and the worse thing is there're
> > many things like [1-9], [3-8], [1-9a-f], [0-9a-f-] etc...
> 
> I finally found a summary of the old discussion I tried to recall:
> 
> <https://www.gnu.org/software/gawk/manual/html_node/Ranges-and-Locales.html>
> 
> Ten years on, and we still haven't solved this.
> 
> I think it's time to implement the Rational Range Interpretation
> across all GNU tools.

Thanks Florian, I saw this patch from your team:
https://www.sourceware.org/ml/libc-alpha/2018-07/msg00620.html

I've sent a patch to fstests@, try to avoid this problem:
https://marc.info/?l=fstests&m=153199466428997&w=2

We already exported LANG=C and LC_ALL=C, I'm trying to change the
"[a-z]" to "[:lower:]" in Makefile for bypassing this confused
issue. (But yes, I need to wait reviewing :)

> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
