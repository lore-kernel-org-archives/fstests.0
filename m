Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBD2BE621
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567365; cv=none; b=i7WYIM1EvjfWXJvrmhRZU//S2hfGkTZyPA6+87r9m5ZQJVQqvuNOrBpgtoWEKoBS/lqCG1ieM3bnkVeVv8qZWOI1lbHnKq0E2u1agYh5ldTFIRD02vPOUrQrgkcNJelw8Fg3cSTIFGsJNZ8RARY45t4vmYlzeGBlDlC6UCy015I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567365; c=relaxed/simple;
	bh=rw06QuVf7IeZhonEheUzO9bImWrxy54wWvMoPZ3rPPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtnv85G7zzK8ZPji5qF3ifc0JxwdwpyJlA9TZL2Ym1gCWBlwRUubpzJJ3sxPo3BnLvSgWk3sK4bZS4hS46oznnmDMzWrG0pm/EQvXmiFYmFw/HH2NKUtbCgHaqjNbHpXbo2f/9piPCa7WydUJFva35vh+kE7iGa94HYbvUSeXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmA9jTOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmA9jTOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A66C2BCB3;
	Thu, 30 Apr 2026 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567365;
	bh=rw06QuVf7IeZhonEheUzO9bImWrxy54wWvMoPZ3rPPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmA9jTOfKdh+rcJMT2HDlcSDROwRn4f/DGiAyhm55x0B7HltyLiW/UuVpr7gaLHbi
	 6I9xjEj/CnnpD82wAyX2/WIvMjwT2haflK6k2Q0zvj/8JL63CPPArLFuaozO/Dmhoj
	 +O5sSYlbMVNe6BC+iGK0byDjPOW03Rsk4Wh0ZJIxpGf59s29i+7vzXk66vQrz/q8Xh
	 cOfsPtUVZQ33Sq4Kk7KdlJzYX/KgLryJbnBSNNh5/z7pVV+26IThl3zE0GqZJVIb3T
	 zHvcCfpV8MaOwbvuP8uuFY7Q94fwEkHqGCxyKo9Rmv5iBfjp8p5eP2Kj+q8+yEsykb
	 uoQClBM2vb9jw==
Date: Thu, 30 Apr 2026 09:42:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] common/rc:  Add helper to calculate percetage of
 free space available
Message-ID: <20260430164244.GU7739@frogsfrogsfrogs>
References: <20260430131317.693845-2-lukas@herbolt.com>
 <20260430131317.693845-4-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430131317.693845-4-lukas@herbolt.com>

"percentage" in the subject line

On Thu, Apr 30, 2026 at 03:13:16PM +0200, Lukas Herbolt wrote:
> It calculates percentage of filesystem available space and returns it
> in MB. This helper will be used in the following test/generic fixes.
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5fe44e2158ff..32c566cdb68a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6189,6 +6189,14 @@ _require_fanotify_ioerrors()
>  	_notrun "$FSTYP does not support fanotify ioerrors"
>  }
>  
> +# Returns percentage of available space on given mount point.

“Computes a percentage of the available space in a filesystem and
returns that quantity in MB.  The percentage must not contain a percent
sign ("%").”

> +# usage example:
> +# _mb_pct_of_available_space <mount point> <percents>

s/percents/percent/

--D

> +#
> +_mb_pct_of_available_space()
> +{
> +        _df_device $1 | $AWK_PROG -v pct=$2 '{printf "%.f", (($5*(pct/100))/1024)}'
> +}
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.53.0
> 
> 
