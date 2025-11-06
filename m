Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C433093CD
	for <fstests@vger.kernel.org>; Thu,  6 Nov 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419523; cv=none; b=JbuUfUWy2zGLoD2E22es7VFqME/T690tnZ/FcyOpUE331PDIITR8gsXtLVW02+kpXqq4P6wbW9c73jVJ5kv0Vvl1MnmoYlNC5Xo5kJdFJS/ud3+4aKNyNS3xMThSyfJyJ7S4GWbm9X8Hcu49tkwXV/JqVxdspTF0Gdajk9ysEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419523; c=relaxed/simple;
	bh=jZcI5+1Ss6TPvgkAAV76GUd62OE9+TiURdgHBGyzwoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srXERISAJE7ZvFTFWCqI+9V+4QCr/vzCKdWK+dCt2oh9v7+oCi1Rv+4SZYQJqwv8r4bkbNwsgMvTsGXWqhQDxpXqXbUtiLsVfcid3efVLd8qjadkYbIxP1Dk3npae+/tAkK+j+qmZSAAdic2G5YwJcNC4bjtdDd7JxNczpHDFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz6Qetui; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz6Qetui"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so988252a12.3
        for <fstests@vger.kernel.org>; Thu, 06 Nov 2025 00:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762419520; x=1763024320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck0m8wFZB9XcmaKq8dytQ0ONqq6wW9ZN3Xn7nrKuDWc=;
        b=Sz6QetuiUOHkA3tM+NddvSdrLzzIvP6a/nXsDbGgIdL56l1FE2G16HlcbU8kQ7PFLA
         HfMSQVIEcrsCnz/+YSltV/EHvolDeDWRC10b/XRskjSzE61iY6qDxDSSaBFc2IM4HCyq
         YnmVFnSY+7gslOmfhj7DAIydVezdn+1/AqgPUDUrjqDyHJqOuB4Zc/vhXcCO9pUcayiQ
         Xx+/j33PiEOVlTNfTjhn+ocM5j9Z8HXjN5Pv6J2Ow4N3FaBHZdPesil5a2LODYrj6hhj
         +pCMCg6QEm58dQEGpBnmYanvL3/HQeywq8Fgjy8nkYZpUSkFNWb1eXTH7xcj12VU1Cbm
         iY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419520; x=1763024320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck0m8wFZB9XcmaKq8dytQ0ONqq6wW9ZN3Xn7nrKuDWc=;
        b=SNIlCNBy0dFxKcqMngBS1EldrBICL+0utbxEGpdabwSBdrB1G+1TWNJx3DJpMSCXWC
         O3+4oy1vBcWOwrnObIDyD4QcpMazyL5NcPcOqQtLXPvm0S/u7fLKS6bubDWLEiWjsN6j
         hmJf0dHdKJskundlpsSw6E+Zuybmuq1dW+M/VMajfauOfm7erkqradxVecooi0TpxXy5
         iDj6MdwEEb9tIK/vlGX4lALBIEy5E9Axy+KoLccTuV6n99DhyqNISdB+/0RyXCGsdP30
         OcWB0bCgVSqPEGjvww63Xa8gDxgNmvScsJfSfcOZo/KQIIKl/Vt5XGZc+werk+BngDTT
         7HgA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0xpg9WpxKc29/q8m6VAwjm7FDC093B883KCrMa2An/VNTOfPnxb57GreaZD9k412w1NIjjx5@vger.kernel.org
X-Gm-Message-State: AOJu0YyDW4y3Fi4szV7olkRsUYevEaAnp5ruq+IL3UWpcMJkw1z5kuP4
	jYLvZkZTqR9CircbR40CsRhDrNF1gKR2hO/qJa41QLq7p9DjqzcZYVLDp1m9P40HFUEETeJLkVC
	WmePI9Q7iAgo2y50u1Dedj9IE2l1FIv3kmt6B4d9B9Q==
