Received: from userp2130.oracle.com ([156.151.31.86]:44068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfH2DMn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Aug 2019 23:12:43 -0400
Date: Wed, 28 Aug 2019 20:12:16 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 2/2] iomap: partially revert 4721a601099 (simulated
 directio short read on EFAULT)
Message-ID: <20190829031216.GW1037422@magnolia>
References: <20181202180832.GR8125@magnolia>
 <20181202181045.GS8125@magnolia>
 <CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com>
 <20190828142332.GT1037422@magnolia>
 <CAHpGcMLGWVssWAC1PqBJevr1+1rE_hj4QN27D26j7-Fp_Kzpsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHpGcMLGWVssWAC1PqBJevr1+1rE_hj4QN27D26j7-Fp_Kzpsg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>, jencce.kernel@gmail.com, linux-xfs <linux-xfs@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, cluster-devel <cluster-devel@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 28, 2019 at 04:37:59PM +0200, Andreas Gr=FCnbacher wrote:
> Am Mi., 28. Aug. 2019 um 16:23 Uhr schrieb Darrick J. Wong
> <darrick.wong@oracle.com>:
> > On Wed, Aug 21, 2019 at 10:23:49PM +0200, Andreas Gr=FCnbacher wrote:
> > > Hi Darrick,
> > >
> > > Am So., 2. Dez. 2018 um 19:13 Uhr schrieb Darrick J. Wong
> > > <darrick.wong@oracle.com>:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > >
> > > > In commit 4721a601099, we tried to fix a problem wherein directio=
 reads
> > > > into a splice pipe will bounce EFAULT/EAGAIN all the way out to
> > > > userspace by simulating a zero-byte short read.  This happens bec=
ause
> > > > some directio read implementations (xfs) will call
> > > > bio_iov_iter_get_pages to grab pipe buffer pages and issue asynch=
ronous
> > > > reads, but as soon as we run out of pipe buffers that _get_pages =
call
> > > > returns EFAULT, which the splice code translates to EAGAIN and bo=
unces
> > > > out to userspace.
> > > >
> > > > In that commit, the iomap code catches the EFAULT and simulates a
> > > > zero-byte read, but that causes assertion errors on regular splic=
e reads
> > > > because xfs doesn't allow short directio reads.  This causes infi=
nite
> > > > splice() loops and assertion failures on generic/095 on overlayfs
> > > > because xfs only permit total success or total failure of a direc=
tio
> > > > operation.  The underlying issue in the pipe splice code has now =
been
> > > > fixed by changing the pipe splice loop to avoid avoid reading mor=
e data
> > > > than there is space in the pipe.
> > > >
> > > > Therefore, it's no longer necessary to simulate the short directi=
o, so
> > > > remove the hack from iomap.
> > > >
> > > > Fixes: 4721a601099 ("iomap: dio data corruption and spurious erro=
rs when pipes fill")
> > > > Reported-by: Amir Goldstein <amir73il@gmail.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > ---
> > > > v2: split into two patches per hch request
> > > > ---
> > > >  fs/iomap.c |    9 ---------
> > > >  1 file changed, 9 deletions(-)
> > > >
> > > > diff --git a/fs/iomap.c b/fs/iomap.c
> > > > index 3ffb776fbebe..d6bc98ae8d35 100644
> > > > --- a/fs/iomap.c
> > > > +++ b/fs/iomap.c
> > > > @@ -1877,15 +1877,6 @@ iomap_dio_rw(struct kiocb *iocb, struct io=
v_iter *iter,
> > > >                                 dio->wait_for_completion =3D true=
;
> > > >                                 ret =3D 0;
> > > >                         }
> > > > -
> > > > -                       /*
> > > > -                        * Splicing to pipes can fail on a full p=
ipe. We have to
> > > > -                        * swallow this to make it look like a sh=
ort IO
> > > > -                        * otherwise the higher splice layers wil=
l completely
> > > > -                        * mishandle the error and stop moving da=
ta.
> > > > -                        */
> > > > -                       if (ret =3D=3D -EFAULT)
> > > > -                               ret =3D 0;
> > > >                         break;
> > > >                 }
> > > >                 pos +=3D ret;
> > >
> > > I'm afraid this breaks the following test case on xfs and gfs2, the
> > > two current users of iomap_dio_rw.
> >
> > Hmm, I had kinda wondered if regular pipes still needed this help.
> > Evidently we don't have a lot of splice tests in fstests. :(
>=20
> So what do you suggest as a fix?

