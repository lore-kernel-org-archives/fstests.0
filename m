Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B244A92F4
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367718; cv=none; b=SrXbNmpxPYZooDB2xcMG68oZtId1nl6NS/9LbpPRk8iXfuhVipXvVP14273HeSdcLjEDfajp+jjNuU9qYqosqOOkDkdr02VuSjVlSxLQ0kWXgJl1xD6DMY3B8NrqVyLSmuI6fldLvnM34QjR38mnJIcpGIG+6AomCAZf6my57Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367718; c=relaxed/simple;
	bh=YZnmMV2FemnVBYwDDYzgH086Irjwp/2zvGnDtx/0w8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaPBNbjx4We/6XgTLIpYHmk73pSOyadg9ppqllwtuzqXlowR6tFkKwUTCbunlW3pInyXOdxl15fG0Km+41MzF/73ZkiSM0oRgaj5kaDr88O06E/lr+OnN8BXmYeFbj8JAAL+nt1wNzKaevjxsbVGOhbtRd5+lzmr31nADyVAwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fazUBOk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fazUBOk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718531F000E9;
	Wed,  2 Sep 2026 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367717;
	bh=vxHAZ5rjGJkjORceE3N6V3Ex3itVORMiO3sGqglODqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fazUBOk99SiUizSTQFAL1KE5URuE2mlzc+yYkYulbtMbqQDQtb3AFEshajRnjUPHu
	 Vo7WBIFhxO08LvjNIpSB8nV+ochCUPUscHUgEwupns2GOOfOfjldPw/Gf5X5XfAcqV
	 mXf0rDReYB5hQ3Fj5swAXp/GdU6k/iCJbAQbOy0yXMloiGNRrBD8hO8e9BVoeVxUB4
	 Q02w0R2nHikJkFmlPhzRkLeI8NX45FMG5i6/KVndq6U7P+Dnpq/oxv3ATE8pSfaEPV
	 jbDgyur3j9ev4wgfMhWQ/odRKjzSzaBd/v1WkWBsqMYGgm2iqLezzoOWTdHBIpZQRg
	 0Mzt27kSMRDtg==
Date: Thu, 3 Sep 2026 00:48:30 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] generic/263: enable sub-block reads
Message-ID: <aphTDUZjt3lTj9gp@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831065120.2578146-5-hch@lst.de>

On Mon, Aug 31, 2026 at 09:51:07AM +0300, Christoph Hellwig wrote:
> The description of generic/263 claims that it tries to exercise sub-block
> direct I/O, but the test currently limits reads to PAGE_SIZE alignment.
> 
> Use the new min_dio_alignment -r option to query the minimal read
> alignment and only limit the read alignment to that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/263 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/263 b/tests/generic/263
> index 91cfbe5253bd..c456d62ebd43 100755
> --- a/tests/generic/263
> +++ b/tests/generic/263
> @@ -15,7 +15,7 @@ _begin_fstest rw auto quick
>  _require_test
>  _require_odirect
>  
> -psize=`$here/src/feature -s`
> +psize=`$here/src/min_dio_alignment -r $TEST_DIR $TEST_DEV`

Makes sense to me (except the "psize" name, I think we should update that later).

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
>  
>  run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> -- 
> 2.53.0
> 
