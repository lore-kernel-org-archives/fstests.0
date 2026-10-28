Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207385;
	b=VbJ5pHmCr9M7+UveF6DNIgQKamrvLz/nLKQ0/Obsgg8CRqyF/Wx9yMgHyI0pgLV5ov8J
	 bwg4ypTlvD8QAPnzbftC5WKlTbO1hHR8YEU1fifeEKa8OQqQKd2ELw9gjoLNuRC4xSHhq
	 R8mBTiHNzoSp9fhaXPEKP9JXGma3v70PBXHM5aj/7MFhsB7rZfsAE5ioV3+IMhLjac1V3
	 OJFdxg2lOQ17MGeU94HrcTJxK3baQzhssoYVZAe8Z74zBmplW7iDa8/ENXzhMMBnCV1+3
	 ++ALxhX3ZQuA3XnxWRuzyY5/B0UCwge0IvIQlH3haz5q2ber8eEzfsdkYXTsrW0+BUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2xgBp2YSeBo3Q/NCEu2AtR7FEuBhT4AHoZ8P53VrU48=;
	b=dstW7uFGRYBvskTFYPlPSRzatPgpSkvdhqIIRUEXIN2GWgz+HMi7NvFgFOfaOkvCY2PE
	 Lzfzgb1fvLJp0+xbJkH5Si0gBvBNbv5VUPlrxLbwo3XkfMmnMaJGJYJEh2c6gcVgr9KvH
	 VndWGVJV5r+qgZw0Un00x/8YH3goDR68ihAlt+wnBf1qlNdAuCRVynGIfWCenSsdfK3Lu
	 NfInT6toyqdHEa+fikLXufBCMSeCPABrBm/3SK0lmMDlSw4f1iZHpLn2FTxDdKTUpgvK0
	 mNjUqGOmoOOKmEjaODr+lxeTGb+f62xzIyVLlbSUq0YaSOnwLA0QWdEGmY+ea4X5xPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkctEGZk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC22606A31C
	for <fstests@vger.kernel.org>; Wed, 28 Oct 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkctEGZk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AC11F01825;
	Wed, 28 Oct 2026 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207384;
	bh=2xgBp2YSeBo3Q/NCEu2AtR7FEuBhT4AHoZ8P53VrU48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkctEGZk5HarFJ6/4o76we8AZEnyQAdGAHf5B8YlPx2+Z1FrP/FEO69R0L8wMdOhR
	 m/vDoOtRe8xxPUuP+vvXe6/KAm41ANB56tuFU5vjlHYES5q0BvffNyB6i1fDqQTK/+
	 zVd4iCjq1SpW9DBzm8KdEcFGI1I7iKI+i+LPzO9N/RFzXTj2dWxTnlRpGlcxbzuO4v
	 cigGa1oJRfw/ec3v8wRxIuD5SLjeSbwwqnGy6SZ0aljQbRditfwfrMaHpry3ne0rxK
	 XhNYfL6aCPpGTMDk0FhB1DFjlNMQyTbp4ugwaJszFZEF6ay7Vr725hQrYyp7txn1XY
	 5YgYA0t/xCqPQ==
Date: Thu, 29 Oct 2026 01:09:39 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] tools/get_maintainer.pl: accept and ignore
 --nogit-chief-penguins
Message-ID: <auId2GI01gShq9uf@zlang-mailbox>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, 
	fstests@vger.kernel.org
References: <20261027-b4-v1-1-a87dca9172c9@kernel.org>
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
In-Reply-To: <20261027-b4-v1-1-a87dca9172c9@kernel.org>

On Tue, Oct 27, 2026 at 09:51:54AM -0400, Jeff Layton wrote:
> b4 prep --auto-to-cc passes --nogit-chief-penguins as an option to
> get_maintainer.pl. Ensure that it accepts and ignores it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Makes sense to me, thanks Jeff!

Reviewed-by: Zorro Lang <zlang@kernel.org>

Just out of curiosity, how did you configure your environment to trigger
this in fstests? Did you symlink "scripts" to "tools" (e.g. ln -s tools scripts),
or did you set some b4 git config :)

Thanks,
Zorro

>  tools/get_maintainer.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/get_maintainer.pl b/tools/get_maintainer.pl
> index 671ffe26a799..02c02eea3e67 100755
> --- a/tools/get_maintainer.pl
> +++ b/tools/get_maintainer.pl
> @@ -31,6 +31,7 @@ my $email_fixes = 1;
>  my $email_list = 1;
>  my $email_moderated_list = 1;
>  my $email_subscriber_list = 0;
> +my $email_git_penguin_chiefs = 0;
>  my $email_git = 0;
>  my $email_git_all_signature_types = 0;
>  my $email_git_blame = 0;
> @@ -228,6 +229,7 @@ if (!GetOptions(
>  		'git-blame!' => \$email_git_blame,
>  		'git-blame-signatures!' => \$email_git_blame_signatures,
>  		'git-fallback!' => \$email_git_fallback,
> +		'git-chief-penguins!' => \$email_git_penguin_chiefs,
>  		'git-min-signatures=i' => \$email_git_min_signatures,
>  		'git-max-maintainers=i' => \$email_git_max_maintainers,
>  		'git-min-percent=i' => \$email_git_min_percent,
> 
> ---
> base-commit: 22348afe338c0f6d540c0d7ef0db749eaa51b218
> change-id: 20261027-b4-5ff755f4716c
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
