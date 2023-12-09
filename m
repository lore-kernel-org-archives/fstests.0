Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9Y74zsT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FB10EF
	for <fstests@vger.kernel.org>; Fri,  8 Dec 2023 21:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702098385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx2KXkKWGXskx9hgbxqcfFshAbEoRjOrA8XTrz3yxFs=;
	b=P9Y74zsTr3ITtemK18G0mv+zNvSS17Ij0xHUwsX9pmtLLhbs5ddx1CYC4PyL1XDMS+5KKN
	UbXj6z30CZ+sesVut2S0gShrWRp6iiL/TZjbeMe3dqi9lBkXBbFxnB1g9P4L2f84bJlNtV
	r6u3Z+jKHxZ9sNNAR3i2NvLg7fgN31g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-unbn32ZxMAyIUs3o6gNA9w-1; Sat, 09 Dec 2023 00:06:21 -0500
X-MC-Unique: unbn32ZxMAyIUs3o6gNA9w-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9f55676a1so576723b6e.1
        for <fstests@vger.kernel.org>; Fri, 08 Dec 2023 21:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702098380; x=1702703180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx2KXkKWGXskx9hgbxqcfFshAbEoRjOrA8XTrz3yxFs=;
        b=n8wAah+iT54ColVBt9Gpbb6N9n5GpPR6Dpsd3wxxFy6hJTwkcoKOGCt7PKNPqXT358
         Cq4qzDnUooUNUNNMYL51J9ROdFE30tYyhsJBpZsendX8fn8hnKp34TPb9BVCkp/I7zB6
         DwQFmr5YGrtAF5ujxNKjLxvsG4weFO0hnHz9UEQhhdiDv06CV9OkUHrjCVMV+Zv+J7E9
         kOgNE3Xd/OcaA8XEucyNr9JsaV9DvAYnEAp1EXe25HuyzwQvAQLEjYWn84vwd9EANkeU
         t/DU85ur1n/1Sg+WtkL1aFSGcW6+UFHJGQfDz0y8EOXcKK23h/7jQSp8ryACgzifehnJ
         B87A==
X-Gm-Message-State: AOJu0Yxm3Qk1h1qP+qu6tppsxva6z4VEmemt2MGaASHlixQlmaj5+43K
	DONb4VzhYBiW7j1KGiDcjNeX9/FCVFgu02kxWZZQInMgc8iiQsjCgDle1aAMh6U8VNbOjjHPxbw
	lkd3TTEmAaxrymP0aFQ==
X-Received: by 2002:a05:6808:38c4:b0:3b9:d586:f18f with SMTP id el4-20020a05680838c400b003b9d586f18fmr1730687oib.63.1702098380493;
        Fri, 08 Dec 2023 21:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECd3K0sY9EZGo2RH5DiJfxKjvWTvRoVlV8FXXIspjT93g5ldddKqeTGXRNnNamvgan+wi9og==
X-Received: by 2002:a05:6808:38c4:b0:3b9:d586:f18f with SMTP id el4-20020a05680838c400b003b9d586f18fmr1730681oib.63.1702098380226;
        Fri, 08 Dec 2023 21:06:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006cbb65edcbfsm2522628pfl.12.2023.12.08.21.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 21:06:19 -0800 (PST)
Date: Sat, 9 Dec 2023 13:06:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCHv3 1/2] aio-dio-write-verify: Add sync and noverify option
Message-ID: <20231209050616.lcbfxdbqlgcskh3c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>

On Mon, Nov 20, 2023 at 04:49:33PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds -S for O_SYNC and -N for noverify option to
> aio-dio-write-verify test. We will use this for integrity
> verification test for aio-dio.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/aio-dio-regress/aio-dio-write-verify.c | 29 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index dabbfacd..a7ca8307 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -34,13 +34,16 @@
>  
>  void usage(char *progname)
>  {
> -	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  filename\n"
> +	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  [-S] [-N] filename\n"
>  	        "\t-t truncsize: truncate the file to a special size before AIO wirte\n"
>  	        "\t-a: specify once AIO write size and startoff, this option can be specified many times, but less than 128\n"
>  	        "\t\tsize=N: AIO write size\n"
>  	        "\t\toff=M:  AIO write startoff\n"
> -	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n",
> -	        progname, progname);
> +			"\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
> +			"\t-N: no_verify: means no write verification. By default noverify is false\n"
> +	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
> +	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
> +	        progname, progname, progname);
>  	exit(1);
>  }
>  
> @@ -292,8 +295,10 @@ int main(int argc, char *argv[])
>  	char *filename = NULL;
>  	int num_events = 0;
>  	off_t tsize = 0;
> +	int o_sync = 0;
> +	int no_verify = 0;
>  
> -	while ((c = getopt(argc, argv, "a:t:")) != -1) {
> +	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
>  		char *endp;
>  
>  		switch (c) {
> @@ -308,6 +313,12 @@ int main(int argc, char *argv[])
>  		case 't':
>  			tsize = strtoul(optarg, &endp, 0);
>  			break;
> +		case 'S':
> +			o_sync = O_SYNC;
> +			break;
> +		case 'N':
> +			no_verify = 1;
> +			break;
>  		default:
>  			usage(argv[0]);
>  		}
> @@ -324,7 +335,7 @@ int main(int argc, char *argv[])
>  	else
>  		usage(argv[0]);
>  
> -	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR, 0600);
> +	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR | o_sync, 0600);
>  	if (fd == -1) {
>  		perror("open");
>  		return 1;
> @@ -342,9 +353,11 @@ int main(int argc, char *argv[])
>  		return 1;
>  	}
>  
> -	if (io_verify(fd) != 0) {
> -		fprintf(stderr, "Data verification fails\n");
> -		return 1;
> +	if (no_verify == 0) {
> +		if (io_verify(fd) != 0) {
> +			fprintf(stderr, "Data verification fails\n");
> +			return 1;
> +		}
>  	}
>  
>  	close(fd);
> -- 
> 2.41.0
> 
> 

