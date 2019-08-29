Received: from mx1.redhat.com ([209.132.183.28]:43456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfH2B3Q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Aug 2019 21:29:16 -0400
Date: Thu, 29 Aug 2019 09:36:04 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2 2/2] iomap: partially revert 4721a601099 (simulated
 directio short read on EFAULT)
Message-ID: <20190829013604.GQ7239@dhcp-12-102.nay.redhat.com>
References: <20181202180832.GR8125@magnolia>
 <20181202181045.GS8125@magnolia>
 <CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com>
 <20190828142332.GT1037422@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190828142332.GT1037422@magnolia>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>, Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>, jencce.kernel@gmail.com, linux-xfs <linux-xfs@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, cluster-devel <cluster-devel@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 28, 2019 at 07:23:32AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 21, 2019 at 10:23:49PM +0200, Andreas Gr=FCnbacher wrote:
> > Hi Darrick,
> >=20
> > Am So., 2. Dez. 2018 um 19:13 Uhr schrieb Darrick J. Wong
> > <darrick.wong@oracle.com>:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > >
> > > In commit 4721a601099, we tried to fix a problem wherein directio r=
eads
> > > into a splice pipe will bounce EFAULT/EAGAIN all the way out to
> > > userspace by simulating a zero-byte short read.  This happens becau=
se
> > > some directio read implementations (xfs) will call
> > > bio_iov_iter_get_pages to grab pipe buffer pages and issue asynchro=
nous
> > > reads, but as soon as we run out of pipe buffers that _get_pages ca=
ll
> > > returns EFAULT, which the splice code translates to EAGAIN and boun=
ces
> > > out to userspace.
> > >
> > > In that commit, the iomap code catches the EFAULT and simulates a
> > > zero-byte read, but that causes assertion errors on regular splice =
reads
> > > because xfs doesn't allow short directio reads.  This causes infini=
te
> > > splice() loops and assertion failures on generic/095 on overlayfs
> > > because xfs only permit total success or total failure of a directi=
o
> > > operation.  The underlying issue in the pipe splice code has now be=
en
> > > fixed by changing the pipe splice loop to avoid avoid reading more =
data
> > > than there is space in the pipe.
> > >
> > > Therefore, it's no longer necessary to simulate the short directio,=
 so
> > > remove the hack from iomap.
> > >
> > > Fixes: 4721a601099 ("iomap: dio data corruption and spurious errors=
 when pipes fill")
> > > Reported-by: Amir Goldstein <amir73il@gmail.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > ---
> > > v2: split into two patches per hch request
> > > ---
> > >  fs/iomap.c |    9 ---------
> > >  1 file changed, 9 deletions(-)
> > >
> > > diff --git a/fs/iomap.c b/fs/iomap.c
> > > index 3ffb776fbebe..d6bc98ae8d35 100644
> > > --- a/fs/iomap.c
> > > +++ b/fs/iomap.c
> > > @@ -1877,15 +1877,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_=
iter *iter,
> > >                                 dio->wait_for_completion =3D true;
> > >                                 ret =3D 0;
> > >                         }
> > > -
> > > -                       /*
> > > -                        * Splicing to pipes can fail on a full pip=
e. We have to
> > > -                        * swallow this to make it look like a shor=
t IO
> > > -                        * otherwise the higher splice layers will =
completely
> > > -                        * mishandle the error and stop moving data.
> > > -                        */
> > > -                       if (ret =3D=3D -EFAULT)
> > > -                               ret =3D 0;
> > >                         break;
> > >                 }
> > >                 pos +=3D ret;
> >=20
> > I'm afraid this breaks the following test case on xfs and gfs2, the
> > two current users of iomap_dio_rw.
>=20
> Hmm, I had kinda wondered if regular pipes still needed this help.
> Evidently we don't have a lot of splice tests in fstests. :(
>=20
> > Here, the splice system call fails with errno =3D EAGAIN when trying =
to
> > "move data" from a file opened with O_DIRECT into a pipe.
> >=20
> > The test case can be run with option -d to not use O_DIRECT, which
> > makes the test succeed.
> >=20
> > The -r option switches from reading from the pipe sequentially to
> > reading concurrently with the splice, which doesn't change the
> > behavior.
> >=20
> > Any thoughts?
>=20
> This would be great as an xfstest! :)

JFYI, I added splice operation into fsstress, and I tried to add splice o=
peration
into xfs_io long time ago:

https://marc.info/?l=3Dlinux-xfs&m=3D155828702128047&w=3D2

But it haven't been merged. If you have any suggestion, please feel free =
to
review it:)

Thanks,
Zorro

