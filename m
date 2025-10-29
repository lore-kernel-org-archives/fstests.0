Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E329A9F9
	for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739357; cv=none; b=azp1AXnEE+WKf2oAjMxrVZfDUKFcb29f1M5vYMKFw2z8TmNZN4rlZ0tItza+UIQzj/f7BIyyILj2jMfhHQpS7g195nelZNAi9FcDzg+6XVq5ZbmaAkjdXcakcWs6E7VzePReG7tCun1Yy1ap6Aro8UqxyRt5b+7LaU5+r8tdk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739357; c=relaxed/simple;
	bh=FnowuDxDevMD9mwxtf2kNZdUxIQHi9dzh6ou8P39uIk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lZteFCox8CjUDmYowBL8sCibwVuFOBxOR0dj9SFVkoQjwodU3zvpupjhFDXPNHmGg3c2/2CzevgG8DBXdteD2I8Q2owkS8p850sSooJwCL7IlnV9MjOkluO313NI1czda0pM60iAZc/3X0Q2+QS3q3069PdKYt8rbx/0dpwgsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctQ82c1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctQ82c1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1E8C4CEF7;
	Wed, 29 Oct 2025 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761739356;
	bh=FnowuDxDevMD9mwxtf2kNZdUxIQHi9dzh6ou8P39uIk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ctQ82c1pR6v5IOaKMWnF5Zoi83j1Lq4iLMqUndjC8XcxGYLeVnA/ObbfJAMKMKb9z
	 K3II5fnXvLGBeTI1sZ+x1qAWERTERwL/YZS6MYYZXHpxZ9pxdk2wOJiXJfQwjY+NQd
	 OjxgtLMwbM2+M2J/tKhy+FdamHdHMiysbhmBofSQv5MBEqlas7497FYuQyrMAeppzi
	 GnOrxUMBKBhR5udK6TGwzn3uMjpw4GSM+46Yaj6Ev/VZVT3jBJFJ5A98RQIZ7VfYct
	 aPiIup7aCMUOXWXnksZMdB1pAJcrvCbOPQElMUFjR9caUl2tWJVKME4cfvxJBcjeWj
	 b/+OwV1+7yUVg==
Message-ID: <1a26766d-311c-460b-b5c3-309750b3f0a1@kernel.org>
Date: Wed, 29 Oct 2025 20:02:33 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1] f2fs/011: use random data to avoid file compression
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20251029093457.183578-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251029093457.183578-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Joanne,

On 10/29/25 17:34, Joanne Chang wrote:
> Currently, the created files are filled with 0. When filesystem level
> compression is used, they take up much less space than expected. So
> the final fallocate does not show an error.
> 
> The created files are filled by /dev/urandom instead to ensure they
> are not compressed. This way the files take up the same space whether
> compression is used or not.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>
> ---
>  tests/f2fs/011 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> index c21cb586..75679b36 100755
> --- a/tests/f2fs/011
> +++ b/tests/f2fs/011
> @@ -35,8 +35,9 @@ _scratch_mount -o checkpoint=disable:10%
>  pinfile=$SCRATCH_MNT/file
>  
>  # simulate fragment status in f2fs
> -for ((i=0;i<256;i++)) do
> -	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
> +dd if=/dev/urandom of=$SCRATCH_MNT/0 bs=1M count=1 2> /dev/null

IIRC, $XFS_IO_PROG is preferred in xfstests [1]

[1] https://lore.kernel.org/fstests/20250326140938.6ll7yeez6iwabvgi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com

So, what do you think of this?

for ((i=0;i<256;i++)) do
	$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 1m" $SCRATCH_MNT/$i >>$seqres.full
done

> +for ((i=1;i<256;i++)) do
> +	cp $SCRATCH_MNT/0 $SCRATCH_MNT/$i
>  done
>  sync
>  

