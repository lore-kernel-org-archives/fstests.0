Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B716E865
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105462; cv=none; b=F6aTJNqIYHRB+BlQSDLOYfYkiAYntwx3bG/1GcuHU32a05Wm0akMb6oaFpcYgBqWPVJ19DOWoJf8fL5CEFA6Xzju//otb39r6LsSFKHnvCDteYuOzrDv/ucYfVYLCOw6AsD9Nxt894mdWxiIa3R9A0hkJQneoYRi2NXIJnC9Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105462; c=relaxed/simple;
	bh=NSsUX26r7vAZQWPLCDAcmo977ZWLzVvQcfJaa4jlmsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZChXq4PM+Hx+ypViwpFmvFyOyXxxxSsmyCeYZyA8M/xxGMWU/bWM/bQmWEZz3rIKYbZV3Y2ZniwfaH7SsnmDqjMLmKcpFNkx86eBS4/HoFp6+Pya9XmVx0Nhl0FMmsBOGNCigkNV5TZHwPImToyBvwY5RXWfuP5AX081YfZsR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcsRc3SW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcsRc3SW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715105460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOezcvxSVzcfUz4S/Bx0GNXDNNhLebcSp97/GHBNB0E=;
	b=AcsRc3SWQ7WHS1qZGP3SA4xtrudY3fB1kxOlvkiqN/vxFVDUH9ytFSyxrM5D8e9GSpk46e
	L2lBkrlnQfIiaOSfHW5CuOr5Uv0ZKH5/hCt0DzDl5vYNSOHuTYWMlo2DoFK6Zz+mQ37KFA
	/wgsEZVWqswaYpD+44CtItL26IF4yiU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-rTzg_WztMUC8V1MeOEdVrw-1; Tue, 07 May 2024 14:10:59 -0400
X-MC-Unique: rTzg_WztMUC8V1MeOEdVrw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b294c5ebc1so2863514a91.2
        for <fstests@vger.kernel.org>; Tue, 07 May 2024 11:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105458; x=1715710258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOezcvxSVzcfUz4S/Bx0GNXDNNhLebcSp97/GHBNB0E=;
        b=UTnI767rk9gedf/qHpfAa6yFX/zFEj9Ek7TiukTKxRu7mzMurIM5eIJ6Rbh02Ubda9
         U1UQgVSQCQHFjvIp/YwNVZT7h002h4tCqLHlnAyumUryrhE92/KsMkw/++6Z/dGKaGbd
         N/1fzQAJpJolMGwan5QSDRuBaubC6ylhq/dslTwWAJ1wvXjPHOHJ/1SSNSp4JOActHWR
         9nif/cFt48fQhEHhghLuTdU7WTj1kWO8tNW673M7T5OLlVR9VyfNs/n563bEowB/XmQj
         tqINN7LEZalX311KMEr/axbcWE/HT06E3zf5dfXOclwa1oZGhiMvUyV5nkjhexOfLEkx
         Skww==
X-Gm-Message-State: AOJu0YwKqhx00nw1kGPd6wzi+fhk/WehVb1Vs6ay9Ea3S0QNhFF6jO8H
	ldGAhO2JV4jWHwcbi5IZXnZut6t3xAt5QLqymXfmuBUjPLdeH8EUUUboT+O+FPaHY/+4lph1Mqj
	5BqDWLmlxtk9Iy3EC5UwkWZMi1FN7SLittfbbCRuxolc+I5O+cyrd+w5+rGXBL9Tzrw==
X-Received: by 2002:a17:90a:c8:b0:2b4:3a1e:2400 with SMTP id 98e67ed59e1d1-2b6165a14c5mr385173a91.18.1715105457626;
        Tue, 07 May 2024 11:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcpfwOHT3voUtq9XH1Xu55Y7C4xSD6uq8kE+BqyUrJzMKa9rH+rj7gBhkLVJxYr5cdgUQLBg==
X-Received: by 2002:a17:90a:c8:b0:2b4:3a1e:2400 with SMTP id 98e67ed59e1d1-2b6165a14c5mr385154a91.18.1715105457134;
        Tue, 07 May 2024 11:10:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090a71c500b002b436698285sm8395711pjs.43.2024.05.07.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:10:56 -0700 (PDT)
Date: Wed, 8 May 2024 02:10:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, gost.dev@samsung.com,
	mcgrof@kernel.org, ritesh.list@gmail.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240507181051.3kclut23noosrmoe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506150119.184097-3-kernel@pankajraghav.com>

On Mon, May 06, 2024 at 05:01:18PM +0200, Pankaj Raghav (Samsung) wrote:
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
> ---

Makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/seek_sanity_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 48b3ccc0..bc30f77c 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
>  	int filsz = 4 << 20;
>  
>  	if (!unwritten_extents) {
> @@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
>  {
>  	int ret = 0;
>  	char *buf = NULL;
> -	int bufsz = sysconf(_SC_PAGE_SIZE);
> +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
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

