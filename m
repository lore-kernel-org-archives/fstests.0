Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272321791F4
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177470; cv=none; b=ZuEeWSZ6DJuftl8ptbVHhvXceSn+De34aH0s4NW+myIU3juAMOJ43ylr5SNGtQEhanwvAysjdDXs7gaXcTWiS8zqZnzzUShBrvro9x801Cu635PY6VeF1pcEKR6Z7i514YMdJC4k7PN65mXpnfFwFT0MEScsSeam/BL/2UueAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177470; c=relaxed/simple;
	bh=H1PqTlmv5a5mEkW0AUI7oVfFZcL8ClY+7soqMkv0boY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiqOFEmAqE5CfPLv858ZCGucRL4eyJ1J42lDY378i0ba+nQeM4jQga7Q2AsaD3tUBnHpCB9hf/HatOdu0VLfleBtvLrxggvDAR47S3ARcZr3kmY3YDhGIFfD8xsqRZf//6g4RPSggcy9b9Ol/4L1DU27kNkMPmpwGOxrM+uI29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs+8fn1g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs+8fn1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736177465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdy3jSOgeleUr81pKn+/TwmZO4lACCen+OcerxwIOnU=;
	b=gs+8fn1gTiMPwAZXvLf8RK1DtOdjfrHdXIHfbRF5DYcIdeX2d4tWKxQtC/ubl2wh06abqC
	9FX2c7sT+vFUJo1Y9Y5lhT9cuoblcOg2nx0StsYOYHGEkCEkkE8oHYtI6yc82V9KTRzkOf
	W88MhG8WayLvY8kffZTpur/89MS48yI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-rMe90lMXMraqDWUjeREIaQ-1; Mon,
 06 Jan 2025 10:30:59 -0500
X-MC-Unique: rMe90lMXMraqDWUjeREIaQ-1
X-Mimecast-MFC-AGG-ID: rMe90lMXMraqDWUjeREIaQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C185195608B;
	Mon,  6 Jan 2025 15:30:58 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.122])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50EC9195606C;
	Mon,  6 Jan 2025 15:30:57 +0000 (UTC)
Date: Mon, 6 Jan 2025 10:33:04 -0500
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, nirjhar@linux.ibm.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <Z3v3sIj1_5s0tyCk@bfoster>
References: <20241227193311.1799626-1-joannelkoong@gmail.com>
 <20241227193311.1799626-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227193311.1799626-2-joannelkoong@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Dec 27, 2024 at 11:33:10AM -0800, Joanne Koong wrote:
> Add support for reads/writes from buffers backed by hugepages.
> This can be enabled through the '-h' flag. This flag should only be used
> on systems where THP capabilities are enabled.
> 
> This is motivated by a recent bug that was due to faulty handling of
> userspace buffers backed by hugepages. This patch is a mitigation
> against problems like this in the future.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  ltp/fsx.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 97 insertions(+), 11 deletions(-)

