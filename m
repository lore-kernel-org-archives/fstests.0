Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795264065;
	b=tzKIzWkP9eGQrWI8Iz/uNC7IVqdHGcSu+gm8x/vxXg60MDibjEDe3QAbLbGlW6OQdJRA
	 d7reDU4qOjeVdDnZkwybh03hLpY4KsJN9n+FA3lnX5EPll7b0FXvoeGrnFbQpzdnwB+Dn
	 XhYn5qTDFzhTYXYQ10VBYnuKax3lxygoX0T61giZLY1HSXvokVCjm49klJXnrJGzghUqE
	 ov/9XIbKfhN0C9im6c3aGTDna48IXlQdedC4vsqVXAcjMBza4ILf/agGqhstwydaxkevP
	 IS4k3DruiMLLpGMfDac8JZJpYs7HpIK9gQ1abHxM2g9lPus7vA1w95oRtG9U9SchQlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264065;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=piJ7K8Zz5x7PoHs9wAFNjGyPr/KpkAvmJqOotHCP8lA=;
	b=cl10WUxNut4Pve4J3Zzez4ICwF0mkxiv26iyK2YAi9j6zQUF6bv55Kp4R7z9il8N7fzZ
	 G+YKxJYAELyVYl/MuAj11coqcTtcgAjMqJhXAu95tpj6ZEKiilM3SHai+oUrO0su/FduQ
	 YjLMnviB+czHo8V6uYDrO2C9PqKIA1sB729dMzdcxNZ8uH4fUdUeXZ7QqDYga3/Sx1YuH
	 NpZAWAMfzzPTmHTl1Wg3LJLiH7CDmaQPVV0F6gFgkpu4Z0gNLHjIsCl3WOg4NBfuFZIrm
	 UMSQ98/Kd2LNnA6TyKTQ2Ri8pIEJN2ZQ13cc7hbobkPRjmLwzPalBaTyUtdORHfAuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8clZubd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27F606A320
	for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8clZubd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F6F1F000C0;
	Sat, 21 Nov 2026 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264065;
	bh=piJ7K8Zz5x7PoHs9wAFNjGyPr/KpkAvmJqOotHCP8lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k8clZubd+44Gr80hIIOtNUfy/0umJUL1vcDkE0wlFwAg6Al045qZWKvfqlamOroMp
	 mXuu8DmtUuWGv93tw4xY3ZRzOXNZLCkMyMZzFy2Sn1mj+fC75D1iN2oXXplaOc4bVK
	 CQ017UCRhlTF5+6kmmSI5DOWf0IuVs/Re4QjbFd++1Jk+FoLNsqZIQNrT2kU6xvEzA
	 NbmogO5QBIvMA932K7WhNus2nJCKJLO7q8ysxQoI+QGMmwhK+AOepUZFFGbg/PPad3
	 fuvZ3Q/5a0Qy2CmjOU7vKSL+nxf8a/H+5rtdmzGzZ62DDmAvz9b34s7cbxc+DYOXdj
	 UzBppcGjdMovg==
Date: Sat, 21 Nov 2026 20:27:37 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, preichl@redhat.com
Subject: Re: [PATCH] xfs: add tests using xfs_admin to the admin group
Message-ID: <awGOJT8NneMmtluk@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests@vger.kernel.org, preichl@redhat.com
References: <20261119080729.3035971-2-aalbersh@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119080729.3035971-2-aalbersh@kernel.org>

On Thu, Nov 19, 2026 at 09:07:29AM +0100, Andrey Albershteyn wrote:
> So far, only xfs/156 and xfs/157 are in admin group. Let's include all
> the tests which use this script into the group. This script is not that
> complex, so, this increased coverage would help with testing '-g admin'.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/xfs/158 | 2 +-
>  tests/xfs/160 | 2 +-
>  tests/xfs/161 | 2 +-
>  tests/xfs/287 | 2 +-
>  tests/xfs/548 | 2 +-
>  tests/xfs/612 | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/xfs/158 b/tests/xfs/158
> index 89bf8c851659..7b218ec09486 100755
> --- a/tests/xfs/158
> +++ b/tests/xfs/158
> @@ -8,7 +8,7 @@
>  # everything works properly after the upgrade.
>  
>  . ./common/preamble
> -_begin_fstest auto quick inobtcount
> +_begin_fstest auto quick inobtcount admin
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/160 b/tests/xfs/160
> index 8cc784e7e1dc..d62b305e4d25 100755
> --- a/tests/xfs/160
> +++ b/tests/xfs/160
> @@ -8,7 +8,7 @@
>  # timestamps work properly after the upgrade.
>  
>  . ./common/preamble
> -_begin_fstest auto quick bigtime
> +_begin_fstest auto quick bigtime admin
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/161 b/tests/xfs/161
> index c35bcabb5eda..bcbc2f951f9d 100755
> --- a/tests/xfs/161
> +++ b/tests/xfs/161
> @@ -9,7 +9,7 @@
>  # commit 16b60cb9e315ed for this test to run properly; v4.06 should do.
>  
>  . ./common/preamble
> -_begin_fstest auto quick bigtime quota
> +_begin_fstest auto quick bigtime quota admin
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/287 b/tests/xfs/287
> index 4537b040f3cd..d8a1e5379721 100755
> --- a/tests/xfs/287
> +++ b/tests/xfs/287
> @@ -8,7 +8,7 @@
>  # xfs_db functionality
>  #
>  . ./common/preamble
> -_begin_fstest auto dump quota quick
> +_begin_fstest auto dump quota quick admin
>  
>  # Import common functions.
>  . ./common/quota
> diff --git a/tests/xfs/548 b/tests/xfs/548
> index af72885a9c6e..779db614c0e6 100755
> --- a/tests/xfs/548
> +++ b/tests/xfs/548
> @@ -8,7 +8,7 @@
>  # counters.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick metadata
> +_begin_fstest auto quick metadata admin
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/612 b/tests/xfs/612
> index 4bead570009a..5fc1d0813ac0 100755
> --- a/tests/xfs/612
> +++ b/tests/xfs/612
> @@ -7,7 +7,7 @@
>  # Check that we can upgrade v5 only features on a v4 file system
>  
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick admin
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.54.0
> 
