Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67D403B06
	for <fstests@vger.kernel.org>; Fri, 10 Jul 2026 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727218; cv=none; b=RBxXxIT37b+qBM1/vvKNWR//bS3fztFVcpR6Ycz+2oNt+Eh2qOS00wJXP9FNtZzbPcyf657Ky97r21XiO4vZB2RsE6ZHadYjHDDNRKFEPpack1FDMplQvnATh2325pwIzJI7L0qWL1xQJNOLHjo68IaA+q99wEPGV1k/b04+Yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727218; c=relaxed/simple;
	bh=ZtLfIVow9lKOhZZ3DFhsYBinp+dXmCj09ObGs3oUZ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klPHPTUwKghKIR9zo5XTjGUGw4eiJszoHHhqJ2t0ekezF5jOQVirvPXhRgPnn8I2cqpyJrXFClyWpl489gpnC27MYfG9UW+3QCXEB0obDDqK8taREZqJokWkolCH7iGSBjiOZtnoRhPNKZIXYcBrhlGD3jk/atUWkup7tyYnwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkQVuBt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkQVuBt2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A7B411F000E9;
	Fri, 10 Jul 2026 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783727216;
	bh=z3CTJb1w5VI6BzZZRo5PRc4qysDFBuaXwcBAEYkTMI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkQVuBt2oUfZVL1mqg9SCTW+Ho6piOfoLzanVbl/Q3ntap5w6cycqhG5Av1gnYHHm
	 OQ4uhqMqtVhAOFR/bYVIMmWEZVma3u9u2nsH58nrxhb9N8bDC7yLzErMHnbGaX7C0B
	 ugvnrii+Ce2MIcYs+FGkSmKqELXBK5LdqVEozktHuA7qGQrfmcp3elebGCDi1D0jVM
	 /LrAuoIxC2VyjELSIx83yyaFWnBZ2uEwRnNvd0NQ202FNGzYM8yvS0EaO0vQ1UKHlU
	 bgBMjXEXRYXrkSbMtBnqpfxr7lqLYyltgf4WUmkVAbCq2w0Earc505iMIPQYvvBkNU
	 UyuqWCDeZe8TQ==
Date: Fri, 10 Jul 2026 16:46:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] xfs/083: redirect populate stderr to avoid spurious attr
 restore warnings
Message-ID: <20260710234655.GC15202@frogsfrogsfrogs>
References: <20260710195355.139127-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710195355.139127-1-avinesh.kumar@suse.com>

On Fri, Jul 10, 2026 at 09:53:55PM +0200, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" print warnings
> on stderr. _scratch_populate uses it, and xfs/083 only redirects stdout,
> so the warnings leak into the test output and fail it.
> Redirect stderr to $seqres.full too.
> 
> +Warning: option --restore=file is unsafe without option -P (--physical) as it traverses symbolic links in pathnames
> +Warning: option --restore=file is unsafe without option -h (--no-dereference) as it dereferences symbolic link pathnames
> 
> [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8
> 
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  tests/xfs/083 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/083 b/tests/xfs/083
> index 9291c8c0..48deaafa 100755
> --- a/tests/xfs/083
> +++ b/tests/xfs/083
> @@ -91,7 +91,7 @@ echo "+ create scratch fs" >> $seqres.full
>  _scratch_mkfs_xfs >> $seqres.full 2>&1
>  
>  echo "+ populate fs image" >> $seqres.full
> -_scratch_populate >> $seqres.full
> +_scratch_populate >> $seqres.full 2>&1

That's quite an overbroad brush there -- we want any *unexpected*
errors to go to the .out file.  Given there are five users of setfattr
--restore flag:

$ git grep -i attr.*--restore
common/overlay:497:             _getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | $SETFATTR_PROG --restore=-
common/populate:154:    ) | setfattr --restore -
common/populate:203:            ) | setfattr --restore -
tests/generic/062:189:setfattr -h --restore=$tmp.backup1
tests/xfs/227:75:       $SETFATTR_PROG --restore=$tmp.$1.attrs $2

Maaaaybe this should instead be a targeted wrapper for that?

_setfattr_restore()
{
	$SETFATTR_PROG --restore=- 2> $tmp.setfattr.$$
	local ret=$?
	cat $tmp.setfattr.$$ | sed -e '/--restore=.*unsafe.*without/d' 1>&2
	return $ret
}

--D

>  
>  echo "+ check fs" >> $seqres.full
>  _repair_scratch_fs >> $seqres.full 2>&1 || _fail "should pass initial fsck"
> -- 
> 2.54.0
> 
> 
