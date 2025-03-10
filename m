Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDA1CEADB
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636109; cv=none; b=gzeAjorqiKh8tW3g3QWj0qg4NClGBnCAxilnITbh5hwhfx0+WvjeDfof30yNVAR1NgtHXn2rbVIgHH0tDfpQ38W9s5nuAiuGPJiLryLs5aKFHxPcOmZrSmykiVX6AtxIVKeR3vZrxSlzKS8Wz0CJne8uItNmkxnPbk31Ww0RhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636109; c=relaxed/simple;
	bh=HdcReUXK5VikoOoFXvwcu6K9LxjITts1JsPLEeLKHm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4aJdhoXyRjA3m0dWxPpF30h5HVMXQ+BKSnHJq3Bdy1/MM3y9OUn9C40qLHSb4fo/64dg5++mldanJZkra6J2NSaW5w6CYi1+oQ10Ne79Fz8UTbEyVAswglpCcXoTQmWj70jG0joskE1cUnVB1nF4V5LE755dsiYQwPEd5M+SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWCuQP5m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWCuQP5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741636106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOVGRYhvRF8U399jZHygKPFd5tS2cIqbXc6OU6+8P3c=;
	b=TWCuQP5mAtK53EgxaBfIhu9SRTh7Mk3/ExkZhvJ7bAohSMzafvHPm06yZjneX/vpjIXQ57
	0b8P8L+PkUXNkrZYGy8RH30v0MbMZpB+xQMQd+WPZlR3THuvvkSeXtS1Ya3UsWBiQ6ABYG
	MiHpjQgzwsD4z9+50m9hG7dk+UeLk2s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-l3rXEZ0oNFq6It_fVJZtAA-1; Mon, 10 Mar 2025 15:48:25 -0400
X-MC-Unique: l3rXEZ0oNFq6It_fVJZtAA-1
X-Mimecast-MFC-AGG-ID: l3rXEZ0oNFq6It_fVJZtAA_1741636104
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2217a4bfcc7so72527175ad.3
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 12:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636104; x=1742240904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOVGRYhvRF8U399jZHygKPFd5tS2cIqbXc6OU6+8P3c=;
        b=s68cWiDA6IM824xcru7y73CvkXPi2O4WQIQPu3GrmglzLpii5NWC+7mAyXapK0lGqz
         i9UdKsxR6BrErg9FQDXdwH2mqwDfgKl7rjAOWUggLRJ0BBHWcseNAKBJrT+rkuxzxUAh
         pnIWDdAMXVM81f98GE4jsS6KS1PhlxorZ5ZlN/p75gAUDnFqvuMPr7OuybsofAs65IjP
         sas6w6JsZorTlUtNLM4qEQ7bEsRGFnQnStOWxD5tEuH/Jy7J5kjse1sq1kwlitJ6WY1z
         xMrjHiwADJ7qNvFMywqUhNJeMK9PSVkcgI91oU5McuBkDOJ1EOn3k5Ap1DQam65F73ue
         6CBA==
X-Forwarded-Encrypted: i=1; AJvYcCXxm8cEdFa0kuhxDqhrHuBEpg4Lm4guuBLu4Fmk727VzwfMF6cglda5v7t/9UgiHNdfVGIr+foR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/C8Wxd7kLlz4LEcyb30DN1uZdRNC2cq9yEwK1YVqK/iT5irO
	Q0oPJvRAw+9kKaXiJ120OatPR6xE/4gBTer3I99D+8hQ0b2QdPxGljDU9nHOopJ401rVylDKRH7
	EU594G7k3ds31VmqtF1Zo8AKNo6fXcZUiiAdmIVYzAPxYRSeq3WBp4uYNuCb2k4TXXw==
X-Gm-Gg: ASbGncu6N/ozYCBGLZrclNq/1s2pffe/UzXlUb55LF1AsoxJWH5jgpXA5hqzL4mVJHI
	I1JZzc3tgxPJSd9mFeMpueccz6iK01b9lS1kP8Xp/Bp9fYzRsY9q4fBfOcy+Rw9GMt+K4klMhag
	NnDXhXCuTjWvggN+81KOwIC/+oS8hxxnyHvtqGUX1OZCCh+RUm7NKX124hF8aJkC/YB6/MLvGON
	qZpspCQ5uPmcUWOnYoaaxajkBRrJGSW+CQRKzhMSgkBQxFdg7vGJLF2OJg91ixJvd5H0yMs3sPQ
	OZcm/pHVYxkqRSeTJlYwRhK3Zm1Lyk0lxFGEGXGBiieS/CiYQ6+/vH0j
X-Received: by 2002:a05:6a00:22d4:b0:730:99cb:7c32 with SMTP id d2e1a72fcca58-736eb7d9a50mr1501560b3a.7.1741636103917;
        Mon, 10 Mar 2025 12:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfnUMoN0oZOYdg27N0V7GBO2uZwi/uwY/SVCkMZe9c/mXbgJsNGhdPHXrd8YJtfe4VVfRxVQ==
