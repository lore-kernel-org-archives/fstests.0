Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A93B42F1
	for <fstests@vger.kernel.org>; Tue,  7 Jul 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419236; cv=none; b=httio3RHBszg5nod49LeKzwsVE8dKyIKxBzT+MSWjtU2lnZSnjGCMUCoIG7qPEaZxIlDVY9Ql0ez6EGGRhPn2d2VETzAABq5afzg0rwVnFUFpLIgWvJpoxh+1WAAG/ocqPp6ucWVguNyWevRIMe7+0POrq21nTyWXVqPYzXS31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419236; c=relaxed/simple;
	bh=bwiGgmyJ4hPxwTPc59aN3peJx4VC+KW32lnvnHnZ+s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uG0PtWrVlcfu5ZE4K1L/utvN5MwaSDDlZlL6X3ys0rEpkE4yam7Q7tbK7v90Sz6gjmM7zoKQBdsDpSXy95k71zyPwDEuzzERwxCZNyIw2JPy/6F28szzkPhBMH8tSbsjX+FHVIuj9t7t0N+dtH6o5G40Tmd6wQiW7KWsW8uypEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlYM7d/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlYM7d/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585171F00A3A;
	Tue,  7 Jul 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419235;
	bh=mpXcOEu0WUkg9IXLiaEAgCjFTTJb7gqngOKpzTnr42c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FlYM7d/NlZZPzpXaOuTpqg3nnsYG5665sRx8nXJtjRsfvVYYQPhUQgTR8JOCqindS
	 /Cqvog2SCJAH9eBgBJCCp7e14RdANaxyesmbUDkq1a5NMuX/inK5NU/GxQ5VA6COA8
	 0uhQ0fHGSVtPGk30fKnjYQzJ0iL6cAlB0MCZ6zxRThkRI03/lUlyvqtwMPgmSWf/2R
	 ivqat/gqVZItO7fapEV0AeHLExXCXK2v+CuB7yUphwkJgBQtoBCHrqEkt1nztUmcco
	 v9TZBy/XNOGB/gN7kzj2npxiXi7DKkPpgBUFcoooh+tW0Y6d0AfQ6RS60HD3Zjl0Z3
	 o2jZc6uZ1pIDA==
Message-ID: <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
Date: Tue, 7 Jul 2026 18:13:52 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
To: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
Content-Language: en-US
From: Anand Suveer Jain <asj@kernel.org>
In-Reply-To: <20260706064326.3657995-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 14:43, Chao Yu wrote:
> f2fs has supported to report fserror, this patch adds support for f2fs
> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> 
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 494725547..f51ad59f3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>  		test -n "$x" && return 0
>  		;;


> +	f2fs)
> +		x="$(cat /sys/fs/f2fs/features/fserror)"
> +		test -n "$x" && return 0

Don't we need to check if /sys/fs/f2fs/features/fserror
is present in the running kernel (there are helpers)
before reading it?



>  	esac
>  
>  	_notrun "$FSTYP does not support fanotify ioerrors"

