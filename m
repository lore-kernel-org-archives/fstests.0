Received: from mail-pf0-f173.google.com ([209.85.192.173]:39163 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEEOJQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 May 2018 10:09:16 -0400
Received: by mail-pf0-f173.google.com with SMTP id a22so5454440pfn.6
        for <fstests@vger.kernel.org>; Sat, 05 May 2018 07:09:16 -0700 (PDT)
Date: Sat, 5 May 2018 22:09:11 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] README: document the new default run mode
Message-ID: <20180505140911.GE8373@desktop>
References: <20180505001951.5665-1-david@fromorbit.com>
 <CAOQ4uxgJ4+R05wfkgCA6DUEoQbPPJEhTGiE=5QDqoX5hjE7D7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgJ4+R05wfkgCA6DUEoQbPPJEhTGiE=5QDqoX5hjE7D7A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, May 05, 2018 at 09:55:54AM +0300, Amir Goldstein wrote:
> On Sat, May 5, 2018 at 3:19 AM, Dave Chinner <david@fromorbit.com> wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Also document the new way to run all tests (i.e. check -g all) and
> > clean up all the stray whitespace in the readme file.
> >
> > Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> [...]
> > +      and it excludes tests that exercise conditions known to cause machine
> > +      failures (i.e. the "dangerous" tests).
> 
> That would have been nice.. if it was implemented...
> 
> I counted 22 dangerous tests, 20 of which are in auto group, unlike the
> 87 dangerous_* tests, none of which are in auto group.

The 'dangerous' group and 'auto' group are not mutually exclusive when
it was introduced, see commit 3f28d55c3954 ("add freeze and dangerous
groups"). But from previous discussions[1][2], they should be mutually
exclusive.

[1] https://www.spinics.net/lists/fstests/msg08652.html
[2] https://www.spinics.net/lists/fstests/msg08663.html

> 
> If running ./check would exclude 'dangerous' tests by default, should it
> also exclude dangerous_* tests? Or should we just remove the 20
> 'dangerous' tests from auto group and try not to add new auto&dangerous
> tests in the future?

I agreed, I think we should just remove the 20 'dangerous' tests from
auto group (AFAICT, they are not dangerous anymore). And I'll avoid
adding new tests that are in both dangerous & auto group.

Thanks,
Eryu
