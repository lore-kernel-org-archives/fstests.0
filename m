Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379A3451DA
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993534; cv=none; b=egRm9bP9c3o30CUsXk7UzH+iDtJOjLfd/v1NRCic+QBFSkQrOwMJ/ZIix8wWZQOYncclngXpb9UG2qU550ww0AAePAX59SYLhxN1NEO4WIEZjd6H6W/r7EJ5TK2qvTEdvekBhVdByLH4smXtmDqO8DYmOrxD0izbTSpCH18rReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993534; c=relaxed/simple;
	bh=dwA0O1SqYfsgiOIIr1xH4M+72XH8ZIUVtP/XzSonX3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTZ0OfvBkQZxEYb7/4MWP0H4rItdxTY77kERtSIbxSQylI1ZN8UCukCjRCRzX7/4J+bGeqOFskLuay2uz8QJDUVkePQ+Uk4OstQATNN3QEdmxj5zB+/OAUYtwG6FO3EP9K3VQRzPR71NUJd1oMA6ly8+s6xSWOsra6bdf0TzQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd5D3DdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd5D3DdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2DC4CEF5;
	Wed, 17 Dec 2025 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765993532;
	bh=dwA0O1SqYfsgiOIIr1xH4M+72XH8ZIUVtP/XzSonX3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jd5D3DdQuOF1CsFEYtFJpxJSzTtr8YR9GoeJ7Qo3OJax8ulS9EHzwtPAZkxjfDYMJ
	 MzXlFwEd5gJxWo900w91eixb/0SLAIbbnV/0DrA/6c8cgnL9o6BYXuGIoZBMxZE4fB
	 A190/uvNCO8TS0AyYZix4UO75iziFIinQz0BMQi6mkZ2Tx6GVlzaUf2ZqTQRAwTj0K
	 W2UAvIhNMl0uxJqgw7r2hpREug+Dr4rhSuGZi1AOxi2vXEm1clxXwF7R4UUbPeh+PP
	 s6/Sj/JEAND26OqHJb/7VXaZT5fVCSme3SHuc785V5yjIeUSaLCn2OWpji+r5qI5gt
	 2Ff27IC7vn0zA==
Date: Wed, 17 Dec 2025 09:45:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <asj@kernel.org>
Cc: zlang@kernel.org, hch@lst.de, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix flaky device name in _cleanup_flakey
Message-ID: <20251217174531.GK7716@frogsfrogsfrogs>
References: <6025643af0c6a7d7d377aef22a53f23f24f06db6.1765988375.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6025643af0c6a7d7d377aef22a53f23f24f06db6.1765988375.git.asj@kernel.org>

On Thu, Dec 18, 2025 at 01:00:22AM +0800, Anand Jain wrote:
> There is no device named flakey-test, which _cleanup_flakey() currently
> uses. The actual device name is stored in $FLAKEY_NAME and is set to
> flakey-test.$seq. Use $FLAKEY_NAME instead.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>

Ugh, still finding obvious bugs a year later <grumble>

Cc: <fstests@vger.kernel.org> # v2024.12.08
Fixes: 603030dee015ba ("fstests: per-test dmflakey instances")

Thanks for spotting this, Anand.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  (apply this on top of the patchset
> 	'stop overriding SCRATCH_{,LOG,RT}DEV v2')
>  common/dmflakey | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/dmflakey b/common/dmflakey
> index cb0359901c16..6ac666f5b61e 100644
> --- a/common/dmflakey
> +++ b/common/dmflakey
> @@ -76,7 +76,7 @@ _cleanup_flakey()
>  	# otherwise the umount will hang
>  	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
>  	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null
> -	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume flakey-test > /dev/null 2>&1
> +	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume $FLAKEY_NAME &> /dev/null
>  
>  	_unmount $SCRATCH_MNT > /dev/null 2>&1
>  
> -- 
> 2.43.0
> 
> 
