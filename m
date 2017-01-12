Received: from mx1.redhat.com ([209.132.183.28]:56300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbdALEZe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Jan 2017 23:25:34 -0500
Date: Thu, 12 Jan 2017 12:24:30 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: cleanup tmp files in tests
Message-ID: <20170112042430.GW1859@eguan.usersys.redhat.com>
References: <20170106034507.5915-1-eguan@redhat.com>
 <20170107045731.GC575@zzz>
 <20170109101717.GD1859@eguan.usersys.redhat.com>
 <CAOQ4uxjqYFxCedvvYo8=YgoXDCPXogozAuVGd842sJLGQ9ipFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjqYFxCedvvYo8=YgoXDCPXogozAuVGd842sJLGQ9ipFQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 09, 2017 at 12:46:23PM +0200, Amir Goldstein wrote:
> On Mon, Jan 9, 2017 at 12:17 PM, Eryu Guan <eguan@redhat.com> wrote:
> > Hi Eric and Amir,
> >
> > On Fri, Jan 06, 2017 at 08:57:31PM -0800, Eric Biggers wrote:
> >> Hi Eryu,
> >>
> >> On Fri, Jan 06, 2017 at 11:45:07AM +0800, Eryu Guan wrote:
> >> > $tmp.* files should be removed in _cleanup() even if the test is not
> >> > using any $tmp.* file explicitly, because common helper functions
> >> > may take use of them too.
> >> >
> >> > So cleanup tmp files properly in tests, and add a _cleanup()
> >> > function and trap it on exit if the test doesn't do so, to make all
> >> > tests consistent on the way they do cleanup.
> >> >
> >> > Also remove other tmp files used by the tests and the harness so
> >> > that we leave no new tmp files in /tmp dir after a full test run.
> >> >
> >>
> >> Why exactly can't the boilerplate go in a preamble file which is sourced by all
> >> the tests?  For example common/preamble containing something like:
> >
> > Thanks for your review! As you two are basically suggesting the same
> > solution, so I reply to you together.
> >
> > I agree that we can do a common/preamble for all tests to source, but I
> > don't think we need to do that and it's not worth the effort.
> >
> > IMO, we define and setup the tests in the tests themselves, not in a
> > common/preamble file, which makes the tests clear and easy to read. We
> > don't want to "hide" any setups in a common file and to be a "surprise"
> > to the reader, we don't have to look around for a certain setup.
> >
> 
> The motivation for your work is the fact that tmp files are being created
> in a way that is "hidden" from the test author  and therefore, IMO,
> the cleanup of those temp files should also be in a common function
> that is "hidden" from the test author.

[Sorry, I got back to this late.]

That's a good point, so I think what should be done is let common
functions clean up their tmp files, so there's no hidden usage of $tmp
and tests only need to remove $tmp.* used explicitly in the tests.

I checked all the common functions, there're only two that are not
cleaning up their tmp files properly, _do() and run_fsx().

I'll send v2 patch for review, which will be a much simpler patch.

Thanks,
Eryu
