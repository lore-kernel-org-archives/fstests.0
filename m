Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815F1D69C
	for <fstests@vger.kernel.org>; Sun,  4 Feb 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051745; cv=none; b=S6Z4pceFuKX16wUGB9Hf0WH7RbhkuZOSuEktJAONDlqMbjRSM83oIyZ+k7/6h5p8yrLTAZpLPghQD/AIknDhYOx7MlXfI6kcq2L9Ma7Au9ADc1EYWHuLX//3VsAwXlXoYqZXjuyHbPthG3JlE7A5i39cFzcAXgQmdGfF0om+/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051745; c=relaxed/simple;
	bh=2lQxsMXetMmfPulv8VNxNiq4nllrdAS4HMkZOzSYxLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVjLRNt9osDeiYvLUJ/dPGkpI0u/LXBstsmmoCqDUYCLodYNLLwN+h8Ah5cSijrh3r2tQeWHzc/XgNqLjt3wu+lMTbLsjWUQg6PgggcLOWiXzAAbpmC0Ss4H/Re1eAaF+MsIWyLB/0cC1kDANyAyY6nnfoB47bii5YkfZXOMNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMrIJ/wW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMrIJ/wW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE42C433F1;
	Sun,  4 Feb 2024 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707051745;
	bh=2lQxsMXetMmfPulv8VNxNiq4nllrdAS4HMkZOzSYxLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMrIJ/wWPhr3h1A7DMhRDPBPSi0V2IaPdX4hLAY3UU6V4JUkixRWVXYuGafxemce7
	 5ONTi7KOpFWdT6tSld5vYrbfsRonMLgp5osaCyo699OkJMagYd/CszLbeSwbYkpKfI
	 D6ae+LGcsZhwIES7bWlDl0GfkGg7LjXNdET1LtFx+1naM32EgVNl9lCEuCZ0+5L7yW
	 CRBWo1Zaklg4NKMEyS7SubgbqaLMEUiqMx+OyEsRQdqVBi2ONaUQN5GbgZ9DJgwUvT
	 zIepYXoRZbd1CCzr9HYwN3Ny0mgfEOQ06A+52d1IVa9VZhpxnJErX74ujrrg4CkHb8
	 v/+BCtZAH28kw==
Date: Sun, 4 Feb 2024 21:02:21 +0800
From: Zorro Lang <zlang@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/597,598: Require groups
Message-ID: <20240204130221.um3r7gcljqjhywel@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240114095611.29401-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114095611.29401-1-richard@nod.at>

On Sun, Jan 14, 2024 at 10:56:11AM +0100, Richard Weinberger wrote:
> Moving to a new test bed is always fun.
> Forgot to add group fsgqa2 and tests 597, 598 failed.
> 
> generic/597       - output mismatch (see /root/xfstests-dev/results//generic/597.out.bad)
>     --- tests/generic/597.out   2024-01-14 08:55:20.176084268 +0000
>     +++ /root/xfstests-dev/results//generic/597.out.bad 2024-01-14 09:41:15.548729962 +0000
>     @@ -2,13 +2,17 @@
>      == Test symlink follow protection when
>      == process != link owner and dir owner != link owner
>      fs.protected_symlinks = 0
>     +chown: invalid group: 'fsgqa2:fsgqa2'
>      successfully followed symlink
>      fs.protected_symlinks = 1
>     +chown: invalid group: 'fsgqa2:fsgqa2'
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/597 | 2 ++
>  tests/generic/598 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tests/generic/597 b/tests/generic/597
> index ff985ca61915..a3035489aea3 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -32,8 +32,10 @@ _require_test
>  _require_sysctl_variable fs.protected_symlinks
>  _require_sysctl_variable fs.protected_hardlinks
>  _require_user fsgqa2
> +_require_group fsgqa2
>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa
> +_require_group fsgqa
>  _require_symlinks
>  
>  OWNER=fsgqa2
> diff --git a/tests/generic/598 b/tests/generic/598
> index 769c1b1a1ad9..31b7fde48868 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -32,8 +32,10 @@ _require_test
>  _require_sysctl_variable fs.protected_regular
>  _require_sysctl_variable fs.protected_fifos
>  _require_user fsgqa2
> +_require_group fsgqa2
>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa
> +_require_group fsgqa
>  _require_chmod
>  
>  USER1=fsgqa2
> -- 
> 2.26.2
> 
> 
