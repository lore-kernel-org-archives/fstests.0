Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfBLRFB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Feb 2019 12:05:01 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8991020700
        for <fstests@vger.kernel.org>; Tue, 12 Feb 2019 17:04:59 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id p9so1124489uaa.5
        for <fstests@vger.kernel.org>; Tue, 12 Feb 2019 09:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20180412213838.28929-1-jeffm@suse.com> <20180424093646.GA11384@desktop>
 <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com> <20180427112356.GP11384@desktop>
 <20180427170009.GT27853@wotan.suse.de> <20180428024545.GR11384@desktop>
 <33a80b8a-fe26-faee-9704-d1bb2c933a3a@suse.com> <21a3f3ab-b439-9851-8258-4e3e7f9ca472@suse.com>
 <d00ccf46-0b58-9f69-51f4-570bc9fce805@suse.com>
In-Reply-To: <d00ccf46-0b58-9f69-51f4-570bc9fce805@suse.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 12 Feb 2019 11:04:46 -0600
Message-ID: <CAB=NE6WQwAOcSyKWi_smYVCiLSZoYGMdO4fJwnZ85_0jR7wh+Q@mail.gmail.com>
Subject: Re: [PATCH] check: annotate good and expunged tests in results
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Nikolay Borisov <nborisov@suse.com>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Tue, May 1, 2018 at 8:44 AM Jeff Mahoney <jeffm@suse.com> wrote:
>
> On 5/1/18 9:34 AM, Jeff Mahoney wrote:
> > On 4/30/18 4:48 PM, Jeff Mahoney wrote:
> >> On 4/27/18 10:45 PM, Eryu Guan wrote:
> >>> On Fri, Apr 27, 2018 at 05:00:09PM +0000, Luis R. Rodriguez wrote:
> >>>> On Fri, Apr 27, 2018 at 07:23:56PM +0800, Eryu Guan wrote:
> >>>>>
> >>>>> But the test run & pass info is already available from the check output
> >>>>> and the test result summary at the end of check. Is that sufficient for
> >>>>> you? Also, we already have mechanism to generate a test report in xunit
> >>>>> format, i.e. ./check -R xunit -g auto, which includes results for passed
> >>>>> & failed & notrun tests.
> >>>>
> >>>> Do we have a way to parse the results *after* a run? For instance,
> >>>> if you forgot -R xunit ?
> >>>
> >>> There's a tools/compare-failures script that takes the outputs of check
> >>> as inputs and compares the results. But, TBH, I never run it after
> >>> reviewing it.. Perhaps it could be enhanced somehow.
> >>
> >> Yeah, that takes check output.  Without capturing it at runtime, it
> >> can't compare anything.
> >>
> >> The XML report may do most of what I want provided we can enable it by
> >> default and write it someplace safe rather than clean it up
> >> automatically when the test run is interrupted.
> >>
> >> I already have test code that extends it to output expunged tests and to
> >> add an explicit <pass/> element.  It saves the timestamps already, so
> >> that's a plus.
> >
> > And shortly after writing this, I had a test run hang.  Since it hung,
> > even writing it on exit wouldn't have worked.  There's not enough
> > information leftover to generate it.  I think I'd still like the results
> > directory to contain the information required to generate it as a
> > post-mortem.
>
> After thinking on it a bit more, since you object to writing a bunch of
> files by default, we could accomplish the same goal by adding a "files"
> report type that does this without dropping files for everyone.  I'm
> working that up now.

How's that going BTW? :)

 Luis
