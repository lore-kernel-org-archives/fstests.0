Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3810A2C
	for <fstests@vger.kernel.org>; Wed,  8 May 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136617; cv=none; b=r9deeB+1qLPPOBKkjs2Yr3L8urB3+IrasKN51wimOSgDcVoGKCoGB24n5uWkJ2Uy9QPT0uNobYsUxq9DF0jKExsBBQO6xbr3S33nnq089iC5o898lZXD0fUw+DDUs7GuFqm8idm3+TcE71TjAisXBOK9jHmSQh5yree1mG88DR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136617; c=relaxed/simple;
	bh=AtxJW7W/dJnVkTBNH6tsstdzezz1LVhH/ea08XAI1rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1hqbUVd/xxxrQxVTpwwu1Ewh0hyX4u71c+1LhF3OVlgG7NYOUsJD7XmVzvnBq9e1c8KWVpO0bsX18RzQUbWzuLiwF03/c4YuyGhclKWB6ykuUrs/EqW1TQD2cN2KBw4TlPk+16kt/qMrnvi2/eagipj2ISwdKEWtxSKfMdCDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrI4QLUI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrI4QLUI"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so47213921fa.3
        for <fstests@vger.kernel.org>; Tue, 07 May 2024 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715136613; x=1715741413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpK/MucTLA9qJ51/MATOVSR0DjsdMqp8mEBNZuqi2cs=;
        b=hrI4QLUI7chDtNjeoEQb9JcD9bvnIpCDCdx3vaRwAKVc0oB+znnKuJk9pWNuO1rH8e
         Og2AAV4+ODZ0nXqx/IY2FYmHKJV/mBd6JqqdBhUjB/0AGAnRnKwGhKFXTiIbR6LWjHRy
         Zs+Is+7sz/MOY6y4WLPfbcNOF20mXuXaXiou4P3zpzEz4L++k2EXJVGLg+ck6MMlZwnX
         AqDLnmqdlpLroXZ+oCqbqZVYu0ZLWYNB28LhcHCSn1xDBkGQp+4y4neYwysk+PiYjiyC
         gr0wsldCefVnUD/UgORDh0tJ/AREO7DMVIiCqd5bhNQQzuSri/OJ9rogCKafsUoxZ5Ln
         VJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715136613; x=1715741413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpK/MucTLA9qJ51/MATOVSR0DjsdMqp8mEBNZuqi2cs=;
        b=Eo9J9IBZ36XiT+m2Ir7X9x9pCgigPMiR/AN7E9omcCV+pXsU25wcQgCGMEK18M8DcI
         JtgNLvlLVCSXM8DCr6Wnh4VSI+Y10ehkHaFGG//gJamjGg9kCz1ZIYYJoI+6NdxQCQoj
         8y2PqkFD5YZvauRrblz4NNN7OrEZB6YpfoYKROTh24BgWnMR868qeuNaEbW9000+s+IO
         sKralKiCVVt4xHpz5b/CUo4NIoFHPe+5r6YY9aLo5VhfWhgrprm0WIgs9ssSxBcx/tmm
         xC+4gRdZ4Pq7VWxUBWC8w/xsUte07t8CvNGNzQinMqTsgMPDEV00M7TCbLUEvl/YBOcz
         sj9g==
X-Forwarded-Encrypted: i=1; AJvYcCUDC3xl0/EK6Z5JO5VTsmbieK1ljh2rSnzKKi3BV/sxEEPr2k95s46exHC5/AOAMyaCooKBUmIRN8xgib+ejbykVcEFhiNjvw==
X-Gm-Message-State: AOJu0YzlRh+wISUTx0HYCkwtQVmImd4ALOj7TmKC35HEUQItzVktS5Gl
	m/tl1lfa9sGesmaiqCjrzSO1zIkdi3HDe93Ov3yYWUbcKSKPKF367mn4tlYpPWgP1zs5a+EXUXg
	kK6B7WHD762YScKf1+W9uRy61/o0=
X-Google-Smtp-Source: AGHT+IHaNdkNgcscpeuCfOEXv/Kc39hcGAcpcCj4GkbUUQ7EULFAkdsTMPPDM3X+WhA4YtrNdXhNLbQQXMnpLeENYik=
X-Received: by 2002:a2e:2c05:0:b0:2e3:4f79:4d26 with SMTP id
 38308e7fff4ca-2e447194930mr7652241fa.11.1715136613271; Tue, 07 May 2024
 19:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-2-kernel@pankajraghav.com> <20240507222323.GC2049409@frogsfrogsfrogs>
In-Reply-To: <20240507222323.GC2049409@frogsfrogsfrogs>
From: Ritesh Harjani <ritesh.list@gmail.com>
Date: Wed, 8 May 2024 08:20:01 +0530
Message-ID: <CALk7dXqCD2MDPavit0mkD061bEHTswFxuwbfPZuAuCtNcFAPFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, fstests@vger.kernel.org, gost.dev@samsung.com, 
	mcgrof@kernel.org, zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 3:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Mon, May 06, 2024 at 05:01:17PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > This test fails when xfs is formatted with 64k filesystem block size*.
> > It fails because the soft quota is not exceeded with the hardcoded 64k
> > pwrite, thereby, the grace time is not set. Even though soft quota is
> > set to 12k for uid1, it is rounded up to the nearest blocksize.
> >
> > *** Report for user quotas on device /dev/sdb3
> > Block grace time: 7days; Inode grace time: 7days
> >                         Block limits                File limits
> > User            used    soft    hard  grace    used  soft  hard  grace
> > ----------------------------------------------------------------------
> > 0        --       0       0       0      0       3     0     0      0
> > 1        --      64      64    1024      0       1     0     0      0
> > 2        --      64       0       0      0       1     0     0      0
> >
> > Adapt the pwrite to do more than 64k write when the FS blocksize is 64k=
.
> >
> > Cap the blksz to be at least 64k to retain the same behaviour as before
> > for smaller filesystem blocksizes.
> >
> > * This happens even on a 64k pagesize system and it is not related to
> >   LBS effort.
> >
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  tests/xfs/161 | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/xfs/161 b/tests/xfs/161
> > index 486fa6ca..94290f18 100755
> > --- a/tests/xfs/161
> > +++ b/tests/xfs/161
> > @@ -38,9 +38,15 @@ _qmount_option "usrquota"
> >  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
> >  _scratch_mount >> $seqres.full
> >
> > +min_blksz=3D65536
> > +file_blksz=3D$(_get_file_block_size "$SCRATCH_MNT")
> > +# Write more than one block to exceed the soft block quota limit.

Maybe we should improve this comment to -

# Write more than the soft block quota limit of 12k which is set later
via xfs_quota
# On 64k bs this will get rounded to the nearest blocksize which is 64k

> > +blksz=3D$(( 2 * $file_blksz))
> > +
> > +blksz=3D$(( blksz > min_blksz ? blksz : min_blksz ))
>
> If we don't set $min_blksize and always write (2 * $file_blksz) does the
> test still work?

I guess it won't (even for bs=3D4k), because we set the bsoft=3D12k via xfs=
_quota.
So we have to write more than 12k to trigger the grace timer.

-ritesh
