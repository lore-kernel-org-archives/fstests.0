Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D898763FA
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462583; cv=none; b=IeowPMG8pVr6RAxV35tOEt2xEQODQl8yL09j6cpRSihDqYzucuMcCkg6gUW2JeuirZwnirVXdD7FFRCoWmLsAuRuCUzFYELwuH1TRzbkOwSk3fKYnHcQCKSAdItasHZkkpJ5QwdBo+sV92eAdyeB2T3yMmJGDKt+dFlt74u8uGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462583; c=relaxed/simple;
	bh=aBd/YJI+B4tpPJ4gYlzmTgXT+KOiMZAQAX+sS6HBLtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riDXLZiu5eWQBDlMH6OouBPGSIJUOOSc5f6uWhHRZjy/TCkw1PZPO+ByYoigrOXyFiGFS6Xn4glxwUlD9GjM+K0sbzosLFZ7dr2rt481phMOSuNeRkSVyFw8YlFrf+svThGHJQ+ztqwfvvQjHbj+ZvoofP5OdHZU/xyKfgP7IOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiG9pE0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiG9pE0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711462580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99IBjrYML6mmxn5tpo6ATUOgl5sDTAoiaLQ6B/QxuaQ=;
	b=AiG9pE0AaN4Z92WCQ3qnFzxt8Jxy6Jw2ZR3uV2hVo3zXedrFZ4tmX1UmEN/wr+bI13iKqH
	XxDghW2M6sY7i+Dq1UForQKhAZpYdxXfJH+Q+sVzaae63P+dxgapcG9MxH76iJOMpGKJ55
	/h/t7LD72OIiu6ZcRBIJcK+huWRl0Sk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-EvaJNO4IOp2Bh7kDnALlbg-1; Tue, 26 Mar 2024 10:16:18 -0400
X-MC-Unique: EvaJNO4IOp2Bh7kDnALlbg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-22233c4914dso5672433fac.3
        for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 07:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462578; x=1712067378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99IBjrYML6mmxn5tpo6ATUOgl5sDTAoiaLQ6B/QxuaQ=;
        b=QBscPKIEAKzsbCdSWB08Lyqt332WDDj3sYidIB72/IPJ4U4uVMqcY5WVRWRcrDzxfv
         9klnvjcz26CRUhKnLHvZ4Irg7OOswiN48vIIebrhzHrccRfE0L0n+WjfZ3uh0iNkSNKI
         y+BBcxQc5VXQSpRl23jkjphySbE4GMDT3vzha4E8GSC+n+OenH3vApW/Y5uiITtppa3C
         d1rkrYuuEhdR0vJneVLV9DPEgzFXqeGEUTbs5D23NsG3TbBPvnfuvcaPE/ln/CLG5jG1
         it9qZiJ88mq9qJMoNXuoNT5u1eqNlNz3ed9YzfaNAQ5QzGAg2gcJ92Kf9rPyFnpgMDCW
         DVRA==
X-Gm-Message-State: AOJu0YwGyMzvv8Vo9O3gsorzu8fRMvTB6/oj4e4Q1UzdwwiYccEWdQwO
	WmIoSD8Q8ZFlVm2GUTV2OXDCXRdDfZVxSuGpXaoWjD/bnd9h2wrMGmB9gZYg5sL+GjnitxhRlSv
	Y2yWzgGFi1LS5EyfsipZTfLvvxO5BhKmKu9+gy3b7ZmpuBlPJeLdxaIw=
X-Received: by 2002:a05:6358:3398:b0:17b:f672:4abe with SMTP id i24-20020a056358339800b0017bf6724abemr1265735rwd.16.1711462577763;
        Tue, 26 Mar 2024 07:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECFuRzRZA7BPkT7kDiq6sPTQoP7H8KUMd3wyezleyqvqsfbZLFDW2kfpqU56ELEmkeALDgCw==
X-Received: by 2002:a05:6358:3398:b0:17b:f672:4abe with SMTP id i24-20020a056358339800b0017bf6724abemr1265691rwd.16.1711462577174;
        Tue, 26 Mar 2024 07:16:17 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q27-20020a63751b000000b005bd980cca56sm7579727pgc.29.2024.03.26.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:16:16 -0700 (PDT)
Date: Tue, 26 Mar 2024 22:16:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: =?utf-8?B?6JSh5pmT5paM?= <caixiaobin0807@163.com>
Cc: fstests@vger.kernel.org
Subject: Re: Question: Why tests/generic/482 and tests/generic/487 can't pass
 both at the same time.
