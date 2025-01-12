Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585C819
	for <fstests@vger.kernel.org>; Sun, 12 Jan 2025 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655395; cv=none; b=VsTqKij0yUrnR3Opgeuprt4lMQpSx8Qwn2eZGU/WiSuhRzrnfe3N5iXq0cE3LZAeyQ2GYqmGYvpJ/ieO3JfFCwXu4w6Cx746PV4osJjppBHy8AbzxdciaUpLeSOj4bBk7JlNrn2pz8l3g24ZaAaXh9rfcTu97VNcX+eDaDRdYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655395; c=relaxed/simple;
	bh=7hHc1pSQH1UlR5jDDmAUy5Fra0CcdoApO9uHV9L8OKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LciB2J/oE5/7zcc9Eplp5mk1Bh5n4vRrtTlFWmHXSfz9nWIaZUZd/xtww9ekUQfoxYgaiOprBY5DS30oEZK6OoUXxty+K3fVOihvcJDYMcH7VGGDU5YgK2LQtzIr6OgGKqtP7Hdfx4suSrwuBAl0sEHMqyNpLGVLvK20Lqtrzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/QwmhE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/QwmhE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736655392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTY6TMmCzfQlzVIQg5Y/MHXa+8quUBbVQp5dpY6lhXU=;
	b=D/QwmhE9b3EGSYjvzou+m66fgce6U+6kKw8VpHZ4xYuPfAJ8hKzVqLUzH3i/c+W8Vuf1Ec
	gSkVbiaiJd53ymU2JolmEqHlSivEl2FQ2SrQArkzP4qI/ycOcryH2sKOq479/FuW2LMSjh
	Y/ZuE98YLkyt2Qa8xr+CrpiJQ9lE7NE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-4qpenNsHNP-WvEMibFLnew-1; Sat, 11 Jan 2025 23:16:31 -0500
X-MC-Unique: 4qpenNsHNP-WvEMibFLnew-1
X-Mimecast-MFC-AGG-ID: 4qpenNsHNP-WvEMibFLnew
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216266cc0acso69299975ad.0
        for <fstests@vger.kernel.org>; Sat, 11 Jan 2025 20:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736655390; x=1737260190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTY6TMmCzfQlzVIQg5Y/MHXa+8quUBbVQp5dpY6lhXU=;
        b=mk+6ahalx1ocit0lqa5VGnvtrnt5sQecl7C6mYKJBxmu+uobA3wDGLt5BYZVbHOgpc
         UOZBKS9isQJikiq0Fc44hqmiXL2sg7TULIeFYpMsuCfaJgE/YwVPDHgcmrQirU2+Epjl
         GIuGG5t59IARkS2cQBGnMpE6cNcktQR9yBdCdlllg5OBDlBWtHevLXZRwsiCgW3wTkUj
         SPYuZXerNCxhWZgMoRE3rc0bmldknJEPmgMYFrdC7iB9XDhu2l1CaF79Ca7biqNKKOm8
         27Mheq4TM7NGYMHWigYJcIyWRi+RmuZkpxHmmB4tfl7u6NUQOsHdYfDTCnMiEXpV4Bpt
         95hw==
X-Gm-Message-State: AOJu0Yw0GfRi1Q0klHW9+C+Sv4LPpLrcOcLXTB5Dvm0rcuNw9xJzgU5W
	TT9umqzlM4btMWGnftFpfoPMZPr6Jz2oeyBxiFKrpAfi1mJ0bKi6YFMXaYBR7mwSwj6M7rmFUpK
	e9/YqvKvW7zKhvDKHboMFeeKeCRYjYvpaPigsavK+S902fA6iP/F0UMY=
X-Gm-Gg: ASbGncskR/dJIkrb99MZdpIRSg7S56foPF580YCv4DIRMjjKFYPUoTDkTg/pMpwJ0Rq
	9thmHKBGe90HpKjEv3okXng7y6VycBr5itbo3G4p2LgdfbMcKv1Sc+hc8Ff1Npff/OJ/OICTcvo
	NIPUP2F7OBNuY6Gu1nVY0WcVsixRX2ibNPI5hBCjmfGfESeIajWSWezbKa8ibFdRmyXU4KZ+Yig
	A8yOZm818Zm8Codh2C6z4C0Q1kz+xO2y/Cf932OQ9aJ+5wCSOR1ZPpFC/RLsaxWo8UkoOGuS1so
	1weyldMbj75lmEoTVjQ8pg==
X-Received: by 2002:a17:902:dac9:b0:215:742e:5cff with SMTP id d9443c01a7336-21ad9f7ca15mr60029675ad.16.1736655390056;
        Sat, 11 Jan 2025 20:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQy7ZyNMZEphjGRQwqp3Z7rj5F/Nk/MuuJx8raJ9MhFYQB9SMky7CVrddpIzz52aioEP5oNA==
X-Received: by 2002:a17:902:dac9:b0:215:742e:5cff with SMTP id d9443c01a7336-21ad9f7ca15mr60029455ad.16.1736655389674;
        Sat, 11 Jan 2025 20:16:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2179b6sm33477535ad.115.2025.01.11.20.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 20:16:29 -0800 (PST)
Date: Sun, 12 Jan 2025 12:16:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, djwong@kernel.org, nirjhar@linux.ibm.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250112041624.xzenih232klygwvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
> 

[snip]

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

Hi Joanne,

Sorry I have to drop this patchset from the "upcoming" release v2025.01.12. Due to
it cause a regression build error on older system, e.g. RHEL-9:

    [CC]    fsx
 fsx.c: In function 'init_hugepages_buf':
 fsx.c:2935:36: error: 'MADV_COLLAPSE' undeclared (first use in this function); did you mean 'MADV_COLD'?
  2935 |         if (madvise(buf, buf_size, MADV_COLLAPSE)) {
       |                                    ^~~~~~~~~~~~~
       |                                    MADV_COLD
 fsx.c:2935:36: note: each undeclared identifier is reported only once for each function it appears in
 gmake[4]: *** [Makefile:51: fsx] Error 1
 gmake[4]: *** Waiting for unfinished jobs....
 gmake[3]: *** [include/buildrules:30: ltp] Error 2

It might cause xfstests totally can't be used on downstream systems, so it can't
catch up the release of this weekend. Sorry about that, let's try to have it
in next release :)

Thanks,
Zorro


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
> 

