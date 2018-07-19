Received: from albireo.enyo.de ([5.158.152.32]:41744 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbeGSRFD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jul 2018 13:05:03 -0400
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: xfstests can't be installed by running make install
References: <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
        <20180717033214.GJ2830@desktop> <87muupipos.fsf@mid.deneb.enyo.de>
        <20180718031515.GK4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180718034749.GL4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180718040540.GM4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <87601dhyga.fsf@mid.deneb.enyo.de>
        <20180718083126.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <87pnzlexrm.fsf@mid.deneb.enyo.de>
        <20180718101205.GT4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Date: Thu, 19 Jul 2018 18:21:05 +0200
In-Reply-To: <20180718101205.GT4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        (Zorro Lang's message of "Wed, 18 Jul 2018 18:12:05 +0800")
Message-ID: <874lgv9oy6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: guaneryu@gmail.com, david@fromorbit.com, fstests@vger.kernel.org, Paul Smith <psmith@gnu.org>, bug-make@gnu.org, Jim Meyering <meyering@fb.com>
List-ID: <fstests@vger.kernel.org>

* Zorro Lang:

> I was trying to change all these things to [:digit:], [:lower:], [:upper:],
> [:alpha:] and [:alnum:]. But there're many, and the worse thing is there're
> many things like [1-9], [3-8], [1-9a-f], [0-9a-f-] etc...

I finally found a summary of the old discussion I tried to recall:

<https://www.gnu.org/software/gawk/manual/html_node/Ranges-and-Locales.html>

Ten years on, and we still haven't solved this.

I think it's time to implement the Rational Range Interpretation
across all GNU tools.
