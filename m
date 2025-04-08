Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A571EB3D
	for <fstests@vger.kernel.org>; Tue,  8 Apr 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141936; cv=none; b=SGlgskNyQ9tJSN1ukY/jvnWAo1g8XvSNOE0oDSvjvzbe60EjmRBhHud5lT574TJcrbamJwYOP8Z0+schA9jIYz8NNRVfOWpD+DtSqTau/rdxvWvXBlyIUEjyn4dmvWNyf6pYYGX2n/VXFpvwWbE6XdDfoH4aDzRG566xMdA5yB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141936; c=relaxed/simple;
	bh=blK+2dSu5U1MvGMATzL2nzu5PORFi1D65ho5AwWGdJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW5rwip8fHDuRj7CRJnVTMjD9O126BjzKNUJLPdEyhGLiSdR2ybxRBFyEalG7p56TwvxBuSy7s0q1T4jgwxhNn+vhBD40D5xF8+cXLEEGsgMY7yqT/RJOtaoaDsaM9b76q3q+KOMa8/kRh3AsA9QPYZSx2xJjkp3TeCQWXc2kPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRIkITU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRIkITU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744141933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oma75DDDa0KBCALqpSmWhoycUi8mZCtafF3LLZWkW7M=;
	b=SRIkITU15Diyw1DUjqUdCAEf4er59z74ZssFETr/i2KljvBoZWB8nkPkZ/DHvaDjG17v7g
	28bxsLi/N3Bi9WnucR4xBfjAup26hD3kTTt8N7XoQiRmzNsCKavcbSM/4QJYemMtwF/P2d
	KZkQ0Ql75KuTt5I6U/SfbtIkJ8AdpZ0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-y5f89ZS7MhS40JufUCbidA-1; Tue, 08 Apr 2025 15:52:11 -0400
X-MC-Unique: y5f89ZS7MhS40JufUCbidA-1
X-Mimecast-MFC-AGG-ID: y5f89ZS7MhS40JufUCbidA_1744141930
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-306b51e31c7so2837762a91.1
        for <fstests@vger.kernel.org>; Tue, 08 Apr 2025 12:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744141930; x=1744746730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oma75DDDa0KBCALqpSmWhoycUi8mZCtafF3LLZWkW7M=;
        b=QKJdDVKAgCfQh6l2DcbW6z7Y7aSvj0Stn5BhLj4L0U/1OJq1ZNgdch1wVvc9qJz7Ta
         0F62euNqyVIheocOhD58OP78QcBduCa/jpOqwABzCkYcwGNAM6IP10+drCtJKfsKgGtU
         2PYBzzCL+p5GUi8KiCv2JM4Iiurpa4nzIZZ0JyShjCfrCgwyTkavJP3A2keUIko6Xy98
         s22jKBDl0Q+ZhDJQR5GJUxDvGqzBclEpc7ayU9z1TxHPdt2Y2tm6sGuAc3Quirl2Hruf
         VR719g7gsfRaDz1PY6/qfXOs3UWTVyC3GKaNTo0QEu9+noWb5d6pOpowbGJuNGLrjD7R
         fK/w==
X-Gm-Message-State: AOJu0Yxr4F+o1Y8KGrrrynqT6bo1t4hUfU1tgjKuUe/WmArrOz1pfpI3
	5KAcQCLwTaqpLwWGeh8431S7J5nS21J6m8MBro3ooegxYyrC61s23osW2I3pAU3HRj05U2zWY3g
	fQu8WQQ/UI7z8eixGOm0aVKaYJ301MnGZe+p3GxTRzRr41MSW+/EPEUv1QErKglROMQ==
X-Gm-Gg: ASbGncvhFVqeCh0GGd8/86UQEa5TwIh1oZYUQYXIpOtLYSgeL/gQXSOa93h2DKx3kcT
	z0eoe7RCc0vCIIjZl9fNusL2ueleH9t43AWMGC7Dc1r8HVol9pQS45rLfLnvpWI7HZu5NA8jBQ+
	NUvmpQveA4/DQeKAwBailgwcBrqToxzbYXAlue++IywkXSwSFwlwEJreaFuSdcd7Grr5fgDQB88
	1l8jJpKLwQVzqvVwjb4qIcCMwfJCKZ78rbCWl1vTgDDw9u/09OKu60+tw/Tf/16qsv2jmQ8Opkd
	rxqG+ro2j2jkN/K2yrDlGM59G5MirjZwtvrEJJryrIZnzPoUnGjKNODE
X-Received: by 2002:a17:90b:548b:b0:305:5f2c:c577 with SMTP id 98e67ed59e1d1-306dbb649c0mr588761a91.3.1744141929980;
        Tue, 08 Apr 2025 12:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm7E/3wZjw60/tbMTgKGkRRZGRb84veeXZNtHIzFZfBshr9NZ1jKAa0LpWgW18rEJLmLK80Q==
X-Received: by 2002:a17:90b:548b:b0:305:5f2c:c577 with SMTP id 98e67ed59e1d1-306dbb649c0mr588736a91.3.1744141929613;
        Tue, 08 Apr 2025 12:52:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a2f845sm11504240a91.22.2025.04.08.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:52:09 -0700 (PDT)
Date: Wed, 9 Apr 2025 03:52:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] common/rc: fix dumping of corrupt ext* filesystems
Message-ID: <20250408195205.zelfuglmamb5w3ft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250407235931.GB6274@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407235931.GB6274@frogsfrogsfrogs>

On Mon, Apr 07, 2025 at 04:59:31PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The parameters to _ext4_metadump are device, dumpfile, and compress
> options.  This callsite got the arguments in the wrong order, which
> causes fstests to compress all of /dev/sdX as /dev/sdX.zst which is not
> what we want.
> 
> Cc: <fstests@vger.kernel.org> # v2022.05.01
> Fixes: 9fb30a9500c169 ("common: capture qcow2 dumps of corrupt ext* filesystems")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index b2155d37a90d68..a71c15986efd18 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3552,7 +3552,7 @@ _check_generic_filesystem()
>          case "$FSTYP" in
>          ext*)
>              local flatdev="$(basename "$device")"
> -            _ext4_metadump "$seqres.$flatdev.check.qcow2" "$device" compress
> +            _ext4_metadump "$device" "$seqres.$flatdev.check.qcow2" compress
>              ;;
>          esac
>      fi
> 

