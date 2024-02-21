Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6063A1B1
	for <fstests@vger.kernel.org>; Wed, 21 Feb 2024 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530862; cv=none; b=oTWGpW3tOzxMgW4EqD7QDS71Xx2JZF71C5bRHBMCr6cq7VjlkN7LytscbWvudfCK7/FXMu4PD+PpDzQ1miREtSTr702VEqdfFBWQNh3PP0dN9iI7sNNtFAlTXFTEL2v2UnkqJPfpqfrU2tIsCIf93yQ02JFNhjwQrfZpuNuhMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530862; c=relaxed/simple;
	bh=U4KrMUBAYkM4Rs8rXTlDNxx69+v7TKJvnPcsVa5Lleg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvJ2FJ+0kD1Ezi/7DMFsdPKEhutraqoQpM3bnG/19flX9JYh6Fa3ua4+N99PeDHVFPigcavi86Nl8yBJ/kF2uoYnYYgkwQvVBaOxyhI9/VwtNAprj/n5QPTci1Pw07z0B73cfwrW3H+KCoIRM/57XAY+0UGYxKI6G82AzmDh3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfXvgIdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfXvgIdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50751C433B1;
	Wed, 21 Feb 2024 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708530861;
	bh=U4KrMUBAYkM4Rs8rXTlDNxx69+v7TKJvnPcsVa5Lleg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfXvgIdce/5VAthVob9bzssQ7gVdY/k/Rn/7ZbbuBuFwXBIfGB2mwDMleK/S0aa3c
	 7mSEtNiIIAnRkidZOX8/fRnbx9cBWiKUuRjReQSQtOqrCylsUROI7lEIf8UPIQR3Sq
	 sg9QYjl4Yj0JSBG+uacqldEupGs420n24vnlgHFkJ2FQZcMi18htW906hCqzCK1/xB
	 /SaWwN4D+d742fz1RQWJAQQLZ3rzpv98SbaM4ZniOjX5A0zPgPsO6q4UFpmRUlMItu
	 tVpDRPItk6P0vzjKfSPMwF+IH9HE7Zmrw62g3XMNBGjw5nBzDGLablAU2mJ+BuU72c
	 D6ZNL0bBMrusw==
Date: Wed, 21 Feb 2024 07:54:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] add src/t_reflink_read_race to .gitignore
Message-ID: <20240221155420.GL6188@frogsfrogsfrogs>
References: <20240221121021.3591859-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221121021.3591859-1-hch@lst.de>

On Wed, Feb 21, 2024 at 01:10:21PM +0100, Christoph Hellwig wrote:
> Just like all the other test programs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Sorry about chronically missing that,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 50ca94e98..d66190b13 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -165,6 +165,7 @@ tags
>  /src/t_readdir_1
>  /src/t_readdir_2
>  /src/t_readdir_3
> +/src/t_reflink_read_race
>  /src/t_rename_overwrite
>  /src/t_snapshot_deleted_subvolume
>  /src/t_stripealign
> -- 
> 2.39.2
> 
> 
