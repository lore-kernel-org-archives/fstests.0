Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5423D291
	for <fstests@vger.kernel.org>; Wed, 22 Apr 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873472; cv=none; b=rDkhNP5cWyAZKsimIfnSYzmW7/5R77Dz/z/zwzwmW7NL7GZJR+4yzpx5nGWPfgBAcGEFuMiMC68NhchlnMJ2zdV0MevSew8AgFlLxi9fKfjoEC0BnwgEib79QtG4RnM3+JZN32FIxKOdm2aLTlhqJ6XxPjm32yLeuRxTom3OvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873472; c=relaxed/simple;
	bh=pDklzZe91qJpyA0QVwSzW1x6v9qMjjhMm9ofhhyj6y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaycLnScj4YA7A9fTVp5H1tJ0H7fpCoUAvP5d41X14OGFxBbmWEnUs621V4aPNFax3Sj5Z4+A6D6nKpYsZH2HvTXB35+za/Vty/M/RnGqdg0W5Dg1NlvUc335+A+rlXp7vocmnusV5TQVPG9Uytnw5NhkGUVsch6pWygLAIys/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJm9D6F1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJm9D6F1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129FAC19425;
	Wed, 22 Apr 2026 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776873472;
	bh=pDklzZe91qJpyA0QVwSzW1x6v9qMjjhMm9ofhhyj6y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJm9D6F1QSURtecPrLrEpU9yU7Fks/vj1vRgVhpW79zeFASYUAmoD/P31gQXwEV8P
	 9zpEASB5r2EHH62ByzrXOpP0rKsLElIO/24mFa92Mh4gRIozmuJV1HR0MihfUaBOTh
	 tYI5J2lU8PPY5QkcccgSbZUB21j83Fefhsv6cyBjQ0lvf8wtm7YDEU9rX9/oPj0lTt
	 CmBJEncoYHQfTsb/AQora+2c+EDEQKaDrCbVrQwws+/oACRP1WsZPiyJF/IDyfRRFA
	 G653fwWlp1OUQ+ZU9+08nfsoChhENicGnWllkJwisOSiNZHYGmN7O23kpYrR0sXH5f
	 9SH6SnL6aOpqg==
Date: Wed, 22 Apr 2026 08:57:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Dave Chinner <dgc@kernel.org>
Subject: Re: [PATCH] xfs/227: fix bad variable expansion
Message-ID: <20260422155751.GF7739@frogsfrogsfrogs>
References: <20260417180839.282768-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417180839.282768-1-zlang@kernel.org>

On Sat, Apr 18, 2026 at 02:08:39AM +0800, Zorro Lang wrote:
> The create_data() set cmd_str to "-c \"resvsp $((off * 4096)) 4096\".
> That cause xfs_io can't split the command line properly, it fails as:
> 
>   command ""resvsp" not found
> 
> Fixes: aaf40fb7 ("fstests: xfs/227 is really slow")
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Glomming CLI arguments into a string is quite a bash antipattern.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/227 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/227 b/tests/xfs/227
> index 7f8ee2db..ed505b18 100755
> --- a/tests/xfs/227
> +++ b/tests/xfs/227
> @@ -78,13 +78,13 @@ create_attrs()
>  create_data()
>  {
>  	local blocks=$1
> -	local cmd_str
> +	local cmd_args=()
>  
>  	for off in `seq $blocks -1 0`; do
> -		cmd_str="-c \"resvsp $((off * 4096)) 4096\" $cmd_str"
> +		cmd_args+=("-c" "resvsp $((off * 4096)) 4096")
>  	done
>  	$XFS_IO_PROG -f -c "truncate $((($blocks + 1) * 4096))" \
> -			$cmd_str $2 >> seqres.full 2>&1
> +			"${cmd_args[@]}" $2 >> $seqres.full 2>&1
>  }
>  
>  # create the designated file with a certain number of attributes and a certain
> -- 
> 2.52.0
> 
> 
