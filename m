Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE45248166
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053939; cv=none; b=o6VmPM52dQqVzJW5Z3ZtG6+cA7WgR6W+t6/fSRxZzismVvdR3itqZxNGg4kIE9ojTtzS0uRRHprURl+8deP/1UJzKm6ES+i/s+I5URbxvYKLn45zjgQ6Iu5w8geFDuDRMKtE0iCXP7zO3dpjSMSfjVr4u6G0V5HJ8ejFlzfAifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053939; c=relaxed/simple;
	bh=d5xZBJdaHnpl09aYpfOi77JeRenCHEbx5sBAxCZNEn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc2czzXypwi4kdvX5ELmmUGD+cPjJLjUzsd2lsGHkTm73DlO7w/mjrvINcOCJnunEZ0/LWhA6zU3DGXQo31qcFMpi+IihzpyKtpX/coq3F3P5p0bhX1HiEvwRlf11Nj1CKCGK8shyjJJjmPm9GRJF8g5nyF7EkCwy8K+bDfz544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm9tsOq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm9tsOq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7847AC19421;
	Wed,  1 Apr 2026 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053939;
	bh=d5xZBJdaHnpl09aYpfOi77JeRenCHEbx5sBAxCZNEn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mm9tsOq2v4LuKpr88bBG1BdjamDv0aRHPxyyJkbQv2cGyCYNWJp9aFHRLZGgmTZGN
	 3uxhsigXot7TpEG2vJfGnC4ayWsvypQvcM3K5YlMz0dkEh7dEbaW5gFB6GUIvHqCAV
	 819552L3QhuVwSvKVP8iGdjFPyRWU+4Il2Q6smDJj4uvwO+wfe4ijtJE7vGLwQcAle
	 /lMvzx3ZN5k4xl0v2XChf5rzmXtK/81PV3Iw0yaLMqHMmmhgp5KlISDz0KnYfTh/JM
	 dkyVIPmysX+SNw5zFj+1AXs6jUSyrjgW+qj4M4tLuXzU/aMiDqJhZlUELSLGc/f8LN
	 o25saAzTyewOQ==
Date: Wed, 1 Apr 2026 07:32:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/4] generic/775: Fix an infinite loop due to variable
 name clash
Message-ID: <20260401143218.GI6212@frogsfrogsfrogs>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <d1a7045002ded5d9e68347ff0fec41a86ff3877e.1775039135.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a7045002ded5d9e68347ff0fec41a86ff3877e.1775039135.git.ojaswin@linux.ibm.com>

On Wed, Apr 01, 2026 at 04:10:50PM +0530, Ojaswin Mujoo wrote:
> We use i as the iteration variable in the main test loop as well as some
> internal loops. Due to this clash, $i variable of main test loops was
> getting modified by the following loop in prep_mixed_mapping().
> 
> 	for ((i=0; i<num_blocks; i++)); do
> 
> If num_blocks is less than 10 (example ext4 with blocksize 4k and
> cluster size 8k) i would always be set as 3 and the main loop would
> never exit. Take the simplest approach of just renaming the variable.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/775 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/775 b/tests/generic/775
> index 2a4287bb..19ae95e2 100755
> --- a/tests/generic/775
> +++ b/tests/generic/775
> @@ -41,7 +41,7 @@ prep_mixed_mapping() {
>  
>  	local operations=("W" "H" "U")
>  	local num_blocks=$((awu_max / blksz))
> -	for ((i=0; i<num_blocks; i++)); do
> +	for ((j=0; j<num_blocks; j++)); do

You're right that the single-letter variables are a really bad idea in
languages like bash/python/etc where functions can see variables in
caller's scope if they're not explicitly marked local.

But a) why not use "local i" to prevent that; and (b) if you're going
to rename it, why not "blkno"?

--D

>  		local index=$((RANDOM % ${#operations[@]}))
>  		local map="${operations[$index]}"
>  		local mapping="${mapping}${map}"
> -- 
> 2.53.0
> 
> 
