Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D12309EED
	for <fstests@vger.kernel.org>; Thu,  6 Nov 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419792; cv=none; b=rLJED1JBMABliX1K1LLQEKS5iUEpTessZuI10JNsIM6chlaezwLIDq+rbx/8l+1PipL6bN7PvHsFamO0TxmClPWmlwi3NxC7DWlhqyhGfaFcq9OG5OASkMeSz74UKymvueay5/wH+uQQUc87p1PUvpvq7pC0Gmb/RSSjLLRPQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419792; c=relaxed/simple;
	bh=0EKAehxKkI/bTw9WUORbVkGz8/nS+B2Kso4BX+bmOcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXjcVDWebTFlaj6PXGv+gykzWNGw2PDDwxbtRnJt1ANAdf+YnfHUhGeuKDHJkBc/bhGZru+8U4H6cnC4cwqonhXjtdL3wnI683nEjB1ZkDH+a+BB06ajm6eKP87qyPGJ4CfgJiO1zZFS/cMGu15Y/yGAYmlwuuj8XjlJqXC9yxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYTuwoHs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYTuwoHs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64034284521so1067582a12.1
        for <fstests@vger.kernel.org>; Thu, 06 Nov 2025 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762419789; x=1763024589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veIj9WdBpJJNLGbbTumRAOZ1DVwrSRtT1QGKYvneLtE=;
        b=WYTuwoHswTDQdrk2J9Byqj7f/Husd4nnYTfT5hDwYM9qbNvMrqzk3jWBqpFf5pF9IZ
         xzOtmQrbMenNPXGpT4RowxdsBgEo6JvsQhAR1wbpO//4K7gzZeCyE75Wpf/NeEP4k/iT
         VbQO44VulP2dMtkPiivIc/uRMrYO5qbcx3rNe471ERaRKb1SVvMz61pm5UKvSAA8D7nb
         AR9GSbYzwdw5ZQYPqfoAuRZLbkUTooohJKnjOjfmLeJ8srPqEDgBSge2sJx/uMciNPgf
         d+gF5HL/2mL8yg1lylzuq1scROxUHlX2IhXfKjGIl0dm+8hGFrkqvkcp1z69l1Jgf0Y2
         5KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419789; x=1763024589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veIj9WdBpJJNLGbbTumRAOZ1DVwrSRtT1QGKYvneLtE=;
        b=CVZV/Kzj9TPl3zRwSa8v+4/zP8CU2VZpiGdIVIdb0ydgX6uLhPcXXTI2/TFvV4DN+b
         5azwcARgmuWu4gBcFz75iXE0KuLXcyH9ZmU4M859lrNH9yiyPzKeRVTZRNu17Seek2Iy
         YDyRMmqR/ISU6QvMcKX3ppS4hQIK8Y5LaLBFs+d3m6/jvdBw5PjXi2qpKAM2hcCV4ZQN
         Sa6dnmi5T91IdPLA4X0Oifzoq4faDSlVZ0SqF4u/tLVlubpgr5HiTSSePwAymOCAKWA/
         ruLTvyFsbAEn72wtJF3PXM/HLMy5dSOGwkQZV+B5bKIX+txV82Jhhm5gVL9JWNnRZPQ9
         ayNw==
X-Forwarded-Encrypted: i=1; AJvYcCW118cN0HFrGIzuYa8lJ124iKvX5ShM43tOQun4AKJ5rCYQr0gjL2kP3bSbg9o3tv0MTXzIbpaw@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmk5dIThIrH4uyQY2cfSZyQ7C0RZeoWJCSqcdv0EqoR8kmRuQ
	YMDnG85aEuLKhIP+Dqr86pzKZp/XnUohqirjQbN1nBAOFcFJG6TeM5PfPuXSLjfxq+xv/FkZCj1
	4kQFRUvySZdeZ/Gu/DFk+zRP3MLDH6JY=
