Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A592EBB8F
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264890; cv=none; b=SUXFhPYkprIAH1aydduoZ9F2Rf1AQPlVVNfLat250FhUkBGoIGZpgylxG0bzymjvy0zECiaW5u5B2be9v2nWg5EZqJ0+ZUEO3LbxV+jvFAC5MPVBmaWq8tjufIe7l/mp2JYd0mgrib80xI3eah0op/LE17ILHxQLFrE57i8tuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264890; c=relaxed/simple;
	bh=N64cxtxWKUWmMKTGSLr08pMBn+ctl4S+5/TODO1lpvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df7jQX9AhD2l5DC29kBTJPIzRrjvLkUpBdhJ2D+sWz4mi2dLnt4Bb9kRiIilhBdD07k4onxwPGQh+g7jYtAj/vB4fHGFTDJQmPZjM2Isj8XaWz95k5JW7eoZbzpZ/N3FVQ9iEtL5mNTgNgaObdLtIQEfYSiJV/A3KEg2+Q4HaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjaVx9Jx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjaVx9Jx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750264887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cqDpSe58TVNQ0XLmUf8I4dD1kyafCJBBTCejSICEP4=;
	b=PjaVx9JxMwXT2W287F26Bv5xWqDxAwPZHnLxGqtXnVQMtXj+UoIomJOuDkiY3fF8sgXZoN
	EV3ZHe/KV9zwI1RbkGYC2rNh+xqIDzwIaMHsqyqRBgvUv7gw6N9XhY2F5na+wgsCXH7TLN
	NoLKXKWR0C1IqjE98fjXlji46mO9gPI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-9K85dDZcPK2U35t9OSmCng-1; Wed, 18 Jun 2025 12:41:26 -0400
X-MC-Unique: 9K85dDZcPK2U35t9OSmCng-1
X-Mimecast-MFC-AGG-ID: 9K85dDZcPK2U35t9OSmCng_1750264885
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748e1e474f8so1880255b3a.2
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264885; x=1750869685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cqDpSe58TVNQ0XLmUf8I4dD1kyafCJBBTCejSICEP4=;
        b=oXYIIJPu2/a8eAQlbq3GTyy8OfKT7as3zmGvEQ2IPP2NwzWFbQiAmiPHRJyoBoNWmR
         g84zHV4GTcpJxpow33R1MpimPqU1Jud5Gq0sUJ3pnPZvLRHxGqcSfI8+tEZerMJsZRxE
         Mw/cpXTIovnlu2KVvN/GeenWe4z7sGNWeBRg9wNHIvVa/TmB+0nTrmtLgEyam+22bR4D
         rUYqqAjDXVP49DAiOvnDE2xMWbNFskHr+onn901lg3C7iAzvnQ4WgpdQCcIbWYyA0Fk9
         ZiYKJ8x3qgPOYAIxGavg7gjpntxlKCQOe7ARwKgeIK5A5nVdK3TlRCIYXjPFLkaBFnTk
         DB5w==
X-Forwarded-Encrypted: i=1; AJvYcCVWZa+u4EJGwUCNwJkVV4wu7L5/suj+bteSl2KXypxqCqCxml94Q6K9UjY+ve19b5VCIb7T6rKl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/n32LOdFnPiiUNWJ8rrYtIH/omEFpT7nVfCjkLea24mSSI42
	764suEhgrktpVEpFM+g12C/zH2oZFtvLcFPRSxV9pElpLpHqKnfxLkt3vlreNlsHvaa1rCeZGiu
	f2ZFE5QhNslMrifVw9COD9ZAgyy1KQD61jCigdp4a+7APZ9idbF5HLxMURdtZyIhTQNM=
