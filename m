Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F11EF38D
	for <fstests@vger.kernel.org>; Thu, 20 Mar 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457055; cv=none; b=r2+aWfJUn+u0dmByHuPQowceY7FlcMpQ+s1MNCiHSFMxfRo9X3LWvZmAZ93i6ipOcIXLMBFEkVjBZj4PC5WELrKAt9qxrC/kpZTUIEPGoluf5g4dyvsw1+xMPHfKsMusQM0WsfG7wYa7NjUQNslyDWQzbW/TpPn2WRn5tahnW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457055; c=relaxed/simple;
	bh=0DJbJvmprs4v1KMJTQ4/N5KDK8mBon5+XdUaYcUR3Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgiNSlSuGkBDNdadeBO6dcXlwDsWenmOJcBDpfjxvmhpJz71IRISm+oj3H/QC+FZHGeriiS2eff1/MtH1/d4g4ykhRa2UYK3MEZllfWH1AzrjW9EEggaUnDg9LSgDwVBU4a6xLf0+rP9ufWiDyB3WD58Pr5favqdasV4PtMobw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hecP7pNY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hecP7pNY"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so640313a12.1
        for <fstests@vger.kernel.org>; Thu, 20 Mar 2025 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742457051; x=1743061851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHiq8FCzKAdjqW2Xzc/D7zMb254QFKwbEGLKQQyqgSo=;
        b=hecP7pNYSGPvVlh6LAmCpNd0oML9pxqZQuOMC+Br5yB5WRJOy09J5QmfEv7UIY3qdJ
         dqftkI0NDG3dsPWJs2dR+Hy5BrENMX5E76smypyjLR4041iBm+a7scsgaTMghlvzDoWd
         /rvzAL+zht4Oqknku3nMp/Yscr3aR7TQBAmQS8iY6n0V05nY64R6gzKFgHruPQc16end
         lbupKkaAlO4tcHNFrqj034HiX7k8O0to10Xh8wf2WTbPgBmEihOgULITztyMQX+sMwiV
         ismgv2fpUA6JcgqF+Gcy5ieVmyq+Qa+ecsDCPkXoHxWYi/yEptbtuxbAmE2OFhfhp7H5
         U8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742457051; x=1743061851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHiq8FCzKAdjqW2Xzc/D7zMb254QFKwbEGLKQQyqgSo=;
        b=ZWPYg3xKxpFVBULGPUO7Q1GVW6gbBAs6YiWIBOOzTqEeILV73q17x6354BB9E08W5F
         I3JW3pDnLRhYpk4GT9vB9/6uG3t7h1brf6GCdjENEcDhYXjXN9kz5Lc91kIJ26kpbH9j
         CDtzhgbACgNorc3mcSXqfq0Ss4XW5woi7NV69iCYqR1sCHqV95qI7F2pHF12zTnD/MCy
         RGwqYHg4VRhHk+gar03BFrgqtr7oFZPeUtOMGn9xkug04HENDUZU7lGKNtvqDnpY9+xI
         9IEhmTsOpFHsFhC7k0WnyvAFKeOuRCbRnKJwNSQiXp1phKD3ppjfoMoJf65dtY8w/XYm
         QXBg==
X-Forwarded-Encrypted: i=1; AJvYcCW2b/0oDDDxQ+PmcaMDTjZjyS0MQWW/bImkMof5VlOO000ZrHJ4VthQ07NSdxFCDayfSW7Vf5Vv@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFD1pxYrnNzJm1Xrqytu6vqp9gUL7D1UIKjKh7esvEjo35XRS
	8ig+eMsR+qQTviI7OhF3RstTy2UhcW52zLrigA8WLB2pBNNWV42D3vaP4A8TIeeczv5fbJkbv/R
	iEsJTkWiQj+g7ZU1BHhx9HvH7ByFfuTOMHcQ=
X-Gm-Gg: ASbGnct3nSVMSdkuBudRDUBv1WMnRu5216P0yxgHatbPonKRMOqxcitz6wtP/HOkjYQ
	xmam+Ng+Z0aDTXw9HDpi56IesgEIuttl0Es+H6N7OByhKZu+cCBLkQw4vaIdwEcpi8fbB1OMN5a
	pBfQg0nYwcGvgfLqRREQJVQdl5pm6GD2T9PIT3
