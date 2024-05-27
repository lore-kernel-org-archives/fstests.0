Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2515ECD7
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814882; cv=none; b=lkCxst1e16bNqPl/JuwMgb+VsURzjjozWXmNue+dxjOIjfk4/12/VCxe/WAiI9XLwUoFeOoJ2oWysb0OUJzOZVaLx6oe9OLLt71gH0K65TyxRAmhncBKLDOx/AMaO5+GzaGR+Lit/oFo6yvhwk2X8zFx0s9/mCIXRDlwsxhZNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814882; c=relaxed/simple;
	bh=fOBZRx39m18MhETTtE9khHwmQUJvDG0kMS/N+tNg76A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc8EFdONpTef8UrkvRXmkjD4IMCdGxcXSt8IK4IiOkId2C1pl660+5w8idbhMPWk3HZtzMHLvrzcnzsiow8EtImFNBxjv2LQyN6OssVG596iFKkzBOz2pS/32TZcF+cF2/Y1yblIbWFdP+hoO29aI9wegSW9TO539hLZ3U51Opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bcS4MZdJ; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bcS4MZdJ"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vnwkf3HVKz9sHh;
	Mon, 27 May 2024 15:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716814874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qdNJnDzVfXiml847Ypfz2FiFdgTtzOzPgO/dNfonCI=;
	b=bcS4MZdJ1iU3QBSUVCmy2+L5IDGdwCTKayCjPJFYPGFphgZ/qSe6RuuQQQaJ0eis7Xhbxm
	eiUGB18+1BZ1ZKeheZD0lYZY/OloxHhfFZtUbepvsBLvTDw6RtFeq5P84t60lbkM7PAO2G
	XVczZnjfeTYBuUBkBV0t8P7+iHMEfJZSKcyZ68YuPC5lYSnBfMwd7nJ1Uo4obrabUK2OXp
	2u6FM62PJShrLgbEUDLUVGUyaNPVNMyqK34+K8N9ouV3Xdt7JjqNXbVMQPBe8olBeoI8rv
	5KvHsA5OdCMfwm025SLJvxecHQwXrnhMyTGkMx6vCWhWUIdKDPNNE+b7ceGeBg==
Date: Mon, 27 May 2024 13:01:11 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: ritesh.list@gmail.com, djwong@kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240527130111.hyoigq32xaxxpc5x@quentin>
References: <20240527114834.167521-1-kernel@pankajraghav.com>
 <20240527114834.167521-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527114834.167521-3-kernel@pankajraghav.com>

On Mon, May 27, 2024 at 01:48:33PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
> while filling up the buffer for test 13 - 16, round up the bufsz to the
> closest filesystem blksz.
> 
> As we only allowed blocksizes lower than the pagesize, this was never an
> issue and it always aligned. Once we have blocksize > pagesize, this
> assumption will break.
> 
> Fixes the test for LBS configuration.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Looks like I missed the RVB from Darrick [1].

@Zorro could you fix it up before you commit?

[1] https://lore.kernel.org/fstests/20240517155437.GK360908@frogsfrogsfrogs/
> ---
>  src/seek_sanity_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 48b3ccc0..a61ed3da 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -643,7 +643,7 @@ static int test14(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -692,7 +692,7 @@ static int test13(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> -- 
> 2.34.1
> 

-- 
Pankaj Raghav
