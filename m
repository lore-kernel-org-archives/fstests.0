Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915725EF88
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707038; cv=none; b=sews9+B+pKpdQQkf1XcET7zMCZbNACUX2fcqFTDiH7UkVaOQkPVpzCGFyAvSW4oteEcH4pztD3EWo1TdnYkH4enUhonBO9fNb3M5sb5XggQGjRqwJ0LsJQbU3uBIuE+lDqSmsIi+9eigOTe/hAYdWeMSGZZ+VSOXQP/BiZkigd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707038; c=relaxed/simple;
	bh=+mmcw+peiDirOLVIKFnOEiTmPVvhQMaUVIe1NAArIgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTmziavJ99G5RJj8o2niVExeOjI2bddtrulb/0zZHcliYqM2RLeGagJEPXyLt+WoecJu7Dr2JhPJqIubKDMfcyfdOrUDH2BS7QyA39+oFTlAGT8bW9tL5tiH4GIfSMBnTGXrdUpOq4GD4vxb2Q+XQaTowNGWR3LnSjIMtqBj0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/sgvJUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/sgvJUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0717FC4CEEA;
	Tue, 11 Mar 2025 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741707038;
	bh=+mmcw+peiDirOLVIKFnOEiTmPVvhQMaUVIe1NAArIgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/sgvJUSXnwp3WdRQ3i0u7VNT4PCUMzUlNN8rsTHcQPD0+o67o2pYDnn7mDcZ9M1f
	 G9KNi8PO78bpu2CHf8nHQDEeV5WLnZjtI2jzxj1sBpJrFnlSturAbTy0khA6w9pgCh
	 iysCn4jCIg9Xi0BTop1tA8BvzHuf+IwPeWiP4csUrvdVtWHKzRs9cJsxN3ojVz4Pdz
	 Yrx9NF4wVSsoxRHeNB75XNGy1wpIjcXfdiYLGxhMk981S0l7Ia5OdvDfvDpU1qxKIN
	 qjwNroB6TcIddqi7qiN14eS7aG8X5GpJRfMCnLmUCaeIt+wyvK37Gh5R10N9sDZKBV
	 sLJD6fkGwfl8w==
Date: Tue, 11 Mar 2025 08:30:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: use getent when available
Message-ID: <20250311153037.GI2803740@frogsfrogsfrogs>
References: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>

On Mon, Mar 10, 2025 at 12:55:51PM -0500, Eric Sandeen wrote:
> Zorro noticed that on systems using nss-altfiles, some tests failed when
> trying to parse /etc/passwd directly. The "getent" command does the
> right thing in this case, so let's use it as long as it's available.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/rc b/common/rc
> index 6592c835..50312331 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2621,7 +2621,11 @@ _yp_active()
>  _cat_passwd()
>  {
>  	[ $(_yp_active) -eq 0 ] && ypcat passwd
> -	cat /etc/passwd
> +	if type getent &>/dev/null; then

If you want to be really nitpicky, 'type' isn't defined for posix
shells; you're supposed to use command[1]:

	if command -v getent &>/dev/null; then

I don't care that much since fstests is wholly dependent on bashisms so:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

if you decide to change it or not.

--D

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html

> +		getent passwd
> +	else
> +		cat /etc/passwd
> +	fi
>  }
>  
>  # cat the group file
> @@ -2629,7 +2633,11 @@ _cat_passwd()
>  _cat_group()
>  {
>  	[ $(_yp_active) -eq 0 ] && ypcat group
> -	cat /etc/group
> +	if type getent &>/dev/null; then
> +		getent group
> +	else
> +		cat /etc/group
> +	fi
>  }
>  
>  # check if a user exists in the system
> 
> 
