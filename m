Received: from mail-yw1-f65.google.com ([209.85.161.65]:44399 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfAVDdb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 22:33:31 -0500
Received: by mail-yw1-f65.google.com with SMTP id b63so8840355ywc.11
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 19:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20190119024258.6864-1-zlang@redhat.com> <20190119024258.6864-2-zlang@redhat.com>
 <20190121224412.GE4205@dastard>
In-Reply-To: <20190121224412.GE4205@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 22 Jan 2019 05:33:19 +0200
Message-ID: <CAOQ4uxjjGuNKWXmNKGq_7+ckkYm9ERF+Mne-jdvJY8r-4YzkZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore output
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 22, 2019 at 12:44 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Jan 19, 2019 at 10:42:58AM +0800, Zorro Lang wrote:
> > After fsstress has new operation, xfs/068 has different dump output,
> > so change the expected number of files and directories.
> >
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/068.out | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/xfs/068.out b/tests/xfs/068.out
> > index fa3a5523..f9ec37b8 100644
> > --- a/tests/xfs/068.out
> > +++ b/tests/xfs/068.out
> > @@ -22,7 +22,7 @@ xfsrestore: session id: ID
> >  xfsrestore: media ID: ID
> >  xfsrestore: searching media for directory dump
> >  xfsrestore: reading directories
> > -xfsrestore: 383 directories and 1335 entries processed
> > +xfsrestore: 416 directories and 1373 entries processed
>
> Shouldn't you tell fsstress to avoid this new operation so none of
> the tests that rely on the number of files created by a specific
> fstress seed break?
>
> i.e. changing FSSTRESS_AVOID in common/dump as is done already to
> turn off dedupe/clone/copy_file_range for xfsdump/restore tests?
>

IIRC, dedupe/clone/copy_file_range were blacklisted not for not
changing golden output, but because they make the golden output
dependent on xfs reflink feature (i.e. on mkfs options).

This is not the case with the newly added SPLICE operation and
updating the golden output rather than blacklisting the new operation
is what was decided and done two times in recent history (also patches
by Zorro).

Thanks,
Amir.
