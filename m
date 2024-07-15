Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE20F510
	for <fstests@vger.kernel.org>; Mon, 15 Jul 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073035; cv=none; b=sseXmagVAW5aR+ch52pgyrDk3RsMFvcjBlSN24bUsbczZICeN9hXHUWUmSC69XIqU+oLGKQv1XtX9ZThrKJVe0j0VmPBCQSlk/jk6nVC3ENs/HGNr+Xe6h/8ZTnEsmQ3Oudxs3D1AcnQ0OFKmLVDzLYl0ucR/BmY0fTyLyA7ngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073035; c=relaxed/simple;
	bh=GLBPWHClwy1GP/vDrNvrw2mziD2nbi/Qb3Sin6yJ4VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jbp4FyOlSaUHvff8u7KnZtkjLxrk/Qi56liR/7CTEnYosagguXlLC+zQwQZQ28O0MfSPmeK4Gdjmzo11nOYwC4Znb+f1BfjSq8HWRNaNkTgCPBIPPYN+6fmNUKYcT5CjNnTr+DBzhRnvUlDc9mrIwdmPHE0Xq0MQv5/oc2d2KFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGk6WqJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGk6WqJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721073032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwQhkrsQkwoyEjxI3ICbokCDPruayaGARynV9oB8f60=;
	b=ZGk6WqJ8GDjrVNpyP+5E4VcoxzrYvwb8oAugsvgW6ixRj+Q2ICy2bQ9aSgvWgMfxIM1uOK
	6kTO4038hda/MW+SfzbVwhagY8LqC3mCNehNKsagUdZpAAIPIjCq1EqGvYZjm0Ea//9A6i
	2LCWmPT2+o/J//CxJ6jiYxyypOeqJOk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-DQlhwFjbOAu__cYb1BzAUA-1; Mon, 15 Jul 2024 15:50:31 -0400
X-MC-Unique: DQlhwFjbOAu__cYb1BzAUA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-791f856d749so665520a12.1
        for <fstests@vger.kernel.org>; Mon, 15 Jul 2024 12:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073030; x=1721677830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwQhkrsQkwoyEjxI3ICbokCDPruayaGARynV9oB8f60=;
        b=WECKl4evd/eAF7+ysNRn+NP7ZlWHlxu6a2uerIlQ5ikKZdncnu278Tg8m300Cf1of1
         aEH1Nz/laeuE6qEIFz1tApbPxV22xCKzKXcaUwBpR+p3TC15tQY/Z49CodVr+GdC0wDT
         S8rhY1Fi03kp8oWXmYTj9puPjaZ/vvSRulprBwuum/EtiwKUqlrBWL8Bv4qxu0zfujgf
         c2iKBA03YXYbJULlk1pkHlhHAXxmL/vokCTTpMIYhRjJXj779oJuCGv/jG7BcAZQjT88
         5GLhu27j+77x031+pFrRTpFfnvUx5vN43fJ8jGtZVK0gsk2W8vrRggqO42HdE8yUVRlR
         qXhg==
X-Forwarded-Encrypted: i=1; AJvYcCUpSKjMX63WM6LM0NTNz5SjFu2mWUGHyiBoeKzeFYmFjJ7Mp2+crN3nWsTdTrVHH/S3CUjKGlMVxwybMnpz62DbwlF+PjWeYQ==
X-Gm-Message-State: AOJu0YzZrlTxIzrYz+1ZH2iVHA2mX6zdg/LXSeKY/sUpbvJSeeBZf2YZ
	0pruOWftV+46ESxGaOTwcQsEh4ddpm1KyHpPUskdmynuUy78zZIFvIutvep5/zXVSUTP7u864oM
	sMIATY7bAElCsYAEnmVue0F5BczEcjlwBWyYau+jE73gcoDxAnQvEZP4=
X-Received: by 2002:a17:903:64d:b0:1fb:8a61:129d with SMTP id d9443c01a7336-1fc3cc97f0dmr1408425ad.56.1721073030309;
        Mon, 15 Jul 2024 12:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSljk/kwDk3/69psVmSGyvS0BhVyYry6+tBPSjISEh8cmk5vhT+ijmCT4SgmDvm+fenPSQrg==
