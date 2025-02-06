Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F923908E
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882046; cv=none; b=u2uK1HEIthybZvphYt9q3rG4M18YhxT3VbLYejMbNdPODuXrkYW/gDctCluuL4VsQ75J7Nj1zzDDp1zOUJhGNVr9HpdGFedcLl5A4SG2WcDP2NPYkYpvfEp1ts9IYRrI5m+M95PjA47wlNT2OTBVwTU1jrybVBwrQY/658q3moE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882046; c=relaxed/simple;
	bh=sUHcvKjnZPuNrIq0G5P9mPan57QAF5jV5liM2CZfz98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psR+DUwXrKENXpZ5t6DcfYZ264He+IqRMwevLIg+ACaOTqieC8O26crTvSOBmft998nAM7nyNQQCFYbWYPYUxjF8pAUPPxnjSR2F/tjlolRUeRmPxFYL7PhAancudChldOHsV7OEfL8GvCZ32M2fO8BMH8HPrwbV5Fvu97OtLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5xnwzBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5xnwzBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0974DC4CEE2;
	Thu,  6 Feb 2025 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882046;
	bh=sUHcvKjnZPuNrIq0G5P9mPan57QAF5jV5liM2CZfz98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5xnwzBVJ4d9+rg1fbHpamqjaV45lFb62g8WTVeH8nmyRzl8EPEedRuOQJCuW9snB
	 6xWUSv0zHe5TQ0/e7dKfuv/hQJ0ualgbtsVU34t4KWFcRuptMLRvOssu8428j/DM9D
	 6SYcr7lsqqDewJIdLw+B+jOcR2+B4vLWQG4GiaTlAR2jcrfjtpSaJxdnpttWXs1l+3
	 XCdoA5UQttAbi7iSMDpUTFdFVmEsKJRxxNlYf1A2FdxLirI6KjxtGiMaNBMzUOSmUd
	 3LnMkURfMgQZeUuFVEjExgbqfTxuQZ+BthqiDa2z3AuXzANr8PkLyrvwnyMqHLIAib
	 oQtZ4+ne3Gmjw==
Date: Thu, 6 Feb 2025 14:47:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 7/7] lib: remove random.c
Message-ID: <20250206224725.GT21799@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-8-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-8-sandeen@redhat.com>

On Thu, Feb 06, 2025 at 03:20:02PM -0600, Eric Sandeen wrote:
> sparse points out that lots of things in random.c could be static,
> and upon doing so we realize that nothing in this file is used.
> Which is unsurprising since these are all part of the standard
> C library ... so just remove the file.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  lib/Makefile |   5 +-
>  lib/random.c | 224 ---------------------------------------------------
>  2 files changed, 2 insertions(+), 227 deletions(-)

