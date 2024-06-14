Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CF15ECC8
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379874; cv=none; b=BkOfwIyFkik+UfMnkmyWeDnaqTa8KC5JCYVNeTw7AN7jHI0c+qSm5q7EOeLGm+k7Fy/iUlExg1bIcLZT7KEE6mp+wtNlMSKBp/WSxu0y8D0gcnkF3kn17XJldYVz35f8po2W6RrwVl7HUrvkgyHQSIcah6RUGebN4DNzriRHo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379874; c=relaxed/simple;
	bh=In+yRUBvjF92IK/sAk0qM0sxZnHaUKhkI6XZwh7okBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naMT2lbnSG2zw5ua6k/aKJtuEv2qBqAJdjdwGsRPG7Bh0UuwhIiHMf6k3VjXL6oPJcVeP+hXCdzLZXW9UiU1VBcUVBUSPWlyKtzjQtP45sqMy2EExDD6OegAd0agQOauvRdas3MgfM5xhRHfSeCSV5WUbCJPptE9wa7TV9h4WO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR5Upg8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR5Upg8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5197C2BD10;
	Fri, 14 Jun 2024 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379873;
	bh=In+yRUBvjF92IK/sAk0qM0sxZnHaUKhkI6XZwh7okBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HR5Upg8GO07xWFprFkljWTFTKlsymohSE6Fq0r6TYRw/BZ6DbdxvbEafLTGNngw4O
	 A/8Xgxn/k2xC2I4XEp1I8XOTjEZWkdjdJUp4ibRKmmFyXyZOdUFcZKGESSawBRMM2d
	 diRTFY1RYG7vXMjsDNTq3pTf/GD0fmhdBJZ5ITUuBOf1LnMlBBxSdnzjRvLnw+1e/U
	 riu/K6uG8q5SJ1b7IcOmP1iXCftT3VqyEqSJLtn/ObOhjK+V1810UgQrxCGON+9BwH
	 l7oEgPHkSC60Zk8iHPdLbwQRm6wmzHN17MQpa/8JIY/gCLS9IOZxI2vA8IW9KYSbO1
	 x22i8IcQRzrxg==
Date: Fri, 14 Jun 2024 08:44:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 2/5] common/config: fix RECREATE_TEST_DEV initialization
Message-ID: <20240614154433.GB6110@frogsfrogsfrogs>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7@eucas1p2.samsung.com>
 <20240614061722.1080-3-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061722.1080-3-da.gomez@samsung.com>

On Fri, Jun 14, 2024 at 06:17:24AM +0000, Daniel Gomez wrote:
> Do not allow the overwriting of the RECREATE_TEST_DEV variable. When
> this variable is enabled, common/rc -> common/config will reset it
> to false after the test device recreation process. This allows for
> differentiation in mount options for SCRATCH and TEST.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Seems sensible to me -- all the other config section variables work this
way (previous value left alone unless explicitly set by the new
section).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index a1cd14de6..43b32b93d 100644
> --- a/common/config
> +++ b/common/config
> @@ -94,7 +94,7 @@ export PWD=`pwd`
>  export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
>  export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
> -export RECREATE_TEST_DEV=false
> +export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>  
>  # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>  set_mkfs_prog_path_with_opts()
> -- 
> 2.43.0
> 
