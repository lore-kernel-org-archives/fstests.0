Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B41EBA1E
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899334; cv=none; b=RehXv72nkZQYU/kafVS/Cs1ORUZhld5M6I9q3XV5OI4+uh0eamlTcErRre1N/v8FFK2jfhlU7FftYttmX7SqE+Uf3AbO5uNWaUf8unxWc9iqov29w7h+KJY5emOk2afs7GUHm1LtysSqhoxHuXywhqr3U/T/cs0ZDJOoPNjVsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899334; c=relaxed/simple;
	bh=Nzwdg6o8Epi7xB41PjiO/aHDCrUJscT3sEFMw4jKdcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz/szJtOSnBeP8Z8NsfcPwoWPPYAe+hflB1DI6Mad+A2WSIgArV+6t1hW/fI8A5ezx/lLTqaFEJ6q3z47+y1eHiCfdflTAXXEgKDDcNC3aVRnNlWZG9SkSR5FtVXGQ1BY2ioADHXH9aahx0Pm7vuxJalDhXvjTwZdP2wP/dBj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVegEexz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVegEexz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758899332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+UA9/4sihT6+ga8fp0raxdh1Y6GmJgTf+A2TwhFLjc=;
	b=PVegEexz2om0RTVpCX6RCc9HUhR1IJ7Ua9YJIeMIaMJJcuM+WPscKthJl+/kYrTBfeM/2+
	OYoz/UP+KJN9XPbSJ1ZgwsRvK4e0OloDdwtfaMZF3tiRJw0hpBjunu9mm2LuantzQ/jL0E
	LxOlCSt+Gmbpa3ctY4/AVyljfxrlMqI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-PxqxwhaGPxeXtb0E91Q0pQ-1; Fri, 26 Sep 2025 11:08:50 -0400
X-MC-Unique: PxqxwhaGPxeXtb0E91Q0pQ-1
X-Mimecast-MFC-AGG-ID: PxqxwhaGPxeXtb0E91Q0pQ_1758899329
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2699ed6d43dso24726555ad.1
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 08:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899329; x=1759504129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+UA9/4sihT6+ga8fp0raxdh1Y6GmJgTf+A2TwhFLjc=;
        b=aPO56lHSvsHE2BtSnEKH/lfF6S4EAhzxKdnkTFnD/kMjXetvW3MNZSURMbZYtF3fUH
         8BCxnXgSTZ5KStb8tJQp+xgMOiVdjO0kNwHbDAcOpvDFTyDN8fQn2s85h9DghgkrNKPN
         sKHwoxYv2Dpve+NahxmJgiIHNDHUhrZtYUK05Idk4wHLpkBMRmgfB/qmh8LaCwr6+PHL
         ZZylBnvQninvTlS9qdbkKODIgQzJYDbC34yXY2Hwil2Nuo3zSxZv3wjXqP8dVnUEiWHK
         N9P99im5UdKksWB+9MvbgWoi7JHtpDrpVQ5AtstW3p5l/Lb3OoCVgLAm0mllgKG2gVcx
         F9ug==
X-Gm-Message-State: AOJu0YzGqiRxITZFJffRgkrSSEHnTiUVrfuzSzyIgIw1gM16OK04w4pu
	D9EJMBmkTDyO4+NXfmUSTT8w57Xp0cAMIjZkySm3o7ZqmjnpAl9hJPWHlvBwqD5iyIfsxH74BSi
	qnxkx+FRjLM50e62MjdvcHJjXffkO3yLnusf1aT2hA1OdWVQIRruT9PHcdBE=
X-Gm-Gg: ASbGncuTBCZ+poyVG7t8JHckwzGzZxlvm2SaSU5qrhvfhUojxYCureo6iKrALULlGif
	hp/WB6Msl+cIzNSAqKn5WRyFV/QjMu56auoVcGXU7s3yssPn5STkUkz2APV5u4awPWL1bel6agm
	ogHJ+17XBUzmIX4zxjifEeXHAmIIwuU8QKOeUfjci1Dw1IAMdk27KBbkLlHQR0F0e+1ZNp7z7ZH
	zP6KxZ9JBP6eswLnQwqdd9NIHtYbZTR3e/boYJXme2zWvpeqzpSe7+4ShA3zSCkO3NeRn6R1oal
	OnByudSMr8kPJFfPsjNZ+V4/Yq9B8GSmY/h0ENJTQKs8UBgjXOMVAM9qjmQuTWDLNIok4YbZOal
	uEeMg
X-Received: by 2002:a17:902:c409:b0:275:f156:965c with SMTP id d9443c01a7336-27ed4ade26bmr90389345ad.52.1758899329505;
        Fri, 26 Sep 2025 08:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5/jyd+KDYBoNbXQ/Ez1q83B/qAFalkBiRoSO5hRTJUWk1YcB/L/dWS00/3xCyBJekn8aabA==
X-Received: by 2002:a17:902:c409:b0:275:f156:965c with SMTP id d9443c01a7336-27ed4ade26bmr90388985ad.52.1758899329020;
        Fri, 26 Sep 2025 08:08:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69952a7sm57373875ad.101.2025.09.26.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:08:48 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:08:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2] common/rc: destroy loop dev before fallback recreation
Message-ID: <20250926150844.7mp2soi2koanxyxe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250926121249.214798-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926121249.214798-1-bfoster@redhat.com>

On Fri, Sep 26, 2025 at 08:12:49AM -0400, Brian Foster wrote:
> When running fstests on an s390x box I observed failure to unmount
> filesystem errors due to stale loop devices being left around. This
> root caused down to generic/361 leaving around an attached loop0
> device. On further inspection, the test actually created two loop
> devices (loop0 and loop1), and executed on and cleaned up the
> latter.
> 
> The origin of the former appears to be that the initial losetup
> command in _create_loop_device() fails due to $dio_args in this
> environment, but still creates the loop device. For example:
> 
>  # losetup --direct-io=on -f --show /mnt/scratch/fs.img
>  /dev/loop0
>  losetup: /dev/loop0: set direct io failed: Invalid argument
>  # losetup -a
>  /dev/loop0: [64771]:131 (/mnt/scratch/fs.img)
> 
> The helper then goes on to create loop1, but it or the test never
> deals with loop0. To avoid this problem, detach any old loop device
> if one was set up before the fallback losetup command.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---



> 
> v2:
> - Add comment to document wonky losetup behavior.
> v1: https://lore.kernel.org/fstests/20250924181235.152502-1-bfoster@redhat.com/
> 
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 81587dad..1ec84263 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4596,6 +4596,9 @@ _create_loop_device()
>  	# size to the directio alignment of the underlying fs, so if we want to
>  	# use our own sector size, we need to specify that at creation time.
>  	if ! dev="$(losetup $dio_args $args -f --show $file 2>/dev/null)"; then
> +		# losetup can return error for certain configuration settings
> +		# but still create a loop device.
> +		test -n "$dev" && losetup -d "$dev" > /dev/null 2>&1

I'm not sure if "-b" is better than "-n", anyway "-n" makes sense too.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  		dev="$(losetup $args -f --show $file)" || \
>  			_fail "Cannot assign $file to a loop device ($args)"
>  	fi
> -- 
> 2.51.0
> 
> 

