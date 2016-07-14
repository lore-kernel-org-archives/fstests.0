Received: from mx1.redhat.com ([209.132.183.28]:41133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbcGNMSk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:18:40 -0400
Date: Thu, 14 Jul 2016 20:18:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/4] fstests: filename handling for extended names in
 ./check was on a wrong place
Message-ID: <20160714121838.GD2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-3-git-send-email-jtulak@redhat.com>
 <20160713123454.GW2432@eguan.usersys.redhat.com>
 <CACj3i71hZQ6U=s-EwP-jRs3TJwwCQ7KKB6=Bv7gK-ug8V_Tb9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACj3i71hZQ6U=s-EwP-jRs3TJwwCQ7KKB6=Bv7gK-ug8V_Tb9Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, "Chinner, Dave" <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 14, 2016 at 11:11:17AM +0200, Jan Tulak wrote:
> On Wed, Jul 13, 2016 at 2:34 PM, Eryu Guan <eguan@redhat.com> wrote:
> > On Mon, Jul 11, 2016 at 11:26:07AM +0200, Jan Tulak wrote:
> >> The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
> >> was moved at the earliest position, so everything working with the test name or
> >> path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.
> >>
> >> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> >
> > Can you please include more details in the description? It seems not so
> > clear to me what the problem is from the description.
> >
> > If I understand it correctly (after playing around), prior to the patch:
> > [root@dhcp-66-86-11 xfstests]# ./check xfs/999
> > ...
> > xfs/999 0s ... 0s
> > Ran: xfs/999-test-case
> > Passed all 1 tests
> >
> > After applying the patch:
> > [root@dhcp-66-86-11 xfstests]# ./check xfs/999
> > ...
> > xfs/999-test-case 0s ... 0s
> > Ran: xfs/999-test-case
> > Passed all 1 tests
> >
> > So the test name is always correct, right?
> >
> 
> Yes. Most importantly, this fixes issues around other name-based
> operations, see the new message:
> ---
> The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
> was moved to the earliest position, so everything working with the test name or
> path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.
> 
> An example of this issue is $testname.notrun file. When _notrun "foo" was run
> during ./check foo/$name command, it created $name.notrun. But few lines later,
> it wanted $fullname.notrun. So if you did ./check foo/999, but the file was
> 999-bar-baz, then you got comparing outputs (and most likely a fail)
> instead of a skip.
> 
> Another example of this mix is in xfstests output:
> ./check xfs/999
> [...]
> xfs/999 0s ... 0s
> Ran: xfs/999-test-case
> ---
> 
> Do you like it now? And do want it as a new version of the patch? :-)

This does read better to me, thanks! And seems you're going to send a
new patchset, then please send a new version with updated description.

Thanks!

Eryu
