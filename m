Received: from mx2.suse.de ([195.135.220.15]:46501 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752408AbdEHJh1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 May 2017 05:37:27 -0400
Date: Mon, 8 May 2017 10:37:23 +0100
From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH] src/seek_sanity_test: ensure file size is big enough
Message-ID: <20170508093723.tck7rst7mgtu7nff@hermes.olymp>
References: <20170505145723.13582-1-lhenriques@suse.com>
 <20170508085234.GV7250@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170508085234.GV7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, "Yan, Zheng" <ukernel@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Mon, May 08, 2017 at 04:52:34PM +0800, Eryu Guan wrote:
> On Fri, May 05, 2017 at 03:57:23PM +0100, Luis Henriques wrote:
> > Tests test07, test08, and test09 preallocate a file and assume the fi=
le
> > size used is bigger than 10xbufsz (100xbufsz for test09).  This patch
> > adjusts the file size so this assumption is always true.
> >=20
> > As an example, here's test06 output for cephfs, where the allocation =
size
>                         ^^^^^^ meant test07?

ups, yeah I did.

> > is set to 4194304, and the output is (4194304 * 10 + 4194304)
> >=20
> >   07. Test file with unwritten extents, only have dirty pages
> >   07.01 SEEK_HOLE expected 0 or 4194304, got 46137344.              F=
AIL
> >   07.02 SEEK_HOLE expected 1 or 4194304, got 46137344.              F=
AIL
> >=20
> > (Note: The test will be skipped if an integer overflow occurs.)
> >=20
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > ---
> >  src/seek_sanity_test.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> > index a6dd48cc257b..41da59801212 100644
> > --- a/src/seek_sanity_test.c
> > +++ b/src/seek_sanity_test.c
> > @@ -282,6 +282,13 @@ static int test09(int fd, int testnum)
> >  	int bufsz =3D alloc_size;
> >  	int filsz =3D 8 << 20;
> > =20
> > +	while ((filsz < (bufsz * 100 + bufsz)) && (filsz > 0))
> > +		filsz <<=3D 1;
> > +	if (filsz <=3D 0) {
> > +		fprintf(stdout, "Test skipped due to int overflow.\n");
> > +		return ret;
> > +	}
> > +
>=20
> Hmm, why not just set filsz to (bufsz * 100 + bufsz)? This works for me
> on XFS/ext4/btrfs and NFS, I guess it should work for cepthfs too?

Right, that should work too.  I've decided to keep it as a power of 2 as =
I
assumed the original author had a reason for using that value initially
(4Mb).  But yeah if no one objects, I'll submit v2 with your suggestion.

Cheers,
--
Lu=EDs

>=20
> Thanks,
> Eryu
>=20
> >  	/*
> >  	 * HOLE - unwritten DATA in dirty page - HOLE -
> >  	 * unwritten DATA in writeback page
> > @@ -338,6 +345,13 @@ static int test08(int fd, int testnum)
> >  	int bufsz =3D alloc_size;
> >  	int filsz =3D 4 << 20;
> > =20
> > +	while ((filsz < (bufsz * 10 + bufsz)) && (filsz > 0))
> > +		filsz <<=3D 1;
> > +	if (filsz <=3D 0) {
> > +		fprintf(stdout, "Test skipped due to int overflow.\n");
> > +		return ret;
> > +	}
> > +
> >  	/* HOLE - unwritten DATA in writeback page */
> >  	/* Each unit is bufsz */
> >  	buf =3D do_malloc(bufsz);
> > @@ -387,6 +401,13 @@ static int test07(int fd, int testnum)
> >  	int bufsz =3D alloc_size;
> >  	int filsz =3D 4 << 20;
> > =20
> > +	while ((filsz < (bufsz * 10 + bufsz)) && (filsz > 0))
> > +		filsz <<=3D 1;
> > +	if (filsz <=3D 0) {
> > +		fprintf(stdout, "Test skipped due to int overflow.\n");
> > +		return ret;
> > +	}
> > +
> >  	/* HOLE - unwritten DATA in dirty page */
> >  	/* Each unit is bufsz */
> >  	buf =3D do_malloc(bufsz);
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
