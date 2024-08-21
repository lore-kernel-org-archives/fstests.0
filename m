Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9A1509A2
	for <fstests@vger.kernel.org>; Wed, 21 Aug 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260372; cv=none; b=rVarRDrvTJx+H7QkxuE7M6IaS41tfM5YHjAJtn3wrJou4lvtjyTMvlexos/C8srHpJNCHonZ/LPZMCu5bYh819rNZkH0ilaH0FbWjGOz6dMXiuRgjr+9OWDbG8DdiwpuHjpfn4jGR1g0JBhtaNWbIrQZA7YLGXdNfI1K5bJO0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260372; c=relaxed/simple;
	bh=XBWuyCPzktMTTkV4dYygfB64sYo/6fZ+Zje0Pd+SVAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njqFYs0i4fLKD9lZsokw3ARR0uR1ku4wx7VN8+H3SleOf0x7UIT2yp1A7bMbWRZCxKUyPx1MxYxWgAqp1jc41XPy+13NO/hRHhZRPB9NtQwJw1ET+QXKIf9D37CP0gRe184ZmXPaQpETMLTIwXINdrLBnL/UVR+40RMS+svli/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZw+0CIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZw+0CIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F17DC32781;
	Wed, 21 Aug 2024 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260372;
	bh=XBWuyCPzktMTTkV4dYygfB64sYo/6fZ+Zje0Pd+SVAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZw+0CIkZsv7LjhbShOGa5sTkHhC7TFRp6K2fAs/xywHFQiVL9Kj+JrXkXYd3q1g+
	 IPY75hiNedH2Edk7C0ZrNdghFCFYlV8oTQoP+Hhrmv3sbezVkbGd409nFAEqmp/HYI
	 zUrv7vBtB1UkB0l+cRn44ya9n9NxlgcK5oYToT2C7iuDV/YNnbVI1jJt0Zc50tnUSA
	 ZW621SceoADfQtKbbNZEa2am9LFT6H9H8ZIGdNXJRCuBNzePcXqLgBkPk7hczECRQ9
	 UgKNL4Yv1TVp+8r3MQzL9qEUmHpJgjzmTp7PRqbD/y8afFbMJeIH9lA7uLrg7ThJzh
	 H+gn8lk/xOevA==
Date: Wed, 21 Aug 2024 10:12:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
	kernel-dev@igalia.com, Miklos Szeredi <mszeredi@redhat.com>,
	Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/config: Correctly ignore {TEST|SCRATCH}_DEV for
 tmpfs
Message-ID: <20240821171251.GI6047@frogsfrogsfrogs>
References: <20240821155746.55828-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821155746.55828-1-andrealmeid@igalia.com>

On Wed, Aug 21, 2024 at 12:57:46PM -0300, André Almeida wrote:
> As per commit 264e5358e2c2 ("tmpfs: don't require {TEST|SCRATCH}_DEV"),
> tmpfs doesn't need TEST or SCRATCH devices due to being a RAM-based
> filesystem.
> 
> Fix the check by comparing the content of the variable TEST_DEV, instead
> of comparing with the string TEST_DEV. Same for SCRATCH_DEV.
> 
> Fixes: 264e5358e2c2 ("tmpfs: don't require {TEST|SCRATCH}_DEV")
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/config | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 22740c0a..307f93fb 100644
> --- a/common/config
> +++ b/common/config
> @@ -829,10 +829,10 @@ get_next_config() {
>  	fi
>  
>  	if [ "$FSTYP" == "tmpfs" ]; then
> -		if [ -z "TEST_DEV" ]; then
> +		if [ -z "$TEST_DEV" ]; then
>  			export TEST_DEV=tmpfs_test
>  		fi
> -		if [ -z "SCRATCH_DEV" ]; then
> +		if [ -z "$SCRATCH_DEV" ]; then
>  			export TEST_DEV=tmpfs_scratch
>  		fi
>  	fi
> -- 
> 2.46.0
> 
> 
