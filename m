Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64C1CAB3
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416232; cv=none; b=OwbCswtPMwk5+d14TNkFLxJgWaTpdx2RG9BnT6nt3OPPlCcGKLqh1CcMTdT5h2rPUH8Yi3Yrjrm1pQ4NwsK2ZIybFSUdIlQy59F9PZHNNUfyX4C1EXtCJaw+Zcithw70+gfCKkXC8XUtkPMrsjHnTAm9HZSYRTndCF3Jh3MYsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416232; c=relaxed/simple;
	bh=aDtzI1ss6d5C2N2WitXeg/V+PtxxiqOIzFuU+4319v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2ovHRKHF4R3KxDp0OObJNRNi011MNZ15EqWWdBDVCNdxTZIIyaAs8kxfkEcUHSPk0VgqMxA4Q1370SdKMR5yijY013WOBKgWTillu5Vi0uaCI+ccjMGbxclcmQDp2tqb0eH+YbiyNvrA4e82W6KgK8atvnGPSc2sjcWLMCXvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUyDWxcY; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUyDWxcY"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3d3710018so623737b6e.0
        for <fstests@vger.kernel.org>; Mon, 25 Mar 2024 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711416230; x=1712021030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUkZfSoyyRgVi9Ibcv5DCCrizuElkqisQVVgPts9D6w=;
        b=BUyDWxcYZ7dshtZPhsq19conUDFv0RaO+41GC7M9laQdGbVb7v4MkggLebr+Sdx+V1
         fVKmXptsJDNpv3YrDCT/vCD7s8CA/Uma6W4K9EAwUOADkNTmOmgY6dDZLBbBvKp/o2hI
         TW0tj9o3w/wG4je3lGAbDg9hH96T8pB96drCc7tHtSi2J4w8uIKWigq7qfRA9yshWT9G
         3rRPZ+E64toVnb3WjFOQUxuSyYJpfr8OcKZy+7QohpY+n6IP41uRAqaHHHKRKqFNuIUF
         viMBVXl4frNEsLSpAtrHCfPXd330++D9X3sC8o2bfHBv6LV6A3zw/DepN/5CLhqKF9JJ
         s4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711416230; x=1712021030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUkZfSoyyRgVi9Ibcv5DCCrizuElkqisQVVgPts9D6w=;
        b=QJr6VRMOM1VwXcY/tmmSXrj+FDNpTckMUOSm1e5Q+XrPqsjnOQBVfmJ4kL3gvDEFui
         nwRUsynFvZ7rEjs5UxR71TR2UFLZi/1dP0U0XD3Hv1FhRkyDv/FsuyRRciCNAZ2yonxA
         5HoLqpL2psqKNIhmTpFoCyVqNxzVLA7b8ZM9B6P3eDwoUP0nk4okwTGVm4uy7X3z2VOc
         E8stY4PJdVzQwv1l/2hNHIAy4FXJbH6Dgi8j8Sp7a83/PKLA3Og+Sn1kZxTng4HoEgKi
         2G5/WmpRKQ3Y+PzaVTy7r6AuD2bOWiOdb1tvhnz03mGgctbh1UipbwHXPA+DuaUW2gF2
         sC+g==
X-Gm-Message-State: AOJu0Yy94Z3CO+YAly7RjYqiL5O2y14t193v3gfdWBGC1PqDVqtOvRKp
	9eQ6EAfVrDKOfHzgFbPXo4sazejME+I9iMgjzB9Un66wVXWVzVB847MqPmLKWrVfE4F+vSFtGEF
	XGrs4995oYs8wyHTsfYICXkWm7EVgyEXw
X-Google-Smtp-Source: AGHT+IHjubo6yVfPmKc7AHC/NxEHNjAeqeGH/926CzvF3tlmwd4gm1ptKSWgW3aqc1u+nEdFHsQ4VHI/XbSdUXW/yoo=
X-Received: by 2002:a05:6870:8292:b0:221:9635:da6d with SMTP id
 q18-20020a056870829200b002219635da6dmr9614697oae.47.1711416229831; Mon, 25
 Mar 2024 18:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325175323.3450750-1-raj.khem@gmail.com> <20240326002050.GB6379@frogsfrogsfrogs>
In-Reply-To: <20240326002050.GB6379@frogsfrogsfrogs>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 25 Mar 2024 18:23:23 -0700
Message-ID: <CAMKF1srwrrOMA1ny02vbpXSrW9b1g4-JVOLfPh+-2nMw2naN9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] include libgen.h for basename API prototype
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:20=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Mar 25, 2024 at 10:53:22AM -0700, Khem Raj wrote:
> > basename prototype has been removed from string.h from latest musl [1]
> > compilers e.g. clang-18 flags the absense of prototype as error. theref=
ore
> > include libgen.h for providing it.
> >
> > [1] https://git.musl-libc.org/cgit/musl/commit/?id=3D725e17ed6dff4d0cd2=
2487bb64470881e86a92e7
>
> Same question as I had for your xfsdump patchset -- the manpage for
> basename(3) mentions that old glibc posix implementations would modify
> the argument.  Is that still true, or has that not been the case for
> long enough that it's ok not to care?

Thats posix basename's behavior and its still true. If we depend on
GNU basename behavior then
it can be an issue in that case, I will make a copy of the string to
pass to basename to avoid this

>
> --D
>
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > ---
> >  src/splice-test.c                   | 1 +
> >  src/stat_test.c                     | 1 +
> >  src/t_ext4_dax_inline_corruption.c  | 1 +
> >  src/t_ext4_dax_journal_corruption.c | 1 +
> >  src/t_mmap_collision.c              | 1 +
> >  5 files changed, 5 insertions(+)
> >
> > diff --git a/src/splice-test.c b/src/splice-test.c
> > index eb863673..7b7094f5 100644
> > --- a/src/splice-test.c
> > +++ b/src/splice-test.c
> > @@ -11,6 +11,7 @@
> >  #include <unistd.h>
> >  #include <fcntl.h>
> >  #include <err.h>
> > +#include <libgen.h>
> >
> >  #include <stdlib.h>
> >  #include <stdio.h>
> > diff --git a/src/stat_test.c b/src/stat_test.c
> > index 95cfdc4f..77e1acdd 100644
> > --- a/src/stat_test.c
> > +++ b/src/stat_test.c
> > @@ -4,6 +4,7 @@
> >   * Written by David Howells (dhowells@redhat.com)
> >   */
> >
> > +#include <libgen.h>
> >  #include <stdarg.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline=
_corruption.c
> > index e1a39a6c..a40c5df5 100644
> > --- a/src/t_ext4_dax_inline_corruption.c
> > +++ b/src/t_ext4_dax_inline_corruption.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2018 Intel Corporation. */
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <libgen.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journ=
al_corruption.c
> > index ba7a96e4..53be10c2 100644
> > --- a/src/t_ext4_dax_journal_corruption.c
> > +++ b/src/t_ext4_dax_journal_corruption.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2018 Intel Corporation. */
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <libgen.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
> > index c872f4e2..d9315fcf 100644
> > --- a/src/t_mmap_collision.c
> > +++ b/src/t_mmap_collision.c
> > @@ -15,6 +15,7 @@
> >   */
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <libgen.h>
> >  #include <pthread.h>
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > --
> > 2.44.0
> >
> >