X-Gm-Gg: ASbGncs1N8vuViKZYDnKslKSNUYPEb+3nvqESskTPf5XZqUDJ7uZiBrUgGYTURyUkIr
	v9SQVNYT7Tdo1x/cP7RlvvIeXmq1OK05EFg40pkrC4LXLMEZiJhMfo33Zerde/HH0I/Fzy6ZyIm
	C5FF02se4HRucWPfcvHyJQPqWzX0PfGKjDbOzGI/7mU5KOqyHwO4l5Dgot8FniDx43Hm9ulPbBo
	qvrW9VZzQj127Dtd0+WB4aAknVmHTv3yTn6lQfnWhT4oejbQ7QE5n5l8T1IPX9t+QDwiEtOl1c/
	m5BaG1UZ8ib9EnsX9u5NWrjOmhiiKaYzvm25viZKeF7KTjf2ba20ltvFt5+6FFQ=
X-Received: by 2002:a05:6a00:4fce:b0:746:3200:620 with SMTP id d2e1a72fcca58-7489cfdb032mr21850421b3a.9.1750264885008;
        Wed, 18 Jun 2025 09:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ1vWKRmqYm421cr7fdnsID8bPNxfK4AjQRoXMc8zb1QCzWNM3v9/ZDPAEyGXE6WQmp3tVsg==
X-Received: by 2002:a05:6a00:4fce:b0:746:3200:620 with SMTP id d2e1a72fcca58-7489cfdb032mr21850384b3a.9.1750264884500;
        Wed, 18 Jun 2025 09:41:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b37ddsm11532732b3a.134.2025.06.18.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:41:23 -0700 (PDT)
Date: Thu, 19 Jun 2025 00:41:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, zlang@kernel.org,
	fstests@vger.kernel.org, Friendy Su <friendy.su@sony.com>
Subject: Re: [PATCH] generic/633: add _require_chown
Message-ID: <20250618164119.pa4qjwgeceybwhy4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250613135209.645818-2-Yuezhang.Mo@sony.com>
 <20250613150132.GW6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613150132.GW6143@frogsfrogsfrogs>

On Fri, Jun 13, 2025 at 08:01:32AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 13, 2025 at 09:52:10PM +0800, Yuezhang Mo wrote:
> > For file systems that do not support chown, such as exfat,
> > running this test does not make sense and should be skipped.
> 
> /me scans the test, only sees stuff about idmap...
> 
> If I read this correctly, exfat doesn't assign individual files a
> user/group id, so idmapping (which is what this test really does) has
> very little meaning, because every file is "owned" either by the value
> provided by the uid= mount option, or the uid of the mount(8) process.
> Therefore g/633 can't test remapping of select uids.
> 
> If that's the case then
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Actually it's failed on exfat on my side:

FSTYP         -- exfat
PLATFORM      -- Linux/x86_64 dell-per750-41 6.16.0-0.rc1.250613g27605c8c0f69.21.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jun 13 16:05:28 UTC 2025
MKFS_OPTIONS  -- /dev/sda6
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch

generic/633 2s ... [failed, exit status 1]- output mismatch (see /root/git/xfstests/results//generic/633.out.bad)
    --- tests/generic/633.out   2024-06-07 01:20:04.367004296 +0800
    +++ /root/git/xfstests/results//generic/633.out.bad 2025-06-19 00:31:17.760030233 +0800
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +vfstest.c: 110: hardlink_crossing_mounts - Operation not permitted - failure: chown_r
    +vfstest.c: 2418: run_test - Operation not permitted - failure: cross mount hardlink
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/633.out /root/git/xfstests/results//generic/633.out.bad'  to see the entire diff)
Ran: generic/633
Failures: generic/633
Failed 1 of 1 tests

> 
> --D
> 
> 
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > Reviewed-by: Friendy Su <friendy.su@sony.com>
> > ---
> >  tests/generic/633 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/generic/633 b/tests/generic/633
> > index b683c427..d75d4dc8 100755
> > --- a/tests/generic/633
> > +++ b/tests/generic/633
> > @@ -13,6 +13,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
> >  . ./common/filter
> >  
> >  _require_test
> > +_require_chown
> >  
> >  echo "Silence is golden"
> >  
> > -- 
> > 2.25.1
> > 
> > 
> 

