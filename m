Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06A3C1D5D
	for <fstests@vger.kernel.org>; Wed, 29 Jul 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340042; cv=none; b=fZtBtvDMJBds0hQ8YgVS9WpqVXrtqhm5CtG1odttFsw7i2OlEFLRZYNzId7KkQWSSIwt9sykVkDFC71NbzTlLm/zOKNz8EPLja6ySoD6+7larg+3vYnWZE42Y3sr53Pevg/qo8/j9lgbTNKxpHkzG7cknadCzNwH4Om3Bwey3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340042; c=relaxed/simple;
	bh=XxUfU/IuK2GZz3W/49oVdvFsk38YPIDF45DOd+baAtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmGED+rIdrXzyb5SXzkJuOY52HbwnKOzzAzdIszFeQA3LxpoGf6lt2wTbGZJlf8SLXVeFEBaZNnqHIYoOR6wwqNJW/fkdFG/eZ2upTl/I6PpWuDUp/m3gKfVZFQNQM36aUdoj6pjg/NSkk7xuLxKgpvMDWNmS5Iy54XXvCMYHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMEom+X5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMEom+X5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CB811F00A3A;
	Wed, 29 Jul 2026 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340041;
	bh=DB5SQYU+LDdWOKafWbpcL7FJRQ0W5HkGsqlY7Lrf3tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XMEom+X5Q8A5NO/vhvv34dsBRHbRZSRWZipGFkvi2UqgJAjIU0Q/akt/BCNByH/w8
	 JTSfisOg2PLq5tElGSF3aEliQF4e7ImsGw7Fpa75wy5Xi+U6tzY/ejvBr1/MpE15l7
	 VYl2QFgo8qmM9jvsVeZ7XAwtPtZiZzj7vAZtY//8bYqUPEfO1YpnskwtsfOiU+lwGW
	 aPuuxMlDWmUN1qz9DaSM9m6Fyt1p745Mv0IOueDOrXIAP4tQLPZCcMnBRWANOqnW6U
	 Rz1GbzMPJOwlqlXInojQOUsvXaZ95VaheM2vyquq5S/153LRqV8Rn32oJ4CzxsaXgG
	 w8B+QgMMTlZPQ==
Date: Wed, 29 Jul 2026 08:47:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/rc: support f2fs in
 _require_fanotify_ioerrors()
Message-ID: <20260729154721.GD7371@frogsfrogsfrogs>
References: <20260729094909.1499590-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729094909.1499590-1-chao@kernel.org>

On Wed, Jul 29, 2026 at 09:49:09AM +0000, Chao Yu wrote:
> f2fs has supported to report fserror, this patch adds support for f2fs
> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> 
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> v3:
> - fix to chech sysfs node correctly
>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 106f044ad..3a8f03412 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6266,6 +6266,12 @@ _require_fanotify_ioerrors()
>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>  		test -n "$x" && return 0
>  		;;
> +	f2fs)
> +		local feat_file="/sys/fs/f2fs/features/fserror"
> +		if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> +			return 0
> +		fi
> +		;;
>  	esac
>  
>  	_notrun "$FSTYP does not support fanotify ioerrors"
> -- 
> 2.49.0
> 
> 
