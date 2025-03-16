Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2596134CF
	for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742136873; cv=none; b=F3zMY1b2SQYsXUOnIX9WXt2IGQwG6TYGHca5uoyw5v6AUmUokJ5tF/ZLsjH/vB8ELahIfDMZ0iLv+cuIEexE1B1r+0IU//CYu+3uB076D8WPfL3lgEOUmsT3iR5wQYbHchbis+rHgLfEs94Q11SUGXgetI+dJIpKR82aZVArpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742136873; c=relaxed/simple;
	bh=RHnlK3xQFYy11E73j0F0HIMUaGAkIcprphSPxApHOx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJSkkHAxkDnsHGkE7F+lx4NNp4iSVSazwrRyJkIOnc/mCeAuvAZRkXSxGEYSvaQc0eXDmVX5yign7+EnemT3a4wnY48sR6XSZZzjPPGFAQBtzqVMHx8OPxPPocov6jL4fDOeSEcwssufYjas5HvJGll/V99wxxq2JEK8kPVsxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOhVhLrA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOhVhLrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742136870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPw2nLMEMICPBUWtN/xFxEv/zhnjjTdte+ujvsynnTM=;
	b=XOhVhLrAZUOk2fG9/Jb4F99kE+PaDZS3OknBnVAVRZiyVHq919yVajPU/t+ccvi819h3nT
	OdIf5KrCY2dAspRt/Nv3fbRsXCscjEij7HmTSiPqrOA8Pqpj8H4xs++R2oyi4mwEzyBiYy
	e6DHpKSEqAGA1l6L/DMVkhRVhQebdRc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-pxM5blORPNCxZa9U3Q3WzA-1; Sun, 16 Mar 2025 10:54:29 -0400
X-MC-Unique: pxM5blORPNCxZa9U3Q3WzA-1
X-Mimecast-MFC-AGG-ID: pxM5blORPNCxZa9U3Q3WzA_1742136868
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2217a4bfcc7so58340675ad.3
        for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 07:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742136867; x=1742741667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPw2nLMEMICPBUWtN/xFxEv/zhnjjTdte+ujvsynnTM=;
        b=X+MK86rPmF+D+EjYR8FdLCd7lMl/eaoHCIe8QNu1IeLrCT+k+Ga9E8m6Z/IdJIY0TZ
         pzpWijtu2ANR33nB6/uAXWzGeHDcPCiMCxRcIqW4oCvDRfFM9rQ9gYPduTXdEk9V3P6E
         OagQXnrYkAF3oohD7mnoEBi20iYf2Akjdugryx/H0cvHHMnIAVzwmPKeTs8Gkc92Ewlr
         bHc2+lnv8GzsqqE8pLb9FUhRyKeAjblUqZbbq43pI9Bh9BmewotOg9rtmntN6H9iLU9A
         nMYwNwAGQ/A5akH03WorN3ARdjNQu2KsZpvjw/V55NebDjd3AHvO8qVyjsmxMmUn+weV
         Y6bQ==
X-Gm-Message-State: AOJu0YwmY55kzgwb7MvYTM9bswVrXMn02Bw/kVmyy8AzOddY8pwFBYSu
	Daz7SGDS0uL6KesWNUcyfxHHac+4e+VZXSj7P31T5h1eB4dMv5B0w8p57/BBQvHj6AFL5SpxqNI
	0l+owwOpGITlpaxiBT8BU39q2u5h51etlFcRoiPx3U3wGkoPUFU5aAJM=
X-Gm-Gg: ASbGnctxDPvHjvv+SQ3Yi16ysNwohBW0+eOknoG5kMB2ngLjHeyo+MB5/+8XEZWskfQ
	FeX4hQ2J3DJgEeBiEOkNfk1hIy/e5pNIOQuEKndFpS3xdiDv1FhHYiXmC1ZimAYSKzD1RbVuoxv
	7LGRsOZ+qxy+lZ3VTjvEYKkuaWuupnFpeXmMPrZNQf2E+goc2qW4DuGb2ID/ZvRH/PvC+XCjo/D
	0EHuPk81aqJBBN5RqN5/Ny5RWIa1g6Dtcqxl0+uYbBO7BnvSAkSZooMPwDM1ikvqjOu1X02GkNu
	Vo0VbHmG7M0B27HotbPxtdpeEO84pcZXIM7cF7HBcl33RzntTGeDZSEe
X-Received: by 2002:a05:6a00:1413:b0:736:d6da:8f9e with SMTP id d2e1a72fcca58-7372225268amr13137018b3a.0.1742136867584;
        Sun, 16 Mar 2025 07:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKFWg5VALjvCHMj15aDzW/Jb1kGiNfRrxSUloQKMj4iL8q0+KROkCOYzcfLS+hKW/2McNjGA==
X-Received: by 2002:a05:6a00:1413:b0:736:d6da:8f9e with SMTP id d2e1a72fcca58-7372225268amr13136997b3a.0.1742136867174;
        Sun, 16 Mar 2025 07:54:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115592b7sm6064554b3a.64.2025.03.16.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:54:26 -0700 (PDT)
Date: Sun, 16 Mar 2025 22:54:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/7] lib: remove random.c
Message-ID: <20250316145423.c2ws6hhrozl33czv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-8-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310182954.1396724-8-sandeen@redhat.com>

On Mon, Mar 10, 2025 at 01:29:09PM -0500, Eric Sandeen wrote:
> sparse points out that lots of things in random.c could be static,
> and upon doing so we realize that nothing in this file is used.
> Which is unsurprising since these are all part of the standard
> C library ... so just remove the file.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---

Hi Eric,

When I did the fstests regression test this weekend, I found a regression
failure on generic/007 (diff output):

  --- /dev/fd/63	2025-03-15 13:31:35.044534292 -0400
  +++ generic/007.out.bad	2025-03-15 13:31:35.002455111 -0400
  @@ -14,9 +14,9 @@
   .........................................................................
   .........................................................................
   ....................................................
  -creates:  18736 OK,  18802 EEXIST  ( 37538 total, 50% EEXIST)
  -removes:  18675 OK,  19927 ENOENT  ( 38602 total, 51% ENOENT)
  -lookups:  12000 OK,  11860 ENOENT  ( 23860 total, 49% ENOENT)
  -total  :  49411 OK,  50589 w/error (100000 total, 50% w/error)
  +creates:  18839 OK,  18890 EEXIST  ( 37729 total, 50% EEXIST)
  +removes:  18783 OK,  19951 ENOENT  ( 38734 total, 51% ENOENT)
  +lookups:  11858 OK,  11679 ENOENT  ( 23537 total, 49% ENOENT)
  +total  :  49480 OK,  50520 w/error (100000 total, 50% w/error)
 
  -cleanup:     61 removes
  +cleanup:     56 removes

By bisecting, the first failed commit is this patch. After removing
the fstests internal lib/random.c, the output of src/nametest.c is
changed too, that breaks the g/007 (xfs/188 maybe too) test.

It fails on all filesystems (e.g. xfs, ext2/3/4, btrfs, tmpfs, nfs,
cifs etc). I'll defer the release of this week (03.16), hope we can
fix this regression next week :)

Thanks,
Zorro

>  lib/Makefile |   5 +-
>  lib/random.c | 224 ---------------------------------------------------
>  2 files changed, 2 insertions(+), 227 deletions(-)
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

