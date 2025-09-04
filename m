Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE23126B5
	for <fstests@vger.kernel.org>; Thu,  4 Sep 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007559; cv=none; b=kW5LcU6kJoffTCBdc4wTx0A3TgDb2ng9SOgo6t02BgKK/Li7RRMnuCn3k/mCdI/obPtywvp+/BpVBjBXUGyi1u72MzS2l+Why/rSlhaM6xI+F4WLgUO5Ac3y3qQomvytiZWPg3PR1S3T9y5JTYC2oGgO2U52anXPbHq7kGpN9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007559; c=relaxed/simple;
	bh=0TFVItmf9nXUHxwT077yaL+fpDSVSKq3dUyp0d4NDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzwYDg8HfVXiYvdw/OAOzQh8PAe+sfebqzb4GQy/5Id632wgY9TdC4oK7Ebb9BfEi9jlWVQM3JTh9mrzYMuhzOpZaVvJpW1U/0Hyc6+WiHSzjf9/H+9BClm2GUpCESmpJFtV8H+nV2s49lAflOiS7hZ8dAXrnf2SnE85oysWdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J83wFC/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J83wFC/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA160C4CEF0;
	Thu,  4 Sep 2025 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007559;
	bh=0TFVItmf9nXUHxwT077yaL+fpDSVSKq3dUyp0d4NDEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J83wFC/TCNlaLnUUOjMjVjrGL0c+vX3rbfHdQIxMpQ30ar9MaHUgG9JXETzwc07GF
	 Gtfdjs1f5xJHVKdDz3nr3/SU7eNsqppEEDM7e845VK8E/yeQhLuJI4I/SQa+Pjpzei
	 vEKqE7UdaZVN4l+9JJD4hbSJYftwEkjyIh6VR7GjBFQmB+1RmWpxbTlkkoSNixI2Pn
	 qXRuPlboqpK0v839jhpubw6c7WhDmfErLOhJ2CSmJKMb51W/EE4YFhsNLL+AGi45WS
	 2Ga99FLHB72JueCRjmTnkgj0l6xjtywX4Wwr0kdzhYJ2PSFnjloGDXRh22rrIZs6tO
	 mxoQXeyX17N9Q==
Date: Thu, 4 Sep 2025 17:39:17 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1] common/encrypt: Do not run
 _verify_ciphertext_for_encryption_policy on compressed FS
Message-ID: <20250904173917.GB854551@google.com>
References: <20250904085449.290354-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904085449.290354-1-jprusakowski@google.com>

On Thu, Sep 04, 2025 at 10:54:49AM +0200, Jan Prusakowski wrote:
> _verify_ciphertext_for_encryption_policy() checks if encryption works
> correctly by reading encrypted file's contents directly from a block device and
> comparing it to a known good ciphertext.
> 
> This, however, won't work if the file systems is also compressed. So this patch
> disables tests using this function when a compressed FS is used.

Apparently this is for f2fs.  There isn't really any such thing as a
"compressed filesystem" for f2fs.  Rather, f2fs supports compression on
a per-file basis: the filesystem can contain a mix of compressed and
uncompressed files.  Probably you used 'compression_extension=*', which
caused f2fs to automatically enable compression on the files that
xfstests created, which caused the test failure.  But that behavior is
specific to 'compress_extension=*', not to compression support per se.

> diff --git a/common/f2fs b/common/f2fs
> index 1b39d8ce..c46e2aa2 100644
> --- a/common/f2fs
> +++ b/common/f2fs
> @@ -25,3 +25,10 @@ _require_scratch_f2fs_compression()
>  		_scratch_unmount
>  	fi
>  }
> +
> +_require_f2fs_no_compress()
> +{
> +	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "compress"; then
> +		_notrun "This test requires no compression enabled"
> +	fi
> +}

That just checks for compression support, not whether the test file is
actually compressed.

But also, we don't really need to skip these tests.  Instead, how about
using 'chattr +m' to explicitly set the test file to uncompressed?

- Eric
