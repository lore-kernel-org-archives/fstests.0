Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF016468C3B
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196862; cv=none; b=GwlybemKSj7J3JEC0AEfx/u9lFQnUa6g1aJPiXZ+H/C+KcuhElt0EzqJ7wekdxYRRSCXbz2+N7jS85bUJENyCCXh8O78WteCNdFw9dSzDINoCdTXc+BzdvAwW8sXCt4j2LM4q8IP1YTygjbpHNTWGca63lvtXbCHVBGIaJhFPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196862; c=relaxed/simple;
	bh=aXUTDXlCZXbrIXDDSuHyaW6e+/bouBaVRgGr6j6bs2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc3dKcLCrx6p8B14GybCc0ctMlJeVJzRBGpPZVdpTb/d/wEKZrJzJ1P3iijRvbkRxjOa8eouqjtteVXdQF+hss5vYcRI3s5woi7jacNKVtqFKozcESBfPMZrlM+lfRM0wF2uc6o0Z9H1ai6a8hSp/h+gltGFXHBL4d7Tj63tBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx+MAd4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx+MAd4g"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 474541F000E9;
	Mon, 31 Aug 2026 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196861;
	bh=p/G70IzA0Qfk/EuOd+ELGGnIyT4cvZe+ZKpqhM+Sxs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nx+MAd4gP/jbZMyUe3IVZ99N3XMeXQRluhch6IblgIZ75lozAZx8/p7vO76bokaNN
	 HzSbUD/59QyXGu6vIZhgSuCR+HguMZ1DhYmCHjdenB5tKNMXhnkJPqwRleLoK2Lcum
	 /kuXkiHa7lFfB6jE45PrSqQQTUnVBNT4VX16eovvySzDVwy10HNEXxILV4VJlTFkRw
	 KhyclbW7iLwMAKOgz8rbFj/X8afxFywWN4ZQJ9op2lJ+8cr8mPGr+7/ygyMxLKBg0z
	 vjsZtiI8iFgs51uX0Ez80VjMO7gpSMBHTx5TC5a6DYHkpJCiOYQC24c6ezuhTApifm
	 +YK+jrAVcoWag==
Date: Mon, 31 Aug 2026 10:21:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH] common/rc: remove trailing space from _mread() default
 map_len
Message-ID: <20260831172100.GH839663@frogsfrogsfrogs>
References: <20260831104206.2284-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831104206.2284-1-prabhakar.pujeri@dell.com>

On Mon, Aug 31, 2026 at 10:42:05AM +0000, Prabhakar Pujeri wrote:
> The default map_len expansion contains a space before its closing brace,
> so the variable includes trailing whitespace.  Its current unquoted use
> tolerates that whitespace, but the value should contain only the computed
> length and may be used differently in the future.
> 
> Remove the stray space and leave the surrounding expansion unchanged.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Heh, whitespace...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 02bdb31..2db85e5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -176,7 +176,7 @@ _mread()
>  	local file=$1
>  	local offset=$2
>  	local length=$3
> -	local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file)) }
> +	local map_len=${4:-$(_round_up_to_page_boundary $(_get_filesize $file))}
>  
>  	# Some callers expect xfs_io to crash with SIGBUS due to the mread,
>  	# causing the shell to print "Bus error" to stderr.  To allow this
> -- 
> 2.55.0
> 
> 