Message-ID: <20240326141613.ekd5wk4zmeqnde3x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <7d19c3c3.51df.18e73815f19.Coremail.caixiaobin0807@163.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d19c3c3.51df.18e73815f19.Coremail.caixiaobin0807@163.com>

On Mon, Mar 25, 2024 at 10:47:22AM +0800, 蔡晓斌 wrote:
> 
> Hi, I have a question when I ran the xfstests, please help me to solve this question, tks.
> 
> 
> In my environment, I ues the machine with architecture of aarch64, and then setting the env in local.config file like below:
> 
> 
> 
> 
> # Ideally define at least these 4 to match your environment
> # The first 2 are required.
> # See README for other variables which can be set.
> #
> # Note: SCRATCH_DEV >will< get overwritten!
> 
> 
> export TEST_DEV=/dev/mmcblk0p12
> export TEST_DIR=/mnt/xfstests/dir
> export FSTYP=ext4
> export SCRATCH_DEV=/dev/mmcblk0p13
> export SCRATCH_MNT=/mnt/xfstests/dir-mnt
> export SCRATCH_LOGDEV=/dev/mmcblk0p14
> export USE_EXTERNAL=yes
> export DUMP_CORRUPT_FS=1
> export KEEP_DMESG=yes
> export USE_KMEMLEK=yes
> export LOGWRITES_DEV=/dev/mmcblk0p15
> export MIN_FSSIZE=10485760 # 10MB
> export DIFF_LENGTH=0
> 
> 
> And execute the command "./check -l -T tests/generic/[0-9][0-9][0-9]" to run the xfstests. When it ran out, I find that "tests/generic/482" was failed, and "tests/generic/487" was successed. 
> 
> 
> So I check the source code for those two tests, and I found that used different function in them, like below :
> 
> 
> tests/generic/482 :
> 
> 
> # real QA test starts here
> 
> 
> # Modify as appropriate.
> _supported_fs generic
> 
> 
> _require_no_logdev
> _require_command "$KILLALL_PROG" killall
> 
> 
> --------------------------------------------------------------
> 
> 
> tests/generic/487 : 
> 
> 
> 
> # real QA test starts here
> _require_scratch_nocheck
> 
> 
> sflag='-s'
> case $FSTYP in
>         btrfs)
>                 _notrun "btrfs has a specialized test for this"
>                 ;;
>         *)
>                 ;;
> esac
> 
> 
> _require_logdev
> _require_dm_target error
> 
> 
> Then continue to check the source code :
> 
> common/rc :
> 
> 
> 
> # this test needs a logdev
> #
> _require_logdev()
> {
>     [ -z "$SCRATCH_LOGDEV" -o ! -b "$SCRATCH_LOGDEV" ] && \
>         _notrun "This test requires a valid \$SCRATCH_LOGDEV"
>     [ "$USE_EXTERNAL" != yes ] && \
>         _notrun "This test requires USE_EXTERNAL to be enabled"
> 
> 
>     # ensure its not mounted
>     $UMOUNT_PROG $SCRATCH_LOGDEV 2>/dev/null
> }
> 
> 
> # This test requires that an external log device is not in use
> #
> _require_no_logdev()
> {
> [ "$USE_EXTERNAL" = "yes" ] && [ -n "$SCRATCH_LOGDEV" ] && \
> _notrun "Test not compatible with external logs, skipped this test"
> }
> 
> 
> I find that these two functions behave as mutually exclusive in use, so I don't understand why xfstests can't pass both tests at the same time. Please help me to solve this question, thank you again. 

Not sure what's the problem you hit. g/482 and g/487 are totally different two
test cases.

The g/482 calls _require_no_logdev due to it needs dmlogwrites device, and:

  commit 50f6d46410367586ab151b357e67393599eebd1c
  Author: Darrick J. Wong <djwong@kernel.org>
  Date:   Tue Jul 26 12:48:51 2022 -0700

      dmlogwrites: skip generic tests when external logdev in use

but the g/487 calls _require_logdev due to it needs an external log device, to
avoid the effection from the dm-error of data device.

The g/482 shouldn't fail if there's a SCRATCH_LOGDEV, it should _notrun. If it
failed you'd better to check that failure.

About how to run g/482 and g/487, as one requires logdev, the other one requires
no_log, so you should have two config sections at least, one have SCRATCH_LOGDEV,
the other one unset it. Then run two kinds of tests (with or without log device).

Thanks,
Zorro

> 
> 
> Looking forward to your reply.
> 