>=20
> Do you have one ready to go, or should I just make one from the source
> code?
>=20
> --D
>=20
> > Thanks,
> > Andreas
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > #define _GNU_SOURCE
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <sys/wait.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <err.h>
> >=20
> > #include <stdlib.h>
> > #include <stdio.h>
> > #include <stdbool.h>
> > #include <string.h>
> > #include <errno.h>
> >=20
> > #define SECTOR_SIZE 512
> > #define BUFFER_SIZE (150 * SECTOR_SIZE)
> >=20
> > void read_from_pipe(int fd, const char *filename, size_t size)
> > {
> >     char buffer[SECTOR_SIZE];
> >     size_t sz;
> >     ssize_t ret;
> >=20
> >     while (size) {
> >         sz =3D size;
> >         if (sz > sizeof buffer)
> >             sz =3D sizeof buffer;
> >         ret =3D read(fd, buffer, sz);
> >         if (ret < 0)
> >             err(1, "read: %s", filename);
> >         if (ret =3D=3D 0) {
> >             fprintf(stderr, "read: %s: unexpected EOF\n", filename);
> >             exit(1);
> >         }
> >         size -=3D sz;
> >     }
> > }
> >=20
> > void do_splice1(int fd, const char *filename, size_t size)
> > {
> >     bool retried =3D false;
> >     int pipefd[2];
> >=20
> >     if (pipe(pipefd) =3D=3D -1)
> >         err(1, "pipe");
> >     while (size) {
> >         ssize_t spliced;
> >=20
> >         spliced =3D splice(fd, NULL, pipefd[1], NULL, size, SPLICE_F_=
MOVE);
> >         if (spliced =3D=3D -1) {
> >             if (errno =3D=3D EAGAIN && !retried) {
> >                 retried =3D true;
> >                 fprintf(stderr, "retrying splice\n");
> >                 sleep(1);
> >                 continue;
> >             }
> >             err(1, "splice");
> >         }
> >         read_from_pipe(pipefd[0], filename, spliced);
> >         size -=3D spliced;
> >     }
> >     close(pipefd[0]);
> >     close(pipefd[1]);
> > }
> >=20
> > void do_splice2(int fd, const char *filename, size_t size)
> > {
> >     bool retried =3D false;
> >     int pipefd[2];
> >     int pid;
> >=20
> >     if (pipe(pipefd) =3D=3D -1)
> >         err(1, "pipe");
> >=20
> >     pid =3D fork();
> >     if (pid =3D=3D 0) {
> >         close(pipefd[1]);
> >         read_from_pipe(pipefd[0], filename, size);
> >         exit(0);
> >     } else {
> >         close(pipefd[0]);
> >         while (size) {
> >             ssize_t spliced;
> >=20
> >             spliced =3D splice(fd, NULL, pipefd[1], NULL, size, SPLIC=
E_F_MOVE);
> >             if (spliced =3D=3D -1) {
> >                 if (errno =3D=3D EAGAIN && !retried) {
> >                     retried =3D true;
> >                     fprintf(stderr, "retrying splice\n");
> >                     sleep(1);
> >                     continue;
> >                 }
> >                 err(1, "splice");
> >             }
> >             size -=3D spliced;
> >         }
> >         close(pipefd[1]);
> >         waitpid(pid, NULL, 0);
> >     }
> > }
> >=20
> > void usage(const char *argv0)
> > {
> >     fprintf(stderr, "USAGE: %s [-rd] {filename}\n", basename(argv0));
> >     exit(2);
> > }
> >=20
> > int main(int argc, char *argv[])
> > {
> >     void (*do_splice)(int fd, const char *filename, size_t size);
> >     const char *filename;
> >     char *buffer;
> >     int opt, open_flags, fd;
> >     ssize_t ret;
> >=20
> >     do_splice =3D do_splice1;
> >     open_flags =3D O_CREAT | O_TRUNC | O_RDWR | O_DIRECT;
> >=20
> >     while ((opt =3D getopt(argc, argv, "rd")) !=3D -1) {
> >         switch(opt) {
> >         case 'r':
> >             do_splice =3D do_splice2;
> >             break;
> >         case 'd':
> >             open_flags &=3D ~O_DIRECT;
> >             break;
> >         default:  /* '?' */
> >             usage(argv[0]);
> >         }
> >     }
> >=20
> >     if (optind >=3D argc)
> >         usage(argv[0]);
> >     filename =3D argv[optind];
> >=20
> >     printf("%s reader %s O_DIRECT\n",
> >            do_splice =3D=3D do_splice1 ? "sequential" : "concurrent",
> >            (open_flags & O_DIRECT) ? "with" : "without");
> >=20
> >     buffer =3D aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
> >     if (buffer =3D=3D NULL)
> >         err(1, "aligned_alloc");
> >=20
> >     fd =3D open(filename, open_flags, 0666);
> >     if (fd =3D=3D -1)
> >         err(1, "open: %s", filename);
> >=20
> >     memset(buffer, 'x', BUFFER_SIZE);
> >     ret =3D write(fd, buffer, BUFFER_SIZE);
> >     if (ret < 0)
> >         err(1, "write: %s", filename);
> >     if (ret !=3D BUFFER_SIZE) {
> >         fprintf(stderr, "%s: short write\n", filename);
> >         exit(1);
> >     }
> >=20
> >     ret =3D lseek(fd, 0, SEEK_SET);
> >     if (ret !=3D 0)
> >         err(1, "lseek: %s", filename);
> >=20
> >     do_splice(fd, filename, BUFFER_SIZE);
> >=20
> >     if (unlink(filename) =3D=3D -1)
> >         err(1, "unlink: %s", filename);
> >=20
> >     return 0;
> > }
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
