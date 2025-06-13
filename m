Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93123DE
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772992; cv=none; b=oJrXo/pixA54EQ67bdJCX2KA6D0qD7QsYEAdZh2nNPEoXwmFcC4jfLYBdtXUo6TSyB74A30iT1hikJzuvbx60Yb+2AjEZwLUc0bdi7mW7LrjyNitWS4+YslOhOHvCpiRA+Jv3fbN451r3n9AbHXA+sTQJmJaAWmS7lF/g6bPjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772992; c=relaxed/simple;
	bh=Y1VCsTPyOOdJkZTTEEVnjOaxai2qHehzGz4nr6Yowzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdYj2bsqmrTamjrHoJqfvz4PfYPYDqFfJNBP5GoxQpQ4WeF7Z3ophihLjseAqHP9zecN3ukC9MRFKtjbFLQrumezA4tBHULe0rPSfNhxIV9inwIYTTErs3DfsOBToD3IUigUGxMBmj2NmL5HCWmIwmstRsI1ok8ygnQAXE32vCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUr7Znxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUr7Znxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8047C4CEEA;
	Fri, 13 Jun 2025 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749772991;
	bh=Y1VCsTPyOOdJkZTTEEVnjOaxai2qHehzGz4nr6Yowzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUr7Znxx3ALoogB01FPrLglbyLOsPYxgMrL3/ycqOKGwbtLq0RnlaZo1BY25hCVzg
	 cwyDYxlCGHzKfmJpRM33WNn3VfTQKJKMaZBWkg7ZZL/ljtzaED3+3SkJXcFpEaJyPI
	 7Z0TInQ+pJM/fZ3dVljnFA5GSKt43jeCuRUs80cKtVoZorcRQBHF1iOknV81mBcdCE
	 apM4t+ntZfPUEa1P40LAOr9ueCvgpL4Oa0JdKVPPtB5+7/EY/7LJ/R5H0oP3mhvIJt
	 yq7LtMCXuO1sB6l1sP4p6BJIamJ/QvOryvSuBZKy8D4uMhFA8SErQaqcyAADlS18Jz
	 t+ve+vGVPaXDQ==
Date: Thu, 12 Jun 2025 17:03:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] src/fill2: fix segfault during fopen error cleanup
Message-ID: <20250613000311.GU6143@frogsfrogsfrogs>
References: <20250612190513.8669-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612190513.8669-1-ailiop@suse.com>

On Thu, Jun 12, 2025 at 09:05:13PM +0200, Anthony Iliopoulos wrote:
> When fill2 fails to open the output file (e.g. due to ENOSPC), it jumps
> into the cleanup code where it attempts to call fclose, and this causes
> a segfault within the glibc fclose code as it attempts to deref a null
> pointer.
> 
> Fix it by conditionally calling fclose on the file pointer only when
> non-null.
> 
> This is consistently reproducible with xfs/041.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Well I guess a NULL pointer is an "illegal pointer" as the manpage says,
so

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  src/fill2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/fill2.c b/src/fill2.c
> index 4cc1c3d79a98..37ed00b1d9b1 100644
> --- a/src/fill2.c
> +++ b/src/fill2.c
> @@ -307,7 +307,7 @@ main(int argc, char **argv)
>   cleanup:
>  
>      /* close file and flush buffers - check if this fails */
> -    if (fclose(f) != 0) {
> +    if (f && fclose(f) != 0) {
>  	fprintf(stderr, "fill2: fclose() on \"%s\" failed: %s\n",
>  		dfile, strerror(errno));
>  	status = 1;
> -- 
> 2.44.0
> 
> 
