Received: from mx1.redhat.com ([209.132.183.28]:49784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbcLIFwg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 9 Dec 2016 00:52:36 -0500
Date: Fri, 9 Dec 2016 13:52:33 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: fix excluding test groups
Message-ID: <20161209055233.GM29149@eguan.usersys.redhat.com>
References: <1481204070-10881-1-git-send-email-amir73il@gmail.com>
 <20161209041641.GL29149@eguan.usersys.redhat.com>
 <CAOQ4uxifuW2DDm5B976XUbGCPLiUvct6RDZY6KQ5Sa_ZYT=zYQ@mail.gmail.com>
 <CAOQ4uxjyPcy2D1Minu5vH=xHU7=kcNNXQraRNGZKpBzzE7+xKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjyPcy2D1Minu5vH=xHU7=kcNNXQraRNGZKpBzzE7+xKA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 09, 2016 at 07:35:25AM +0200, Amir Goldstein wrote:
> On Fri, Dec 9, 2016 at 6:57 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Fri, Dec 9, 2016 at 6:16 AM, Eryu Guan <eguan@redhat.com> wrote:
> >> On Thu, Dec 08, 2016 at 03:34:30PM +0200, Amir Goldstein wrote:
> >>> The -x flag is used to exclude tests that belong to
> >>> certain groups from the test args list.
> >>>
> >>> When the test args list is expressed as a match pattern,
> >>> -x fails to exclude the tests that match the pattern
> >>> and belong to excluded groups.
> >>>
> >>> For example:
> >>> $ ./check -n -x xfs/??? | wc -l
> >>
> >> You mean "./check -n -x fuzzers,dangerous_fuzzers | wc -l" here?
> >>
> >
> > No. I just wanted to present the total number of tests that match the
> > pattern to show in the next line that -x does not exclude any tests.
> >
> 
> And yes, I have typo. Should be:
> $ ./check -n xfs/??? | wc -l

I meant for this, and I pasted the wrong cmdline too.. sorry.

> 
> >>> 341
> >>> $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
> >>> 341
> >>>
> >>> After the fix:
> >>> $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
> >>> 315
> >>>
> >>> This bug seems to date back to this git repo epoc.
> >>>
> >>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>> ---
> >>>  check | 9 ++++++---
> >>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/check b/check
> >>> index 8f2a1bb..9732460 100755
> >>> --- a/check
> >>> +++ b/check
> >>> @@ -158,11 +158,14 @@ _timestamp()
> >>>  _prepare_test_list()
> >>>  {
> >>>       unset list
> >>> +     touch $tmp.list
> >>>       # Tests specified on the command line
> >>>       if [ -s $tmp.arglist ]; then
> >>> -             cat $tmp.arglist > $tmp.list
> >>> -     else
> >>> -             touch $tmp.list
> >>> +             # flatten multi tests line (tests/$fs/???) to 1 test per line
> >>> +             list=$(cat $tmp.arglist)
> >>> +             for t in $list; do
> >>> +                     echo "$t" >> $tmp.list
> >>> +             done
> >>
> >> Perhaps a sed is more efficient? e.g.
> >>
> >> -               cat $tmp.arglist > $tmp.list
> >> +               sed 's/ \+/\n/g' $tmp.arglist > $tmp.list
> >>
> >
> > I have considered that and decided that efficiency is not an issue here
> > and better have the robustness of the shell parser without having to worry
> > about all the possible whitespace cases that I may be missing.
> 
> But maybe that just because I am not confident enough about my regexp
> skills. If folks feel confident about the sed variant, I have no objection.

$tmp.arglist is populated by

echo $SRC_DIR/$test_dir/$test_name >> $tmp.arglist

which actually is "echo tests/xfs/???", and it is expended to multiple
tests in one line by bash in one shot, seperated by only one space. So I
think it's safe & quick to do a sed on $tmp.arglist.

> 
> > Besides, this is exactly the same as the population of $tmp.arglist when
> > the args list is expanded by the shell, which is BTW a workaround for
> > this issue, e.g.:
> >
> > $ ln -s tests/xfs xfs
> > $ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
> > 315

This is different, "xfs/???" is expended first by your interactive shell
before passing it to check, so check sees multiple tests and iterates
over them.

Thanks,
Eryu
