Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0E1DDD6
	for <fstests@vger.kernel.org>; Thu,  2 Nov 2023 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcrL98Mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B72C433C7;
	Thu,  2 Nov 2023 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698951549;
	bh=ZiO2lHEBYb1GPsbDe5Y568IrZA2/oX2TO88OoHKckfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OcrL98MvyAlY+K74zmxsvtG6BHlPfCP6B6eXl7EThlO8Y2PLU5kPAGaIgxKbZvVgg
	 IEe4ldph4veTKa1xp7Lkzw6CyZuvZzwgvLjnElnY0uzfPkkfL4dJq0QlIokDkHoxlB
	 zZQwR++82O82iHoVn7JY6Pw1I4x27ig1UimZ036yLr4AqlklpVpZgGT/I3c7fkWDWT
	 6p0aM8GvfofM+nZbfW5OMHDgh/ybvcFE++Ts220fBLyGVhe0kheXraj9EKHvxU40TM
	 GnktxZi+DbaHbfwmQUeQdGWPlLr3e2z14iWxWjIlh/zpoUeHIOtub+iN4UH1TG6SKf
	 sbJFzOGKpk3pg==
Message-ID: <f3c14dc1db7b4aa5d348cd0ccdfb63117c6e2d86.camel@kernel.org>
Subject: Re: [PATCH] generic/732: fix mount option munging
From: Jeff Layton <jlayton@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Yongcheng Yang <yoyang@redhat.com>
Date: Thu, 02 Nov 2023 14:59:07 -0400
In-Reply-To: <20231102080640.bntmfreb7t5rh4wp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231101-master-v1-1-08bbe2f83307@kernel.org>
	 <20231102080640.bntmfreb7t5rh4wp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 16:06 +0800, Zorro Lang wrote:
> On Wed, Nov 01, 2023 at 02:17:13PM -0400, Jeff Layton wrote:
> > With NFS in particular, we are usually testing with some mount options.
> > Ensure that we preserve those and just add "nosharecache" onto the end
> > of the string.
> >=20
> > Cc: Yongcheng Yang <yoyang@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  tests/generic/732 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/generic/732 b/tests/generic/732
> > index 785aac58f361..ae49152e42dc 100755
> > --- a/tests/generic/732
> > +++ b/tests/generic/732
> > @@ -40,7 +40,7 @@ mkdir -p $testdir1 $testdir2
> >  # Don't share the data and attribute caches among mount points for NFS=
.
> >  # This caching behavior is necessary to reproduce this issue as we're
> >  # checking the alignment of each mount point's own unique cache.
> > -[ "$FSTYP" =3D "nfs" ] && MOUNT_OPTIONS=3D"-o nosharecache"
> > +[ "$FSTYP" =3D "nfs" ] && MOUNT_OPTIONS=3D"$MOUNT_OPTIONS -o noshareca=
che"
>=20
> Good to me, and looks like the later option replaces the former one, if
> there're same options (e.g. -o sharecache -o nosharecache).
>=20
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>=20
>=20

Thanks, Zorro.

Now that I look more closely, I'm not sure this test will ever pass
properly on NFS. It's basically doing this:

client1: A/f -> B/f
client2: B/f -> A/f
client1: A/f -> B/f

...and the two clients aren't aware of the changes the other is making
(because they were mounted using -o nosharecache). The 3rd rename ends
up thinking that the B/f dentry is still positive, and the rename
syscall fails with EEXIST.

The really confusing bit is that this test passes against servers
running older kernels, because the rename response had the wrong change
info in it and that tricks the client into invalidating the directory
caches when it shouldn't need to do that.

We fixed that in fdd2630a7398 (nfsd: fix change_info in NFSv4 RENAME
replies), and now this test pretty reliably fails when testing against
modern nfsd.

We have some longer term plans to add support for directory delegations
eventually, which may make it easier to keep the caches more coherent,
in this situation, but until then we might want to skip this test.

--=20
Jeff Layton <jlayton@kernel.org>
