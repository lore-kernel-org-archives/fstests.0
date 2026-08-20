Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C698262FD0
	for <fstests@vger.kernel.org>; Thu, 20 Aug 2026 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236685; cv=none; b=pwRVoQ8mqcohvYE5PUZcPvUKCUmG6ohwx/UO+ooanFppiNcz7aSO6Kl4vwKu7nNQ/NqGrQ7ZSjacL1ZSK+PA7cTT5L4q3C9GjCnfohwqctsj2qRbYurgtAZ+36v0zgK3c3v8AnggYhtth4uxJsdClMXFsIXfeuUochQZU47t8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236685; c=relaxed/simple;
	bh=O3WZgejWzyplPePWY4JK6l96j2vd/AdfLKHS3mwc/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv52YuQAg8Mi+r/Q+WY/LN4gL2/yy3uZAlfxkdasseJhU0LmOyEwY9dBpGXaIsZurMtYDd5862wm00ukuHVWLLxSB3e1nHZKFNy0kgtjO/eJ3HiM7sy9xm3p2hE9n0/xlCYpwL7aZXT3Zy8zx7UN9OVzYKBzzRlRf7qP39JKqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QagHZN1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QagHZN1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6961F000E9;
	Thu, 20 Aug 2026 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236683;
	bh=Rarf94iPwjBcM/XbhLKspXOOakWeVpX8nCxCmHTeudg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QagHZN1pZwSug2SNLzFDWtaTsPimEvsK4fODRMxr4pAyya6EmQAnyPQeH9BH3xES6
	 aB7FZHgjSYxYTD5AlU4WXBvFNtRb/6G4IjYK22pikAN9R19tbG5aRgtcKnJ1F5Fvtt
	 gA2IyiHsZ0EM/a0NoGAyizFxMkUvwMPYPF73OFHazv/GGwF01Bez4A9rmYgSz2y/Vd
	 WFkPRLbn4LKAlx5Jia1K166YvxnDerKglmjcjyeH1Jfy/7wcJ0pwsgW/XaysMAIoZc
	 2MvQn93GN4ZVyYz71Pf1pisTfqHcXnPWGQ4XD1XXCH+ddWJK4lBGT6RNVwJv8zTrok
	 BuLTB2iRlT+0w==
Date: Thu, 20 Aug 2026 22:37:56 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/683: _require_chmod
Message-ID: <aocNwfDmKV4DB9M5@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@sandeen.net>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <a6e9a97f-295b-4bba-aaef-60af17e9c70a@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e9a97f-295b-4bba-aaef-60af17e9c70a@sandeen.net>

On Wed, Aug 19, 2026 at 03:32:01PM -0500, Eric Sandeen wrote:
> generic/683 uses chmod but does not _require_chmod, so filesystems
> like exfat fail.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Hi Eric,

So great to see you ! This patch makes sense to me. Actually, g/683 belongs
to the same group/patchset of SUID test cases as g/684 through g/688, and all
of them use chmod. If we need to add _require_chmod to g/683, I would suggest
adding it to all of them.

Thanks,
Zorro

> 
> diff --git a/tests/generic/683 b/tests/generic/683
> index 883905da..226d2758 100755
> --- a/tests/generic/683
> +++ b/tests/generic/683
> @@ -24,6 +24,7 @@ _cleanup()
>  # Modify as appropriate.
>  _require_user
>  _require_test
> +_require_chmod
>  verb=falloc
>  _require_xfs_io_command $verb
>  _require_congruent_file_oplen $TEST_DIR 65536
> 