X-Gm-Gg: ASbGncst/qYqWFD/VJeojb4aWlUImoR4H8d7QFlZHoJcrBi7LllBbtM2J2dbhh2lgGt
	dk98ONNPXM1plIEMRo4i9RuaioDcq3lYkNxcXpwV/GVQGZ0dj4AOBY4cYPY8MJ/SiJZ/NPPR2b9
	voGpElq9iE3zzkm+UzZUW7KEs7J5MROs16BIkIDVKp4yaSs3VNP5PQ6OZAXmOZdiPn4PDjOycyh
	attlvqGdQcMzbXML4CcQOpssUjtrifpU2onZPz4xlvLPK+cqtXNuq2S/6aQIvsF7/JeHLP2cKG4
	2FXeShAeVwftOXn9NifBCxI0L3FWJw==
X-Google-Smtp-Source: AGHT+IGzG4L1zsLSrPolVgz53k8qLjyW8wdBsccQu20dip4z2Ulliwm8dDW4Lw75AwMHZ0hiIPIToqA/2u2N+i4Tu34=
X-Received: by 2002:a05:6402:34c6:b0:640:abd5:8642 with SMTP id
 4fb4d7f45d1cf-64105a477d4mr5755119a12.21.1762419788438; Thu, 06 Nov 2025
 01:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
 <CAOQ4uxhgCqf8pj-ebUiC_HNG4VLyv7UEOausCt5Cs831_AnGUg@mail.gmail.com> <20251105225609.GD196358@frogsfrogsfrogs>
In-Reply-To: <20251105225609.GD196358@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 10:02:57 +0100
X-Gm-Features: AWmQ_bn2fAKjP1LvxTPOzsC5eSdfONWi8mVFNaKjNuG1RFoEXsyn3eS71zosukU
Message-ID: <CAOQ4uxhqVQYZvgNp=yN_u9rqoEw4wZ_YuAfwnpgrnduBruNMbg@mail.gmail.com>
Subject: Re: [PATCH 02/33] generic/740: don't run this test for fuse ext* implementations
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:56=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:59:00AM +0100, Amir Goldstein wrote:
> > On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > mke2fs disables foreign filesystem detection no matter what type you
> > > pass in, so we need to block this for both fuse server variants.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  common/rc         |    2 +-
> > >  tests/generic/740 |    1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 3fe6f53758c05b..18d11e2c5cad3a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1889,7 +1889,7 @@ _do()
> > >  #
> > >  _exclude_fs()
> > >  {
> > > -       [ "$1" =3D "$FSTYP" ] && \
> > > +       [[ $FSTYP =3D~ $1 ]] && \
> > >                 _notrun "not suitable for this filesystem type: $FSTY=
P"
> >
> > If you accept my previous suggestion of MKFSTYP, then could add:
> >
> >        [[ $MKFSTYP =3D~ $1 ]] && \
> >                _notrun "not suitable for this filesystem on-disk
> > format: $MKFSTYP"
> >
> >
> > >  }
> > >
> > > diff --git a/tests/generic/740 b/tests/generic/740
> > > index 83a16052a8a252..e26ae047127985 100755
> > > --- a/tests/generic/740
> > > +++ b/tests/generic/740
> > > @@ -17,6 +17,7 @@ _begin_fstest mkfs auto quick
> > >  _exclude_fs ext2
> > >  _exclude_fs ext3
> > >  _exclude_fs ext4
> > > +_exclude_fs fuse.ext[234]
> > >  _exclude_fs jfs
> > >  _exclude_fs ocfs2
> > >  _exclude_fs udf
> > >
> > >
> >
> > And then you wont need to add fuse.ext[234] to exclude list
> >
> > At the (very faint) risk of having a test that only wants to exclude ex=
t4 and
> > does not want to exclude fuse.ext4, I think this is worth it.
>
> I guess we could try to do [[ $MKFSTYP =3D~ ^$1 ]]; ?

Yeh of course, either that or [ $MKFSTYP =3D $1 ]
if we do not care to add pattern matching.

Thanks,
Amir.
