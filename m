Received: from mx1.redhat.com ([209.132.183.28]:34792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdLHGHR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 8 Dec 2017 01:07:17 -0500
Date: Fri, 8 Dec 2017 14:07:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/459: Fix check for ro-remount in extN
Message-ID: <20171208060712.GG2749@eguan.usersys.redhat.com>
References: <1512122736-6045-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <CAOQ4uxiesM5ENw=WB1U9UO88ibstvBWsVatZFOyDA50Y_r7RoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiesM5ENw=WB1U9UO88ibstvBWsVatZFOyDA50Y_r7RoQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>, xuyang.jy@cn.fujitsu.com
Cc: fstests <fstests@vger.kernel.org>, Carlos Maiolino <cmaiolino@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 03, 2017 at 11:29:15AM +0200, Amir Goldstein wrote:
> On Fri, Dec 1, 2017 at 12:05 PM, yang xu <xuyang.jy@cn.fujitsu.com> wrote:
> > Currently ,freeze failure caused by the lack of space can not
> > guarantee to remount extN filesystem in read-only mode.
> > We can add a touch to trigger the action which aborts journal
> > and ro-remounts the fs.
> >
> > Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>

I saw failures occasionally on ext3/4 too.

> > ---
> >  tests/generic/459 |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/generic/459 b/tests/generic/459
> > index eb05fb8..197d729 100755
> > --- a/tests/generic/459
> > +++ b/tests/generic/459
> > @@ -132,9 +132,11 @@ ret=$?
> >  #      - The filesystem turns into Read-Only and reject further writes
> >  #      - The filesystem stays in Read-Write mode, but can be frozen/thawed
> >  #        without getting stuck.
> > -ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
> > -
> > -if [ $ret -ne 0 ]; then
> > +if [ $ret -ne 0 ]; then
> > +       # fsfreeze failed, filesystem should reject further writes and remount
> > +       # as readonly
> > +       touch $SCRATCH_MNT/newfile >/dev/null 2>&1
> > +       ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
> >         if [ -n "$ISRO" ]; then
> >                 echo "Test OK"
> >         else
> > --
> 
> The ro-remount behavior that this test is checking is not documented anywhere
> AFAIK nor is required from fs on failure to fsfreeze.
> It is also not related to the XFS bug this test is covering.
> 
> I do not object to keeping this ro-remount check nor to keep fixing it
> for other fs.
> Just pointing out the possibility to pass the test if fsfreeze failed
> regardless of
> ro-remount, which is a logical, but not required behavior from fs.

I tend to take this patch for now (with some comments edits), the
original ro-remount check is already there based on the actual behaviors
from different filesystems, if we see false failures on other
filesystems due to not-remount-ro or the expected behavior is documented
somewhere in the future, we can revisit the test then.

Thanks for the patch and review!

Eryu