Thus marks the return of Sandeen, Remover of Code!!

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  delete mode 100644 lib/random.c
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index 53540ca7..ce4381a2 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -11,13 +11,12 @@ LT_REVISION = 0
>  LT_AGE = 0
>  
>  #
> -# Everything (except for random.c) copied directly from LTP.
> +# Everything copied directly from LTP.
>  # Refer to http://ltp.sourceforge.net/ for complete source.
>  #
>  CFILES = dataascii.c databin.c datapid.c file_lock.c forker.c \
>  	pattern.c open_flags.c random_range.c string_to_tokens.c \
> -	str_to_bytes.c tlibio.c write_log.c \
> -	random.c
> +	str_to_bytes.c tlibio.c write_log.c
>  
>  default: depend $(LTLIBRARY)
>  
> diff --git a/lib/random.c b/lib/random.c
> deleted file mode 100644
> index d5c81be8..00000000
> --- a/lib/random.c
> +++ /dev/null
> @@ -1,224 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * random.c -- pseudo random number generator
> - * Copyright (C) 1994  Chris Wallace (csw@bruce.cs.monash.edu.au)
> - */
> -
> -#include <sys/types.h>
> -
> -/*
> - * modified by dxm@sgi.com so that this file acts as a drop in replacement
> - * for srandom and random.
> - */
> -
> -/*
> - *	A random number generator called as a function by
> - *	random (iseed)	or	irandm (iseed)
> - *	The parameter should be a pointer to a 2-element int32_t vector.
> - *	The first function returns a double uniform in 0 .. 1.
> - *	The second returns a int32_t integer uniform in 0 .. 2**31-1
> - *	Both update iseed[] in exactly the same way.
> - *	iseed[] must be a 2-element integer vector.
> - *	The initial value of the second element may be anything.
> - *
> - *	The period of the random sequence is 2**32 * (2**32-1)
> - *	The table mt[0:127] is defined by mt[i] = 69069 ** (128-i)
> - */
> -
> -#define MASK ((int32_t) 593970775)
> -/*	or in hex, 23674657	*/
> -
> -#define SCALE ((double) 1.0 / (1024.0 * 1024.0 * 1024.0 * 2.0))
> -/*	i.e. 2 to power -31	*/
> -
> -static int32_t mt [128] =   {
> -      902906369,
> -     2030498053,
> -     -473499623,
> -     1640834941,
> -      723406961,
> -     1993558325,
> -     -257162999,
> -    -1627724755,
> -      913952737,
> -      278845029,
> -     1327502073,
> -    -1261253155,
> -      981676113,
> -    -1785280363,
> -     1700077033,
> -      366908557,
> -    -1514479167,
> -     -682799163,
> -      141955545,
> -     -830150595,
> -      317871153,
> -     1542036469,
> -     -946413879,
> -    -1950779155,
> -      985397153,
> -      626515237,
> -      530871481,
> -      783087261,
> -    -1512358895,
> -     1031357269,
> -    -2007710807,
> -    -1652747955,
> -    -1867214463,
> -      928251525,
> -     1243003801,
> -    -2132510467,
> -     1874683889,
> -     -717013323,
> -      218254473,
> -    -1628774995,
> -    -2064896159,
> -       69678053,
> -      281568889,
> -    -2104168611,
> -     -165128239,
> -     1536495125,
> -      -39650967,
> -      546594317,
> -     -725987007,
> -     1392966981,
> -     1044706649,
> -      687331773,
> -    -2051306575,
> -     1544302965,
> -     -758494647,
> -    -1243934099,
> -      -75073759,
> -      293132965,
> -    -1935153095,
> -      118929437,
> -      807830417,
> -    -1416222507,
> -    -1550074071,
> -      -84903219,
> -     1355292929,
> -     -380482555,
> -    -1818444007,
> -     -204797315,
> -      170442609,
> -    -1636797387,
> -      868931593,
> -     -623503571,
> -     1711722209,
> -      381210981,
> -     -161547783,
> -     -272740131,
> -    -1450066095,
> -     2116588437,
> -     1100682473,
> -      358442893,
> -    -1529216831,
> -     2116152005,
> -     -776333095,
> -     1265240893,
> -     -482278607,
> -     1067190005,
> -      333444553,
> -       86502381,
> -      753481377,
> -       39000101,
> -     1779014585,
> -      219658653,
> -     -920253679,
> -     2029538901,
> -     1207761577,
> -    -1515772851,
> -     -236195711,
> -      442620293,
> -      423166617,
> -    -1763648515,
> -     -398436623,
> -    -1749358155,
> -     -538598519,
> -     -652439379,
> -      430550625,
> -    -1481396507,
> -     2093206905,
> -    -1934691747,
> -     -962631983,
> -     1454463253,
> -    -1877118871,
> -     -291917555,
> -    -1711673279,
> -      201201733,
> -     -474645415,
> -      -96764739,
> -    -1587365199,
> -     1945705589,
> -     1303896393,
> -     1744831853,
> -      381957665,
> -     2135332261,
> -      -55996615,
> -    -1190135011,
> -     1790562961,
> -    -1493191723,
> -      475559465,
> -          69069
> -		};
> -
> -double 
> -_random (int32_t is [2])
> -{
> -	int32_t it, leh, nit;
> -
> -	it = is [0];
> -	leh = is [1];
> -	if (it <= 0)	
> -		it = (it + it) ^ MASK;
> -	else
> -		it = it + it;
> -	nit = it - 1;
> -/*	to ensure all-ones pattern omitted    */
> -	leh = leh * mt[nit & 127] + nit;
> -	is [0] = it;    is [1] = leh;
> -	if (leh < 0) leh = ~leh;
> -	return (SCALE * ((int32_t) (leh | 1)));
> -}
> -
> -
> -
> -int32_t 
> -_irandm (int32_t is [2])
> -{
> -	int32_t it, leh, nit;
> -
> -	it = is [0];
> -	leh = is [1];
> -	if (it <= 0)	
> -		it = (it + it) ^ MASK;
> -	else
> -		it = it + it;
> -	nit = it - 1;
> -/*	to ensure all-ones pattern omitted    */
> -	leh = leh * mt[nit & 127] + nit;
> -	is [0] = it;    is [1] = leh;
> -	if (leh < 0) leh = ~leh;
> -	return (leh);
> -}
> -
> -/*
> - * make this a drop in replacement for random and srandom
> - *
> - * XXX not thread safe I guess.
> - */
> -
> -static int32_t saved_seed[2];
> -
> -long random(void)
> -{
> -    return _irandm(saved_seed);
> -}
> -
> -void srandom(unsigned seed)
> -{
> -    saved_seed[0]=seed;
> -    saved_seed[1]=0;
> -    _irandm(saved_seed);
> -}
> -
> -- 
> 2.48.0
> 
> 
