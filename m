Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52B277C80
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379335; cv=none; b=N8oX7A+0779eI2E92rcGP5Kyoh2FdJtC15gqzvin5pIf+07KamW9SJDdtvxvFndVxB29ZUq5AFJNle/p2pvUcp8juMOU0Z+GZeodP82T0tj3r+Wh1x1A5wPPvLVJr32kihfUf7Vh+fjmF8Ev06zT8P2g6OjghmEFn+BHG7Nz4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379335; c=relaxed/simple;
	bh=JUHji7UujZqlO7w3tuePIlD7pcqYDmKrXssbri1stvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgRt8O3KqBfIRtISZ+ENYSLNTiR2BUFAaIhw7jMrstQ+dZa1JVbObwRUykzWz9RoUri/kJ9LvATM3XvL4QUUcXpoGIbVuFI9CTcg5spIA8eskn2qFhEgF52/rPJ0uXfCE29itC9kAp6xhXP6EocQGonFsLMD+12jVbApk5N90uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bo5xc0ry; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo5xc0ry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751379333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WB0WRDy9FRZayc1U1MzG8GUWJDmiN9dk9GtzK6cuSOw=;
	b=bo5xc0ryZ7X2eRo24BzbNR+Om7i5ZGLtvGtbzHk0wAqa7yxzy80hefmNJCU4ATTolGDRXl
	Tc2Hdb+QFKUwRR5bWeu14NCyOUYeSFPEA1IrFuRDKGbr0yKiwKUgV7gUw9t77vYNfTd5Hu
	zY17LBWnaiEWjKL59IbJS7LVKeLVouw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-tvp7ZlEuPNqUFlg7ghHrEw-1; Tue, 01 Jul 2025 10:15:32 -0400
X-MC-Unique: tvp7ZlEuPNqUFlg7ghHrEw-1
X-Mimecast-MFC-AGG-ID: tvp7ZlEuPNqUFlg7ghHrEw_1751379331
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31c38d4063so2199415a12.3
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 07:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379331; x=1751984131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB0WRDy9FRZayc1U1MzG8GUWJDmiN9dk9GtzK6cuSOw=;
        b=stOFmxn6xJUz3k6WmPY6WjHULFTjFyztso43qH9xcSqhxLnBCJIzBgQkibjFvKnOp1
         cQDz1bFRSUk/sZrxAztL9z1vA0XlRugsuNozytk+NEvEhf0qFKcLLHShyCIyrZ6YdgFM
         ivywByBumyGIXQgg8/Sqhjdcmrr+YOPXoowOgbzkD0jvBq1Qe0MRnnfcLHFpbtRINQAH
         yLWV7drY7tLHyeFyD+u9lAALA5oLHCBm5y/BUUlF0VYIWzgPxM1XMvHmP9wOWHCQ43JR
         BeR6tT8zANW7vAJV0jZozLcPt1Ps0NN1IRZxRjy9s+IQ23a+VBjFJerlp74vbM0Ufyj8
         NgTQ==
X-Gm-Message-State: AOJu0Yygu2iobkJle9wQmAlN3P94PtsLmo19cBEcFZnlia17DKIydLjN
	iUtGhbtFpDZqURp0+jbxA8Z/krVgJiES5c93OA6bH11aT6eH2WhcS8KQ0nKPZ5usIDU0cJ8AAfi
	kGtNsaq4Kp+sgIEIiQKtcm4C2Kma1kKg7mfaWBuN6VqW6T29Rk5dOxS0gAok=
X-Gm-Gg: ASbGncvzEexcPLgc46tv3YBSvIs7+Y0LPASLzUOPVH8Yu0LTCsIhGlyq0J0w+dlEdqt
	HNjhnu+7nRPyrEzls1f4rpOeEmr9iEv2J6UjFeLAIOTecweqs0U3OIaTjNocWkM/C3oh8WwS4pZ
	pt2S1+irpUdGZMlBzQtD5r9u8/losyw7hYq29VXCF2eFoVZ7h/E4OXCStUwoEegk83OL67mqc2w
	uss/ugfrAFFkeJ1xbnWjlJ6OTumAvB5Jp23oYzCSfgpcAuj3YfiAziiw05+nAKExPZ8ErqTIqKR
	48j293a3p32D9vPp0abOGyaWAGwi8B+qOfMqN2dqRT7GGjm+QBo70PkhTwEINO8=
X-Received: by 2002:a05:6a21:329c:b0:21f:bdcc:843e with SMTP id adf61e73a8af0-220a12a7bdfmr25950521637.11.1751379330747;
        Tue, 01 Jul 2025 07:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAqqjmvMONRgF28Ze2pDlWlSW3k73ymZXX0NrkVI1QPI0pM4v+y9MA2CCJ1Re2hZc2Ab4Nkg==
X-Received: by 2002:a05:6a21:329c:b0:21f:bdcc:843e with SMTP id adf61e73a8af0-220a12a7bdfmr25950462637.11.1751379330167;
        Tue, 01 Jul 2025 07:15:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3008e2esm10726566a12.16.2025.07.01.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:15:29 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:15:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/2] fstests: remove duplicate initialization in the
 testcase
Message-ID: <20250701141525.iwjz5y3lawy3olk7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1748058175.git.anand.jain@oracle.com>
 <ef4d2dbb8d82020bc3eac655d03650bfbd77f9ff.1748058175.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef4d2dbb8d82020bc3eac655d03650bfbd77f9ff.1748058175.git.anand.jain@oracle.com>

On Sat, May 24, 2025 at 11:57:13AM +0800, Anand Jain wrote:
> _begin_fstest() already initializes several variables, including `seq` and
> `seqres`, so remove those redundant initializations from the testcase.
> 
> Also, ext4/053 unnecessarily re-initializes `here`, `tmp`, and `status`,
> which `_begin_fstest` already handles. Remove those as well.
> 
> and remove template comment.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Thanks for cleaning up these redundant codes,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/253 |  3 ---
>  tests/ext4/053  | 10 ----------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/tests/btrfs/253 b/tests/btrfs/253
> index 96ab140f1780..a0cc9b55de69 100755
> --- a/tests/btrfs/253
> +++ b/tests/btrfs/253
> @@ -28,9 +28,6 @@
>  . ./common/sysfs
>  _begin_fstest auto
>  
> -seq=`basename $0`
> -seqres="${RESULT_DIR}/${seq}"
> -
>  # Parse a size string which is in the format "XX.XXMib".
>  #
>  # Parameters:
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 77b3ac8171f0..55f337b48355 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -9,12 +9,6 @@
>  . ./common/preamble
>  _begin_fstest auto mount
>  
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
> @@ -27,13 +21,9 @@ _cleanup()
>  	rm -f $tmp.*
>  }
>  
> -# get standard environment, filters and checks
>  . ./common/filter
>  . ./common/quota
>  
> -# remove previous $seqres.full before test
> -rm -f $seqres.full
> -
>  echo "Silence is golden."
>  
>  SIZE=$((1024 * 1024))	# 1GB in KB
> -- 
> 2.49.0
> 