Thanks for the buffer init code cleanup. This looks much nicer to me
now. Modulo comments from others:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..fb6a9b31 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -190,6 +190,7 @@ int	o_direct;			/* -Z */
>  int	aio = 0;
>  int	uring = 0;
>  int	mark_nr = 0;
> +int	hugepages = 0;                  /* -h flag */
>  
>  int page_size;
>  int page_mask;
> @@ -2471,7 +2472,7 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> +		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
>  	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
>  	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
>  	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> @@ -2484,6 +2485,7 @@ usage(void)
>  	-e: pollute post-eof on size changes (default 0)\n\
>  	-f: flush and invalidate cache after I/O\n\
>  	-g X: write character X instead of random generated data\n\
> +	-h hugepages: use buffers backed by hugepages for reads/writes\n\
>  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>  	-j logid: prefix debug log messsages with this id\n\
>  	-k: do not truncate existing file and use its size as upper bound on file size\n\
> @@ -2856,6 +2858,95 @@ keep_running(void)
>  	return numops-- != 0;
>  }
>  
> +static long
> +get_hugepage_size(void)
> +{
> +	const char str[] = "Hugepagesize:";
> +	size_t str_len =  sizeof(str) - 1;
> +	unsigned int hugepage_size = 0;
> +	char buffer[64];
> +	FILE *file;
> +
> +	file = fopen("/proc/meminfo", "r");
> +	if (!file) {
> +		prterr("get_hugepage_size: fopen /proc/meminfo");
> +		return -1;
> +	}
> +	while (fgets(buffer, sizeof(buffer), file)) {
> +		if (strncmp(buffer, str, str_len) == 0) {
> +			sscanf(buffer + str_len, "%u", &hugepage_size);
> +			break;
> +		}
> +	}
> +	fclose(file);
> +	if (!hugepage_size) {
> +		prterr("get_hugepage_size: failed to find "
> +			"hugepage size in /proc/meminfo\n");
> +		return -1;
> +	}
> +
> +	/* convert from KiB to bytes */
> +	return hugepage_size << 10;
> +}
> +
> +static void *
> +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> +{
> +	void *buf;
> +	long buf_size = roundup(len, hugepage_size) + alignment;
> +
> +	if (posix_memalign(&buf, hugepage_size, buf_size)) {
> +		prterr("posix_memalign for buf");
> +		return NULL;
> +	}
> +	memset(buf, '\0', buf_size);
> +	if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> +		prterr("madvise collapse for buf");
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	return buf;
> +}
> +
> +static void
> +init_buffers(void)
> +{
> +	int i;
> +
> +	original_buf = (char *) malloc(maxfilelen);
> +	for (i = 0; i < maxfilelen; i++)
> +		original_buf[i] = random() % 256;
> +	if (hugepages) {
> +		long hugepage_size = get_hugepage_size();
> +		if (hugepage_size == -1) {
> +			prterr("get_hugepage_size()");
> +			exit(100);
> +		}
> +		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for good_buf");
> +			exit(101);
> +		}
> +
> +		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
> +		if (!temp_buf) {
> +			prterr("init_hugepages_buf failed for temp_buf");
> +			exit(101);
> +		}
> +	} else {
> +		unsigned long good_buf_len = maxfilelen + writebdy;
> +		unsigned long temp_buf_len = maxoplen + readbdy;
> +
> +		good_buf = (char *) malloc(good_buf_len);
> +		memset(good_buf, '\0', good_buf_len);
> +		temp_buf = (char *) malloc(temp_buf_len);
> +		memset(temp_buf, '\0', temp_buf_len);
> +	}
> +	good_buf = round_ptr_up(good_buf, writebdy, 0);
> +	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> +}
> +
>  static struct option longopts[] = {
>  	{"replay-ops", required_argument, 0, 256},
>  	{"record-ops", optional_argument, 0, 255},
> @@ -2883,7 +2974,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2916,6 +3007,9 @@ main(int argc, char **argv)
>  		case 'g':
>  			filldata = *optarg;
>  			break;
> +		case 'h':
> +			hugepages = 1;
> +			break;
>  		case 'i':
>  			integrity = 1;
>  			logdev = strdup(optarg);
> @@ -3229,15 +3323,7 @@ main(int argc, char **argv)
>  			exit(95);
>  		}
>  	}
> -	original_buf = (char *) malloc(maxfilelen);
> -	for (i = 0; i < maxfilelen; i++)
> -		original_buf[i] = random() % 256;
> -	good_buf = (char *) malloc(maxfilelen + writebdy);
> -	good_buf = round_ptr_up(good_buf, writebdy, 0);
> -	memset(good_buf, '\0', maxfilelen);
> -	temp_buf = (char *) malloc(maxoplen + readbdy);
> -	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> -	memset(temp_buf, '\0', maxoplen);
> +	init_buffers();
>  	if (lite) {	/* zero entire existing file */
>  		ssize_t written;
>  
> -- 
> 2.47.1
> 

