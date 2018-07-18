Received: from albireo.enyo.de ([5.158.152.32]:44968 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeGRHCf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jul 2018 03:02:35 -0400
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: xfstests can't be installed by running make install
References: <20180711143314.GD4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <20180711163921.GI2780@desktop> <20180715054320.GZ2234@dastard>
        <20180715071110.GH2830@desktop>
        <20180716073051.GH4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
        <ab20c4fcdf86e002d1b348f3cfa96333ed519cd8.camel@gnu.org>
        <20180717033214.GJ2830@desktop> <87muupipos.fsf@mid.deneb.enyo.de>
        <20180717225801.GA19934@dastard>
Date: Wed, 18 Jul 2018 08:26:15 +0200
In-Reply-To: <20180717225801.GA19934@dastard> (Dave Chinner's message of "Wed,
        18 Jul 2018 08:58:01 +1000")
Message-ID: <87601dgiuw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Paul Smith <psmith@gnu.org>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, bug-make@gnu.org, Jim Meyering <meyering@fb.com>
List-ID: <fstests@vger.kernel.org>

* Dave Chinner:

(The regular expression or glob pattern [a-z] matches B.)

>> This is ultimately caused by a locale data update which was backported
>> into Fedora 28 (glibc 2.27) and its derivatives.  Upstream glibc only
>> has this change for version 2.28 (not yet released).  It's currently
>> not considered a release blocker, if it's even considered a bug at
>> all.
>
> So what you are saying (i.e. "not a bug") is that we should expect
> widespread regex breakage in custom scripts when distros roll out
> glibc 2.28 because it will break assumptions people have coded into
> their scripts and custom code for the past 20+ years?

According to POSIX, [a-z] is undefined in locales other than C or
POSIX.  This isn't a recent change.  POSIX pretty much says that you
need to use [[:lower:]] instead.

I don't doubt that a lot of code doesn't follow these rules, and
saying that it is broken according to POSIX doesn't help users who run
into issues.  But on the glibc side, I don't see anyone else arguing
that this needs to be fixed in glibc.
