Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4174A5C48
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367190; cv=none; b=JD4i5xkf+wUOMUbvww+5rxlhPS4hsxGFjGF8qT6xXJqXgpCdfmg39z4OvpH6/MqApPwYOnFMxBPXB3S7Qxutvasly2Iv9RjXHjTyUH7rlmgiltSy8G5FzxJ81Fe6JFp5ftXkEKCUasJfd5LKLI6NejIpzffCYUDyADW25kmCNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367190; c=relaxed/simple;
	bh=ACOv1lwAjT8UjUU1VOT+ELcw4PneS1sq5tFo+keqTJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msz6j+XLUJVK5T57ChGouBZtjtQnE+zEwnMfL0ZVo/FO5P0af3+tGzGMQTYG4KVwHSlSXgdrWel6HvNul0IcAhguzff3jmARvGxRNOZ4fcTTRscj9gst1jh3GwKvofmAWOQcDjOxHVvqD1tf72n9qdwBza+gcZGEdDyhk4ZbnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9S2d7ay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9S2d7ay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FC91F000E9;
	Wed,  2 Sep 2026 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367188;
	bh=reuka5V7LisJ26ZW1Ct5lxIgRjPG6dHj+q+s09VeHSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S9S2d7ayyaikFtaQdNClhegqtAvuk+mNhQ3lEkMXUpOS4C+wfMbInRzXpFZF3xM1M
	 nSPHZFA8Fe5jzcMYpZFleGg103m1fR02zHG8aXUKlKS6N1dq4x90JCMvA7AF8Lqt74
	 J7hRm3NdA6HiQNBAPFuNZTFiLclA97bOW/nYiSZaYTVyudfIMVfAutiV1L+e755Lnx
	 90lW8pW1vwqRemcEXegwFDKtm7sP8Qn9h2eJF16Wskf1jx+OlyT5Ax7PCZvX78rfhj
	 Z2hhQZwQI9oxvK8bKBkk6C+TjBNbr7/7a41bJQvEynHVhFDP4NJaauNd0j9k3iC40W
	 gQvuf36ZqIsEg==
Date: Thu, 3 Sep 2026 00:39:43 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/091: enable sub-block reads
Message-ID: <aphQTqugTNh8820h@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831065120.2578146-4-hch@lst.de>

On Mon, Aug 31, 2026 at 09:51:06AM +0300, Christoph Hellwig wrote:
> The description of generic/091 claims that it tries to exercise sub-block
> direct I/O, but the test currently limits reads to PAGE_SIZE alignment.
> 
> Use the new min_dio_alignment -r option to query the minimal read
> alignment and only limit the read alignment to that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/091 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/091 b/tests/generic/091
> index 5cdf04890c0e..b2fba09d39ef 100755
> --- a/tests/generic/091
> +++ b/tests/generic/091
> @@ -15,8 +15,8 @@ _begin_fstest rw auto quick
>  _require_test
>  _require_odirect
>  
> -psize=`$here/src/feature -s`
>  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> +psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`

Good to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  
>  # fsx usage:
>  # 
> -- 
> 2.53.0
> 
