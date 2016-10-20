Received: from mx1.redhat.com ([209.132.183.28]:55530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964843AbcJTOZK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Oct 2016 10:25:10 -0400
Date: Thu, 20 Oct 2016 22:25:08 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 3/3] fstests: run xfs_io as multi threaded for 'quick'
 tests
Message-ID: <20161020142508.GJ27776@eguan.usersys.redhat.com>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
 <1476615222-7804-3-git-send-email-amir73il@gmail.com>
 <20161016214608.GC14023@dastard>
 <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiMKMB2HqKOjJ7b296oX+MvV_OvCDY5h6gz-A9C5a5DBA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 17, 2016 at 10:01:19AM +0300, Amir Goldstein wrote:
> On Mon, Oct 17, 2016 at 12:46 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Sun, Oct 16, 2016 at 01:53:42PM +0300, Amir Goldstein wrote:
> >> Try to run xfs_io for tests in group quick with command line
> >> option -M which starts an idle thread before performing any io.
> >>
> >> The purpose of this idle thread is to test io from a multi threaded
> >> process. With single threaded process, the file table is not shared
> >> and file structs are not reference counted.
> >>
> >> In order to improve the chance of detecting file struct reference
> >> leaks, we should run xfs_io commands with this option as much as
> >> possible.
> >>
> >> Analysis of the effect of xfs_io -M on tests runtime showed that
> >> it may lead to slightly longer run times in extreme cases (e.g +3s
> >> for generic/132), but has a negligable effect on runtime of tests
> >> among the 'quick' group (worst case +0.3s for generic/130).
> >>
> >> Therefore, we automatically add the -M flags only to tests in the
> >> 'quick' group.
> >>
> >> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >> ---
> >>  check     |  2 ++
> >>  common/rc | 15 +++++++++++++++
> >>  2 files changed, 17 insertions(+)
> >>
> >> diff --git a/check b/check
> >> index 69341d8..e568598 100755
> >> --- a/check
> >> +++ b/check
> >> @@ -574,6 +574,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >>
> >>           mkdir -p $RESULT_DIR
> >>
> >> +         export TEST_GROUPS=`grep $(basename $seqnum) "$SRC_DIR/$(dirname $seqnum)/group"`
> >> +
> >
> > Do we really want to go down this path of changing behaviours
> > of utilities based on what group  they belong to? It means we can no
> > longer look at the test code and recreate the command line without
> > having to work out what group context the test is running under. And
> > how do we tell that it's correct and we don't inadvertantly break
> > it? I ask this because.....
> >
> >>           echo -n "$seqnum"
> >>
> >>               if $showme; then
> >> diff --git a/common/rc b/common/rc
> >> index a838750..7c478cf 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -3799,6 +3799,21 @@ init_rc()
> >>       $XFS_IO_PROG -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
> >>               export XFS_IO_PROG="$XFS_IO_PROG -F"
> >>
> >> +     if echo $TEST_GROUPS | grep -q quick; then
> >> +             # xfs_io -M flag runs xfs_io as multi threaded process
> >> +             # in order to catch fdget/fdset reference leaks, because
> >> +             # file structs are not reference counted in a single threaded
> >> +             # process.
> >> +             # Because reference counted fdget/fdset may lead to slightly
> >> +             # longer run times in extreme cases (such as generic/132),
> >> +             # we limit the use of -M flags to tests with short runtime,
> >> +             # where the effect of the flag is negligable.
> >> +             #
> >> +             # Figure out if xfs_io supports the -M option
> >> +             $XFS_IO_PROG -M -c quit 2>/dev/null && \
> >> +                     export XFS_IO_PROG="$XFS_IO_PROG -M"
> >> +     fi
> >> +
> >
> > .... I can't see how this works - init_rc is
> > called and sets $XFS_IO_PROG long before TEST_GROUPS is set and
> > exported.
> 
> Correct, but common/rc is then included again from every single test,
> so XFS_IO_PROG is adjusted to add the -M/i flag per test after
> TEST_GROUPS is set for a specific test in ./check.
> I saw the -F flag code and figured that's a good place to add -M/i as well.
> With a hunch, I would say that if -F where to be added, it where to be
> added twice.
> 
> > How did you verify that the correct xfs_io command lines
> > were being issued?
> >
> 
> Both by adding debug print and by monitoring ps
> 
> > IMO, either turn it on for everything if it is supported, or make it
> > an explicit command line option to enable.
> 
> If I make the default off, then not enough people will test for reference leaks.
> Since leaks may be hard to find, because they may only be on rare error path,
> the motivation for a test suit IMO is to enforce this option as much
> as possible.
> 
> OTOH, if everyone, always run with -i, then the fast path fdget is
> never tested with
> xfs_io. fast path will get tested with other tools used by tests
> though, so maybe
> that is not such a big concern.

[Sorry for the late response, I'm travelling this week and the network
connection is not as good as I expected.]

I'm still having concerns about losing test coverage by enabling "-i" by
default. How about adding an command line option to disable it? So at
least we could have a way to turn it off. Or is it completely impossible
to lose any test coverage?

Thanks,
Eryu
