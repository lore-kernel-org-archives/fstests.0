Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B83644DE
	for <fstests@vger.kernel.org>; Sun,  2 Aug 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785677122; cv=none; b=Ajd+oUZSz6Ixndq9WKQ/2RiUMGg12H53Iiv5rMGNHmXaMBbAKr7wFCLfHz2PG8f7X8xlM4aL4b70d8d059kIMLcnarReWCXLAbzejLX3MXG3AIwGgcIQEc0yIOwOgY9xeAqK4iykqV/5dzDKDmXo7Hj3y/uHd1K5gQCRKLWYwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785677122; c=relaxed/simple;
	bh=TEHKL32FNCImkG/6c05q87aXwS6FlzEm1fWBaIYLmb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUj8tbmgrb8VN0/2p752mZ8J2GLdt3p1oznno/7mqueJqq91Xa2EYaZaHiq2RrPuo4QtBGJlmYae45zWjX1xLwNKpgVR1NwzZ214YynApkLo26E04iw29JqUwDLGYwsPxFxh+9Ewano3v+XGJ+mDyhpQfbuIyYsCMcoDrSZ+kDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anBfds/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anBfds/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFA81F000E9;
	Sun,  2 Aug 2026 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785677121;
	bh=ft0Gl+O+Y3hvzCpKZZ6PTq7ZSvmTd2z/bSOeZuYNWsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=anBfds/128pgwodCvkTGm1LyIlyJzwC66Bq41ur7OI7rSUCBTukZYKq66ej1tsj1j
	 0tBtDMZx9kc3myvY6xwx5mpU3+3Zl+3cFLUzGAl4gJHuJYAbFIbk+hp1vGQr5FN5Y4
	 Aye6QBwbglMV8vkoEw2W51yaI5KzVHfbwKltFaiAUF0eEbTpp26KDq9SxG0ZRCZlXr
	 Qk9w2d3hNn/1nUD/dL2K0BhaGyzPVurCaWUaGpnG46295j/O/XD0XFNYUWFx/iCxJV
	 9qwcAelYMxAnJrSP8fnuDWweDB6jz8qTKD2kByKurkeXHybVXgOf1XqAI7NO70OlL6
	 8B+Cvb0zeCnNw==
Date: Sun, 2 Aug 2026 21:25:14 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3] common/rc: support f2fs in
 _require_fanotify_ioerrors()
Message-ID: <am9FEmgp25SzUv-L@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	"Darrick J. Wong" <djwong@kernel.org>
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
> ---
> v3:
> - fix to chech sysfs node correctly

Thanks, let's have this at first.

Reviewed-by: Zorro Lang <zlang@kernel.org>

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