(See below)

> > > Here, the splice system call fails with errno =3D EAGAIN when tryin=
g to
> > > "move data" from a file opened with O_DIRECT into a pipe.
> > >
> > > The test case can be run with option -d to not use O_DIRECT, which
> > > makes the test succeed.
> > >
> > > The -r option switches from reading from the pipe sequentially to
> > > reading concurrently with the splice, which doesn't change the
> > > behavior.
> > >
> > > Any thoughts?
> >
> > This would be great as an xfstest! :)
>=20
> Or perhaps something generalized from it.
>=20
> > Do you have one ready to go, or should I just make one from the sourc=
e
> > code?
>=20
> The bug originally triggered in our internal cluster test system and
> I've recreated the test case I've included from the strace. That's all
> I have for now; feel free to take it, of course.
>=20
> It could be that the same condition can be triggered with one of the
> existing utilities (fio/fsstress/...).

Hm, so I made an xfstest out of the program you sent me, and indeed
reverting that chunk makes the failure go away, but that got me
wondering -- that iomap kludge was a workaround for the splice code
telling iomap to try to stuff XXXX bytes into a pipe that only has X
bytes of free buffer space.  We fixed splice_direct_to_actor to clamp
the length parameter to the available pipe space, but we never did the
same to do_splice:

	/* Don't try to read more the pipe has space for. */
	read_len =3D min_t(size_t, len,
			 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
	ret =3D do_splice_to(in, &pos, pipe, read_len, flags);

Applying similar logic to the two (opipe !=3D NULL) cases of do_splice()
seem to make the EAGAIN problem go away too.  So why don't we teach
do_splice to only ask for as many bytes as the pipe has space here too?

Does the following patch fix it for you?

--D

From: Darrick J. Wong <darrick.wong@oracle.com>
Subject: [PATCH] splice: only read in as much information as there is pip=
e buffer space

Andreas Gruenbacher reports that on the two filesystems that support
iomap directio, it's possible for splice() to return -EAGAIN (instead of
a short splice) if the pipe being written to has less space available in
its pipe buffers than the length supplied by the calling process.

Months ago we fixed splice_direct_to_actor to clamp the length of the
read request to the size of the splice pipe.  Do the same to do_splice.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/splice.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..50335515d7c1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1101,6 +1101,7 @@ static long do_splice(struct file *in, loff_t __use=
r *off_in,
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset;
+	unsigned int pipe_pages;
 	long ret;
=20
 	ipipe =3D get_pipe_info(in);
@@ -1123,6 +1124,10 @@ static long do_splice(struct file *in, loff_t __us=
er *off_in,
 		if ((in->f_flags | out->f_flags) & O_NONBLOCK)
 			flags |=3D SPLICE_F_NONBLOCK;
=20
+		/* Don't try to read more the pipe has space for. */
+		pipe_pages =3D opipe->buffers - opipe->nrbufs;
+		len =3D min_t(size_t, len, pipe_pages << PAGE_SHIFT);
+
 		return splice_pipe_to_pipe(ipipe, opipe, len, flags);
 	}
=20
@@ -1180,8 +1185,13 @@ static long do_splice(struct file *in, loff_t __us=
er *off_in,
=20
 		pipe_lock(opipe);
 		ret =3D wait_for_space(opipe, flags);
-		if (!ret)
+		if (!ret) {
+			/* Don't try to read more the pipe has space for. */
+			pipe_pages =3D opipe->buffers - opipe->nrbufs;
+			len =3D min_t(size_t, len, pipe_pages << PAGE_SHIFT);
+
 			ret =3D do_splice_to(in, &offset, opipe, len, flags);
+		}
 		pipe_unlock(opipe);
 		if (ret > 0)
 			wakeup_pipe_readers(opipe);