X-Gm-Gg: ASbGncvJSZ/Z/Ypt+Jl1zXavTs0nUAkyTmmxr3yBfjlOKNKC8bqLqbUhKDldDLmsW4U
	o1h7kBdX+vCg0ltPNsiQ4dmX6Foq0XOpHrqca1Hz4Qno3ATQ0R58Wt+FJwww0jprbi2kqXTBDuQ
	pil2sPyorUGfNlCqGueeS0GX435qVv3ErZqBa7lCPp7A0RSEGt94h/zAUxZngCSIEye7aDrTvW6
	da5az8WG4iUqMuMfFMjquRc5DoW2sqYjhEA+FjGEtS6XLT1PD8X/zVPU//X/vfnJD7xMqJN2C7a
	sd0DpPcMtqeIE5do3KI=
X-Google-Smtp-Source: AGHT+IEHawD1xB6GQmLFykw+yW+B52duLhBw9u10AbP5tS5Ky2pbjNedqdkSkvdgV804kceaE8LvNF0HWEEdMMxXtws=
X-Received: by 2002:a05:6402:4301:b0:634:ab36:3c74 with SMTP id
 4fb4d7f45d1cf-641058bbcafmr5577723a12.9.1762419519709; Thu, 06 Nov 2025
 00:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com> <20251105225355.GC196358@frogsfrogsfrogs>
In-Reply-To: <20251105225355.GC196358@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 09:58:28 +0100
X-Gm-Features: AWmQ_bl5E-AoHE-1AuDyZsQmdfkMyiI2gUbeKfvAWpOXmZ3IVywzlGkMPg_nxeA
Message-ID: <CAOQ4uxjC+rFKrp3SMMabyBwSKOWDGGpVR7-5gyodGbH80ucnkA@mail.gmail.com>
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:53=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> > On Wed, Oct 29, 2025 at 2:22=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > It would be useful to be able to run fstests against the userspace
> > > ext[234] driver program fuse2fs.  A convention (at least on Debian)
> > > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> > > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > > disk-based filesystem type XXX.
> > >
> > > Therefore, we'll adopt the practice of setting FSTYP=3Dfuse.ext4 to
> > > test ext4 with fuse2fs.  Change all the library code as needed to han=
dle
> > > this new type alongside all the existing ext[234] checks, which seems=
 a
> > > little cleaner than FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4, which also woul=
d
> > > require even more treewide cleanups to work properly because most
> > > fstests code switches on $FSTYP alone.
> > >
> >
> > I agree that FSTYP=3Dfuse.ext4 is cleaner than
> > FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4
> > but it is not extendable to future (e.g. fuse.xfs)
> > and it is still a bit ugly.
> >
> > Consider:
> > FSTYP=3Dfuse.ext4
> > MKFSTYP=3Dext4
> >
> > I think this is the correct abstraction -
> > fuse2fs/ext4 are formatted that same and mounted differently
> >
> > See how some of your patch looks nicer and naturally extends to
> > the imaginary fuse.xfs...
>
> Maybe I'd rather do it the other way around for fuse4fs:
>
> FSTYP=3Dext4
> MOUNT_FSTYP=3Dfuse.ext4
>

Sounds good. Will need to see the final patch.

> (obviously, MOUNT_FSTYP=3D$FSTYP if the test runner hasn't overridden it)
>
> Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
> /proc/mounts.  The only weirdness with that is that some of the helpers
> will end up with code like:
>
>         case $FSTYP in
>         ext4)
>                 # do ext4 stuff
>                 ;;
>         esac
>
>         case $MOUNT_FSTYP in
>         fuse.ext4)
>                 # do fuse4fs stuff that overrides ext4
>                 ;;
>         esac
>
> which would be a little weird.
>

Sounds weird, but there is always going to be weirdness
somewhere - need to pick the least weird result or most
easy to understand code IMO.

> _scratch_mount would end up with:
>
>         $MOUNT_PROG -t $MOUNT_FSTYP ...
>
> and detecting it would be
>
>         grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"
>
> Hrm?

Those look obviously nice.

Maybe the answer is to have all MOUNT_FSTYP, MKFS_FSTYP
and FSTYP and use whichever best fits in the context.

Thanks,
Amir.
