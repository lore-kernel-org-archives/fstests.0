Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586182DC791
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024801; cv=none; b=aplMsSjbV5nueXfMp6yyfx7dUO0iaUfNc+aXIQlHMkXEIYWbC+vFoemTFq4Jx0nK93OHSjsd2xCTEiBMUazeuQza6brmzBmh3uq2lxfoqkG7oVUemol+x4lihLLWwi6dW+ZQeKRb26CuCmbxr/oca9MbCHN4s+vs5zpufJJp3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024801; c=relaxed/simple;
	bh=v8Ag9DYlkamLpUU2vBBW7riyL3IX70ye0mtSKFp7kD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfOxHpxrzj8K+qiYt+Ux/Rx5z4R0yQNCMcCKrjFlz17j0WluTSjnuNsmhFcZnUwN7j1jtUkW7SfzW7vpMbz8JaRN1pl3eN6RL9hL+aUEJvS2VMlH82vuOzETxpqQnvqKNmy3eXNBy9RCgFA3wbMldY0iINOsFKiC10u6f0Y8su4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIGBN5BK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIGBN5BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2428BC4CEE7;
	Wed, 30 Apr 2025 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746024801;
	bh=v8Ag9DYlkamLpUU2vBBW7riyL3IX70ye0mtSKFp7kD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIGBN5BKeKPSg2DTTenHdJUNtD15sDCioeM6d8woJAfOnLtKpzlTHm+D81ybThLet
	 kjtTK072d+8I62L+8lLQrlI8Tl8htbP+xgwtIpu397yGv44m5NMshtzmUTDFcdDscE
	 dvBH1spf0D4MiVzvLrQGs65s13632CQb9YkD/CzZcIcZ81JSlM9Pk8j1AQCE0COl4N
	 AG7qQeHOi588Yuj1gvTa9RdqtozfU/cKAWM7yJZ/gx0gYdKx1i7Ms6Lm+8C98Jpt7T
	 9D/JMF/Fhffjkvjs/ojl1GubdLu5wL8zDLF048rIib7POK22+HadJtl/rYKOjm19r4
	 KkSNPKItDGnKw==
Date: Wed, 30 Apr 2025 07:53:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests/MAINTAINERS: update ocfs2 mailing list address
Message-ID: <20250430145320.GM25667@frogsfrogsfrogs>
References: <20250430122342.157170-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430122342.157170-1-ailiop@suse.com>

On Wed, Apr 30, 2025 at 02:23:42PM +0200, Anthony Iliopoulos wrote:
> Bring the ocfs2 mailing list address up to date, following the upstream
> change in kernel commit a57b4b7f0557 ("MAINTAINERS: update ocfs2-devel
> mailing list address").
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

It's definitely not hosted at oracle anymore ;)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc31572902bf..a0f50f3d98b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -157,7 +157,7 @@ F:	tests/nfs/
>  F:	common/nfs
>  
>  OCFS2
> -L:	ocfs2-devel@oss.oracle.com
> +L:	ocfs2-devel@lists.linux.dev
>  S:	Supported
>  F:	tests/ocfs2/
>  
> -- 
> 2.49.0
> 
> 
