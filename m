Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F211426F
	for <fstests@vger.kernel.org>; Sun, 14 Apr 2024 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078675; cv=none; b=bOsDuPVry7v2ict06L8LH5SQfTvgL68l4er7pfJ/7s1IyyBK/O/21HXNaPYpYQ+30o6mH/tGszXQAyBjGqz/ohKRtzeg/opFdnKkd89pJHV3kWoFKfLPpdut/N93fL18Ui8gDEK7wPAHWS0Qv9ckdm92KjWvQQSi+oMLQB2J5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078675; c=relaxed/simple;
	bh=3WFoX5OLT1YH51qlJdU3oe9zUQO2SxQkczALvj1YmgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB1YLV3TKZccRHPUqwdFXphBh0B9Eikp4XwdaY/PnZnjaHvGgardNUmHiLWQW/BEW1t7Tk5AlWXp+dgfjcz/xfyR7sqshJhbv+iNFFeNmeupsMsFod0EHSCP7dsHYBbp2bepMuqLKgTrwocT8hhNMM1Q8fzbNMG2zz05hQS9R2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZY5hBIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZY5hBIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713078672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zuu8Z2F1QzEZwTCCJCZ5XaeMvEBCGNbRsJ3kU2nN3A=;
	b=YZY5hBIaMvMO+IStNrcHzG8r7JabKEX5GTXPYRU7X2thPaSHQe1s3Q9HXxWUFqT3BO/UhH
	rHg2U/dQV0ztEzmYiO1aft0Z1q6RdScWENx8E2n5vQ0e5+AKRaD1au0Bi8InbhRqIBIVhr
	XjB5Hf+0l6pOIXv1Rtvna7Ui5DFkVK8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-fVuK2GTSOyabR2dQp_tiDw-1; Sun, 14 Apr 2024 03:11:10 -0400
X-MC-Unique: fVuK2GTSOyabR2dQp_tiDw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed0e1f8faeso2378152b3a.1
        for <fstests@vger.kernel.org>; Sun, 14 Apr 2024 00:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713078669; x=1713683469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zuu8Z2F1QzEZwTCCJCZ5XaeMvEBCGNbRsJ3kU2nN3A=;
        b=D9pOUSR8A/PeCETIqGYJa/9MYf+y7z81Wgwet/upSVVu6wd6x458v+Zbu1KxsdRuP9
         rO10z8FPjdOCaHWSUz37lF71tJ9t98Qf3VA4CTVsZZiU+Qw+1GNWrmS4aJEyeuNexPeJ
         GOcioP3uesOoG48lpO924MAinilZL4hbqlVpa8eY8cjdPJGXNoLxZg7bPkeEK3lQodn+
         cmekm9fxKtLKjOn/VTfAy2h7KNBMudi9rcuwpc44BIQGf3bo8Ue+QLzJQ7IE2kCi7kZW
         r4wgnMR8ZPAfFo9qMSFkt6fUKcRs03rnAddTzx3lA+LV4XNNOnjZlIDRaDl1lDiRrz5m
         0FkA==
X-Forwarded-Encrypted: i=1; AJvYcCWfJZ3jajRbxsqq2U1YmwpnnMkeAKl00yk1CZWZMbC6F2OF/zw8BTFRuiOHpflBL5faeAkVqM4eOrJKdc6YYPw1jvvOc3pz3w==
X-Gm-Message-State: AOJu0Yxb9fqXj+V+FE5Gws+PUOiO0X2+HKB+/8gjmB/QTluFxyNgLwrS
	dt/CVt+CYtAcqsigsq56byUTDJoo/T8v2qQl9QMn+LXOFoDa/cqEPel/MmE986iHNajQHou1fal
	yx32eDJFa9m58qcsOBKQpE+dh+hqihNfGa7qNwaVhfwH0kMpXjyyjcO8=
X-Received: by 2002:a05:6a20:9681:b0:1a7:9b0e:ded3 with SMTP id hp1-20020a056a20968100b001a79b0eded3mr7017113pzc.11.1713078669030;
        Sun, 14 Apr 2024 00:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuxLKMQb72jku+i7ZXRiPBC25bjS/f8tdf5mzPn9rGGktYnQ3hbtYR4ThLwzBIc7YzHimpyg==
X-Received: by 2002:a05:6a20:9681:b0:1a7:9b0e:ded3 with SMTP id hp1-20020a056a20968100b001a79b0eded3mr7017102pzc.11.1713078668469;
        Sun, 14 Apr 2024 00:11:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ei52-20020a056a0080f400b006ea858e6e78sm5237854pfb.45.2024.04.14.00.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 00:11:08 -0700 (PDT)
Date: Sun, 14 Apr 2024 15:11:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.cz>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.04.03
Message-ID: <20240414071104.g7lfttewsundcaqd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240403072417.7034-1-anand.jain@oracle.com>
 <20240409142627.GE3492@twin.jikos.cz>
 <20240413192824.sz4ppx3rmdvcov6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <27c469b2-95f3-4232-8b86-1c8527eee314@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c469b2-95f3-4232-8b86-1c8527eee314@oracle.com>

On Sun, Apr 14, 2024 at 07:13:43AM +0800, Anand Jain wrote:
> On 4/14/24 03:28, Zorro Lang wrote:
> > On Tue, Apr 09, 2024 at 04:26:27PM +0200, David Sterba wrote:
> > > On Wed, Apr 03, 2024 at 03:24:14PM +0800, Anand Jain wrote:
> > > > Zorro,
> > > > 
> > > > Please pull this branch, which includes cleanups for background processes
> > > > initiated by the testcase upon its exit.
> > > 
> > > What is the ETA for a pull request to be merged? Not just this one but
> > > in general for fstests. I don't see the patches in any of for-next or
> > > queued.
> > 
> > I think you might be confused by the subject of this PR, there's not v2024.04.03
> > version, and no plan for v2024.04.03.
> > 
> 
> It is the patches which were pending to be pulled as below, and I see them
> now in the patches-in-queue branch.

Yes

> 
> --------
>   https://github.com/asj/fstests.git staged-20240403
> 
> Anand Jain (1):
>       common/btrfs: lookup running processes using pgrep
> 
> Filipe Manana (10):
>       btrfs: add helper to kill background process running
> _btrfs_stress_balance
>       btrfs/028: use the helper _btrfs_kill_stress_balance_pid
>       btrfs/028: removed redundant sync and scratch filesystem unmount
>       btrfs: add helper to kill background process running
> _btrfs_stress_scrub
>       btrfs: add helper to kill background process running
> _btrfs_stress_defrag
>       btrfs: add helper to kill background process running
> _btrfs_stress_remount_compress
>       btrfs: add helper to kill background process running
> _btrfs_stress_replace
>       btrfs: add helper to stop background process running
> _btrfs_stress_subvolume
>       btrfs: remove stop file early at _btrfs_stress_subvolume
>       btrfs/06[0-9]..07[0-4]: kill all background tasks when test is
> killed/interrupted

Yes, I've merged them in for-next, will push it today (after I check
the regression test results).

Thanks,
Zorro

> --------
> 
> Thanks, Anand
> 
> 
> > Last fstests release is v2024.03.31, I generally make a new release in ~2 weeks
> > (1 week at least, 3 weeks rarely), and each release is nearly on Sunday. Due to
> > I have to give the new release a basic test and check the test results at the
> > weekend (I have my jobs on workdays), if nothing wrong, I'll push it on my Sunday
> > night. That's how I deal with fstests release, please feel free to tell me if you
> > have any concern :)
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > 
> 

