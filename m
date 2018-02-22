Received: from mx2.suse.de ([195.135.220.15]:42391 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933069AbeBVQGF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Feb 2018 11:06:05 -0500
Date: Thu, 22 Feb 2018 16:06:14 +0000
From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH v2 6/8] fsstress: implement the clonerange/deduperange
 ioctls
Message-ID: <20180222160614.t2afwtdsouxliqie@hermes.olymp>
References: <151314499003.18893.8687182548758898133.stgit@magnolia>
 <151314503583.18893.15475795025536691678.stgit@magnolia>
 <20171215020731.GM6896@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171215020731.GM6896@magnolia>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: eguan@redhat.com, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 14, 2017 at 06:07:31PM -0800, Darrick J. Wong wrote:

<snip>

> +void
> +clonerange_f(
> +	int			opno,
> +	long			r)
> +{

<snip>

> +	/* Calculate offsets */
> +	len =3D (random() % FILELEN_MAX) + 1;
> +	len &=3D ~(stat1.st_blksize - 1);
> +	if (len =3D=3D 0)
> +		len =3D stat1.st_blksize;
> +	if (len > stat1.st_size)
> +		len =3D stat1.st_size;
> +
> +	lr =3D ((__int64_t)random() << 32) + random();
> +	if (stat1.st_size =3D=3D len)
> +		off1 =3D 0;
> +	else
> +		off1 =3D (off64_t)(lr % MIN(stat1.st_size - len, MAXFSIZE));
> +	off1 %=3D maxfsize;
> +	off1 &=3D ~(stat1.st_blksize - 1);
> +
> +	/*
> +	 * If srcfile =3D=3D destfile, randomly generate destination ranges
> +	 * until we find one that doesn't overlap the source range.
> +	 */
> +	do {
> +		lr =3D ((__int64_t)random() << 32) + random();
> +		off2 =3D (off64_t)(lr % MIN(stat2.st_size + (1024 * 1024), MAXFSIZE)=
);
> +		off2 %=3D maxfsize;
> +		off2 &=3D ~(stat2.st_blksize - 1);
> +	} while (stat1.st_ino =3D=3D stat2.st_ino && llabs(off2 - off1) < len=
);

I started seeing hangs in generic/013 on cephfs.  After spending some
time looking, I found that this loops forever.  And the reason seems to
be that stat1.st_blksize is too big for this filesystem (4M) -- when
doing:

	off1 &=3D ~(stat1.st_blksize - 1);

off1 (and off2) will both end up with 0.  Does this make sense?  Would
something like:

-	off1 &=3D ~(stat1.st_blksize - 1);
+	if (stat1.st_blksize <=3D stat1.st_size)
+		off1 &=3D ~(stat1.st_blksize - 1);

be acceptable?  (and a similar change for off2, of course.)

Cheers,
--
Lu=EDs
