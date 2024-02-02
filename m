Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA6141990
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876412; cv=none; b=TKoX6VWGBRdcBmHJT+TweK+TaXQNJM/+8iUdsGSGGZq7ww3U3n3ntamRhubEueFQdNsMwkuPKj8cupgKhDcR4Roxsu8oBooVIlrSjN9hqfId5ivqWSbGe+XoroRdg2ePIHM7Plk0kis9hri2b2sh3XnwZBrajYfEcGXaA5iPrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876412; c=relaxed/simple;
	bh=tbufM01LMGev4Pg+LbNrac1oVsvR6Ipue9czRk3ZHGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhGkuFtKgyBUENxsgU/3k8k2J0Rxr8QHZh70BPRp210gtPifmAKLAIQy96OdYMDLgctXnMdKYHlGB46he6KqUv5OIP2zESXLxFTufRqJ1NN3qy8ctdCLotRcR2kIlR6FwfOK6/4mZ/qMJurikIZnjnvGJSDdZTurSrNDw/a/KEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4XxVnHS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4XxVnHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706876409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWPDTjGrjhjMNJrQTp58AfSW6I+1SdSuSRFkFXF1+8I=;
	b=W4XxVnHStTEzTGzOa1OjXNN2S49p7lAzjOOjDtee9ubXRlnDRXIUd/8VaYgfIUKlePLFtA
	SB7yrEspWcDZk9zDOR4j76uUBJliT8+mQ9gUsexenyx+2wwW2vCTGvTxIxbQaHf7by92Oy
	BmKbHp1gAYcHA/ahT14YvLz70DdaK5E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-WbKMfugaMVmZF2-RRohW8g-1; Fri, 02 Feb 2024 07:20:08 -0500
X-MC-Unique: WbKMfugaMVmZF2-RRohW8g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55fbf844bacso987694a12.1
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 04:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876407; x=1707481207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWPDTjGrjhjMNJrQTp58AfSW6I+1SdSuSRFkFXF1+8I=;
        b=ZauQ7Mo4RHpkjQZ0CxGeWkublM5slNGzDJTca0GLn+GBQcGe4xP6THB2O5cefwnJMN
         hV84PKGR5DaZMrANDUemIbbnsa850KrxMQjghBHgxKEQ5f/LWtYcTTvdalSN217Z7Eq+
         yyPEjHKDMKx1TMa08r5AcZ11bMENdwEwb09pHK1tQTo2UCQNmoValIL3O1SKr8zCf++M
         utqVrhnfKckXH+KrTX5OXwwewshgTp8ybessAxDCF4RuHUwWlnMpdidOLe9ZkKqY9K9D
         IK3dW8gJyPgTHtCEj1Vt6TW54h2RrncX2k4zLSnYbgbdp0eYtzYHntK0QOzi9o20gGa0
         X1lQ==
X-Gm-Message-State: AOJu0YyKSussp6mt91/n5OusEuG9JRnkC1m8XySF9YQWTPnOHDf2a1ba
	2wf4w7uQLL7sEf3zmqqFcowdCGCVT3YuQM13ORlsV3uvB2hIFBzG0BTPuj13BNZ2voDgixGu2NW
	gbV7Hm2p8pRnaX7tP5Sw8MbId7rLAWmhFmOJSM7sMe4eJAEP79YJcHdaj6s9GDmIdudwVTRQ9ns
	Azy8mrUjLIdADZxv0q5ytlwTcC1Sc73Q==
X-Received: by 2002:aa7:d658:0:b0:55f:fe5f:318d with SMTP id v24-20020aa7d658000000b0055ffe5f318dmr723320edr.34.1706876405571;
        Fri, 02 Feb 2024 04:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR4U7ivvBycWNkO9vjimzq3Qe8mpE2HwujRdVJU5dpg0VqWAIR99pGP56VZelEw+1aGxYD6xcwsZ7wOl2LnIE=
X-Received: by 2002:aa7:d658:0:b0:55f:fe5f:318d with SMTP id
 v24-20020aa7d658000000b0055ffe5f318dmr723287edr.34.1706876404908; Fri, 02 Feb
 2024 04:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>
 <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 2 Feb 2024 07:19:53 -0500
Message-ID: <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: Zorro Lang <zlang@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zorro,

On Fri, Feb 2, 2024 at 7:04=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Thu, Feb 01, 2024 at 12:10:44PM -0500, Jeff Layton wrote:
> > On Mon, 2023-09-25 at 16:18 -0400, Alexander Aring wrote:
> > > This patch adds fcntl corner cases that was being used to confirm iss=
ues
> > > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > > implementation and in those corner cases issues was being found and
> > > fixed.
> > >
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > > changes since v2:
> > > - move fcntl tests into one fcntl c file
> > > - remove ofd and same owner tests, should be reflected by only one te=
st
> > > - simplify commit message (remove testname out of it)
> > > - add error messages in fcntl.c to give more information if an error
> > >   occur
> > >
> > >  src/Makefile          |   3 +-
> > >  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/generic/732     |  32 +++++
> > >  tests/generic/732.out |   2 +
> > >  4 files changed, 358 insertions(+), 1 deletion(-)
> > >  create mode 100644 src/fcntl.c
> > >  create mode 100755 tests/generic/732
> > >  create mode 100644 tests/generic/732.out
> > >
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 2815f919..67f936d3 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -19,7 +19,8 @@ TARGETS =3D dirstress fill fill2 getpagesize holes =
lstat64 \
> > >     t_ofd_locks t_mmap_collision mmap-write-concurrent \
> > >     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > >     t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> > > -   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test
> > > +   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
> > > +   fcntl
> >
> > I think this function needs a less-generic name than "fcntl". Other the
> > lock tests themselves look like a nice addition though.
>
> Yeah, the "fcntl" name is too "big", please rename it to show what it try=
s
> to test. Hi Alexander, you can tell me the new name you'd like to change,
> if you don't want to send a V2. That might help to catch the fstests rele=
ase
> of this weekend :)
>

I was thinking about "fcntl_corner_tests", if this is okay.

Thanks.

- Alex

