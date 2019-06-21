Received: from mail.kernel.org ([198.145.29.99]:52658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfFUKtK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Jun 2019 06:49:10 -0400
MIME-Version: 1.0
References: <20190619120624.9922-1-fdmanana@kernel.org> <20190621103642.GK15846@desktop>
In-Reply-To: <20190621103642.GK15846@desktop>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Jun 2019 11:48:57 +0100
Message-ID: <CAL3q7H4YqSZSdUo5zrFKjmtDEaOKak2YHVf9MR3y9WdXnE2xnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] generic/059: also test that the file's mtime and
 ctime are updated
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 21, 2019 at 11:36 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 01:06:24PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test as well that hole punch operations that affect a single file block
> > also update the file's mtime and ctime.
> >
> > This is motivated by a bug a found in btrfs which is fixed by the
> > following patch for the linux kernel:
> >
> >  "Btrfs: add missing inode version, ctime and mtime updates when
> >   punching hole"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/059 | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tests/generic/059 b/tests/generic/059
> > index e8cb93d8..fd44b2ea 100755
> > --- a/tests/generic/059
> > +++ b/tests/generic/059
> > @@ -18,6 +18,9 @@
> >  #
> >  #  Btrfs: add missing inode update when punching hole
> >  #
> > +# Also test the mtime and ctime properties of the file change after punching
> > +# holes with ranges that operate only on a single block of the file.
> > +#
> >  seq=`basename $0`
> >  seqres=$RESULT_DIR/$seq
> >  echo "QA output created by $seq"
> > @@ -68,6 +71,13 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
> >  # fsync log.
> >  sync
> >
> > +# Sleep for 1 second, because we want to check that the next punch operations we
> > +# do update the file's mtime and ctime.
> > +sleep 1
>
> Is this supposed to be after recording the initial c/mtime? i.e. moving
> it after c/mtime_before?

Either way is fine. Capturing the times right before or right after
the sleep, gives the same values as nothing changed the file.

Btw, I had noticed the other day that the second "echo" has
$mtime_after instead of $ctime_after (copy-paste mistake).
Do you want me to send a v2 fixing that typo, or you can do it
yourself when you pick the patch?

Thanks.
>
> Thanks,
> Eryu
>
> > +
> > +mtime_before=$(stat -c %Y $SCRATCH_MNT/foo)
> > +ctime_before=$(stat -c %Z $SCRATCH_MNT/foo)
> > +
> >  # Punch a hole in our file. This small range affects only 1 page.
> >  # This made the btrfs hole punching implementation write only some zeroes in
> >  # one page, but it did not update the btrfs inode fields used to determine if
> > @@ -94,5 +104,13 @@ _flakey_drop_and_remount
> >  echo "File content after:"
> >  od -t x1 $SCRATCH_MNT/foo
> >
> > +mtime_after=$(stat -c %Y $SCRATCH_MNT/foo)
> > +ctime_after=$(stat -c %Z $SCRATCH_MNT/foo)
> > +
> > +[ $mtime_after -gt $mtime_before ] || \
> > +     echo "mtime did not increase (before: $mtime_before after: $mtime_after"
> > +[ $ctime_after -gt $ctime_before ] || \
> > +     echo "ctime did not increase (before: $ctime_before after: $mtime_after"
> > +
> >  status=0
> >  exit
> > --
> > 2.11.0
> >
