Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F30264A9E
	for <fstests@vger.kernel.org>; Mon, 21 Apr 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242151; cv=none; b=sLceHGv6125EuT4DNT//OGQfVllIRALeHWuPqOinJi3wpsl7JColtNzByB3kITeaedM2qSvUx8lKAX1OdhuIciwNRgki0UQBP9KbqaxxEWBhTy2Go4/8CSAyFaKFtewJcGGh1o+6FqPaqi9Xt+JZ04W3rIXYWtHo4c0eV9qxjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242151; c=relaxed/simple;
	bh=UWUJ2SK8CIIbWWwD7CLFIC6pUMBqbKNHCfE0uGMrGM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GedSOVcJ3LWd3xa82EN07YcHJ0oW/ZoDLp4iX6an57kBJySJbuksgZt8EQe5yDKj7fNLoc2W3Po5FhW/22hPERrg8yOO5qdbRJTQNYcF4cB2lLkd8QxdBmmj7G3lTRob5+tstROq+ljlfUQtSulq7jfabtjLauTyJ1ly+e7OnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2wdKWh2Y; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2wdKWh2Y"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fda22908d9so26998707b3.1
        for <fstests@vger.kernel.org>; Mon, 21 Apr 2025 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745242149; x=1745846949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnrv6M3qGNWmiyy4mcQNYGOX8aPRJC6tFYttvLfN+DM=;
        b=2wdKWh2YFv2uRtGBBAuAx/mMdR/kjTa4n8qtlXRXjEVOlON7y5xCbjAMUg5NkwJ/cq
         1S8PxsaaoNxiFNkzIg4Z4bkSW7uaOwTOplJn2sNzQlMNTPEwtca+sM0q8/bam9Tfhu/E
         oISCGXsujA97vOFeuQrsmu+6VoJjImTyZOpnH3+hgqhglkf7bf/adnBhG5fo9Tt6lad7
         LETKKdKvCStwfWNYuwGPdJzP/bmwrx9oU2jNL8/G5QqogPRVhat1FurXn2GDzDqUtw/M
         QBpulW7XlOLEo+BQdCIKz3C/hOADUdzFFsDuaJsxi8jug4opLUG1FcK851ljDBFTWlri
         hDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242149; x=1745846949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnrv6M3qGNWmiyy4mcQNYGOX8aPRJC6tFYttvLfN+DM=;
        b=r7u46x/xeCO8hfFKYuXXsfLgaSznM/u2NSP9jRP3e/YPzWtMhwAbygIW/r94h8laFU
         NeKD1ZnB0e+C5gl9wZwjj/MMAyxCKVxOwxhxzgqtZrTELe7Y50/EmGAsokJPZB6Pujv+
         iGslxRGvi2YfyUErm0/USmdIQWJK20Iwynad8GwjNH2lucpoHyUdvLF4OaiOleq8Paef
         WuUonA4tNx8pNh8xQvWeBoY/1VhbOgRGgZ4XCF19WEOUa0Ms0w7Ls9SjoQL3l0m1O1Gi
         9lLKQnDj2adbWAtR53XcJl2+rJta3he1gPSUNb1+w5VTtfe9n4sXXFTNHC+xC+WTLymK
         KQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYa0FQsEjxj8nMb6k3UrcOX/pwRDAcCEBDmjwBJxYhGOb3BmFUHNRudkxTJau61r2QR2EsiGqf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxq4jojcAzBo06HzMt1mQryyIMsTWdTo4qnU0byzu4UsJS0pUw
	9q6shTayDagchVS2J/I2fVSdQkzD7x0/NQk/Rp0u5cAfZE1urHislFX5ufiRDr8=
X-Gm-Gg: ASbGncsbPC2Bp8rybCn7eIHoJN1AlWOIJZkH1g17fUCVIVzNTm7yE0d0xQF1GpFl3Qe
	1ljnWL9wcwTsCFsOhhrKEp3X1Ahyq5oiwSMSVyh2F/E1dVr/54Ye9QetqRID/QhJqZA3Xfezf6R
	7mCFwqCzHSEieEwKXuTZIb2CI/+O0TMLuvioCvvZUeU35HDHIbGOH53i4ne+Q8UKV7FFAfeifgG
	bh4Dj+OUOJPmAJ9Fh9Uhs4IjFOkrXJ2sRj3PTQ8RcRlPMsP+CN1w/dKiD3r4oGn4tbqbXlH0ukt
	R4gbJzmwyinNurk6GsC+DizCenn2qqV6HYKm+R9ZAmpBfHueDL76TOBWCzdTC/ALYhZQ9QMxcel
	x/g==
X-Google-Smtp-Source: AGHT+IHUPLRzsMvTGG6DjTpC5SK1gq3/jW3qEfZHb6t7huW6ypf+zkmaSK9c4867GNEx6JiRvdQQ+Q==
X-Received: by 2002:a05:690c:9a0a:b0:705:5ab0:ea07 with SMTP id 00721157ae682-706ccc8e67dmr166681727b3.2.1745242148958;
        Mon, 21 Apr 2025 06:29:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca46b09dsm18942657b3.42.2025.04.21.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:29:08 -0700 (PDT)
Date: Mon, 21 Apr 2025 09:29:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/8] btrfs: do not poking into the implementation
 details of bio_vec
Message-ID: <20250421132906.GA4175772@perftesting>
References: <cover.1745024799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745024799.git.wqu@suse.com>

On Sat, Apr 19, 2025 at 04:47:07PM +0930, Qu Wenruo wrote:
> - Fix a crash caused by incorrectly index sector_ptrs
>   The 5th patch, caused by missing increasement of the @offset variable.
> 
> - Use physical addresses instead of virtual addresses to handle HIGHMEM
>   The 6th patch, as we can still get sector_ptr from bio_sectors[] which
>   is using pages from the bio, and that can be highmem.
> 
>   However I can not do a proper test on this, as the latest kernel has
>   already rejected HIGHMEM64G option, thus even if my VM has extra 3GB
>   for HIGHMEM (total 6GB), I'm not sure if the kernel can really utilize
>   those high memories.
> 
>   Furthermore there seems to be other bugs in mm layer related to
>   HIGHMEM + PAGE, resulting zswap crash when try compressing a page to
>   be swapped out.
>   But at least several scrub/balance related test cases passed on x86
>   32bit with HIGHMEM and PAGE.
> 
>   I have tested with x86_64 (64 bit, no HIGHMEM), aarch64 (64bit, 64K
>   page size, no HIGHMEM) with no regression.
> 
> - Fix a incorrect __bio_add_page() usage in scrub_bio_add_sector()
>   The 6th patch, as bio_add_page() do extra bvec merging before
>   allocating a new bvec, but __bio_add_page() does not.
> 
>   This triggers WARN_ON_ONCE() in __bio_add_page() checking if the bio
>   is full.
> 
>   Fixing it by do the old bio_add_page() and ASSERT(), with extra
>   comment on we can not use __bio_add_page().
> 
> - Various minor commit message update
>   And full proper test runs.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
