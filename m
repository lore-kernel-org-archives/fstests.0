Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692051;
	b=Oyumelz+HJcz8ZLDYH2XlisSbliMP+hgF16Vy9ywMaQsHzrqaHNkqFrzRSlY7XBDIUEs
	 byzhiaxKf2GpU4CXzXkC82yuOPdx97+Fok2qDVEWkcrfZVH1wqS99u7LlXwypvspMCtDT
	 vyh3CT/Cdz7qhjnbpCP3qH0cg1U7Vx+i2wjPgDAEIb1x44LfhF9qu1TMsl+4qz+TJRlGx
	 rKJSM5ma4zCYramT28bFG5hCTI0BT0RJL1JqTi/1+MDleOs3EuE9CRtOroSRdaYWqqa2a
	 ceu+D+Ey38bM0FJfuoNm/0BXmUnhwkqPvCQDKP0zoQGHB9djaXi4AlluaryWMfHggxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692051;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=KqzwWnonRTHAQln7fCrKwH8SAkySueb7rruPE0g88jk=;
	b=a9ujg/KH1jTQ6Ewiqvyyj1hUI2zG06jBfqBZm0sMUwnODnlhJ7rsbB6ZSDhhjuvNGkRu
	 tACHpgV19otrCNdQhXeq8UbH0addggrbIhfxy2c55aNO0MVQI73YIK/cpey2bjluy1Gpj
	 31+q/et0OopM8BnsZXmVWzfLfn+G8p3jmXWLo6i8LB6RagKsaYJyCe/hRKYA1U8Q+VwQ/
	 S8EWA1+kFQD/xweH4qVzSurcmOyfBj5ZE8ira3y/qJVEwo1BIdpQctPUaC8uGb3eQh1rs
	 Kh4Tm69/67QMvZX2aCqPosQU+aZMkBC160yegfTslxOWRjXOZVe6pweqZ0kcHUD0vjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A22606A324
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 07:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A22606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAEB168AFE; Tue,  3 Nov 2026 08:47:27 +0100 (CET)
Date: Tue, 3 Nov 2026 08:47:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org, ojaswin@linux.ibm.com,
	hch@lst.de
Subject: Re: [PATCH] check: set seqres before calling init_rc which could
 write there
Message-ID: <20261103074727.GB3678@lst.de>
References: <20261102135730.2143873-2-aalbersh@kernel.org>
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
In-Reply-To: <20261102135730.2143873-2-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 02, 2026 at 02:57:31PM +0100, Andrey Albershteyn wrote:
> There's path where >>$seqres is used in init_rc:
> 
> -> init_rc
> 	-> _test_mount
> 		-> _prepare_for_eio_shutdown
> 			->_xfs_prepare_for_eio_shutdown
> 				-> _set_fs_sysfs_attr
> 
> Which will try to write to .full because $seqres is not set. Fix this by
> setting seqres first, this way it should go to $RESULT_DIR/check.full.
> 
> The init_rc is called in the top context and then per section, however,
> for top context we don't have environment set up yet. These logs are
> just a few sysfs_attr writes and aren't that important, so, let's save
> those to /tmp/xxx.check.full just in case.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  check | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index 534c2cdf7a06..52e4ace34fd7 100755
> --- a/check
> +++ b/check
> @@ -534,6 +534,10 @@ if ! . ./common/rc; then
>  	_fatal "check: failed to source common/rc"
>  fi
>  
> +# The init_rc could write to the $seqres.full, however we don't have any context

s/The //

?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
