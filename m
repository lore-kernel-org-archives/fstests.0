Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87087464
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897663; cv=none; b=QLYB9jiqoqBqFcJGw0Pm8PKQ2yqC/qkg97/CcKw+S9t3LPOKYz9M2rTloT0i5/14qnd11whcQBRckxNZbMGkTNZayFXT967mvPrfzioO60QNlgRqFE0Llxj9tVEdpWu3WBr2QonbQtqx0iWlppUyNc+xH7HymZPqk55iO3PQRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897663; c=relaxed/simple;
	bh=/czCXhckrjR3HqpEvAM9pTn4IEqmdovdh9DgmJ5uVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3Ay3VCcHbpCrWWzpYNeehuvUkcK9fpmY79tZ5Rndk+OBGrQDezf55Ce3nBlnzwLjUx9eg9uo22Ie6N1N2Y4OEqitdWQ+eBnR1n9p4UIFP/YUUdbMWJpp2UrSzhg79VV2oTVdbIsE/VY2UJ7kT0taG5MNdcdZuGXNf2dmyVFmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No0slhFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No0slhFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47209C433C7;
	Wed, 20 Mar 2024 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710897663;
	bh=/czCXhckrjR3HqpEvAM9pTn4IEqmdovdh9DgmJ5uVvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=No0slhFJx2gcQxp9EPByAuJqK+/Zr4sBVJ0Cjv5uIWpBkxS/wawFeHyTJGC75gNNR
	 zEce1XbXmaa9pMqNSLqLdRpwL9nb7YhG+f2Ckf7wAW/punSfGJE3fygjhZBRWxVHJp
	 Ok3Vi9mM78UaUy8/JzCU3uGd8YTRaSWWFaTnhXRWdtYIUXaYdl4aWDeIIJ0guQQFp3
	 kllHG/z7DZtpibP2RH4y4OLcZytyXA7+HmHal8Xy6SQCNxBHdPIbK//50yLNSjqVRK
	 Ff66L2PF+ajeQjcOhgmJgHSMmoU+TeyG9hfT4Nifj2TCqFT/yTu1w2c5crQdkKLHzK
	 EOd7veZqB5C3g==
Date: Tue, 19 Mar 2024 18:21:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4/006: take into account updates to
 _scratch_fuzz_modify()
Message-ID: <20240320012102.GN6188@frogsfrogsfrogs>
References: <20240315171325.2885-1-luis.henriques@linux.dev>
 <20240315171325.2885-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315171325.2885-3-luis.henriques@linux.dev>

On Fri, Mar 15, 2024 at 05:13:25PM +0000, Luis Henriques (SUSE) wrote:
> Test ext4/006 takes into account the number of lines produced by its own
> output.  However, changes introduced to function _scratch_fuzz_modify() by
> commit 9bab148bb3c7 ("common/fuzzy: exercise the filesystem a little harder
> after repairing"), modified the output.  Namely, the following three lines
> were removed:
> 
> 	echo "+++ touch ${nr} files"
> 	echo "+++ create files"
> 	echo "+++ remove files"
> 
> And a new one was added:
> 
> 	echo "+++ stressing filesystem"
> 
> However, the usage of 'fsstress' also added an extra line with:
> 
> 	printf("seed = %ld\n", seed);
> 
> So the delta is one line (-3 + 2).
> 
> Modify test ext4/006 to take this change into account.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Thanks for updating the commit message,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/ext4/006 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 8792167bd9c2..b73692aa5b81 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -131,7 +131,7 @@ echo "++ check fs (2)" >> $seqres.full
>  _check_scratch_fs >> $seqres.full 2>&1
>  
>  grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2fsck failed" | tee -a $seqres.full
> -if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
> +if [ "$(wc -l < "$ROUND2_LOG")" -ne 7 ]; then
>  	echo "e2fsck did not fix everything" | tee -a $seqres.full
>  fi
>  echo "finished fuzzing" | tee -a "$seqres.full"
> 
