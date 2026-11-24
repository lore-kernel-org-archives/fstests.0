Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551653;
	b=AbdjM0oUEaEfflQ0LmXgEV1ObBz2l3sRNakGidxH/2tyMQO/U8qqaV8S1LZD3rEyR0P5
	 7VjJb9G3W6r4cBrVgG7rl2Q7EJ1oxGeKex51evu5vYgwpSybjHdAqQP7tIbFLuGBn2BKp
	 eJEqpemy1U8+BCqGW6lywCWoqd7JDq+lagY2WsNgtUGWwij9ZZSLH0mq8PyeXuOgQ2jh9
	 6jprjtwFSsMUR5bwGAidg/1P9ZjNE2//xWaf0ZUacH4MlfLptYaSIY9GSVZ752+L7cFyL
	 0dGNojInmy4tyOq1wvWOQCvHEZpYtkAtbS1JTdYgmHXOT1ZjM4ibOmt2hoO/rRGk9xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551653;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4u6gCTBN02Qj/qC4z3dWPUkB8GxVKQBxJddjcpuEnWo=;
	b=QXY90ncaB8p1eyUtlGsk7NLitvlqzNrX2kalc72vrG4lV2IoI/y3xKtYewDymCiJZIZj
	 ce/MjIzpz7VzdFUlv0Gt8QBMQUDZQh11zisQWqz4dgrt2+HQOn3Nj/vXXhYOpIoXmput+
	 GCWVnwo7QaDdRhdd8u9da61z5DvSWBNTyuKlgLwK1ZfRWKfxA1MdDEP8BhTZjsCTIDxUy
	 /xlr94xNHgJ40zegYfxiZMUaoDATwsnYBUcoeIFja4J5RnUJkdQSceXZ0U4fn3QsbbLP4
	 04Mtv8uPPWmH5QBCMRJH3IMS0uwgAt45LgPc7QH8JjvNqjpHujXzCKU6/FxaYsC9o0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5ulxac9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91285606A321
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5ulxac9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39AB1F000CF;
	Tue, 24 Nov 2026 20:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551653;
	bh=4u6gCTBN02Qj/qC4z3dWPUkB8GxVKQBxJddjcpuEnWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O5ulxac9ACQZIG7BypwqjQTZttgnog7KuZm6CeaoiK7A1UisUMCZ37l2pzoaFHsey
	 KqGFBUFHU6qzibAAG5uEpgszGa3Zmq5jiiBrc56vzEgQBkbkWAAAYWa74VXsKL+Khs
	 VsFXRC9/dtkWlSi9JCdjAALZnGM7jxWnhLjOinU+IrX4e+UPQBjRn5VyUWwe1WNp+T
	 u6mGys8wcgTTVS6wG0jVP0CgDgue/a/rD4Vhqc2EIkFEImFk1aFfO8M/USK5Fg9LZu
	 c1SQemrHPaAs7VhLZ3ipSSdtbKmxc9Zha7/q6IKk+YpMRkOrXgaucC82GZl26bYm2y
	 DsPVD4IwY5RTw==
Date: Wed, 25 Nov 2026 04:20:46 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 2/2] xfs/349,xfs/556: both these tests require online
 repair in the kernel
Message-ID: <awXw0TF3yf7pM_f-@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests <fstests@vger.kernel.org>, preichl@redhat.com
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-3-aalbersh@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124103617.4012647-3-aalbersh@kernel.org>

On Tue, Nov 24, 2026 at 11:36:15AM +0100, Andrey Albershteyn wrote:
> Both these tests run xfs_scrub without -n (scrub only, no repair),
> therefore, scrub tries to repair found issues. However, without online
> repair enabled in the kernel scrub exits with a message that online
> repair is not supported, breaking the golden output.
> 
> In the xfs/556 case, online repair will not repair anything but just
> prints a message that unrepairable issue found.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  tests/xfs/349 | 1 +
>  tests/xfs/556 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/xfs/349 b/tests/xfs/349
> index a03ab812dc9e..0940ced42121 100755
> --- a/tests/xfs/349
> +++ b/tests/xfs/349
> @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
>  
>  _require_scratch
>  _require_scrub
> +_require_xfs_io_command "repair"	# online repair support

As neither of these two cases explicitly runs xfs_io -c "repair", I think
the comment could briefly mention why the online repair command is needed,
to prevent it from being accidentally removed in the future.

Thanks,
Zorro

>  _require_xfs_stress_scrub
>  _require_populate_commands
>  
> diff --git a/tests/xfs/556 b/tests/xfs/556
> index f5ad90c869ba..022a8e674a5a 100755
> --- a/tests/xfs/556
> +++ b/tests/xfs/556
> @@ -26,6 +26,7 @@ _cleanup()
>  _require_scratch
>  _require_scratch_xfs_crc
>  _require_scrub
> +_require_xfs_io_command "repair"	# online repair support
>  _require_dm_target error
>  
>  filter_scrub_errors() {
> -- 
> 2.54.0
> 
