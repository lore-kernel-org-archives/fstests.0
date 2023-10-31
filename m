Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CC1A73C
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TviSicQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD5FC433CB
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698752672;
	bh=9/s5EZb7+QYF720fufqbIF67LpM65Ha3yx6618mShio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TviSicQCiL9VOWRj1sZlw4aBCxcxO/3aAMyLjHZf59wRxSBdjxOBV0OqPOmmXSw0t
	 aGyYB8idTiUdsgjIbnxR94rzwq/ta1jEd/wWDh0pcUYochyS8XmUGjp95+8Kbr7Qj/
	 TREf44XFD8SngT2xUvPdKOp3dB6xLrefEHG4LDIPVEF8O9oCG7Hf6kZYhUVuZYf+vz
	 Ax4pLodGBkAt4ffuhHa8xvacNm4EgYRtrgRZVIUk5z99+8jQEUvzLadmWmanSX9IIQ
	 EUTupVKfnmBGtMrkRZfV0q5OFqh6KElvrFveAlHOpFx8i8ZacHgfFuZoYf3H+VEB6p
	 s5Y5tYlPAy0EQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9936b3d0286so853826266b.0
        for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 04:44:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx7YohL3rKPw0gsWGRbQLA/k+IYlFGvjiQOzl7vjq15f7nAF9z+
	DQKK6hxGDm6owFvdxJgc3YUSJ+RVU6pTuz4OTzQ=
X-Google-Smtp-Source: AGHT+IGU1OfLk39/NaBDoZbOFgx2l1ZBIB6mBhK2Pj0FmIu4tx1SpnnRwmkHoR0qUyvpxuYooUT1jA4yhsdNFBfskU4=
X-Received: by 2002:a17:906:99c1:b0:9c7:4d98:9847 with SMTP id
 s1-20020a17090699c100b009c74d989847mr11541931ejn.53.1698752671018; Tue, 31
 Oct 2023 04:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031111027.3367136-1-kernel@pankajraghav.com>
In-Reply-To: <20231031111027.3367136-1-kernel@pankajraghav.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 31 Oct 2023 11:43:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5vTNDQkr5z+PEZu=wzDtjOfzQdBmHpj49BerWeFYgDvg@mail.gmail.com>
Message-ID: <CAL3q7H5vTNDQkr5z+PEZu=wzDtjOfzQdBmHpj49BerWeFYgDvg@mail.gmail.com>
Subject: Re: [PATCH] fstests: redirect stderr to stdout in generic/269 and xfs/051
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>, gost.dev@samsung.com, 
	mcgrof@kernel.org, djwong@kernel.org, fdmanana@suse.com, p.raghav@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:11=E2=80=AFAM Pankaj Raghav <kernel@pankajraghav=
.com> wrote:
>
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> A recent commit redirected the stdout from /dev/null to $seqres.full.
> That commit missed redirection of stderr to stdout which was present
> before.
>
> This leads to test failures as the stderr is going to the output:
>
> fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output erro=
r)
> fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output erro=
r)
> fsstress: check_cwd failure
> fsstress: check_cwd failure
>
> Redirection of stderr to stdout is still needed because fsstress can
> still return errors in generic/269 and xfs/051 as we inject enospc and
> shutdown the fs respectively. These tests only care about the fs
> consistency at the end.
>
> Add the removed 2>&1 back in these two tests.

Wasn't this already fixed in the for-next branch?

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-next=
&id=3Dbbeaf7d1cbf2db50549cdc95b4d2099748641b1c

>
> Fixes: f55e46d6 ("fstests: redirect fsstress' stdout to $seqres.full inst=
ead of /dev/null")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> There could be more tests that might be affected by this regression but
> I came across only these two when I ran the test for xfs.
>
>  tests/generic/269 | 2 +-
>  tests/xfs/051     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/generic/269 b/tests/generic/269
> index b852f6bf..eddca10d 100755
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -23,7 +23,7 @@ _workout()
>         out=3D$SCRATCH_MNT/fsstress.$$
>         args=3D`_scale_fsstress_args -p128 -n999999999 -f setattr=3D1 $FS=
STRESS_AVOID -d $out`
>         echo "fsstress $args" >> $seqres.full
> -       $FSSTRESS_PROG $args >> $seqres.full &
> +       $FSSTRESS_PROG $args >> $seqres.full 2>&1 &
>         pid=3D$!
>         echo "Run dd writers in parallel"
>         for ((i=3D0; i < num_iterations; i++))
> diff --git a/tests/xfs/051 b/tests/xfs/051
> index 1c670964..eca67bb8 100755
> --- a/tests/xfs/051
> +++ b/tests/xfs/051
> @@ -38,7 +38,7 @@ _scratch_mount
>
>  # Start a workload and shutdown the fs. The subsequent mount will requir=
e log
>  # recovery.
> -$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full &
> +$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full 2>&1 &
>  sleep 5
>  _scratch_shutdown -f
>  $KILLALL_PROG -q $FSSTRESS_PROG
> --
> 2.40.1
>
>