X-Received: by 2002:a17:903:64d:b0:1fb:8a61:129d with SMTP id d9443c01a7336-1fc3cc97f0dmr1408315ad.56.1721073029937;
        Mon, 15 Jul 2024 12:50:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc39f2asm44609095ad.193.2024.07.15.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:50:29 -0700 (PDT)
Date: Tue, 16 Jul 2024 03:50:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.07.14
Message-ID: <20240715195026.5c4qvx2thoeessqu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <64ec6187145dfd111f22f1ae151ae538@kernel.org>
 <20240715154454.GB70013@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715154454.GB70013@mit.edu>

On Mon, Jul 15, 2024 at 11:44:54AM -0400, Theodore Ts'o wrote:
> On Sun, Jul 14, 2024 at 10:00:37PM +0800, Zorro Lang wrote:
> > 2. Most of cases have removed '_supported_fs' line. From now on, if you don't
> >    need a specific white or black fs list for a case, don't need _supported_fs
> >    line.
> 
> A side effect of this change was that it triggered a failure in my GCE
> test-appliance's regression test suite.  That's because one of the
> things the regression tests run is: 
> 
> 	gce-xfstests -c ext4/4k,btrfs/4k btrfs/001 generic/001 generic/002
> 
> and previously, when testing the ext4/4k configuration, btrfs/001
> would be skipped due to its "_supported_fs btrfs" line.  Now, the test
> is actually run, and it fails (unsurprisingly).
> 
> I'm going to work around this in my test appliance, so I'm not asking
> that the change be reverted, but I thought I would point out that this
> does result in a behavioural change in some corner cases.

Hi Ted,

Sorry about this trouble to you. Sure, this's a behavioural change, and it's
been talked several times. Generally, even with this change, fstests only run
tests/generic and tests/$FSTYP cases by default. So it won't run tests/btrfs
cases if FSTYP=ext4. But with this change a fs has chance to force to try
another fs' case by specify the case name particularly (if the tester thinks
it's good to him).

If you or anyone find regressions from it, please feel free to report to
fstests@.

Thanks,
Zorro

> 
>        	    		       	       	      - Ted
> 
> commit 71b003b9ad0a0f0e4bf91619702addd0bb552f7d
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Mon Jul 15 11:34:30 2024 -0400
> 
>     test-appliance: exclude tests that are not supported for the file system type
>     
>     This is needed due to upstream xfstests commit f2c179ef055d ("remove
>     spurious _supported_fs calls").
>     
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/test-appliance/files/root/runtests.sh b/test-appliance/files/root/runtests.sh
> index f59305b0..817d51f2 100755
> --- a/test-appliance/files/root/runtests.sh
> +++ b/test-appliance/files/root/runtests.sh
> @@ -386,6 +386,14 @@ do
>  	    AEX="$AEX -E /tmp/exclude-tests"
>  	fi
>  	if test ! -f "$RESULT_BASE/tests-to-run" ; then
> +	    case "$BASE_FSTYPE" in
> +		ext2|ext3|ext4)
> +		    tests_regexp="ext4"
> +		    ;;
> +		*)
> +		    tests_regexp="$BASE_FSTYPE"
> +	    esac
> +	    tests_regexp="^($tests_regexp|shared|generic|perf|selftest)"
>  	    bash ./check -n $FSTESTSET >& /tmp/tests-to-run.debug
>  	    ret="$?"
>  	    echo "Exit status $ret" >> /tmp/tests-to-run.debug
> @@ -396,6 +404,7 @@ do
>  	    fi
>  	    bash ./check -n $FSTESTSET 2> /dev/null | \
>  		sed -e '1,/^$/d' -e '/^$/d' | \
> +		grep -E "$tests_regexp" | \
>  		sort > "$RESULT_BASE/tests-to-run"
>  	    nr_tests=$(wc -l < "$RESULT_BASE/tests-to-run")
>  	    if test "$nr_tests" -ne 1
> 

