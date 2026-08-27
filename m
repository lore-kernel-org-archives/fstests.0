Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41D3FD12A
	for <fstests@vger.kernel.org>; Thu, 27 Aug 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843663; cv=none; b=ux9VSWXaKZFz4fJ1BiZ5neNZfJHtZeyRBsAxh9uapW0wfBBEVN9j8UvOtz7wOital/w5JYpwyiFgFQXV9DSZ8U2txOJP4sa0WUeJKqmr60639zXvVMD4YVLfCpB//o9D/ooYOhowL9zQS/yvskzQHQjeUJ9/tZfs8uhTB3ER/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843663; c=relaxed/simple;
	bh=4T6WOc3F4eIcaU6/5/c851Y3MOW1D4dbQ4DLxmTdtyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCyjP2vBuScJX6NKogMn5aCN0VJ0ajBH9qJCtL8/Ge3YJZpH4Do8EEvnrXW64QKjDZ6mtVN1MeKU+lzZyAdkisDIp9F/L6SIUU11qjOTFronhymST/SfApwE1BiYzKSYDGdY8eSROKVE/s5qzV9w8gxhIDa0ZErE67ikULFqZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOdxEne9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOdxEne9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7611F000E9;
	Thu, 27 Aug 2026 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843661;
	bh=vA7jbxZKli9Jq8o74UyQz0r/T0TSg99fWoaZ8lqGrgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oOdxEne9ofTs0nzrLzUU77abjtyXW6LsykPq2jVROhEnMsgDSBFNktEAZD4+W4hb1
	 q+gVodfODPFNGw4PlLnwW/UiLz+VHiXEKi89aI38//JsdTgUtGh/qRhF/Xe9vEWm5j
	 IVo3JqIBonLIOKhx1LRwZTznctnDgbePQ74UwZE+p7hV87cwxSPJ2g7bLd4bO/rBBM
	 UWMmoVUTej5kEIuuQcUWusmQytUgT2NkHwSJ0UA767JKDdK42UtM6LzanbNucxjbKN
	 lgSRNYT8G2EAEaodqNfj+3Jbpb28TrN9ACMBL4u1cwBCyf6SKg8RvGd/vm/k7gGt0e
	 4Ir/9iht/pNjg==
Date: Thu, 27 Aug 2026 23:14:12 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] Add _require_chown as needed
Message-ID: <apBHC5UVZYiHZzbw@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>, 
	fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-4-sandeen@redhat.com>
 <ao8dOPXMBJtSbTXv@zlang-mailbox>
 <ecf63a4a-2e6b-42cf-8a58-51780630b3fd@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf63a4a-2e6b-42cf-8a58-51780630b3fd@redhat.com>

On Wed, Aug 26, 2026 at 02:56:42PM -0500, Eric Sandeen wrote:
> On 8/26/26 12:52 PM, Zorro Lang wrote:
> > On Mon, Aug 24, 2026 at 07:11:10PM -0500, Eric Sandeen wrote:
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> > I doubt there's any filesystem that supports `chmod` but not `chown`.
> > 
> > Reviewed-by: Zorro Lang <zlang@kernel.org>
> 
> Yep, I'm not sure why we have both helpers, tbh ...
> 
> hey, you asked for ful _requirel annotation so .... ;)

Haha, I just wanted to add the same _require_ to patches that were
copy-pasted from the same template. I wasn't planning on updating all
cases across the fstests. Generally, for test cases that are already
merged, we usually don't add extra _require checks unless there's an
obvious failure. Anyway, since you've already gone through and updated
everything, the current changes look good to me:)

> 
> Thanks,
> -Eric
> 
> 
