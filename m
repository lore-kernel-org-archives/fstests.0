Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C93D92
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3RvIx6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE931C433C7;
	Sun,  5 Nov 2023 20:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699216514;
	bh=qnrGtSegoQTETxZi3s770TVSB0xrNHoa6J92+tI39Pw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=A3RvIx6ka5jyqjZmxvH4Nz5aacujWGatNAcR+YGGeIoReXHUFISt8cipematAhYse
	 0p0pyv9gI2RGL3W2B1Uj3eHj2jZFmmOx9lRQN/XsqoHmaXp8m/hcLaqMjOEc2c7iJV
	 OB4wdCCKKFEv9LK+OpihdKouJHpEXMqOOJN6pefLLl7SM0rTGSY6ceWtXJs49JvTlC
	 poa2GRg74/EbybEuZb185R4uCY0bELurWFK4dDyYT+nEbYpTm8LyaSc4qMCTFLJeUr
	 PhP5EbCbrs0gODr7W0Tn/FeqZ4MMZYA4YqHBvXMP5edTy3pd30tkNn45/eS1991iAc
	 SuV7jn4kGZf0A==
Message-ID: <ffd368c39361682f98cf7bffbc421744946853e2.camel@kernel.org>
Subject: Re: [PATCH] generic/732: fix mount option munging
From: Jeff Layton <jlayton@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Yongcheng Yang <yoyang@redhat.com>
Date: Sun, 05 Nov 2023 15:35:12 -0500
In-Reply-To: <20231105184352.j7u526d4kyjmwhm3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231101-master-v1-1-08bbe2f83307@kernel.org>
	 <20231102080640.bntmfreb7t5rh4wp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	 <f3c14dc1db7b4aa5d348cd0ccdfb63117c6e2d86.camel@kernel.org>
	 <20231105184352.j7u526d4kyjmwhm3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-06 at 02:43 +0800, Zorro Lang wrote:
> On Thu, Nov 02, 2023 at 02:59:07PM -0400, Jeff Layton wrote:
> > On Thu, 2023-11-02 at 16:06 +0800, Zorro Lang wrote:
> > > On Wed, Nov 01, 2023 at 02:17:13PM -0400, Jeff Layton wrote:
> > > > With NFS in particular, we are usually testing with some mount opti=
ons.
> > > > Ensure that we preserve those and just add "nosharecache" onto the =
end
> > > > of the string.
> > > >=20
> > > > Cc: Yongcheng Yang <yoyang@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  tests/generic/732 | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/tests/generic/732 b/tests/generic/732
> > > > index 785aac58f361..ae49152e42dc 100755
> > > > --- a/tests/generic/732
> > > > +++ b/tests/generic/732
> > > > @@ -40,7 +40,7 @@ mkdir -p $testdir1 $testdir2
> > > >  # Don't share the data and attribute caches among mount points for=
 NFS.
> > > >  # This caching behavior is necessary to reproduce this issue as we=
're
> > > >  # checking the alignment of each mount point's own unique cache.
> > > > -[ "$FSTYP" =3D "nfs" ] && MOUNT_OPTIONS=3D"-o nosharecache"
> > > > +[ "$FSTYP" =3D "nfs" ] && MOUNT_OPTIONS=3D"$MOUNT_OPTIONS -o nosha=
recache"
> > >=20
> > > Good to me, and looks like the later option replaces the former one, =
if
> > > there're same options (e.g. -o sharecache -o nosharecache).
> > >=20
> > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > >=20
> > >=20
> >=20
> > Thanks, Zorro.
> >=20
> > Now that I look more closely, I'm not sure this test will ever pass
> > properly on NFS. It's basically doing this:
> >=20
> > client1: A/f -> B/f
> > client2: B/f -> A/f
> > client1: A/f -> B/f
> >=20
> > ...and the two clients aren't aware of the changes the other is making
> > (because they were mounted using -o nosharecache). The 3rd rename ends
> > up thinking that the B/f dentry is still positive, and the rename
> > syscall fails with EEXIST.
> >=20
> > The really confusing bit is that this test passes against servers
> > running older kernels, because the rename response had the wrong change
> > info in it and that tricks the client into invalidating the directory
> > caches when it shouldn't need to do that.
>=20
> Hi Jeff,
>=20
> Thanks for this information.
>=20
> Do you mean this case tests passed on nfs due to a bug, and that bug
> will be fixed soon?
>=20

It has already been fixed (fdd2630a7398).

This is a bit of a confusing bug. It turns out that in one specific
case, that patch actually helps a test somewhat similar to this to pass,
but in most cases, having that bug fixed will make this test fail on NFS
(and that behavior is expected, if not ideal).

The real problem is that this is trying to test the behavior of the
NFSv4 change attribute, but that value isn't directly observable from
userland today. All you can do is try to infer its effect on the cache,
which is also impossible to observe directly.

> I remember yoyang@ wrote this case for a known nfs issue. And this case
> tests passed on most filesystems. If it won't be suitable for newer nfsd,
> can we change it for new nfs? Or _notrun it by someone condition?
>=20
> >=20
> > We fixed that in fdd2630a7398 (nfsd: fix change_info in NFSv4 RENAME
> > replies), and now this test pretty reliably fails when testing against
> > modern nfsd.
> >=20
> > We have some longer term plans to add support for directory delegations
> > eventually, which may make it easier to keep the caches more coherent,
> > in this situation, but until then we might want to skip this test.
>=20
> Is there any chance (change it a bit) to make this case still works for n=
fs?
>=20

Sure: You could wait out the dircache timeout (60s) between rename
calls. See acdirmin/acdirmax mount options too, which could be used to
lower those timeouts to make the test run more quickly. But...if you're
using those mount options, you wouldn't hit the original bug that this
is was trying to test in the first place.

It's probably better to just skip this on NFS. This would probably be a
better test done via pynfs rather than xfstests, since that would allow
you to directly observe that the change attribute changes when you
expect it to.
--=20
Jeff Layton <jlayton@kernel.org>
