Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9526B97E
	for <fstests@vger.kernel.org>; Mon, 15 Sep 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947201; cv=none; b=OL5yuOi/wkd2l5ERP2A0JAcu/V+kcM3m5vBz7AKXAHeGvogDS8S6VRGz5Ew0iLx9aZiABecYl8PEl3uQCQ84efN4WZqVUbEkeXMsBMwlj/1JZ9ZbQbcIg4xIiWO1hs06/aVOjdFZh5k45QhvfMsVk+OlFEFWu52sxC0aYLGA5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947201; c=relaxed/simple;
	bh=EO0NYEiZDq71xTAUjldgSm08C6CtejksZMgKKNt5NI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv3iOQR1upuhofPD8vy1xEIbsMeA7XjryT+V6et8inegzsWZ9wgBzRry//5ViFvou0qDJ17yrNG07hceBh5uXOAxC1aujuGl8ML5itDoYiqGEIiy9q5CNYF8t6kSMMLfGEEss+PbjLsuKfr/3Vrl1AcHIclRI3SfIKAJsoQ3MEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSgzu1v5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSgzu1v5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F24C4CEF1;
	Mon, 15 Sep 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947201;
	bh=EO0NYEiZDq71xTAUjldgSm08C6CtejksZMgKKNt5NI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSgzu1v5NJPKv/Vz+5FAYMrOyn8EPWSERJhTOEr1diQwb+OqNTq7XyT/B/7LH278H
	 oWWrf7+/RAStv7aKVmSKiOB0s85JXMg/JOdWnzZ2DEvFvRhfM9V7DYk5YWIPrtXY5+
	 DOdrDRpEpmLCCDaHIakB/n+LdaqemDJLTuIcEwWtYpH54WKK2tU3nX6dA8VlGcQZZO
	 8JYGdL3e7kG/Pv5wzshb9L7ayDUsxpZ2QfCnjgh0QTM8lZS7GdHyaeqoLWt0DTNQNn
	 jdcnkRxOkLqUHmJELW5LDL9iTPKM9rPV3CGsMI5w3tmTz2wj4nxoAaagPcBLlXLXQ9
	 mZo4Z8Zl7gSUw==
Date: Mon, 15 Sep 2025 09:39:51 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 1/1] common/encrypt: Do not run
 _verify_ciphertext_for_encryption_policy on compressed FS
Message-ID: <20250915143951.GB1993@quark>
References: <20250915100451.810719-1-jprusakowski@google.com>
 <20250915100451.810719-2-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915100451.810719-2-jprusakowski@google.com>

On Mon, Sep 15, 2025 at 12:04:51PM +0200, Jan Prusakowski wrote:
> common/encrypt: Do not run _verify_ciphertext_for_encryption_policy on compressed FS

A better title would be something like
"common/encrypt: Explicitly set the test file to uncompressed".
(We do still run _verify_ciphertext_for_encryption_policy.  And as I
mentioned before, there's not really any such thing as a compressed FS.)

> verify_ciphertext_for_encryption_policy() checks if encryption works
> correctly by reading encrypted file's contents directly from a block device and
> comparing it to a known good ciphertext.
> 
> This, however, won't work if the test file is also compressed. So this patch
> adds a check if a test file is compressed and disables compression in this case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> ---
>  common/encrypt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/encrypt b/common/encrypt
> index d4f6e3dc..c25ff5a4 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
>  	_set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
>  	for src in $tmp.testfile_*; do
>  		dst=$dir/${src##*.}
> +		# To make sure the test file is not compressed we create an empty one
> +		# and disable compression first (F2FS won't allow resetting the
> +		# compression flag if the file has data already in it).
> +		touch $dst
> +		if lsattr $dst | grep -qE ".+c.+ $dst" ; then
> +			chattr -c $dst
> +		fi
>  		cp $src $dst
>  		inode=$(stat -c %i $dst)
>  		blocklist=$(_get_ciphertext_block_list $dst)

Is adding 'm' (FS_NOCOMP_FL) needed too?  If not, why does it exist?

Also, have you verified that the tests that use this function still pass
on both ext4 and f2fs?

- Eric
