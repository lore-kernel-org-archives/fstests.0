Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2085146A75
	for <fstests@vger.kernel.org>; Fri, 12 Apr 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936667; cv=none; b=beEVWSLuvNeAF0fDchIzszA8AmYQjXB9EEoB8tlKjeuupwVUNG0woGdfsPR17InZBLDh1vQt/ZrLy2WkfPQHxhJqdUo+2Y7k+jrbvYK2hcI4jInh6kGL93gmc5+ERzULowBLfF6tIg/q+NXkHLSQWMgsqvUIRxlEc2uWqaAezKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936667; c=relaxed/simple;
	bh=enUQ+JStMDjd+Q0pF8O/Y7FGbASwnCgWi0iedbvfBCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOB3X+CeqKXOp+6hPYno+zB9RFQFEeSPal6WdPZK02PJvKZexQqw7iqDxvK3gY5FaKn8ccZPPB8qtL8WvB/cd0EngUNVoAkH/dnuDsmuApCjtUuEJkHwAGJpWWDBR08lTazOBcwwXHAew4ieRJx6/Va/glSWsWgqaHqkbOYl3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOrY2G6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOrY2G6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663B8C113CC;
	Fri, 12 Apr 2024 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712936667;
	bh=enUQ+JStMDjd+Q0pF8O/Y7FGbASwnCgWi0iedbvfBCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOrY2G6LPmVmkSPYWpx0fDjvdDZ+G7Ff80AL6A/2TZ9W8997/Eg298lv7VI0JxUe6
	 5W98uSre8MxAW6d3MWodrcMICqvvzDGlKV1uXVaMK7LTKrwJ+lfC5lDrtAZLmVS1uZ
	 YWmdJ6P4EwZ9QMUpWQfbjNGxTqiAzsi+JH1jXxuOYVAysUSpBrYKnYrN3ZukkpyKWv
	 H3Xw6mWxFT3EN7ShW8pnOOM1/acdJA99d5P7Xe2fagF6rsRphJw4AIOQzUv1GY5xuQ
	 1A6vg84RHeQ1/1sF0yZvRxdKnw1Kt8emjlIY3KsjmYaCo/mgtQMnqRnElLyRsi25/g
	 egVerrfCxEqEw==
Date: Fri, 12 Apr 2024 08:44:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/config: export TEST_DEV for mkfs.xfs
Message-ID: <20240412154426.GA11935@frogsfrogsfrogs>
References: <20240411063234.30110-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411063234.30110-1-ddiss@suse.de>

On Thu, Apr 11, 2024 at 04:32:33PM +1000, David Disseldorp wrote:
> As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
> attempts to create XFS filesystems sized under 300M fail, unless
> TEST_DIR, TEST_DEV and QA_CHECK_FS environment variables are exported
> (or a --unsupported mkfs parameter is provided).
> 
> TEST_DIR and QA_CHECK_FS are already exported, while TEST_DEV may only
> be locally set if provided via e.g. configs/$HOSTNAME.config. Explicitly
> export TEST_DEV to ensure that tests which call _scratch_mkfs_sized()
> with an fssize under 300M run normally.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 2a1434bb..4bd5650f 100644
> --- a/common/config
> +++ b/common/config
> @@ -932,6 +932,9 @@ else
>  fi
>  
>  _canonicalize_devices
> +# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
> +# and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
> +export TEST_DEV

I wonder if we only ought to do this for $FSTYP = xfs, but I don't have
a problem with this so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.35.3
> 
> 
