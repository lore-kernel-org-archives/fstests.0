Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CF4D9E0
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007835; cv=none; b=eMtqBGKMk4R+cLcrFS+6Wqi+ovgwvLE0UWgHVKDvvP9p7BNM7puAlwbHaReyJdF3aeYnf9Ytcr+ed8DPszeVDCPXsEbJD55xKK6ezizfoSxOX5DQa/xOX18hWSoiI2v0dLAuke1BZWz6ib31XjIjAWKzRG87Z+UaCcMSa6XtWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007835; c=relaxed/simple;
	bh=5Ag61F9nkbcncWlG83sAczWAGiPKgjTLNzcx/NInwug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWQQMH8zP1yp40fVKAnDAXOjiAhchOjglx7rfvRmzjrdNggdmHXJUZHt1vuan7hbHH3pFxU0HAQgN7MTP8BRmXvSXhv6qv7dm50O+jyecUPhnbTGlk0TCI/CiE6e3F3MBbYHZIZljZ7O/GYnIdnmpPWTPG2mx6GaufTo4OyisWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ogdjs3/x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ogdjs3/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709007833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXemS4YmjkSB4jwwgKrOkkaFhO+nICzv28dt7FQYGcA=;
	b=Ogdjs3/x7H7VPhnqbcThOXCaKypr3TibkXpcoVnWOoudp3bsVw1i+C+qyKaIb17tBgOumM
	a88PcbgSjA0AhOJeEzaL9Sjh57zqIjZ7mEESIolfEIhIncXQKnQ5HEfuR8gG05jafyF5Sy
	6bHfalDDdcZ7gPArLf5BdxL6ypR+ZWk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-miMHKXMZNJCzFBkIO1HBcw-1; Mon, 26 Feb 2024 23:23:51 -0500
X-MC-Unique: miMHKXMZNJCzFBkIO1HBcw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso3388401a12.2
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 20:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709007830; x=1709612630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXemS4YmjkSB4jwwgKrOkkaFhO+nICzv28dt7FQYGcA=;
        b=ibHONc0YztH6VT0vif1Tp/LwRr/h9wt1aOv47GKtMYDj4ithwhcgsJxWWXhXSdVNhQ
         Onx7rUBcTHaCFLXIzX3W4xS6d1CTV6ckM0XYRhHIaJSnVwGjX3UV6omseyHbkRTHIC9V
         su7yfCQ59adp7HbqZZ3LTLI2QFv9glDLjCj3P2qT5AvKhS7LIC8Kn4WX9/hEMoEnhi4t
         aUqGmMtMbjT2FnwhxJl12HaTFhgu5vST5lzM6YO1XhccOOLIYKoF9pd4YM+8kZCJ6PFG
         59CqtirU33QY98zl8eA8dKVoZjKA/cjFq97JkoRelJD8Oa3ehognOJwOwKA3EhlxPyDE
         kmqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLqGjW+QDU3BGWffzLSCBDrlG0/q8a1vfWmK8XBji0mijOyhBKfqpj59unpw7s4cCUGN0jp57F3Bhj8L9MrMq0X9ModjhE0g==
X-Gm-Message-State: AOJu0Yw+q6HIKyijRrfeLLr54fKSB+QoLv2+jCv/gu6rNMcZFTrFE/+u
	77l7tbFJ9Ui0j1GcFzKIHuw8Aj9bXz+/F8icnbKLSqdRQl9WjIN8tWGpWiK8MeqV9bfi2Onr94x
	BYqcnosHepxxezOGN3en7RqiY2lW/nC5QHe55ymTWznF+xm7Yre//EkU=
X-Received: by 2002:a05:6a21:8cc4:b0:19c:9b7b:66a with SMTP id ta4-20020a056a218cc400b0019c9b7b066amr1262741pzb.49.1709007830371;
        Mon, 26 Feb 2024 20:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1h8cU3GJ+GksiO0o1zjDmbaL3uTKC+Gz5ZMmUtkQNpPmPPUHysrE8z437h/4uGDyRY8mWMA==
X-Received: by 2002:a05:6a21:8cc4:b0:19c:9b7b:66a with SMTP id ta4-20020a056a218cc400b0019c9b7b066amr1262735pzb.49.1709007830057;
        Mon, 26 Feb 2024 20:23:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id li16-20020a17090b48d000b0029ab712f648sm3595539pjb.38.2024.02.26.20.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:23:49 -0800 (PST)
Date: Tue, 27 Feb 2024 12:23:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/8] generic/192: fix spurious timeout
Message-ID: <20240227042346.joa66rfv5324mnmp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915261.896550.17109752514258402651.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170899915261.896550.17109752514258402651.stgit@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 06:01:19PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> I have a theory that when the nfs server that hosts the root fs for my
> testing VMs gets backed up, it can take a while for path resolution and
> loading of echo, cat, or tee to finish.  That delays the test enough to
> result in:
> 
> --- /tmp/fstests/tests/generic/192.out	2023-11-29 15:40:52.715517458 -0800
> +++ /var/tmp/fstests/generic/192.out.bad	2023-12-15 21:28:02.860000000 -0800
> @@ -1,5 +1,6 @@
>  QA output created by 192
>  sleep for 5 seconds
>  test
> -delta1 is in range
> +delta1 has value of 12
> +delta1 is NOT in range 5 .. 7
>  delta2 is in range



> 
> Therefore, invoke all these utilities with --help before the critical
> section to make sure they're all in memory.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

This patch makes sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

Just better to give 1 or 2 whitespaces to diff output message (especially the
lines with "+") in commit log :) I always need to change that manually before
merge the patch :-D

Thanks,
Zorro

>  tests/generic/192 |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/tests/generic/192 b/tests/generic/192
> index 0d3cd03b4b..2825486635 100755
> --- a/tests/generic/192
> +++ b/tests/generic/192
> @@ -29,17 +29,27 @@ delay=5
>  testfile=$TEST_DIR/testfile
>  rm -f $testfile
>  
> +# Preload every binary used between sampling time1 and time2 so that loading
> +# them has minimal overhead even if the root fs is hosted over a slow network.
> +# Also don't put pipe and tee creation in that critical section.
> +for i in echo stat sleep cat; do
> +	$i --help &>/dev/null
> +done
> +
>  echo test >$testfile
> -time1=`_access_time $testfile | tee -a $seqres.full`
> +time1=`_access_time $testfile`
> +echo $time1 >> $seqres.full
>  
>  echo "sleep for $delay seconds"
>  sleep $delay # sleep to allow time to move on for access
>  cat $testfile
> -time2=`_access_time $testfile | tee -a $seqres.full`
> +time2=`_access_time $testfile`
> +echo $time2 >> $seqres.full
>  
>  cd /
>  _test_cycle_mount
> -time3=`_access_time $testfile | tee -a $seqres.full`
> +time3=`_access_time $testfile`
> +echo $time3 >> $seqres.full
>  
>  delta1=`expr $time2 - $time1`
>  delta2=`expr $time3 - $time1`
> 

