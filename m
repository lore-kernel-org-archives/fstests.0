Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511402753E8
	for <fstests@vger.kernel.org>; Fri, 14 Feb 2025 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511996; cv=none; b=tBe1vlZfkEOF/Mb30n8/uhyH6LeqvTg/ekmeK6TJdGlleZWIA0iqFtYKo6CwC752RykI6PQW8bIwy1obSMw+XfLfQ6qqHVJuMUVF66axKC4153pTAyds+e/uxmtVoeWBfOTKqAK0DFp8Irib9+beNyDw6KZz0ezU4Ngzt7RwO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511996; c=relaxed/simple;
	bh=IzvsunMUO/Q7xCzth6qfZB0FSQ9hYgIAAb3k8lAwH5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fcwv9gLkEEgxZXRgvWnz0KGuPdlDN4TNyPjMAZX5HtL9zaFYckmwI6rUdjj8DEB23a9d2i0B9WWQ1/PvxNMY+rPfbi37Ib89/rlkcoHYTmyaG4+cBC3cErjRgPkQ+fj9sao3iy6GA/JMKmp2+pFK6TGUhsPvFSD0ckpCXI037IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEYvJAQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEYvJAQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E93C4CED1
	for <fstests@vger.kernel.org>; Fri, 14 Feb 2025 05:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739511995;
	bh=IzvsunMUO/Q7xCzth6qfZB0FSQ9hYgIAAb3k8lAwH5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NEYvJAQIeoJcRA/vUugKJJ+1j2JZe6WXQPcxR0jWnlbIiL6nykAv5NdQ7j0GowngI
	 H5QR/0t/ONobUnVGI2zaJK/XlYvlfEIZw+MBbyM3k1to3mNh0oJGy3uWyWizckrB2O
	 11fhsNzLDdznEARUtF5jSkO1+UPmS/b6MgkOrBF7aq3l/P1sdpuNyokf3mqFko9j0S
	 ue7jfM3lkF29GIi46g0Eq25M17L3tyFCBkd4vgK29RK5kkc0EaKywvwFJWzw3J8qn6
	 uJdWrs3T0Kj45IOxzvhMB8dtBMARpKde8aSGtB4iJjhTVqt7tmV0wfSwxWPVoIL7fN
	 +wElMW6nj6z+A==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2aa17010cbcso1342288fac.3
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 21:46:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkXL/s3tt+nBCnkrVEaPlh/ghjbDTx8RPUyarqXc8Cyx1w6SYt3n7fDZtOqdfyN3TKuaAZl50Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWnPlhAwSdUxZYR86oHw8QtqHfYW6/y20G+sWrWvUVUxQRocv
	aOfrkL/I6XAJwUgf0a8uKA5ffN9OSN/xZMGEiUV6cJkKwe2NqfuATKpg4gJcI/QqAcRyyWzp0B9
	jZxtb1Vx8pcFkFcqYfrO20jinjhc=
X-Google-Smtp-Source: AGHT+IHh2BzvUnmkYVHmvWDKevP0eSss489GVam2Uuw0vwc6Gn37kTuir42QLqPqsvl0RM/wUJHtx1SxrxGEVouIrL8=
X-Received: by 2002:a05:6870:d1c1:b0:2bc:7907:bea1 with SMTP id
 586e51a60fabf-2bc79083568mr730342fac.8.1739511995070; Thu, 13 Feb 2025
 21:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs> <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
 <f05f9875-1552-4d77-8403-7b191da24141@redhat.com> <20250214040220.GA21799@frogsfrogsfrogs>
In-Reply-To: <20250214040220.GA21799@frogsfrogsfrogs>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 14 Feb 2025 14:46:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-xUp2-BHpywB01EYKmnFej5=CP9+6tsUaUCGc40xC_CA@mail.gmail.com>
X-Gm-Features: AWEUYZkpyUoqZ4YTG5oDPio4yki9K1yZUngC4HlH1_QShOmesIKNFSSeLivE7tI
Message-ID: <CAKYAXd-xUp2-BHpywB01EYKmnFej5=CP9+6tsUaUCGc40xC_CA@mail.gmail.com>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:02=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Feb 13, 2025 at 09:17:28PM -0600, Eric Sandeen wrote:
> > On 2/13/25 2:50 PM, Eric Sandeen wrote:
> > > On 2/13/25 1:51 PM, Darrick J. Wong wrote:
> >
> > ...
> >
> > >>> +rm -f $TEST_DIR/testfile.$seq
> > >>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> > >>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
> > >>
> > >> When does the file not get created?
> > >
> > > In some unknown error case? ;)
> > > There's probably no reason for that test, though of course
> > > it's still expected to pass.
> > >
> > > In the various discussions of the exfat bug scattered around
> > > the internet people kept pointing out that "well, the file does
> > > get created" so I probably had that on my mind.
> >
> > To put a finer point on it, because I can't tell for sure - are
> > you asking me to take that test out?
>
> Nah, I was just wondering if there was something about the buggy exfat
> code that either prevented the file from being created, or if the bug
> was that the empty file got deleted after the zero-byte pwrite and I
> misunderstood what's going on.
>
> (IOWs I think this test is fine, but could the exfat maintainer
> clarify?)
File was not deleted due to a bug in exFAT. It has caused a
misunderstanding because exFAT returns an incorrect errno (-EFAULT)
from zero length write.

Thanks.
>
> --D
>
> > Thanks,
> > -Eric
> >
> >
