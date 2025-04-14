Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B70DDC3
	for <fstests@vger.kernel.org>; Mon, 14 Apr 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656700; cv=none; b=Bgin+jjBxdunhwxwcCYp1RAiKs8FdbmThptKI9M5CgyEBgD4LnyU7o0HF5ochi31ey1+/dfDh365Cmgx1Ny1dhKhdSYroDfVBBKIcRwdvpbWu+kdqJL3k58StWc/m1O3DDah6iBGaX1TNezbdj7UEOmVUZx2H8sXEmLjl77sVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656700; c=relaxed/simple;
	bh=x6DkU9kLxc4s51hy2fQg/mW9af2D6qYU1TlPl2cZLRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsnCSs94Qivnm7zdG4CjsanVVFVu9547xo5LWp5z8BoJuAx9jYYNUYtFLO2NICMWNSwUlbk8UnaqixPi/7hTgCjnFVVLwHQ078NRbCP0KRRXrJWauzN+5iajguCNmx4BNr27bsqDpHV5k4d6mSrn1raszGwLJttVD6vMkWLmKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP1UQues; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP1UQues"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F713C4CEE2;
	Mon, 14 Apr 2025 18:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744656700;
	bh=x6DkU9kLxc4s51hy2fQg/mW9af2D6qYU1TlPl2cZLRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZP1UQuesLbxJRMa+anI6RJxmPJ9kuN3gZX5asuX2gRASk4VDdE30e281jHJZVAw53
	 tLXwpT+dD90Zx+QowdaZn0O0pqbWKa+MP2vFYePRrHpWm6OfAs9BOezYwehbnBtErY
	 BQsD36JSp66XY52kELlwDxF4XnOdsiqhgOOKeiqouDnSWWcaAk/ShpLHZapTh/Q+se
	 M1YkYUGSxVhgJ7/LgyLxDXRJWKKmU55bgWsP8pxLc4SignHzYBlwyDce/rbAtDVUEa
	 IMuHhZJU2cjcXajkC0sZB3oQ2QJacJfTNxXrs795tZp6Kc3AKD9ChKvLiraB+GqHpa
	 7RJPNmgp47ZpQ==
Date: Mon, 14 Apr 2025 11:51:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/233: use relative path to invoke fsstress
Message-ID: <20250414185139.GA25667@frogsfrogsfrogs>
References: <20250414115820.399980-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414115820.399980-1-hch@lst.de>

On Mon, Apr 14, 2025 at 01:58:20PM +0200, Christoph Hellwig wrote:
> This test uses su to run fsstress as $qa_user.  Because the shell calling
> fsstress is run as $qa_user it might not be able to access the xfstests
> or parent directory which might only be accessible to the user xfstests
> is run as (e.g. root).  Switch back to calling fsstress using a relative
> path, partially reverting the effects of commit c475ff6ff6d7
> ("common/config: add $here to FSSTRESS_PROG").
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ooops, I missed that subtlety.  Maybe we should document that?

	# The absolute path $here might not be traversable (+x) to the
	# qa_user, so supply a relative path to fsstress here.
	if ! _su $qa_user -c "ltp/fsstress $args" | tee -a $seqres.full | _filter_num

With something like that captured,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/233 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/233 b/tests/generic/233
> index df67b39092b7..91dc554d3478 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -43,7 +43,7 @@ _fsstress()
>  	# temporarily.
>  	ulimit -l unlimited
>  	echo "fsstress $args" >> $seqres.full
> -	if ! _su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
> +	if ! _su $qa_user -c "ltp/fsstress $args" | tee -a $seqres.full | _filter_num
>  	then
>  		echo "    fsstress $args returned $?"
>  		cat $tmp.out | tee -a $seqres.full
> -- 
> 2.47.2
> 
> 
