Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD798200AE
	for <fstests@vger.kernel.org>; Wed, 22 Nov 2023 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWT7MOSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE40C433C7;
	Wed, 22 Nov 2023 23:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700695010;
	bh=I9W/2skD4JLmoYRj1WeRWSHO/tEBgeAPFTJP/l9x2yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWT7MOSRPt1d6aqNnS9rroQZO1Qekd39K1RQwBzfpGu9LMErqrQsUsFhnfg+gmbfF
	 rhkyaY/WeC7APCT4Cndb9zKX5xDv6/asBFuh8vYu7aFJSNd+TNX2qc6AltuPKLZMP9
	 9Lr2M8y3nbHtpc05wDLnTgmzR2jCMKYAM6PpFNyG3zQKRRPwjrC09SyfO6nauTBNbW
	 5Vfwq/w+NyoXcCr+uz5hCE0fMghtoHxaJAonSUQAy7/I2EFQCtAtQxp/2WRVRKVKNv
	 ADdAtyCQZwC8HPbDyo/wkQi06IOOeFh7y+98HiaZhVtR03ChjR7N8xMNHLbbaVrW0f
	 hKCyqCr1YzWKg==
Date: Wed, 22 Nov 2023 15:16:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/581: remove extra escape character from awk line
Message-ID: <20231122231648.GA1541@sol.localdomain>
References: <ZV40XOGNJdru13XE@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV40XOGNJdru13XE@suse.de>

On Wed, Nov 22, 2023 at 05:03:24PM +0000, Luis Henriques wrote:
> Checking the keys in /proc/key-users is buggy, as there's an extra '\'
> character: in '{print \$4}' the '$4' shouldn't be escaped otherwise the
> 'awk' command will fail.  This has passed unnoticed because the output
> is sent to '_user_do' function and the result assigned to a variable.
> 
> While there, replace 'awk' by $AWK_PROG.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
>  tests/generic/581 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi!
> 
> Please note that I'm not an 'awk' expert and I may be wrong!  But if I do
> see an error if I run something like:
> 
> $ awk '/^[[:space:]]*1000:/{print \$4}' /proc/key-users 
> awk: cmd. line:1: /^[[:space:]]*1000:/{print \$4}
> awk: cmd. line:1:                            ^ backslash not last character on line
> 
> But maybe this depends on the awk implementation, although I've tried a few.
> 
> diff --git a/tests/generic/581 b/tests/generic/581
> index cabc7e1c69ab..1a4b571d40ce 100755
> --- a/tests/generic/581
> +++ b/tests/generic/581
> @@ -92,7 +92,7 @@ while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys; do
>  done
>  
>  # Set the user key quota to the fsgqa user's current number of keys plus 5.
> -orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
> +orig_keys=$(_user_do "$AWK_PROG '/^[[:space:]]*$(id -u fsgqa):/{print $4}' /proc/key-users | cut -d/ -f1")

The backslash is needed to prevent $4 from being expanded by bash, because the
whole pipeline with 'awk' and 'cut' is in a double-quoted string:

    "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1"

Without escaping the $, bash would replace $4 with the empty string while it's
doing expansions on the whole double-quoted string.

- Eric