X-Google-Smtp-Source: AGHT+IHh73MaZNCxU5Ke7hkkOmhcRWC59SjeBiHGkqtvd9acBNNTKHAgasy04lPJ9ljyoVaQrvY2NZRcjQcGq5/Dtqs=
X-Received: by 2002:a05:6402:5206:b0:5eb:5eca:f1d with SMTP id
 4fb4d7f45d1cf-5eb9eedfabdmr2034854a12.7.1742457050360; Thu, 20 Mar 2025
 00:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu> <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319164410.GB1061595@mit.edu> <20250319200142.dmt2sz2jnotmyjeo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319233242.GC1079074@mit.edu> <20250320052539.k54w7kv6rz4gusu5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250320052539.k54w7kv6rz4gusu5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Mar 2025 08:50:39 +0100
X-Gm-Features: AQ5f1JoKtPoXvocpXErWgRf9g5V8yjAhLpBv1faPrbPG_zLBEpw_406uLfoRvAQ
Message-ID: <CAOQ4uxj-EPRLaLaK8iFWvzYXNdZH7Qub6Smh=UzJAq2Z3gN2Ew@mail.gmail.com>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/ overlayfs
To: Zorro Lang <zlang@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Eric Sandeen <sandeen@sandeen.net>, 
	Christian Brauner <brauner@kernel.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Wed, Mar 19, 2025 at 07:32:42PM -0400, Theodore Ts'o wrote:
> > On Thu, Mar 20, 2025 at 04:01:42AM +0800, Zorro Lang wrote:
> > > Fstests supports overlayfs testing with different underlying fs, for =
example
> > > if you want to test overlay with ext4, you can set local.config as:
> > >
> > >  FSTYP=3Dext4
> > >  TEST_DEV=3D/dev/sdb
> > >  TEST_DIR=3D/mnt/test
> > >  SCRATCH_DEV=3D/dev/sdc
> > >  SCRATCH_MNT=3D/mnt/scratch
> >
> > Yes, I know.   My test appliances has autmation around setting local.co=
nfig
> >
> > >
> > > then does:
> > > # mkfs.ext4 -F $TEST_DEV
> > > # mkfs.ext4 -F $SCRACH_DEV
> > > # mkdir /mnt/test
> > > # mkdir /mnt/scratch
> > > # ./check -overlay -g auto
> > >
> > > For more details you can refer to xfstests/README.overlay.
> > >
> > > Currently fstests only supports overlayfs testing as this, other fs, =
e.g. nfs,
> > > has to prepare nfs SCRATCH_DEV and TEST_DEV by the user. I'm thinking=
 about
> > > supporting other upper fs testing likes overlay (if it's helpful).
> >
> > I have automation that handles this, so I'm good:
> >
> > ./kvm-xfstests --primary-fstype xfs -c overlay/default -g auto
> >
> > My point was that might be the reason why it might be convenient for
> > the test generic/699 being in generic/ instead of overlay/, since it
> > means that people who are runing a large number of configs, e.g.:
> >
> > ./kvm-xfstests -c ext4/default,xfs/default,btrfs/default generic/699
> >
> > can easily test overlayfs with idmapping with different underlying
> > file systems.  (Note: this is where my automation will write to
> > local.config while iterating across different file system configs).
>
> Yeah, that's why I left this case in generic/, I thought Christian Braune=
r
> might want that -- "do this idmapped mount test on overlay, no matter he
> tests on each kind of underlying fs". So I cc Christian Brauner, to check
> if that's his purpose.
>

I don't think that's not the reason - the reason is that the integration of
idmapped tests and ./check -overlay is not trivial when overlayfs idmapped
mount are not supported.


> >
> > Is it worth regularly running generic/699 across multiple underyling
> > file systmes?  I dunno; I'll let other people chime in on it, since I
> > don't really use overayfs with idmapping myself, and I haven't
> > examined the code paths in question myself.
>

There is another generic test that "_require_extra_fs overlay" and is not
an "overlayfs test" - generic/631.

This test open codes mount -t overlay explicitly.

_overlay_mount_dirs was written as a helper for overlayfs tests
that run with ./check -overlay.

We could fix generic/699 with MOUNT_OPTIONS=3D"" _overlay_mount_dirs
Since there is not really much in this helper, my preference is to
open code mount -t overlay, but I don't mind the former.

Thanks,
Amir.
