Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179E37267E
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280138; cv=none; b=eaytvo6HT1ejWwwKYp2acYx+eNtIN/enQntJ9Bcp0ikc/S9JWhGNEOtbdt77bQiA/+35xYLMPMCpIB/HO77Bpp7taFuuHhGWL15QyHap0mZNw7ODkePPvwzIf0J13/m09uX/+g3eZol1jmo8Hvm3MPjGrGDKS587v/cu+oEw150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280138; c=relaxed/simple;
	bh=/loaCfdl7dj5eXod4M+AZQGBoKKw1DGeiRESug2iHG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaV653GQcMf+j7i0BtE2qluHW6ZVw0sgfE+nEqDXJ8T2QdermF4P0KECX7KJtt3BFitTw9I6nUWaWHHGjHz4RtiDjnx4w/QWaHnEO7QWOiRQujXfW6TKDF6AYqLSDzeP5VTRRBG57pUroHfl1o46vnNyOlnFkM8OEhB2mpjjTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8is7I0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8is7I0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1411F000E9;
	Fri, 17 Jul 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280136;
	bh=w0y0E50384hKrsODlpwmviHqrsNr9UJFgIeGMMLZutM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8is7I0lKMHgc5Eghb2PIgvkzAUvIXOPI14XxoTwltvIy0naPwZurmYM9gQ/o9bvl
	 8W/68iMaoVRbwiTKrbs85uwULuq2EJgf3OcbReGsV4AHVOhsf8M6gKAPKGNCdLDb1n
	 cQiYm14hG8CKsZlF/C6nmkZYQdry+2yOnHSg9UJxyZLHr5j75x2JqNO+Pai1/dpz4B
	 Hz7tM+B7Qs3A5uiichQxeW8V4LRCKhzflfCklZEtNk/+Xp+ngYPC9DFqWIqg8MDRrS
	 ynIJtDQYihGvRgTErRGcKCf3mAIIv8tEccsVVlGWZ7wvMFioV7TI1H9EU7qQAnTKtV
	 U+4lXadpEv3uA==
Date: Fri, 17 Jul 2026 17:22:11 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/062: filter setfattr --restore symlink-safety
 warning
Message-ID: <alnu6gq9a1bJJF8b@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	fstests@vger.kernel.org
References: <20260706061102.90603-1-avinesh.kumar@suse.com>
 <20260706191326.122555-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706191326.122555-1-avinesh.kumar@suse.com>

On Mon, Jul 06, 2026 at 09:13:26PM +0200, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> attr 2.6.0 (CVE-2026-54371 fix)[0] makes "setfattr --restore" warn when
> used without -P and the dump contains a symlink, which generic/062 does.
> The warning leaks into the compared output via the setfattr() wrapper
> and fails the test. Adding -P isn't portable (older attr doesn't have it),
> so filter the warning in the wrapper instead.
> 
> [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8

For generic/062, modifying the g/062 itself seems fine and logical, as
_extend_test_bed() explicitly introduces complex symlink paths for
testing purposes.

Have you run xfstests on XFS with attr 2.6.0? There are quite a few
setfattr --restore invocations in common/populate. If those also trigger
the new unsafe restore warnings, we might want to consider introducing
a helper function, such as _setfattr or _setfattr_restore to handle to
-h and -P things.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> 
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  tests/generic/062 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/062 b/tests/generic/062
> index 89659040..ddf0a478 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -30,7 +30,12 @@ getfattr()
>  
>  setfattr()
>  {
> -    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
> +    # attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
> +    # -P/--physical is unsafe because it can traverse symlinks. Older attr does
> +    # not accept -P, so just filter the warning to stay version-agnostic.
> +    $SETFATTR_PROG $@ 2>&1 | \
> +        sed -e '/^Warning: option --restore=file is unsafe without option/d' | \
> +        _filter_scratch
>  }
>  
>  _create_test_bed()
> -- 
> 2.54.0
> 
