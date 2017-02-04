Received: from mx1.redhat.com ([209.132.183.28]:36684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753510AbdBDD64 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 22:58:56 -0500
Date: Sat, 4 Feb 2017 11:58:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: cleanup $TEST_DIR/$seq* files
Message-ID: <20170204035853.GE1859@eguan.usersys.redhat.com>
References: <1485513589-7416-1-git-send-email-amir73il@gmail.com>
 <20170203093527.GB1859@eguan.usersys.redhat.com>
 <CAOQ4uxhd_ijbFm9e0o01+Z=-2z0dMaONRBKm8jM3kN808hSGeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhd_ijbFm9e0o01+Z=-2z0dMaONRBKm8jM3kN808hSGeQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 03, 2017 at 12:42:19PM +0200, Amir Goldstein wrote:
> On Fri, Feb 3, 2017 at 11:35 AM, Eryu Guan <eguan@redhat.com> wrote:
> > On Fri, Jan 27, 2017 at 12:39:49PM +0200, Amir Goldstein wrote:
> >> Test generic/007 was failing after running test overlay/007,
> >> because the latter left behind a directory named 007 in test dir
> >> and the former failed to mkdir a directory with the same name.
> >>
> >> Greping the tests for the pattern $TEST_DIR/$seq* found some more
> >> files/dirs of this sort that were not being cleaned up.
> >>
> >> Clean those files/dir on _cleanup trap to fix the 007 tests collision
> >> and avoid similar collisions in future tests.
> >>
> >> Left the directories $TEST_DIR/$seq.mnt in tact, because they are
> >> always empty and created with mkdir -p.
> >>
> >> There are more files left behind as can be seen in any aged test dir.
> >
> > TEST_DIR is supposed to be aged over multiple runs, so leaving test
> > files in it should be just fine, unless these files are consuming a lot
> > of free space and would block subsequent tests.
> >
> 
> Good point, but aging doesn't mean that the files need to stay there
> create + delete is perfectly good aging.
> As a matter of fact, all these test take care of removing the test
> files *before* running the test, so why not cleanup *after* the test as well?
> I can understand why it makes sense to leave behind $seq.$$ files to
> fill up TEST_DIR with junk over time, but I cannot understand the reasoning
> to leave behind $seq.<const> files, which are going to be removed before
> next run anyway.

Looks reasonable to me, I'll take your v2 patch, thanks!

Eryu
