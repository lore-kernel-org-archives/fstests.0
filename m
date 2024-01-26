Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CF171A7
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272341; cv=none; b=QyOtEY0yT+DH8AuiSBUVi68718s4KyKVDBper9lOHl7Ey6vBbPXDoyUrEPeZ8lIlahyEiJNXOlmJUXkfo+ONV8/LQxXMQOhUFtH1jpnPJOdzrysXkDWpe44YYzRGbfuENFwmylCV2ui6qbNBF5MXTUgPtqKzeMs11IrU8tb+Zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272341; c=relaxed/simple;
	bh=1H3uzI4QHi5Ndkj8uf2Wub9vtRl+nihZODj0BnCzWJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwv+wnJSisnBxkN1rp4mt9bWV3n62MmQ9smjmuHyveeUpqAz1fscmk/t8bt/ufK9gr+iu0G6JyCI1oAKJB1G1XTTLQUAgmXsrMlm//fBeEkyvayRWrDFyjEMQMDRa2bI33BIu8kuyBnlivogEmrwZCwgvd0kiAchMtAzvceo/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1+9F7Kx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1+9F7Kx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706272338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCYS4qYRdFBHd402HHe9dWT2+MHdhxVNAL+zD6tX4U0=;
	b=F1+9F7KxmIy1Vxxc9Z5Hq7afxLbSX5e8CyLYs6L+ccSSmdfnubzL8x/U6GCP8ORriPNgHu
	oB+meHAx7NWB00vMVBDjk2lkd0jI9B7sT4ApVWBgmOGMP+7iml9t30I+idXU1jYKG/ugFI
	CWkDkixxRuQ4cXZejajUC4RWzGGaEBc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-WwVY42LZNXOTIamg5wVeGQ-1; Fri, 26 Jan 2024 07:32:17 -0500
X-MC-Unique: WwVY42LZNXOTIamg5wVeGQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so9601666b.1
        for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 04:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706272336; x=1706877136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCYS4qYRdFBHd402HHe9dWT2+MHdhxVNAL+zD6tX4U0=;
        b=OzD+OR8aRMf+9Vs+FSQHSBhfwFDVQFF2uMMhiuhkB7c7a5HONAoPrGCNQtdzcyOYF/
         tjza2XuNrzYR0sUhCFLzE465Tg9n8lK2BBmAdGp8IohdtSgncU0a2vtkSWx8lYi+4kdc
         sm4PUj594RyYFxOwIiFg0+9jnfLcHZrTdYPcd4zlhvKgdElW25Qf5O4G4rUIrnQtHcPf
         QB9o2TOB3TNcRgD++JMk9KkHQJ/5AIwIoUriYcEZJNauY/Xire3oYEkHWBx93wmJy/5j
         ep8X2AjwJCAO9Pz8w5rj9rqg1ymOKvq0jLFLjDbmdcCOPXvC3ct88NCX++jO8TWPW/p6
         EZqQ==
X-Gm-Message-State: AOJu0Yx6EzONpzqnyrUFoWaAhzrtGr5BqAONKm1sHygKHraNErsMdafR
	0BRAzOHykvv38w48v6we9ovMlWBK5LjRWA//XjVn1HMofPSXymEH6gPUjUschchGzdX+M7qdlvN
	CkiR3irRY3QwZVNibKhW0Ha7d8POOuVu0ix8QC+PY1JVLwlXz26PoOg==
X-Received: by 2002:aa7:de05:0:b0:55d:71c5:5186 with SMTP id h5-20020aa7de05000000b0055d71c55186mr2162edv.1.1706272335881;
        Fri, 26 Jan 2024 04:32:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE21LY4FDpNGEBP68LGb4aRv6P4+kTsAN3BuyvZ1NuWg7wKifsI7z01clN6+dkZshh18Kx22w==
X-Received: by 2002:aa7:de05:0:b0:55d:71c5:5186 with SMTP id h5-20020aa7de05000000b0055d71c55186mr2155edv.1.1706272335515;
        Fri, 26 Jan 2024 04:32:15 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ez16-20020a056402451000b0055c82e27412sm552694edb.75.2024.01.26.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:32:15 -0800 (PST)
Date: Fri, 26 Jan 2024 13:32:14 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, guan@eryu.me, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Re: [PATCH 01/10] generic/256: constrain runtime with TIME_FACTOR
Message-ID: <uwmnuifvgbyh3viyfrwneik6swgogqikaqm57ucy7wqonedtf7@zkycyddctajh>
References: <170620924356.3283496.1996184171093691313.stgit@frogsfrogsfrogs>
 <170620924382.3283496.6995781268514337077.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170620924382.3283496.6995781268514337077.stgit@frogsfrogsfrogs>

On 2024-01-25 11:04:14, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test runs 500 iterations of a "fill the fs and try to punch" test.
> Hole punching can be particularly slow if, say, the filesystem is
> mounted with -odiscard and the DISCARD operation takes a very long time.
> In extreme cases, I can see test runtimes of 4+ hours.
> 
> Constrain the runtime of _test_full_fs_punch by establishing a deadline
> of (30 seconds * TIME_FACTOR) and breaking out of the for loop if the
> test goes beyond the time budget.  This keeps the runtime within the
> customary 30 seconds.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/256 |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> 
> diff --git a/tests/generic/256 b/tests/generic/256
> index 808a730f3a..ea6cc2938a 100755
> --- a/tests/generic/256
> +++ b/tests/generic/256
> @@ -44,6 +44,8 @@ _test_full_fs_punch()
>  	local file_len=$(( $(( $hole_len + $hole_interval )) * $iterations ))
>  	local path=`dirname $file_name`
>  	local hole_offset=0
> +	local start_time
> +	local stop_time
>  
>  	if [ $# -ne 5 ]
>  	then
> @@ -57,6 +59,9 @@ _test_full_fs_punch()
>  		-c "fsync" $file_name &> /dev/null
>  	chmod 666 $file_name
>  
> +	start_time="$(date +%s)"
> +	stop_time=$(( start_time + (30 * TIME_FACTOR) ))
> +
>  	# All files are created as a non root user to prevent reserved blocks
>  	# from being consumed.
>  	_fill_fs $(( 1024 * 1024 * 1024 )) $path/fill $block_size 1 \
> @@ -64,6 +69,8 @@ _test_full_fs_punch()
>  
>  	for (( i=0; i<$iterations; i++ ))
>  	do
> +		test "$(date +%s)" -ge "$stop_time" && break
> +
>  		# This part must not be done as root in order to
>  		# test that reserved blocks are used when needed
>  		_user_do "$XFS_IO_PROG -f -c \"fpunch $hole_offset $hole_len\" $file_name"
> 
> 

LGTM
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