X-Received: by 2002:a05:6a00:22d4:b0:730:99cb:7c32 with SMTP id d2e1a72fcca58-736eb7d9a50mr1501541b3a.7.1741636103535;
        Mon, 10 Mar 2025 12:48:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736db486f14sm2355811b3a.7.2025.03.10.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:48:23 -0700 (PDT)
Date: Tue, 11 Mar 2025 03:48:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] f2fs/009: detect and repair nlink corruption
Message-ID: <20250310194818.wki325qreuta26nc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250306081809.2397527-4-chao@kernel.org>
 <20250310080006.rkvoxu55fe3qlxmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c62943db-6169-462a-95a0-15fb2d5bc079@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62943db-6169-462a-95a0-15fb2d5bc079@kernel.org>

On Mon, Mar 10, 2025 at 05:59:23PM +0800, Chao Yu wrote:
> On 3/10/25 16:00, Zorro Lang wrote:
> > On Thu, Mar 06, 2025 at 04:18:09PM +0800, Chao Yu wrote:
> >> This is a regression test to check whether fsck can handle corrupted
> >> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> >> and expects fsck.f2fs can detect such corruption and do the repair.
> >>
> >> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> > 

[snip]

> >> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV >> $seqres.full
> >> +	if [ $? != 0 ]; then
> >> +		exit
> >> +	fi
> >> +
> >> +	export FSCK_OPTIONS="-f"
> > 
> > You've set below code in _repair_scratch_fs():
> > 
> >     f2fs)
> >         fsck -t $FSTYP -f $SCRATCH_DEV
> >         ;;
> > 
> > The FSCK_OPTIONS="-f" is useless.
> > 
> >> +	_repair_scratch_fs >> $seqres.full
> >> +	if [ $? != 1 ]; then
> > 
> > What does $?=1 mean? Does $?=1 mean finding corruption and fixed, $?=0 mean no corruption?
> 
> That's correct.
> 
> > 
> > If you want to detect there's a corruption, then fix it, then check if it's fixed. How about
> > calling _check_scratch_fs at first to get the corruption error you expect, then call
> > _repair_scratch_fs to fix it. Then call _check_scratch_fs to make sure the corruption is
> > fixed?
> > 
> > Something likes (just a rough example)
> > 
> > _check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
> 
> You mean this?
> 
> export FSCK_OPTIONS="--dry-run"
> _check_scratch_fs >>$seqres.full 2>&1 || _fail "can't find corruption"

No,

> 
> We need to export FSCK_OPTIONS w/ "--dry-run", otherwise _check_scratch_fs
> will be stuck once it detects corruption.

If so, you might need to give _check_scratch_fs (and _check_test_fs) a f2fs
specific handling. Due to _check_scratch_fs aims to do "check" only,
_repair_scratch_fs aims to do "repair", they have different target. When
we call _check_scratch_fs, we hope it reports pass or corruption then return,
neither "repair" nor "stuck". So if I understand correct, you might need:

_check_scratch_fs()
{
	case $FSTYP in
	...
	f2fs)
		FSCK_OPTIONS="--dry-run" _check_generic_filesystem $device
		;;
	...
}

Or you have any better way to do f2fs check :)

Thanks,
Zorro

> 
> > _repair_scratch_fs >> $seqres.full
> > _check_scratch_fs
> > 
> >> +		_fail "fsck can not detect and repair zero nlink corruption "$i
> >> +		exit
> >> +	fi
> >> +
> >> +	export FSCK_OPTIONS=""
> >> +	_check_scratch_fs >> $seqres.full
> > 
> > I think _check_scratch_fs outputs nothing if run passed, right?
> > 
> > _check_scratch_fs calls _check_generic_filesystem for f2fs, the FSCK_OPTIONS
> > is "null" by default, so above FSCK_OPTIONS="" is useless too.
> > 
> >> +	if [ $? != 0 ]; then
> >> +		_fail "fsck hasn't fixed nlink corruption "$i
> >> +		exit
> >> +	fi
> >> +
> >> +	_scratch_mount >> $seqres.full
> > 
> > ">> $seqres.full" isn't necessary.
> 
> Will update according to you comments, thanks a lot.
> 
> Thanks,
> 
> > 
> >> +	_scratch_unmount
> >> +done
> >> +
> >> +echo "Silence is golden"
> >> +
> >> +status=0
> >> +exit
> >> diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
> >> new file mode 100644
> >> index 00000000..7e977155
> >> --- /dev/null
> >> +++ b/tests/f2fs/009.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 009
> >> +Silence is golden
> >> -- 
> >> 2.48.1
> >>
> >>
> > 
> 

