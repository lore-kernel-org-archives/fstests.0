Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4984A8A05
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196780; cv=none; b=p6vskWHygg9TaQIWmwEC8JsBBjYpFNmvOCZo9JK/bGh0omx9/y5tvfNwZeABVINVco+ZG6jq8qW16oyyn9qXk4zmsvZhPuoQuLqNSPJC9rFrrm8mvhZONf6A7HjnealhMd/n+I2wsgf1OlgWO9UZfsZTFlYSnm7rGOkYazDrKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196780; c=relaxed/simple;
	bh=WQcI+Qn0pWpkx4VujvukM9QHIU5OSJ+HH4lXBu0AFW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDAh30Y7j37l4+w+kzhIOuEJ7aFOChnVSpzjSpU3HYUlegwYpPdkzbwi8fFJeZVbCTqrOSS2u7HiQ2l/WiyZflUvdAMP2hsGmFW636WahaqlbEerpzjedRwDXaK2OM99S/Ug3SbGi4XNjj92hCNexRAvSN5Tr0bogLXhTGWWXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLyl4u/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLyl4u/h"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0297F1F00A3E;
	Mon, 31 Aug 2026 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196779;
	bh=Y181E5hixP+tXixp8SBFx6VrDEpmnvn6hv4pMZCX37Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLyl4u/hiajSPI0Pastm5BWSQs/vJD+jtm2zyz0O62tq+hVzKFoNxEf1QgkvSprtP
	 PPPXcdqnnKAHFOgiZbw4GE7ORK6Eytw5blQJ/a2VmAG5zN0Pe2Pu2vKSdLzIoNK+Wh
	 qsNWtp2vlSUY2yHiOwLwn8f+BErR9ZuuRpLZh4iUVH5BsdFXZsapVTUGe+V1QD0v/G
	 LgwO3Cpvp8bGkAgA3H6r2elQ5p0dY5ZmC4I8ZxulDSzvmWSENtqEm1lYbZKrEgIT1S
	 aysSOuKdQ5gpdvllUanjtN3NQC2YhhXYw2ZhuvpXpuMHhPmW3mNdSDu1UkO8WJHrCq
	 ggEutR3Wv2Nsw==
Date: Mon, 31 Aug 2026 10:19:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] generic/263: enable sub-block reads
Message-ID: <20260831171938.GE839663@frogsfrogsfrogs>
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

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
>  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
>  
>  run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> -- 
> 2.53.0
> 
> 
